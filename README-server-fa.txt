Nana — Smooth Home Update (v2)

WHAT CHANGED
- Player position is now sent on a 50ms movement cadence (up to 20 updates/second when the network can keep up). Unsent position updates are coalesced so a slow connection does not build a backlog.
- The shared-world poll interval is reduced to 150ms while another player is online.
- Remote player interpolation is faster and smoother.
- TV can now be rotated in all four directions with the rotate button while decorating.
- Fireplace can be attached to the top wall row of the room.
- Added four yard fence styles: wood, white, green, and blue. Select a fence in Shop > Yard, rotate it with ↻, and place fence pieces side by side.
- Fixed a shared-decoration deletion bug: picking up a multi-tile item now deletes the server record at the item's original anchor tile, preventing old furniture from reappearing or duplicating.
- Updated the service-worker cache name so browsers fetch the new game files after deployment.

HOW TO UPDATE
1. Keep a backup of the currently published game files.
2. Upload and replace the files in this ZIP in the root of the existing GitHub Pages repository.
3. Wait for GitHub Pages to publish, then reload Nana on both phones. If an old version remains, close the installed web app/browser tab completely and open it again.
4. Do NOT run server-setup.sql again if the shared server is already working. This update does not require a database/schema change.

NOTES
- 50ms is the target send cadence while moving; real delivery speed still depends on each phone's connection and Supabase response time. The client keeps only the newest unsent position to avoid flooding a slow connection with stale coordinates.
- The shared server still uses Supabase RPC polling rather than a dedicated realtime WebSocket game server. The shorter polling interval improves responsiveness but increases database requests while both players are online.
- Test first with both phones together. If the server starts throttling requests or the game becomes less stable, the movement/poll intervals should be tuned back slightly.


نسخه ارتقای چرخش وسایل (Rotation Update):
- تمام وسایل قابل خرید فروشگاه اکنون چهار جهت چرخش دارند.
- ابعاد اشغال‌شده‌ی وسایل مستطیلی هنگام چرخش ۹۰ و ۲۷۰ درجه جابه‌جا می‌شود.
- وسایل پیش‌فرض خانه و اتاق خواب نیز در حالت تزیین با لمس کوتاه می‌چرخند.
- وسیله‌ی خریداری‌شده و چیده‌شده: لمس کوتاه برای چرخش، لمس طولانی برای برداشتن.
- برای دریافت فایل‌های جدید، نسخه‌ی جدید را در GitHub Pages جایگزین کنید؛ SQL را دوباره اجرا نکنید.


نسخه v4 - حیوانات و مینی‌گیم‌ها
- حیوانات آغل هنگام حرکت فریم راه‌رفتن دارند و هنگام توقف در حالت ایستاده می‌مانند.
- گربه‌ی خریداری‌شده در خانه آزادانه قدم می‌زند، مکث می‌کند و جهتش را عوض می‌کند.
- دکمه بوس فقط هنگام نزدیک بودن بازیکن دیگر ظاهر می‌شود و بوس از راه دور حذف شده است.
- در مغازه > بازی‌ها می‌توان توپ و بسته بادکنک آبی خرید. توپ در محوطه قابل شوت‌زدن است؛ برای آب‌بازی بادکنک را کنار برکه پر کنید و نزدیک بازیکن دیگر پرتاب کنید.
- برای اعمال تغییرات، همه فایل‌های ZIP را جایگزین نسخه قبلی سایت کنید. اجرای دوباره SQL لازم نیست.
