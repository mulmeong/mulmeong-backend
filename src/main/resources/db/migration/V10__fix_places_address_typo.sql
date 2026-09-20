UPDATE places
SET address = REPLACE(address, '중남', '충남')
WHERE address LIKE '%중남%';
