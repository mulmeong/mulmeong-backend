# Local seed data

The seed files are intentionally kept outside Flyway migrations. Run them only
after the application schema has been migrated, and load places before magazines.

```bash
psql -v ON_ERROR_STOP=1 -d mulmeong -f docs/seed/places_seed.sql
psql -v ON_ERROR_STOP=1 -d mulmeong -f docs/seed/magazines_seed.sql
psql -v ON_ERROR_STOP=1 -d mulmeong -f docs/seed/dart_candidates_seed.sql
```

`dart_candidates_seed.sql`은 `V3__add_dart_candidates.sql` 적용 후, 그리고
`places_seed.sql` 적재 후 실행합니다. 실행 후에는 활성 후보 85건인지 확인합니다.

`V2__add_terminal_station_type.sql` is a Flyway migration and is applied by the
application. Do not run it manually after Flyway has recorded version 2.
