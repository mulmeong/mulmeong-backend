# Local seed data

The seed files are intentionally kept outside Flyway migrations. Run them only
after the application schema has been migrated, and load places before magazines.

```bash
psql -v ON_ERROR_STOP=1 -d mulmeong -f docs/seed/places_seed.sql
psql -v ON_ERROR_STOP=1 -d mulmeong -f docs/seed/magazines_seed.sql
```

`V2__add_terminal_station_type.sql` is a Flyway migration and is applied by the
application. Do not run it manually after Flyway has recorded version 2.
