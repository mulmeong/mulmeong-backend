# Seed data

The seed SQL files themselves live at `src/main/resources/db/seed/` (classpath,
so they ship inside the jar/image) and are intentionally kept outside Flyway
migrations.

They run automatically whenever the app starts with the `seed` Spring profile
active — see `com.mulmeong.global.seed.DatabaseSeedRunner`. The AWS deploy
workflow (`.github/workflows/deploy.yml`) activates `prod,seed` on every
deploy, so pushing an updated seed file to `main` is enough; nothing needs to
be run by hand on the server anymore.

All three scripts are upsert-safe (`ON CONFLICT ... DO UPDATE`), so re-running
them on every deploy is safe. Order matters: places before magazines before
dart_candidates (`dart_candidates_seed.sql` matches place rows by
`external_id`/name).

To run them locally without booting the whole app:

```bash
psql -v ON_ERROR_STOP=1 -d mulmeong -f src/main/resources/db/seed/places_seed.sql
psql -v ON_ERROR_STOP=1 -d mulmeong -f src/main/resources/db/seed/magazines_seed.sql
psql -v ON_ERROR_STOP=1 -d mulmeong -f src/main/resources/db/seed/dart_candidates_seed.sql
```

or start the app with `--spring.profiles.active=local,seed`.

`dart_candidates_seed.sql`은 `V3__add_dart_candidates.sql` 적용 후, 그리고
`places_seed.sql` 적재 후 실행됩니다. 실행 후에는 활성 후보 85건인지 확인합니다.

`V2__add_terminal_station_type.sql` is a Flyway migration and is applied by the
application. Do not run it manually after Flyway has recorded version 2.
