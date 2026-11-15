-- Nana fixed shared server setup
-- Run this entire file once in Supabase Dashboard > SQL Editor > New query.
-- Shared access code for every player: NANA-2026
-- Change the value below AND SERVER_DEFAULT in index.html if you choose another code.

create table if not exists public.nana_server_config (
  id integer primary key check (id = 1),
  access_code text not null
);

insert into public.nana_server_config (id, access_code)
values (1, 'NANA-2026')
on conflict (id) do update set access_code = excluded.access_code;

create table if not exists public.nana_world_kv (
  room_id text not null default 'main',
  key text not null,
  value jsonb,
  updated_at timestamptz not null default now(),
  primary key (room_id, key)
);

alter table public.nana_server_config enable row level security;
alter table public.nana_world_kv enable row level security;

revoke all on public.nana_server_config from anon, authenticated;
revoke all on public.nana_world_kv from anon, authenticated;

create or replace function public.nana_get_all(p_code text)
returns jsonb
language plpgsql
security definer
set search_path = public
as $$
declare
  saved_code text;
  result jsonb;
begin
  select access_code into saved_code
  from public.nana_server_config where id = 1;

  if saved_code is null or p_code is distinct from saved_code then
    raise exception 'Invalid Nana server key';
  end if;

  select coalesce(jsonb_object_agg(key, value), '{}'::jsonb)
    into result
  from public.nana_world_kv
  where room_id = 'main';

  return coalesce(result, '{}'::jsonb);
end;
$$;

create or replace function public.nana_set_kv(
  p_code text,
  p_key text,
  p_value jsonb
)
returns boolean
language plpgsql
security definer
set search_path = public
as $$
declare
  saved_code text;
begin
  select access_code into saved_code
  from public.nana_server_config where id = 1;

  if saved_code is null or p_code is distinct from saved_code then
    raise exception 'Invalid Nana server key';
  end if;

  if p_key is null or length(p_key) < 1 or length(p_key) > 180 then
    raise exception 'Invalid Nana key';
  end if;

  insert into public.nana_world_kv (room_id, key, value, updated_at)
  values ('main', p_key, p_value, now())
  on conflict (room_id, key)
  do update set value = excluded.value, updated_at = now();

  -- Keep old chat messages and abandoned player-presence records from growing forever.
  delete from public.nana_world_kv
  where room_id = 'main'
    and (
      (left(key, 4) = 'msg_' and updated_at < now() - interval '14 days')
      or (left(key, 2) = 'p_' and updated_at < now() - interval '2 days')
    );

  return true;
end;
$$;

revoke all on function public.nana_get_all(text) from public;
revoke all on function public.nana_set_kv(text, text, jsonb) from public;
grant execute on function public.nana_get_all(text) to anon, authenticated;
grant execute on function public.nana_set_kv(text, text, jsonb) to anon, authenticated;

-- Verify:
-- select public.nana_get_all('NANA-2026');
