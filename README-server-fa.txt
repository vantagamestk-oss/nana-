Nana — shared server update

WHAT THIS PACKAGE DOES
- Moves the game from the old two-role (her/him) network model to a fixed shared room.
- Gives each browser installation a persistent player ID and a generated display name.
- Stores each player's save separately on Supabase.
- Stores player positions separately so multiple players can appear in the same map.
- Stores chat messages as individual records in one shared chat stream.
- Synchronizes farm soil/crop tiles, cleared bushes, and placed/picked-up decorations.
- Adds long-press flattening for an empty tilled tile.
- Fixes PWA icon paths and adds standard 192/512 PNG icons.
- Adds mobile menu scrolling and iOS safe-area padding.

ONE-TIME SERVER SETUP (REQUIRED)
1. Open the Supabase project already used by Nana.
2. Open SQL Editor and create a new query.
3. Paste the complete contents of server-setup.sql and run it once.
4. The shared server access code is: NANA-2026
5. Every player must enter the SAME access code to join the same world.
6. Publish the contents of this ZIP to the root of the existing GitHub Pages repository.

IMPORTANT LIMITATIONS / SECURITY
- The shared room code is a lightweight private-room key, not strong account authentication. Anyone who knows it can enter.
- The existing Supabase URL and public anon key are reused from the original client project.
- This package does not give the assistant direct access to your Supabase dashboard; the SQL step must be run by the project owner.
- Player movement is polled through Supabase RPC, not a dedicated WebSocket game server. Expect a small delay rather than frame-perfect movement.
- Personal inventory/coins remain per-player. Farm tiles, crops, bushes, placed decorations, positions, and chat are shared.
- Test with two devices after SQL setup and publishing. Do not delete the old project backup until the new version is confirmed.
