-- Favorite 엔티티가 BaseTimeEntity(created_at/updated_at)를 상속하도록 바뀌면서 필요해진 컬럼
ALTER TABLE favorites ADD COLUMN updated_at TIMESTAMPTZ NOT NULL DEFAULT now();
