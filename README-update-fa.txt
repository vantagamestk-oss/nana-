Nana update package

Included:
- Fixed PWA icon paths to match the repository's root-level icon.svg.
- Added 192x192 and 512x512 PNG app icons and referenced them in the manifest.
- Bumped the service-worker cache version and updated its precache list.
- Made the login and in-game menu vertically scrollable on small screens, with iOS safe-area padding.
- Adjusted canvas sizing to use visualViewport dimensions where available.
- Added long-press (650 ms) to flatten an empty tilled soil tile.
- Added shared per-tile soil keys using the existing Supabase set_kv/get_all flow, including a one-time migration of existing player soil.

Important:
- This package does not change the Supabase database schema or policies.
- Shared soil synchronization depends on the existing get_all RPC returning all keys for the same PIN and set_kv allowing additional keys.
- Real-device multiplayer testing is still required. Player movement/chat were already implemented in the source project; this patch specifically extends farm-tile synchronization.
