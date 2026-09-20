ALTER TABLE places
    ADD COLUMN content_type_id INTEGER;

UPDATE places
SET content_type_id = 12
WHERE source = 'TOUR_API'
  AND place_type = 'ONSEN'
  AND content_type_id IS NULL;
