-- 물멍 magazines 시드 (243편) + magazine_places 연결
-- 대상: mulmung_schema_final.sql 의 magazines / magazine_places
-- body 마커: [IMG]캡션 · [QUOTE]문장 · [TIP]한 줄 (프론트 렌더)
-- 재실행 안전: 같은 title이 있으면 건너뜀 / magazine_places는 ON CONFLICT DO NOTHING
BEGIN;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','지하 250m에서 올라오는 왕의 물, 수안보','조선의 왕들이 행차하던 국내 최초 자연 용출 온천의 계보','/img/magazine/001.jpg','수안보 사람들은 이 물을 ''왕의 온천''이라 부릅니다. 과장이 아니라 기록입니다. 조선의 임금들이 피부병을 다스리러 행차했다는 이야기가 전해지는 이 물은, 우리나라에서 처음으로 땅을 파지 않아도 스스로 솟아오른 자연 용출 온천으로 꼽힙니다.

숫자로 보면 더 분명해집니다. 지하 250m 암반에서 올라오는 물의 온도는 53℃. 데우지 않고 그대로 탕에 받아도 뜨겁다는 소리가 나오는 온도입니다. 수질은 알칼리성으로, 관절과 피로 회복에 좋다고 알려져 예나 지금이나 어르신들의 신뢰가 두텁습니다.

[IMG]수안보 물탕공원 족욕탕에서 김이 오르는 이른 아침. ⓒ 물멍

지금의 수안보는 관광특구로 지정된 온천마을입니다. 마을 한가운데 물탕공원에는 무료로 발을 담글 수 있는 족욕탕이 있어, 숙박 없이 들른 사람도 43℃ 안팎의 온천수를 경험하고 갑니다. 뜨거운 원탕을 즐기려면 라마다 수안보 같은 호텔 온천이나 노천탕을 갖춘 수안보파크호텔로 들어가면 됩니다.

[QUOTE]땅을 파서 만든 온천이 아니라, 물이 먼저 있었고 마을이 나중에 생겼다.

서울에서 가는 길도 단순해졌습니다. KTX로 충주역까지 간 뒤 246번 버스로 25분. 왕들은 며칠을 행차했던 길을, 지금은 반나절이면 닿습니다. 물은 그때나 지금이나 같은 암반에서 올라옵니다.','43',4,'2025-09-20 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='지하 250m에서 올라오는 왕의 물, 수안보');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='지하 250m에서 올라오는 왕의 물, 수안보' AND source='MANUAL' AND name='수안보온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','충주역에서 시작하는 수안보 1박 2일','246번 버스, 하늘재 숲길, 그리고 저녁의 꿩 코스요리','/img/magazine/002.jpg','첫날 10:30, KTX 충주역. 역 앞에서 246번 버스를 타면 25분 뒤 수안보에 내려요. 짐을 숙소에 맡기고 가장 먼저 갈 곳은 마을 중심의 물탕공원. 무료 족욕탕에 발부터 담그고 여행의 속도를 늦춥니다.

12:30, 점심은 청솔식당의 두부전골이나 산채정식. 산나물 반찬이 상 위에 줄지어 나오는 집이에요. 오후에는 본탕에 들어가지 말고 아껴둡니다. 대신 버스나 택시로 하늘재 입구로 이동해요.

15:00, 하늘재 트레킹. 신라 왕손이 나라를 잃고 넘었다는 이야기가 전해지는 옛 고갯길로, 왕복 4km에 2시간이면 충분한 완만한 숲길입니다. 능선 바람을 맞고 되짚어 내려오면 다리가 알맞게 무거워져요.

17:30, 이제 입탕. 53℃ 알칼리성 온천수에 트레킹의 피로를 풀어냅니다. 수안보의 물은 관절에 좋기로 이름난 물이라, 걷고 난 뒤의 탕이 정답이에요.

19:00, 저녁은 수안보의 명물 꿩 코스요리. 대장군식당이나 삿갓촌에서 꿩 샤브부터 만두까지 이어지는 코스를 받습니다. 전국에서 이런 꿩요리 골목은 수안보가 거의 유일해요.

[IMG]하늘재 숲길, 왕복 4km의 완만한 오르막. ⓒ 물멍

둘째 날 아침엔 한 번 더 탕에 들어갔다가, 늦은 오전 버스로 충주역에 나가면 됩니다. 아침 온천을 건너뛰지 마세요. 이 여행의 반은 거기에 있어요.','43',4,'2025-09-21 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='충주역에서 시작하는 수안보 1박 2일');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='충주역에서 시작하는 수안보 1박 2일' AND source='MANUAL' AND name='수안보온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','온천마을에 꿩요리 골목이 생긴 이유','수안보에서만 가능한 저녁 — 꿩 샤브, 꿩만두, 그리고 탕','/img/magazine/003.jpg','꿩 한 마리로 여덟 가지 요리를 낸다. 수안보의 삿갓촌은 꿩 샤브를 비롯한 8가지 꿩 코스를 차리는 집이고, 대장군식당은 이 동네 꿩 코스요리의 대표 격으로 신문 여행면에 오르내린다. 장군식당, 감나무집까지 — 한 마을에 꿩요리 전문점이 이렇게 몰려 있는 곳은 전국을 뒤져도 수안보 말고는 찾기 어렵다.

왜 하필 꿩일까. 수안보는 산으로 둘러싸인 고원 분지 마을이라 예부터 꿩이 흔했고, 온천에 몸을 풀러 온 손님들에게 귀한 단백질을 대접하던 문화가 요리로 굳어졌다. 탕에서 나온 몸에 뜨거운 꿩 샤브 국물이 들어가는 순서는, 말하자면 이 마을이 수십 년 다듬어 온 코스요리인 셈이다.

[QUOTE]수안보의 저녁은 탕에서 시작해 꿩 샤브 국물에서 끝난다.

먹는 법은 대개 비슷하다. 얇게 뜬 꿩고기를 끓는 육수에 살짝 흔들어 익혀 먹고, 남은 국물에 만두와 국수를 차례로 넣는다. 코스 후반에 나오는 꿩만두는 포장해 가는 사람이 있을 정도다. 꿩이 부담스럽다면 청솔식당의 두부전골과 산채정식, 또는 지역 명물인 올갱이 요리로 방향을 틀면 된다.

53℃ 알칼리성 온천수로 몸을 데우고, 걸어서 닿는 거리의 식당에서 꿩 코스를 받는 것. 화려하지 않지만 다른 동네가 흉내 낼 수 없는 저녁이다. 그거면 수안보에 올 이유는 충분하다.','43',4,'2025-09-22 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='온천마을에 꿩요리 골목이 생긴 이유');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='온천마을에 꿩요리 골목이 생긴 이유' AND source='MANUAL' AND name='수안보온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','놀이공원은 문을 닫았고, 물은 아직 78℃다','창녕 부곡 — 수학여행의 성지에서 목욕의 성지로','/img/magazine/004.jpg','1979년, 경남 창녕 산골에 야자수가 세워졌다. 부곡하와이. 실내 수영장과 온천, 공연장을 한데 묶은 이 유원지는 수학여행 버스와 신혼여행 택시가 줄을 서던 곳이었다. 2017년 5월, 38년 만에 문을 닫았다.

사람들은 부곡이 끝났다고 했다. 물은 그 말을 못 들었다.

부곡온천의 원수 온도는 78℃. 지금도 국내 온천 가운데 가장 뜨겁다. 탕에 들어서면 유황 냄새가 코보다 먼저 도착하고, 은반지를 끼고 들어간 사람은 나올 때 검게 변한 반지를 보고 이 물이 진하다는 걸 알게 된다. 78℃의 원수는 냉각조를 거쳐 42~44℃로 내려온 뒤에야 탕에 닿는다 — 온도는 기계가 조절하지만 성분은 땅이 정한 그대로다.

[IMG]온천중앙로의 저녁. 식당가 간판에 하나둘 불이 들어온다. ⓒ 물멍

하와이가 사라진 자리에서 마을은 두 번째 계절을 맞고 있다. 온천단지에 무료 족욕체험장이 생겼고, 겨울이면 부곡온천축제가 열린다. "41년 만에 다시 왔다"는 방문객의 말이 지역 뉴스에 실린다. 유원지에 딸린 온천이던 곳이, 온천 그 자체로 돌아왔다.

탕에서 나오면 온천중앙로다. 송이네 밥상의 한정식 한 상, 한우곱창 오색그린 부곡본점의 곱창전골이 목욕 뒤의 허기를 받아 준다. 부산서부터미널에서 시외버스로 한 시간 — 부산 사람들에게 부곡은 여전히 가장 가까운 온천마을이다.

[QUOTE]야자수는 뽑혔지만, 78℃는 하루도 식은 적이 없다.

이번 겨울 부곡에 간다면 놀이공원의 흔적을 찾지 마라. 그냥 탕에 들어가라. 이 마을이 원래 하려던 일이 그것이다.','48',4,'2025-09-24 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='놀이공원은 문을 닫았고, 물은 아직 78℃다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='놀이공원은 문을 닫았고, 물은 아직 78℃다' AND source='MANUAL' AND name='부곡온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','부산에서 버스 1시간, 부곡온천 당일치기','서부터미널에서 출발하는 가장 뜨거운 하루','/img/magazine/005.jpg','준비물은 수건 한 장과 갈아입을 속옷뿐이에요. 부산서부터미널에서 부곡행 시외버스를 타면 1시간 뒤 국내에서 가장 뜨거운 온천마을에 내립니다.

① 10:00 부곡 도착 — 터미널에서 온천단지까지는 걸어서 이동. 먼저 무료 족욕체험장에서 발을 담그며 몸을 예열해요. 78℃ 원수를 식혀서 쓰는 물이라 족욕만으로도 발끝이 금세 붉어집니다.

② 11:30 이른 점심 — 온천중앙로의 송이네 밥상에서 한정식 한 상을 받아요. 반찬 수를 세다 포기하게 되는 집입니다. 생선구이가 당기는 날엔 돌솥밥과 생선구이를 함께 내는 집으로 가도 좋아요.

③ 13:00 본탕 입장 — 부곡의 하이라이트. 유황천 특유의 냄새와 뜨끈한 물에 두 시간쯤 몸을 맡깁니다. 국내 최고 수온이라는 말은 탕 안에서 몸으로 이해하게 돼요. 냉탕과 번갈아 드나드는 게 요령입니다.

④ 16:00 마을 산책 — 목욕 후 달아오른 몸을 온천단지 골목 바람에 식혀요. 겨울에 온다면 부곡온천축제 기간을 노려볼 것.

⑤ 17:30 저녁 — 한우곱창 오색그린 부곡본점의 곱창전골로 마무리. 뜨거운 탕과 뜨거운 전골, 하루 종일 뜨거운 것만 먹고 담그는 여행이에요.

19시 전후 버스를 타면 저녁 8시대에 부산으로 돌아옵니다. 숙박 없이도 온천마을을 통째로 누리는 방법, 부곡이라 가능한 일정입니다.','48',4,'2025-09-25 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='부산에서 버스 1시간, 부곡온천 당일치기');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='부산에서 버스 1시간, 부곡온천 당일치기' AND source='MANUAL' AND name='부곡온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','78℃의 탕과 1억 년의 늪, 창녕의 온도차','부곡온천과 우포늪 — 하루에 두 개의 시간을 사는 법','/img/magazine/006.jpg','창녕에는 극단적인 물 두 개가 있다. 하나는 78℃로 솟는 부곡온천, 다른 하나는 태고의 시간이 고여 있는 우포늪. 하나는 국내에서 가장 뜨거운 물이고, 하나는 람사르 습지도시 인증을 받은 국내 대표 자연 늪이다. 같은 군 안에 있으니, 욕심을 내면 하루에 둘 다 만날 수 있다.

순서는 늪이 먼저다. 우포늪의 얼굴은 물안개가 걷히는 오전이기 때문이다. 늪가 탐방로를 따라 걷다 보면 왜가리가 정지 화면처럼 서 있고, 시간이 여기서만 다르게 흐르는 듯한 착각이 온다. 걷는 만큼 보이는 곳이라 두어 시간은 잡아야 한다.

[QUOTE]늪에서 식은 몸을 유황천이 데운다. 창녕의 하루는 그렇게 설계돼 있다.

오후에는 부곡으로 넘어간다. 늪 바람에 식은 몸을 유황천에 담그는 순간, 이 조합의 설계가 완성된다. 유황 성분의 뜨거운 물이 걷느라 뭉친 다리를 풀어 주고, 목욕을 마치면 온천중앙로의 식당가가 기다린다. 한정식이든 곱창전골이든, 이 골목에서 고르면 된다. 조금 발을 넓히면 이웃한 영산면의 영산세유정 같은 현지인 추천 한식집도 있다.

온천만 하기엔 반나절이 남고, 늪만 보기엔 몸이 허전한 사람에게 창녕은 정확한 답을 준다. 1억 년의 늪과 78℃의 탕. 이 온도차가 창녕 여행의 전부이자 핵심이다.','48',4,'2025-09-27 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='78℃의 탕과 1억 년의 늪, 창녕의 온도차');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='78℃의 탕과 1억 년의 늪, 창녕의 온도차' AND source='MANUAL' AND name='부곡온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','지하철역 이름이 온천인 도시, 대전 유성','도심 한복판에서 53℃ 라듐천이 솟는다는 것','/img/magazine/007.jpg','유성온천역 3번 출구를 나오면 관광지가 아니라 그냥 도시가 펼쳐진다. 오피스텔, 프랜차이즈 카페, 버스 정류장. 그런데 몇 걸음 옆 유성온천공원에서는 김이 오른다. 53℃ 라듐 함유 온천수가 도심 한복판에서 솟고 있는 것이다.

유성의 매력은 이 무심함에 있다. 전국 어느 온천이 지하철역과 도보 거리에 원탕을 두고 있나. 유성온천공원의 야외 족욕체험장에는 장 보고 가던 어르신과 노트북 가방을 멘 회사원이 나란히 앉아 바지를 걷는다. 무료이고, 예약도 없고, 유난도 없다. 온천이 일상에 스며든 풍경으로는 국내에서 손꼽히는 장면이다.

[IMG]유성온천공원 야외 족욕체험장, 퇴근길에 발을 담근 사람들. ⓒ 물멍

물은 라듐 성분의 단순천으로 근육통과 신경통 완화에 좋다고 알려져 있다. 자극이 적고 부드러워서 오래 담가도 어지럽지 않은 물이라, 온천 초심자에게 권하기 좋다.

접근은 서울에서도 간단하다. KTX로 대전역, 급행2번 버스로 20분. 목욕을 마쳤다면 대전이 칼국수의 도시라는 사실을 기억할 것. 유성온천역 주변의 온천손칼국수 같은 집에서 뜨끈한 한 그릇으로 마무리하면, 반나절짜리 온천행이 완성된다.

온천을 위해 산을 넘을 필요가 없다는 것. 유성이 백 년 넘게 증명해 온 명제다.','30',4,'2025-09-28 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='지하철역 이름이 온천인 도시, 대전 유성');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='지하철역 이름이 온천인 도시, 대전 유성' AND source='MANUAL' AND name='유성온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','맨발로 14.5km, 그다음에 라듐천','계족산 황톳길과 유성온천을 잇는 대전 하루 코스','/img/magazine/008.jpg','발바닥으로 하는 여행이 있습니다. 대전 대덕구 장동의 계족산 황톳길 — 맨발로 걷도록 붉은 황토를 깔아 둔 14.5km 숲길로, 한국관광 100선에 세 번이나 이름을 올린 곳이에요. 그리고 이 길의 가장 좋은 마무리는 유성의 온천이라고, 대전 사람들은 이미 알고 있습니다.

09:30 계족산 황톳길 입구 — 신발을 벗어 들고 걷기 시작해요. 전 구간을 다 돌 필요는 없습니다. 두어 시간 걷고 돌아 나와도 발바닥은 충분히 일을 한 상태예요. 물기 머금은 황토가 발가락 사이로 올라오는 감각에 다들 처음엔 웃고, 나중엔 말이 없어집니다.

12:30 칼국수 — 대전은 칼국수의 도시. 시내로 나가 대전 3대 명물로 꼽히는 노포 오씨칼국수에서 한 그릇 하거나, 곧장 유성으로 이동해 온천손칼국수로 가도 됩니다.

14:30 유성온천 입탕 — 오늘의 본론. 53℃ 라듐천은 근육통 완화로 이름난 물이라, 맨발 트레킹으로 지친 다리에 이보다 맞는 처방이 없어요. 탕에 다리를 뻗는 순간 오전의 14.5km가 정산됩니다.

17:00 유성온천공원 산책 — 몸을 식히며 공원을 한 바퀴. 아직 발이 아쉽다면 야외 족욕체험장에서 한 번 더 담가요.

흙길로 발을 깨우고 온천으로 재우는 하루. 이 조합은 대전에서만 성립합니다.','30',4,'2025-09-30 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='맨발로 14.5km, 그다음에 라듐천');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='맨발로 14.5km, 그다음에 라듐천' AND source='MANUAL' AND name='유성온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','탕 밖의 대전 — 목욕 후에 가는 노포 세 곳','칼국수, 두부두루치기, 그리고 온천 동네의 한 그릇','/img/magazine/009.jpg','온천 여행의 절반은 목욕 후의 밥이다. 유성온천에서 몸을 풀었다면, 대전이라는 도시가 차려 놓은 노포의 상을 받을 차례다. 세 곳만 추린다.

① 온천손칼국수 — 멀리 갈 것 없이 유성에서 해결하고 싶을 때. 유성구 지역 뉴스에도 소개된 칼국수집으로, 목욕 직후의 몸에 뜨거운 국물이 얼마나 정확하게 들어맞는지 확인하게 되는 집이다.

② 오씨칼국수 — 대전 시내로 나갈 여유가 있다면. 성심당, 진로집과 함께 대전 3대 명물로 묶여 불리는 칼국수 노포다. 대전 사람들이 외지 손님을 데려가는 집이 어디인지 궁금하다면 여기서 답을 얻는다.

③ 진로집 — 두부두루치기라는 대전만의 장르를 만나는 곳. 벌겋게 양념한 두부를 안주 삼고 식사 삼는 이 메뉴는 다른 도시에서 좀처럼 재현되지 않는다. 역시 대전 시내라, 목욕과 식사 사이에 30분쯤의 이동을 감수해야 한다.

[QUOTE]대전의 온천은 라듐천이고, 대전의 해장은 칼국수다. 이 도시는 뜨거운 것으로 뜨거운 것을 다스린다.

순서는 취향의 문제지만 원칙은 하나다. 탕에서 나온 몸은 식기 전에 먹여야 한다는 것. 유성온천역에서 시내까지는 지하철로 한 번에 이어지니, 목욕 가방을 든 채로 노포 순례를 다녀도 어색하지 않은 도시가 대전이다.','30',4,'2025-10-01 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='탕 밖의 대전 — 목욕 후에 가는 노포 세 곳');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='탕 밖의 대전 — 목욕 후에 가는 노포 세 곳' AND source='MANUAL' AND name='유성온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','환승 0회, 요금은 지하철값 — 1호선 끝의 57℃','서울에서 목욕 바구니 들고 가는 온양온천, 역에서 탕까지 도보 10분','/img/magazine/010.jpg','아침 온양온천역 개찰구. 배낭 대신 목욕 바구니를 든 어르신이 먼저 빠져나오고, 그 뒤로 지하철 여행 삼아 종점 부근까지 내려온 청년들이 따라 나온다. 서울에서 1호선을 타고 앉아 있으면 환승 한 번 없이 이 개찰구에 닿는다.

편도 두 시간 남짓, 요금은 지하철 운임. 전국 505곳 온천 가운데 수도권 전철로 직결되는 온천마을은 사실상 온양 하나다. 국내에서 가장 싼 온천행 교통편이라 불러도 틀리지 않는다.

역에서 온천가까지는 걸어서 10분. 역 앞 온양관광호텔을 비롯해 온천을 갖춘 숙소와 목욕탕이 역세권 안에 모여 있어, 짐을 끌고 헤맬 구간이 없다.

[IMG]온양온천역 개찰구, 목욕 바구니와 배낭이 나란히 빠져나간다. ⓒ 물멍

물의 이력은 교통보다 길다. 조선 왕실이 온행을 다닌 기록이 남은 온천이고, 지금 솟는 물은 57℃ 알칼리성이다. 피부가 매끈해지는 물이라는 평이 오래 이어져 온 이유가 여기 있다.

탕에서 나오면 역 앞 온양온천전통시장이다. "배부르고 등 따뜻한 장터"라는 소개가 붙는 시장에서 저녁 지하철 시간까지 허기를 채운다.

[QUOTE]온양의 왕복표는 기차표가 아니라 교통카드 한 장이다.

서울에서 아침에 출발해 탕과 장터를 거쳐 저녁 지하철로 돌아오는 것. 이 단순한 왕복을 다른 온천은 흉내 낼 수 없다. 이번 주말, 배낭 대신 수건 한 장 챙겨 1호선에 앉아라.','44',4,'2025-10-03 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='환승 0회, 요금은 지하철값 — 1호선 끝의 57℃');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='환승 0회, 요금은 지하철값 — 1호선 끝의 57℃' AND source='MANUAL' AND name='온양온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','배부르고 등 따뜻한 장터의 해부학','온양온천전통시장 — 목욕 수건과 장바구니가 공존하는 곳','/img/magazine/011.jpg','시장 구경의 완성형은 젖은 머리로 하는 것이라고, 온양에 가면 배우게 됩니다.

온양온천역 앞의 온양온천전통시장은 한국관광공사 여행기사에 ''배부르고 등 따뜻한 장터''로 소개된 시장이에요. 이 표현의 순서가 정확합니다. 등이 따뜻한 건 온천 덕이고, 배가 부른 건 시장 덕이니까요. 온천가와 시장이 도보 생활권으로 붙어 있어서, 목욕을 마친 사람들이 그대로 장터로 흘러드는 구조입니다.

장날이 아니어도 상설 구역은 늘 돌아갑니다. 반찬 가게에서 풍기는 조림 냄새, 어물전의 얼음 내음, 즉석에서 부치는 전 냄새가 골목마다 층을 이뤄요. 온천에서 데워진 몸으로 걷다 보면 뭐든 다 맛있어 보이는 상태가 되는데, 그게 이 시장을 걷는 가장 올바른 몸 상태입니다.

든든한 한 상이 필요하면 시장 언저리의 시골밥상 같은 백반집에서 한상차림을 받아요. 나물과 찌개가 기본기를 하는 집입니다. 아산까지 온 김에 발을 넓히면 송악저수지 쪽 어죽과 붕어찜이라는 선택지도 있지만, 그건 차가 있는 날의 이야기고요.

서울로 돌아가는 1호선 좌석에 앉아 무릎 위 장바구니를 내려다보는 순간이 이 여행의 마지막 장면이에요. 온천 수건 옆에 반찬 봉지. 온양은 관광이 아니라 생활을 잠깐 빌려주는 동네입니다.','44',4,'2025-10-04 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='배부르고 등 따뜻한 장터의 해부학');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='배부르고 등 따뜻한 장터의 해부학' AND source='MANUAL' AND name='온양온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','은행나무 2.1km를 걷고 57℃에 잠기는 날','곡교천, 현충사, 민속박물관 — 아산의 가을 하루 코스','/img/magazine/012.jpg','가을의 아산은 하루를 이렇게 씁니다.

09:30 온양온천역 도착 — 1호선이든 KTX 환승이든, 아침에 역에 내려 하루를 시작해요. 온천은 아껴 두고 먼저 밖으로 나갑니다.

10:00 곡교천 은행나무길 — 50여 년 자란 은행나무가 2.1km 황금빛 터널을 이루는 길이에요. 전국의 아름다운 가로수길을 꼽을 때 빠지지 않는 곳으로, 11월 초가 절정입니다. 왕복으로 천천히 걸으면 한 시간 반.

12:00 점심 — 온천가로 돌아와 시골밥상의 한상차림. 오후 일정을 버틸 든든한 기본값입니다.

13:30 현충사 — 이순신 장군의 사당이 있는 아산의 대표 유적. 경내가 넓고 정돈되어 있어 소화가 저절로 되는 산책이 됩니다. 인근의 온양민속박물관까지 잇는 것도 좋아요. 옛 살림살이 유물로 채워진 전시와, 건축으로 이름난 구정아트센터가 한 부지에 있습니다.

16:30 입탕 — 드디어 온천. 57℃ 알칼리성 온천수는 피부가 매끈해지는 물로 오래 사랑받아 왔어요. 은행나무길과 유적지를 걸은 다리를 여기서 정산합니다.

18:30 온양온천전통시장 — 저녁거리와 반찬을 사서 상경 열차에 오르면 끝. 걷고, 배우고, 잠기는 하루. 아산은 가을에 계좌를 개설해 두고 겨울에 이자를 받는 동네입니다.','44',4,'2025-10-06 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='은행나무 2.1km를 걷고 57℃에 잠기는 날');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='은행나무 2.1km를 걷고 57℃에 잠기는 날' AND source='MANUAL' AND name='온양온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','역 이름이 온천장인 동네, 62℃ 식염천의 이력서','조선의 목욕객부터 허심청과 무료 노천족탕까지 — 동래온천 연대기','/img/magazine/013.jpg','지하철 1호선 온천장역. 역 이름에 온천이 들어간 이 동네는, 부산이 지금의 이름으로 불리기 훨씬 전부터 사람들이 목욕을 다니던 곳이다. 동래온천은 조선시대 기록에 등장하고, 부산이 항구 도시로 자라는 동안에도 목욕의 중심은 줄곧 이 안쪽 동네였다.

물의 정체는 식염천, 수온 62℃. 소금기를 머금은 뜨거운 물은 몸을 오래 데워 주는 것으로 알려져 있다. 이 물 하나로 ''온천장''이라는 동네 이름이 생겼고, 그 이름이 그대로 지하철 역명이 됐다.

[QUOTE]해운대가 부산의 얼굴이 되기 전, 부산의 휴양지는 동래였다.

근대에 들어 동래는 전성기를 맞았다. 온천장에 별장과 여관이 들어섰고, 동래별장 같은 근대의 장소는 지금 학자들의 연구 대상으로 남아 있다. 동래구는 이 일대를 잇는 탐방코스 ''온천장 풍류길''을 안내한다. 온천의 역사를 발로 따라가는 코스다.

[IMG]온천장역 개찰구를 빠져나가는 목욕 가방. ⓒ 물멍

지금 이 물을 가장 크게 받아 쓰는 곳은 온천장의 대형 온천 허심청이다. 목욕비가 아까운 날엔 거리의 노천족탕이 있다. 무료로 발만 담가도 62℃ 식염천의 성의는 전해진다.

여관 골목이 붐비던 전성기의 소란은 지났다. 그래도 온천장역 개찰구로는 오늘도 목욕 가방이 지나다닌다. 수백 년 끊긴 적 없는 행렬에, 이번 주말 가방 하나 보태라.','26',4,'2025-10-07 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='역 이름이 온천장인 동네, 62℃ 식염천의 이력서');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='역 이름이 온천장인 동네, 62℃ 식염천의 이력서' AND source='MANUAL' AND name='동래온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','4대째 파전, 45년 곰장어 — 동래 목욕 후 두 접시','동래할매파전에서 온천장 곰장어골목까지, 62℃ 식염천 뒤의 순서','/img/magazine/014.jpg','파전이 먼저고, 곰장어가 다음이에요. 동래에서 목욕을 마친 사람의 식사 순서는 이렇게 정해져 있어요. 한국관광공사 여행기사가 ''목욕하고 파전과 곰장어''를 코스로 소개할 정도로 굳은 공식이에요.

파전부터 볼게요. 동래파전은 부산 동래가 원조인 음식으로, 쪽파 위에 해물을 얹고 찹쌀 반죽을 둘러 두툼하게 부쳐 내요. 그 계보를 4대째 잇는 집이 동래할매파전. 지역N문화 ''오래된 가게''에 등재된 노포로, 겉은 눅진하고 속은 촉촉한 동래식 파전의 기준이 되는 집이에요.

[IMG]쪽파가 통째로 깔린 동래파전, 막걸리 잔이 따라온다. ⓒ 물멍

같은 온천동에 소문난동래파전도 있어요. 방송을 탄 집이라, 동래할매파전이 붐비는 날의 두 번째 선택지예요.

해가 지면 곰장어 차례예요. 온천장에는 곰장어골목이 있어요. 45년 전통의 원조 소문난 산곰장어에서는 짚불과 양념 중 굽는 방식을 골라야 하고, 온천입구기장곰장어처럼 상호에 온천이 들어간 집도 골목을 지키고 있어요. 꿈틀거리는 것에 약한 일행이 있다면 양념구이부터 시작하는 게 요령이에요.

[QUOTE]동래의 저녁은 탕에서 시작해 짚불에서 끝난다.

62℃ 식염천에 몸을 데우고, 파전으로 낮술을 하고, 곰장어로 저녁을 마감하는 것. 동래 사람들이 수십 년 반복해 온 이 순서엔 고칠 데가 없어요. 이번 주말, 순서만 지켜서 그대로 따라 해 보세요.','26',4,'2025-10-09 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='4대째 파전, 45년 곰장어 — 동래 목욕 후 두 접시');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='4대째 파전, 45년 곰장어 — 동래 목욕 후 두 접시' AND source='MANUAL' AND name='동래온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','금요일 오후 4시, 온천장역에서 내리기','동래읍성에서 허심청까지 — 부산 시민의 반나절 온천','/img/magazine/015.jpg','이 코스의 출발점은 공항도 터미널도 아니고, 그냥 퇴근길 지하철입니다. 부산 1호선을 타고 가다 금요일 오후 온천장역에서 내리는 것. 동래는 여행지가 아니라 생활권이라서, 반나절이면 온천마을의 정수를 통과할 수 있어요.

16:00 동래읍성 — 먼저 가볍게 걷습니다. 임진왜란의 격전지였던 동래읍성 일대는 성곽을 따라 걷는 산책로가 되어 있고, 가을이면 동래읍성역사축제가 열리는 무대이기도 해요. 성곽길에서 내려다보는 동래 시가지로 워밍업 끝.

17:30 노천족탕 — 온천장으로 내려와 거리의 무료 노천족탕에 발을 담급니다. 본탕 전의 예고편. 옆자리 어르신이 이 동네 물의 역사를 먼저 말 걸어올 확률이 높은 자리예요.

18:00 허심청 — 온천장의 대형 온천에서 본편을 치릅니다. 62℃ 식염천이 원수인 물에 몸을 담그면, 소금기 있는 물이 몸을 오래 데워 준다는 말을 체감하게 돼요. 한 시간 반이면 일주일 치 피로의 인수인계가 끝납니다.

20:00 저녁 — 골목의 공식대로 동래할매파전에서 파전에 막걸리, 여력이 있으면 곰장어골목으로 2차.

집에 돌아가는 지하철에서 아마 졸게 될 거예요. 그게 이 코스가 성공했다는 증거입니다.','26',4,'2025-10-10 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='금요일 오후 4시, 온천장역에서 내리기');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='금요일 오후 4시, 온천장역에서 내리기' AND source='MANUAL' AND name='동래온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','해수욕장보다 온천이 먼저였다','구남온천에서 스파랜드까지, 해운대 1100년 목욕사','/img/magazine/016.jpg','1935년 할매탕, 1961년 송도탕, 2005년 신세계 스파랜드, 2023년 클럽디 오아시스. 해운대 온천의 연표는 아직도 갱신 중입니다.

순서를 헷갈리면 안 됩니다. 해운대는 해수욕장으로 유명해지기 전에 온천으로 먼저 이름난 동네였습니다. 신라 때는 구남온천이라 불렸고, 천연두를 앓던 진성여왕이 이 물을 찾았다는 이야기가 전해집니다. ''해운대''라는 지명 자체가 신라 최치원의 호 ''해운''에서 왔으니, 백사장 이전에 물과 글이 있었던 셈입니다.

[QUOTE]백사장은 1970년대의 발명품이고, 온천은 신라의 유산이다.

본격적인 개발은 온천욕을 좋아하던 일본인들 손에서 시작됐고, 1935년 문을 연 할매탕이 해운대 최초의 대중목욕탕으로 기록됩니다. 지금도 중동 온천지구에는 할매탕과 송도탕 같은 노포가 파라다이스호텔 씨메르 같은 호텔 스파와 한 동네에서 같은 물을 받아 씁니다.

물은 45~50℃의 알칼리성 식염천. 소금기 있는 물이라 몸이 오래 따뜻합니다. 바닷물 아니냐는 오해를 받지만, 지하에서 올라오는 엄연한 온천법 등록 온천수입니다.

[IMG]중동 온천지구 골목, 호텔 타워 아래 자리를 지키는 동네 목욕탕 간판. ⓒ 물멍

2005년에는 센텀시티 공사 중에 새 온천이 터져 신세계 스파랜드가 들어섰습니다. 백화점을 지으려다 온천을 얻은 도시. 해운대의 목욕사는 그렇게 아직 진행형입니다.','26',4,'2025-10-12 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='해수욕장보다 온천이 먼저였다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='해수욕장보다 온천이 먼저였다' AND source='MANUAL' AND name='해운대온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','지하철 2호선으로 완성하는 목욕 하루','해운대역에서 내려 탕, 국밥, 해리단길 순서로','/img/magazine/017.jpg','이 코스에 자동차는 필요 없어요. 부산 지하철 2호선 해운대역에서 내리면 온천지구까지 걸어서 5분이니까요.

오전 10시, 중동 온천지구. 첫 일정은 탕입니다. 1935년부터 자리를 지킨 할매탕이나 해운대온천센터에서 식염천에 몸을 담가요. 60℃로 솟는 물이라 탕 온도도 화끈한 편이에요. 짭조름한 물이 피부에 남기는 매끈한 막, 그게 해운대 물의 서명이에요.

정오, 국밥. 탕에서 빠져나간 염분은 국물로 채우는 게 부산의 순서예요. 59년째 소고기국밥을 끓이는 해운대원조할매국밥으로 가거나, 돼지국밥이 당기면 오복돼지국밥 해운대점. 어느 쪽이든 온천욕 후의 첫술은 오래 기억에 남아요.

오후 2시, 해리단길. 옛 동해남부선 해운대역이 옮겨 가고 남은 뒷골목이 지금은 부산에서 가장 젊은 골목이 됐어요. 골목 한가운데 우일맨션을 중심으로 2~3층 집들이 다닥다닥 붙어 있고, 홍콩 딤섬집 딤타오에서는 하가우와 샤오롱바오를 쪄내요. 커피 한 잔 들고 폐선 자리의 골목을 천천히 도는 것만으로 오후가 갑니다.

[IMG]해리단길 우일맨션 앞, 오후의 골목. ⓒ 물멍

저녁엔 담백한 국물로 알려진 노포 의령식당에서 우동 한 그릇으로 마무리. 탕, 국밥, 골목, 다시 국물. 바다를 한 번도 안 봐도 꽉 차는 해운대 하루예요.','26',4,'2025-10-13 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='지하철 2호선으로 완성하는 목욕 하루');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='지하철 2호선으로 완성하는 목욕 하루' AND source='MANUAL' AND name='해운대온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','1935년의 때수건과 2023년의 가운, 해운대 식염천의 두 얼굴','할매탕·송도탕에서 씨메르·스파랜드까지, 같은 물 위의 두 세계','/img/magazine/018.jpg','할매탕 1935년, 송도탕 1961년. 해운대 온천지구의 첫 번째 세계는 이 두 개의 개업 연도로 요약됩니다. 탈의장 평상, 열쇠 달린 나무 사물함, 뜨거운 탕과 미지근한 탕 두 개면 충분한 구조. 동네 어르신들이 아침마다 출근하듯 드나드는 곳이라, 관광객이 끼어들면 오히려 이쪽이 이방인입니다.

두 번째 세계는 가운을 입습니다. 파라다이스호텔 씨메르는 바다를 보며 몸을 담그는 구조고, 센텀시티의 신세계 스파랜드는 백화점 공사 중 발견된 온천수로 만든 초대형 찜질 시설입니다. 2023년에는 클럽디 오아시스까지 가세해 워터파크와 온천의 경계를 흐려 놨습니다.

[IMG]할매탕의 나무 사물함 열쇠와 호텔 스파의 가운, 나란히. ⓒ 물멍

두 세계의 수도꼭지에서 나오는 물은 같은 땅에서 올라온 같은 식염천입니다. 신라 구남온천 시절부터 이 물의 용도는 하나, 몸을 지지는 것이었고 그 위에 씌운 포장만 시대마다 달라졌을 뿐입니다.

[QUOTE]입장료는 열 배 차이가 나도, 수도꼭지에서 나오는 물의 족보는 같다.

그래서 어느 쪽이 진짜냐는 질문은 성립하지 않습니다. 둘 다 진짜고, 정답은 교차 방문입니다. 첫날은 호텔 스파에서 바다를 보고, 이튿날 아침엔 노포 탕에서 몸을 깨우는 것.

두 세계를 다 건너 본 사람만이 해운대 물맛을 안다고 말할 수 있습니다. 다음 부산행엔 가운과 때수건, 둘 다 챙기십시오.','26',4,'2025-10-15 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='1935년의 때수건과 2023년의 가운, 해운대 식염천의 두 얼굴');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='1935년의 때수건과 2023년의 가운, 해운대 식염천의 두 얼굴' AND source='MANUAL' AND name='해운대온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','논 한가운데 서 있던 학 한 마리','율곡의 기록으로 남은 덕산온천의 시작','/img/magazine/019.jpg','학 한 마리가 논 한가운데서 날아갈 줄 모르고 서 있었습니다. 이상하게 여긴 마을 사람들이 다가가 보니, 상처 입은 학이 몸을 적시던 자리에서 따뜻한 물이 솟고 있었습니다. 학은 그 물로 상처를 다스린 뒤 날아갔고, 사람들은 그 자리를 약수터로 삼았습니다.

지어낸 이야기 같지만 출전이 있습니다. 이율곡의 『충보』에 실린 기록입니다. 조선의 대학자가 문헌에 남길 만큼, 덕산의 물은 일찍부터 ''낫게 하는 물''로 통했습니다.

근대의 연표는 촘촘합니다. 1917년경 일본인 의사 야스이가 이 물의 약효를 발표했고, 1920년경에는 이갑진이 화학성분을 감정하고 욕탕을 세웠습니다. 해방 후 1947년경 두 번째, 세 번째 천공을 뚫었고 1960년 7월 네 번째 천공이 완성되며 지금의 온천지구 골격이 잡혔습니다.

물은 최고 47.7℃의 약알칼리성 중탄산나트륨천. 리터당 0.017mg의 게르마늄이 녹아 있어 근육통과 신경통에 좋다는 해설이 붙습니다. 중탄산 물답게 탕에서 나올 때 피부가 부드럽게 눌리는 감촉이 남습니다.

지금 덕산 온천지구에는 덕산온천관광호텔, 가야관광호텔을 비롯한 아홉 개 온천업소가 가야산 자락 아래 모여 있습니다. 학이 서 있던 논은 사라졌지만, 물은 백 년 넘게 같은 온도로 올라오고 있습니다.','44',4,'2025-10-16 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='논 한가운데 서 있던 학 한 마리');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='논 한가운데 서 있던 학 한 마리' AND source='MANUAL' AND name='덕산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','새벽 절, 낮의 탕, 저녁의 갈비','예산 덕산에서 보내는 느린 1박 2일','/img/magazine/020.jpg','덕산의 하루는 세 단어로 요약돼요. 절, 탕, 갈비.

가는 길부터 계획이 필요해요. 장항선 예산역에서 내려 덕산행 버스로 30분. 배차가 넉넉하지 않으니 시간표를 미리 봐 두는 편이 좋아요. 첫날 오후에 도착해 온천지구에 짐을 풀고, 다음 날 아침 일찍 수덕사로 향하는 동선을 추천해요.

수덕사는 덕숭산 자락에 있어요. 이곳 대웅전은 국보로 지정된 고려의 목조건물이에요. 화려한 단청 대신 나뭇결이 그대로 드러난 맞배지붕 아래 서면, 칠백 년 된 건물이 내는 고요가 어떤 것인지 알게 돼요. 사람이 적은 이른 아침이 제일 좋아요.

[IMG]덕숭산 수덕사 대웅전, 아침 빛이 비낀 맞배지붕. ⓒ 물멍

산에서 내려오면 낮의 탕. 47℃ 안팎으로 솟는 중탄산나트륨천에 산행으로 뭉친 다리를 풀어요. 미끈하고 부드러운 물이라 오래 담가도 부담이 없어요.

저녁은 갈비예요. 예산은 숯불에 굽는 전통 소갈비의 고장이라, 온천 단지 주변으로 갈비집이 몰려 있어요. 양념갈비 노포 소복갈비, 한우 양념갈비의 대복갈비, 덕산면의 소고기 구이집 고덕갈비 중에 고르면 돼요. 삽다리곱창이라는 향토 음식도 이 동네 몫이에요.

탕에서 데운 몸으로 숯불 앞에 앉는 순간, 1박 2일의 예산이 완성돼요.','44',4,'2025-10-17 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='새벽 절, 낮의 탕, 저녁의 갈비');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='새벽 절, 낮의 탕, 저녁의 갈비' AND source='MANUAL' AND name='덕산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','온천 옆 여관에 화가들이 머물렀다','수덕여관, 나혜석과 이응노의 덕산','/img/magazine/021.jpg','수덕사 아랫마을에는 초가지붕을 인 여관이 하나 있습니다. 수덕여관. 절집 아래 숙소치고는 이력이 화려합니다.

한국 최초의 여성 서양화가로 불리는 나혜석이 말년에 이곳에 머물렀습니다. 이혼과 스캔들로 화단에서 밀려난 그가 수덕사 아래까지 흘러들어 그림을 그리던 시절의 이야기입니다. 그리고 이 여관을 사들여 오래 거처로 삼은 사람이 고암 이응노입니다. 파리로 떠나기 전에도, 동백림 사건으로 옥고를 치른 뒤에도 그는 이 초가로 돌아왔습니다.

[QUOTE]절은 산 위에, 여관은 산 아래에, 온천은 들판에 - 덕산에서는 상처의 위치에 따라 가는 곳이 달랐다.

덕산온천에서 수덕사 가는 길에 이 여관을 끼워 넣으면, 온천 여행이 갑자기 근대 미술사 답사가 됩니다. 학이 상처를 씻었다는 전설의 물에서 몸을 데우고, 상처 입은 화가들이 머물던 초가를 지나, 국보 대웅전 앞에 서는 동선. 세 장소가 걸어서 이어질 만큼 가깝다는 것이 덕산의 힘입니다.

온천지구로 돌아오는 길, 가야산 능선이 들판 너머로 낮게 이어집니다. 사적으로 지정된 윤봉길 의사 유적도 같은 예산 땅이니, 하루를 더 쓸 이유는 충분합니다.

몸만 풀고 돌아가기엔 아까운 동네. 덕산은 물보다 이야기가 깊은 온천마을입니다.','44',4,'2025-10-19 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='온천 옆 여관에 화가들이 머물렀다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='온천 옆 여관에 화가들이 머물렀다' AND source='MANUAL' AND name='덕산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','31도, 미지근함을 변호함','도고 유황천은 왜 뜨겁지 않은가','/img/magazine/022.jpg','탕에 들어갔는데 뜨겁지 않다. 도고온천 첫 방문자의 표정이 흔들리는 순간이에요.

도고의 원수는 25~35.5℃. 체온보다 낮게 솟는 유황천이라, 시설에서는 데워서 탕에 채워요. 그런데 이 미지근함이야말로 도고의 무기예요. 유황 성분이 진하게 녹아 있는 물은 뜨겁게 데우지 않아도 할 일을 하거든요. 달걀 삭는 듯한 특유의 유황 냄새가 탕 위에 얇게 깔리고, 나올 때쯤엔 피부가 한 겹 벗겨진 듯 매끈해져요.

이 물의 이력은 짧지 않아요. 신라시대부터 약수로 이름났다는 기록이 있고, 위장병에 좋다고 알려져 마시는 용도로도 쓰였어요. 음용이 가능한 온천은 전국적으로도 드물어요.

1975년 파라다이스호텔이 들어서며 도고는 전국구 온천 관광지가 됐어요. 박정희 전 대통령이 이 지역에 별장을 두었고 서거 전날 이곳에 머물렀다는 이야기까지, 한 시대의 영욕이 이 작은 온천마을을 지나갔어요. 지금은 파라다이스 스파도고가 그 자리를 잇고 있어요.

[QUOTE]뜨거운 물은 몸을 놀라게 하지만, 미지근한 물은 몸을 설득한다.

도고식 입욕법은 하나예요. 오래 담그기. 42℃ 탕에서 5분 버티는 목욕이 아니라, 미지근한 유황수에 30분씩 몸을 불리는 목욕. 장항선 도고온천역에서 택시로 5분이면 이 느린 물에 닿아요.','44',4,'2025-10-20 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='31도, 미지근함을 변호함');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='31도, 미지근함을 변호함' AND source='MANUAL' AND name='도고온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','도고온천역은 두 개다 — 하나는 페달로 달린다','장항선 옛 도고온천역, 폐역 선로 위 레일바이크 4.8km','/img/magazine/023.jpg','도고온천역은 두 개입니다. 하나는 기차가 서고, 하나는 페달로 달립니다. 역 이름에 ''온천''이 들어간 역이 전국에 몇 없는데, 그중 하나가 이렇게 꼬인 이야기를 갖고 있습니다.

사연은 장항선 직선화 공사입니다. 노선이 옮겨 가면서 온천 단지 가까이 있던 옛 도고온천역은 기차가 서지 않는 폐역이 됐고, 새 도고온천역은 들판 가운데로 물러났습니다. 새 역에서 온천까지는 택시로 5분입니다.

버려질 뻔한 옛 역은 다른 방식으로 살아났습니다. 아산레일바이크가 옛 도고온천역을 출발점 삼아, 기차가 다니지 않는 선로 위를 왕복 4.8km 달립니다. 페달을 밟는 40분 동안 창문 없는 열차의 승객이 되어 들판을 통과합니다. 철길 옆에는 카라반과 글램핑 시설까지 들어섰습니다.

[IMG]옛 도고온천역 승강장, 레일바이크가 출발을 기다린다. ⓒ 물멍

반나절 동선은 이렇습니다. 오전에 레일바이크로 허벅지를 데우고, 근처 세계꽃식물원에서 온실 꽃을 보고, 오후에 유황천에 몸을 담그는 순서. 운동, 산책, 목욕이 해 지기 전에 끝납니다.

[QUOTE]도착하는 방법이 기차에서 페달로 바뀌었을 뿐, 온천역이라는 이름값은 아직 유효하다.

기차는 더 이상 서지 않지만 승강장은 아직 승객을 기다립니다. 새 역에 내리거든 온천으로 곧장 가지 말고, 옛 역 승강장에서 먼저 페달을 밟으십시오.','44',4,'2025-10-22 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='도고온천역은 두 개다 — 하나는 페달로 달린다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='도고온천역은 두 개다 — 하나는 페달로 달린다' AND source='MANUAL' AND name='도고온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','바닷가 온천은 회, 도고는 어죽 — 저수지 고장의 목욕 후 한 그릇','붕어마을과 가마솥붕어찜, 유황천에서 이어지는 민물 동선','/img/magazine/024.jpg','민물고기를 뼈째 곤다. 살을 발라내고, 그 국물에 쌀과 국수를 함께 끓인다. 고춧가루 베이스의 칼칼한 국물. 도고온천에서 나온 사람이 먹는 한 그릇, 어죽입니다.

바닷가 온천은 회를 먹고 도고는 어죽을 먹는 데엔 지리적 이유가 있습니다. 아산 서부는 저수지의 고장이라, 이 동네 보양식은 바다가 아니라 민물에서 옵니다. 어죽이 디지털아산문화대전에 향토음식으로 올라 있을 정도입니다. 비린내 걱정은 접어 둬도 됩니다. 칼칼한 국물이 먼저입니다.

[IMG]걸쭉한 어죽 한 그릇, 국수 가락이 국물 위로 올라온다. ⓒ 물멍

첫 번째 집은 붕어마을. 송악저수지 아래 자리 잡은 노포로, 어죽과 매운탕을 함께 합니다. 먹방 영상에도 소개된 아산 어죽의 터줏대감입니다.

두 번째 집은 가마솥붕어찜. 이름 그대로 붕어찜이 간판입니다. 짭짤한 양념을 얹은 붕어찜에 어죽을 곁들이는 구성이 정석입니다.

온천 단지 안에서 간단히 끝내고 싶은 날엔 도고면의 한식당 새참만땅 도고온천점 같은 선택지도 있습니다.

[QUOTE]유황 냄새가 채 가시지 않은 손으로 국수 가락을 건져 올리는 것. 그게 도고의 방식이다.

순서는 취향이지만, 저는 목욕 후의 어죽을 권합니다. 미지근한 유황천에 30분 불린 몸으로 뜨거운 어죽 한 술을 넘기면 안팎의 온도가 맞춰지는 감각이 옵니다. 탕에서 나오거든 저수지 쪽으로 핸들을 돌리십시오.','44',4,'2025-10-23 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='바닷가 온천은 회, 도고는 어죽 — 저수지 고장의 목욕 후 한 그릇');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='바닷가 온천은 회, 도고는 어죽 — 저수지 고장의 목욕 후 한 그릇' AND source='MANUAL' AND name='도고온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','창 맞은 사슴이 몸을 씻던 샘','백암온천, 기록으로 따지면 국내 최고참급','/img/magazine/025.jpg','사냥꾼이 창으로 사슴을 맞혔습니다. 피를 흘리며 달아난 사슴을 쫓던 그는 이상한 장면을 봅니다. 사슴이 김이 오르는 샘에 몸을 담그고 있다가, 언제 다쳤냐는 듯 산으로 사라진 것. 신라 때 일이라고 전해지는 백암온천 발견담입니다.

전설 다음에는 기록이 이어집니다. 인근 백암사 승려들이 이 샘에 욕탕을 만들어 환자를 치료했고, 고려 명종 때는 현령이 화강암을 다듬어 욕탕을 지었다는 기록이 남아 있습니다. 왕조를 넘나드는 목욕의 족보. 마을 이름 자체가 ''따뜻한 우물''이라는 뜻의 온정리(溫井里)입니다.

물은 53℃로 솟는 유황천입니다. 동해안을 통틀어 대표로 꼽히는 유황온천으로, 만져 보면 미끄러운 듯 부드러운 감촉이 먼저 옵니다. 유황천 특유의 매끈함에 넉넉한 수온까지, 노천탕에서 진가가 나오는 물입니다.

[IMG]온정리 온천지구, 백암산 자락에서 피어오르는 저녁 김. ⓒ 물멍

지금 온정리에는 한화리조트를 비롯한 숙소들이 백암산 등산로 초입까지 이어져 있습니다. 서울에서 가장 먼 축에 드는 온천이라는 점이 오히려 이 마을을 지켰습니다. 다녀간 사람들이 물 자랑부터 하는 데는 이유가 있습니다. 천 년 넘게 검증된 물이니까요.','47',4,'2025-10-25 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='창 맞은 사슴이 몸을 씻던 샘');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='창 맞은 사슴이 몸을 씻던 샘' AND source='MANUAL' AND name='백암온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','평해역에서 버스 20분, 산속 53℃ — 백암 1박 2일의 두 문장','첫날은 온정리 유황천, 둘째 날은 후포항 스카이워크와 대게','/img/magazine/026.jpg','동해선 평해역. 여기서 백암행 버스로 20분이면 온정리예요. 좌표부터 짚으면, 백암온천은 산속이에요. 동해안 온천이라고 탕에서 바다가 보일 거라 기대하면 안 돼요. 대신 이 코스는 산과 바다를 하루씩 나눠 가져요.

첫날은 산. 짐을 풀고 오후엔 신선계곡 쪽으로 다리를 풀러 가요. 물놀이 계곡이라기보다 걷는 계곡이라, 온천 전에 몸을 데우는 예열 코스로 맞아요.

저녁엔 53℃ 유황천. 노천탕에 앉아 산 공기에 얼굴만 식히면서 오래 담그는 게 백암의 정석이에요.

[IMG]온정리 노천탕, 김 너머로 산 능선이 어둡다. ⓒ 물멍

둘째 날은 바다. 버스로 후포항까지 내려가요. 등기산공원의 스카이워크가 하이라이트예요. 바닥이 유리로 된 다리가 바다 위로 뻗어 있어서, 파도 위를 걷는 기분으로 왕복하게 돼요. 점심은 항구 물회나 해산물, 겨울이라면 무조건 대게예요. 후포항은 대게 배가 드나드는 울진의 항구니까요.

돌아오는 길에 시간이 남으면 평해의 월송정에 들러요. 소나무 숲 너머로 동해가 열리는 관동팔경의 정자예요.

[QUOTE]산의 물과 바다의 밥. 백암 1박 2일은 이 두 문장이면 충분하다.

밤엔 다시 탕. 바닷바람에 곤두선 몸을 유황수가 풀어 줘요. 다음 연휴, 평해역행 기차표부터 끊어 보세요.','47',4,'2025-10-26 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='평해역에서 버스 20분, 산속 53℃ — 백암 1박 2일의 두 문장');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='평해역에서 버스 20분, 산속 53℃ — 백암 1박 2일의 두 문장' AND source='MANUAL' AND name='백암온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','기사식당, 순대국, 연수원 식당 — 백암온천 골목의 정직한 세 끼','온정면 골목에서 확인한 실속 밥집 셋, 그리고 후포항이라는 반칙','/img/magazine/027.jpg','백암온천 지구에 화려한 맛집 거리는 없습니다. 이 말부터 하고 시작하는 게 정직합니다. 대신 오래 버틴 실속형 밥집들이 탕과 탕 사이의 허기를 책임집니다. 온정면 골목에서 확인한 세 곳입니다.

① 동광식당. 온천지구의 한식 기사식당입니다. 매일 오는 손님을 상대하는 집은 간을 속이지 못하니, 기사식당이라는 간판은 곧 품질 보증입니다. 백반 한 상으로 목욕 후 허기를 가장 빠르게 정리하는 선택지입니다.

② 큰맘할매순대국. 온천지구 안의 순대국집입니다. 유황천에서 나와 몸이 풀어진 상태라면, 뜨거운 순대국 한 그릇이 마무리 사우나 역할을 합니다.

[IMG]온정면 골목, 기사식당의 백반 한 상. ⓒ 물멍

③ LG생활연수원 레스토랑. 의외의 복병입니다. 연수원 안의 식당이지만 외부인도 이용할 수 있고, 저렴하고 푸짐하다는 후기가 도는 곳입니다. 한식 뷔페나 정식류를 만 원 안쪽 감각으로 해결합니다.

그리고 반칙 같은 네 번째가 있습니다. 겨울이라면 후포항으로 나가는 것. 백암온천은 대게철에 울진 대게찜과 묶이는 보양 코스로 소개되는 동네라, 탕과 대게 사이의 이동이 아깝지 않습니다.

[QUOTE]골목은 조용하고, 밥은 정직하다. 온천마을의 식탁은 그 정도면 충분하다.

맛집 검색창을 닫으십시오. 탕에서 나와 셋 중 가장 가까운 간판으로 들어가면 됩니다.','47',4,'2025-10-28 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='기사식당, 순대국, 연수원 식당 — 백암온천 골목의 정직한 세 끼');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='기사식당, 순대국, 연수원 식당 — 백암온천 골목의 정직한 세 끼' AND source='MANUAL' AND name='백암온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','금문교를 건너 원탕까지 4km','세계의 다리를 놓은 계곡, 덕구 원탕길 트레킹','/img/magazine/028.jpg','샌프란시스코 금문교, 노르망디교, 시드니의 하버교, 서울 서강대교. 이 다리들을 반나절에 전부 건너는 방법이 있습니다. 울진 덕구계곡을 걷는 것입니다.

덕구온천 원탕까지 이어지는 계곡 트레킹 코스에는 세계 각국의 유명 교량을 축소해 만든 다리 열두 개가 놓여 있습니다. 계곡을 왼쪽 오른쪽으로 갈아타며 다리를 하나씩 지우다 보면, 어느새 편도 4km가 끝나 있는 구조입니다. 유치하다고 웃으며 출발한 사람도 여섯 번째 다리쯤에서는 다음 다리 이름을 궁금해합니다.

길 중간의 쉼표는 용소폭포입니다. 용이 승천했다는 전설이 붙은 폭포 아래서 숨을 고르고, 선녀탕이라 불리는 소(沼)를 지나면 상류가 가까워졌다는 신호입니다.

종점에는 보상이 있습니다. 원탕. 응봉산 계곡 바위 틈에서 42℃ 중탄산천이 김을 뿜으며 솟는 현장입니다. 이 나라에서 온천수가 제 힘으로 솟아오르는 모습을 눈으로 볼 수 있는 몇 안 되는 자리이고, 족욕 시설이 있어 걸어온 발을 바로 담글 수 있습니다.

[IMG]원탕 족욕장, 등산화를 벗은 발들이 김 위에 나란하다. ⓒ 물멍

돌아 내려오면 왕복 8km. 덕구온천리조트의 본탕이 기다립니다. 계곡에서 발만 담근 그 물에, 이번엔 전신을 담글 차례입니다.','47',4,'2025-10-29 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='금문교를 건너 원탕까지 4km');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='금문교를 건너 원탕까지 4km' AND source='MANUAL' AND name='덕구온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','600년 전 멧돼지가 먼저 들어간 42℃','울진 덕구 — 펌프 없이 바위 틈에서 솟는 국내 유일의 자연용출 노천탕','/img/magazine/029.jpg','화살 맞은 멧돼지가 계곡물에 몸을 씻더니 언제 그랬냐는 듯 달아났습니다. 고려 말, 응봉산에서 그 뒤를 쫓던 궁수 전모가 물에 손을 넣어 보니 뜨거웠습니다. 덕구온천의 발견담은 이렇게 600년 전에서 시작합니다.

이 물이 다른 온천과 갈라지는 지점은 전설이 아니라 솟는 방식입니다. 대한민국 온천은 거의 전부 수백 미터 지하까지 관을 박고 펌프로 퍼 올린 물입니다. 덕구는 응봉산 계곡 바위 틈에서 42℃ 물이 제 압력으로 솟아오릅니다. 자연용출 온천수를 노천탕으로 쓰는 곳은 국내에서 여기가 유일합니다.

[QUOTE]사람이 판 온천은 수백 곳이지만, 산이 스스로 내어준 온천은 여기 하나다.

42℃라는 숫자도 우연이 아닙니다. 데우지도 식히지도 않고 원수 그대로 탕을 채울 수 있는 온도입니다. 수질은 중탄산천 — 유황천의 미끈함과는 다른, 개운하고 부드러운 계열입니다.

[IMG]응봉산 계곡, 바위 틈에서 김이 오르는 용출 지점. ⓒ 물멍

해운대는 사슴이, 덕산은 학이, 덕구는 멧돼지가 온천을 찾아냈습니다. 전국 온천 전설을 모으면 동물 병원 명부가 됩니다. 다만 덕구의 전설은 지금도 눈으로 확인이 됩니다. 노천탕에 앉으면 그 물이 바위 틈에서 방금 나온 물입니다.

가는 길은 각오가 필요합니다. 울진터미널에서 30km, 대중교통이 불편해 자차가 정답입니다. 600년 동안 펌프 없이 솟은 물 — 이번 주말, 그 바위 틈 앞까지 차를 몰아 보십시오.','47',4,'2025-10-31 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='600년 전 멧돼지가 먼저 들어간 42℃');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='600년 전 멧돼지가 먼저 들어간 42℃' AND source='MANUAL' AND name='덕구온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','어깨 위는 눈, 어깨 아래는 42℃, 다음 날은 대게','덕구온천 노천탕에서 후포항 찜통까지, 겨울 자차 이틀','/img/magazine/030.jpg','어깨 위로는 눈, 어깨 아래로는 42℃. 겨울 덕구온천 노천탕에서만 나오는 장면이에요. 자연용출 온천수에 앉아 있는데 눈이 내리면, 이 온도차 하나를 보러 사람들이 울진까지 차를 몰아요.

울진의 겨울은 짝이 정해져 있어요. 대게예요. 대게의 본고장을 자처하는 동네라, 덕구온천과 대게찜을 묶은 겨울 보양 코스는 한국관광공사 여행기사에 실릴 만큼 공인된 조합이에요.

첫날은 낮에 덕구온천리조트 도착, 오후에 노천탕과 스파. 해가 지면 기온이 떨어지면서 노천탕의 김이 두 배로 진해져요. 이 김을 보려면 해 지기 전에 이미 탕 안에 있어야 해요.

둘째 날은 후포항으로 남하해요. 해안 길로 차로 한 시간 남짓. 후포에서는 게를 고르는 일이 곧 관광이에요. 3대째 53년을 이어 온 원조대게후포리, 다이닝코드에 오른 대게앤쿡과 대원대게센타 — 박달대게를 다루는 집들이 항구에 몰려 있어요.

[IMG]후포항 대게찜 찜통에서 오르는 김. ⓒ 물멍

찜통에서 올라오는 김이 어제 노천탕의 김과 닮았다는 걸, 게 다리를 쥐고서야 깨닫게 돼요.

[QUOTE]첫날은 온천의 김, 둘째 날은 찜통의 김.

탕에서 데운 몸으로 게살을 바르는 겨울 이틀. 울진이 먼 게 아니라 이 조합이 멀리 있는 거예요. 눈 예보가 뜨는 주말을 골라, 첫날 오후를 노천탕에 비워 두세요.','47',4,'2025-11-01 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='어깨 위는 눈, 어깨 아래는 42℃, 다음 날은 대게');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='어깨 위는 눈, 어깨 아래는 42℃, 다음 날은 대게' AND source='MANUAL' AND name='덕구온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','주흘관에서 조령관까지, 그리고 31도의 물','문경새재 옛길 세 관문을 다 걷는 날의 일정표','/img/magazine/031.jpg','관문이 세 개다. 제1관문 주흘관, 제2관문 조곡관, 제3관문 조령관. 문경새재 옛길은 이 셋을 꿰며 이어지고, 끝까지 가면 왕복 반나절이 통째로 들어간다.

아침에 점촌역에 내려 문경행 버스를 타면 30분. 문경새재도립공원 입구에서 걷기를 시작한다. 주흘관까지는 길이 평평해서 몸이 덜 깬 상태로도 걸을 만하고, 흙길이 시작되는 구간부터는 운동화 끈을 다시 묶게 된다. 이 길은 조선시대 영남에서 한양으로 넘던 과거길이었다. 지금은 맨발로 걷는 사람들이 그 길을 차지했는데, 흙이 곱기로 소문난 구간이라 신발을 벗어 든 손이 심심치 않게 보인다.

조곡관을 지나면 사람이 눈에 띄게 줄어든다. 계곡 소리가 커지고, 길의 경사가 조금씩 진심을 드러낸다. 조령관 앞에 서면 여기가 경북과 충북의 경계라는 사실이 실감 난다. 관문 아래 그늘에서 물 한 병을 비우고 돌아서는 것으로 반환점을 찍는다.

[IMG]제1관문 주흘관 앞, 아침 아홉 시의 흙길. ⓒ 물멍

내려와서 먹는 밥은 정해져 있다. 소문난식당의 청포묵조밥. 묵을 채 썰어 조밥에 말아 먹는 문경새재 향토음식인데, 반나절 걸은 위장에 부담이 없다. 석쇠구이가 당기면 새재할매집 쪽이다.

마지막이 온천이다. 문경온천의 물은 31도, 칼슘중탄산천. 뜨겁지 않아서 오래 담글 수 있고, 옛길에서 굳은 종아리가 천천히 풀린다. 걷고, 먹고, 담그고. 이 순서만 지키면 하루가 저절로 완성됩니다.','47',4,'2025-11-03 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='주흘관에서 조령관까지, 그리고 31도의 물');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='주흘관에서 조령관까지, 그리고 31도의 물' AND source='MANUAL' AND name='문경온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','돼지한테 돌을 먹인다고요?','문경 약돌돼지와 온천지구 정육식당의 저녁','/img/magazine/032.jpg','돼지한테 돌을 먹인다고요? 문경에서는 진짜예요. 거정석이라 부르는 약돌을 갈아 사료에 섞여 먹인 돼지와 한우가 이 동네의 명물이고, 방송에도 여러 번 나왔어요. 전현무계획3에도 소개됐죠.

약돌돼지를 제대로 먹으려면 문경온천지구로 가면 돼요. 온천약돌한우돼지정육식당은 이름 그대로 정육식당이라, 고기를 근으로 끊어 자리에서 구워 먹는 방식이에요. 약돌한우와 약돌돼지를 같이 놓고 비교해보는 재미가 있는데, 돼지 쪽이 확실히 잡내가 덜하다는 게 중론이에요. 상추에 싸기 전에 소금만 찍어 한 점, 이게 정육식당에서 지켜야 할 첫 번째 예의고요.

고기가 아니면 묵이에요. 문경새재 쪽으로 방향을 틀면 향토음식 묵조밥이 기다려요. 청포묵을 채 썰어 조밥에 말아 먹는 소박한 음식인데, 소문난식당이 이 메뉴로 오래 이름을 지켰어요. 고기의 동네이면서 묵의 동네라니, 문경의 상은 생각보다 폭이 넓어요.

[QUOTE]온천 동네에서 고기를 먹는 건 순서의 문제다 — 먼저 담그면 저녁이 길어지고, 먼저 구우면 밤이 짧아진다.

저는 온천을 먼저 권해요. 문경온천은 31도 칼슘중탄산천이라 한 시간 가까이 담가도 어지럽지 않고, 나와서 먹는 고기가 두 배로 맛있거든요. 숙소는 온천지구 안에 잡으면 걸어서 다 해결돼요. 점촌역에서 버스로 30분, 고기와 물만으로 채워지는 1박이에요.','47',4,'2025-11-04 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='돼지한테 돌을 먹인다고요?');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='돼지한테 돌을 먹인다고요?' AND source='MANUAL' AND name='문경온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','미지근하다고 실망하는 사람에게','31도 칼슘중탄산천을 오래 담그는 법','/img/magazine/033.jpg','문경온천 후기를 읽다 보면 꼭 나오는 문장이 있습니다. "물이 미지근해요." 맞는 말입니다. 31도니까요. 사람 체온보다 낮습니다.

그런데 온천의 세계에서 이건 단점이 아니라 유형입니다. 42도짜리 뜨거운 탕은 10분을 버티기 어렵지만, 31도의 물은 30분이고 한 시간이고 몸을 맡길 수 있습니다. 뜨거운 탕이 사우나에 가깝다면 미온탕은 반신욕에 가깝습니다. 심장에 부담이 적어서 부모님을 모시고 가기에도 이쪽이 낫습니다.

물의 성분도 다릅니다. 문경의 물은 칼슘중탄산천. 중탄산 성분이 든 물은 감촉이 부드러운 쪽이라, 오래 담그는 미온욕과 궁합이 좋습니다. 문경새재 옛길을 걷고 온 날이라면 더 그렇습니다. 굳은 다리는 뜨거운 물에 잠깐 데우는 것보다 미지근한 물에 오래 푸는 쪽이 다음 날 아침이 다릅니다.

[IMG]탕에서 나와 창밖을 보면 주흘산 능선이 걸려 있다. ⓒ 물멍

그러니 문경에서는 시계를 보지 말고 들어가십시오. 물이 식었다고 느껴질 때가 아니라, 손끝이 쭈글쭈글해졌을 때 나오는 물입니다. 미지근함은 이 온천의 결함이 아니라 사용법입니다.','47',4,'2025-11-06 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='미지근하다고 실망하는 사람에게');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='미지근하다고 실망하는 사람에게' AND source='MANUAL' AND name='문경온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','마시는 오색, 담그는 오색','약수와 온천이 한 동네에 있다는 것','/img/magazine/034.jpg','오색에는 물이 두 가지 있어요. 마시는 물과 담그는 물. 오색약수터의 약수는 철분이 든 톡 쏘는 물이고, 오색온천은 42도 알칼리성 온천수예요. 한 동네에서 속과 겉을 다 챙기는 셈이죠. 관광공사 기사 제목도 정확해요. "약수로 속을 달래고 온천으로 피부를 매끄럽게."

순서는 이래요. 아침에 약수터로 걸어가 한 바가지 떠 마시고, 주전골 입구의 산채마을에서 밥을 먹어요. 약수식당은 아예 오색약수로 밥을 지어요. 산채백반에 딸려 나오는 나물 가짓수를 세다가 포기하게 되는 집이에요. 오색단골식당의 산채비빔밥도 좋은 선택지고요.

[QUOTE]속은 약수가, 겉은 온천이, 배는 산나물이 맡는다. 오색의 분업은 명확하다.

두 물의 성격은 정반대예요. 약수는 차고 톡 쏘고, 온천은 뜨겁고 부드러워요. 약수는 서서 마시고, 온천은 누워서 받아요. 그런데 이상하게 둘을 같은 날 겪고 나면 한 세트였다는 생각이 들어요. 몸의 안팎을 같은 산의 물로 채우는 경험이니까요.

오후엔 온천이에요. 42도 알칼리성 물은 나올 때 피부가 미끌미끌한 게 특징인데, 등산객들 사이에서 하산 후 코스로 오래 사랑받은 이유예요. 한계령 길목이라 자차가 편하고, 숙소도 온천지구 안에 있어요. 설악산까지 안 올라가도 돼요. 물 두 가지만으로 오색은 이미 목적지예요.','51',4,'2025-11-07 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='마시는 오색, 담그는 오색');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='마시는 오색, 담그는 오색' AND source='MANUAL' AND name='오색온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','오후 1시 약수터 출발, 4시 알칼리탕 입수','주전골 편도 3.2km, 정상 없는 설악 반나절','/img/magazine/035.jpg','오후 한 시, 오색약수터. 주전골 탐방로는 여기서 용소폭포까지 편도 3.2km다. 기암절벽 사이 계곡을 따라가지만 경사가 완만해 등산화 없이도 걷는다. 설악산에 왔지만 정상은 애초에 계획에 없는 사람들의 코스다.

길은 성국사를 지나 계곡 안쪽으로 든다. 선녀탕의 물빛을 지나고 용소폭포 앞에서 돌아선다. 왕복 두 시간 반이면 넉넉하다. 반환점까지가 오늘 걷기의 전부고, 그 이상은 계획에 없다.

단풍철 주말에는 이 짧은 길에 하루 수천 명이 몰린다. 고요하게 걷고 싶다면 평일 오전이 답이다. 물소리가 끊기지 않는 길이라 이어폰은 처음부터 가방에 넣어 두는 게 낫다.

[IMG]주전골 계곡, 물빛이 초록에서 옥색으로 바뀌는 지점. ⓒ 물멍

네 시쯤 내려오면 몸이 딱 알맞게 데워져 있다. 이제 오색온천이다. 42도 알칼리성 물에 들어가면 계곡 바람에 식은 겉과 걷느라 데워진 속이 한 번에 정리된다. 탕 안에서 오늘 걸은 3.2km가 다리에서 천천히 풀려 나간다. 나올 때 피부가 매끈한 건 알칼리성 물의 덤이다.

[QUOTE]정상을 밟지 않아도 설악산을 다녀왔다고 말할 수 있는 반나절.

저녁은 산촌식당의 더덕구이. 고추장 양념을 발라 구운 더덕 향이 온천 뒤의 허기와 맞는다. 다음 평일 오전, 등산화 대신 운동화를 신고 오색약수터에 서라.','51',4,'2025-11-09 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='오후 1시 약수터 출발, 4시 알칼리탕 입수');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='오후 1시 약수터 출발, 4시 알칼리탕 입수' AND source='MANUAL' AND name='오색온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','해 지기 전에 한계령, 탕은 밤과 아침 두 번','자차로 가는 오색 1박, 챙길 것은 세 가지뿐','/img/magazine/036.jpg','굽이를 돌 때마다 설악의 능선이 각도를 바꾼다. 한계령 길이다. 오색온천은 이 길목의 산중 온천마을이라 대중교통이 불편하고 자차가 사실상 정답인데, 바로 그 이유로 한계령을 넘는 드라이브 자체가 여행의 첫 코스가 된다.

자차 1박이라면 챙길 것은 세 가지다.

① 도착 시간. 한계령 구간은 해가 지면 아쉽다. 능선이 각도를 바꾸는 길이니 밝을 때 넘어야 본전을 뽑는다.

② 밥 순서. 첫 끼는 주전골 입구 산채마을. 오색약수로 밥을 짓는 약수식당의 산채백반이 기준점이다. 더덕구이는 산촌식당, 산채정식은 오색단골식당 — 이렇게 나눠 가면 1박 두 끼가 겹치지 않는다.

③ 탕 타이밍. 오색온천의 42도 알칼리성 물은 밤과 아침, 두 번 담그라고 있는 물이다. 숙소가 온천지구 안에 있으니 밤에는 하루를 정리하는 탕, 아침에는 몸을 깨우는 탕. 같은 물인데 온도가 다르게 느껴진다.

[QUOTE]산중 온천의 사치는 시설이 아니라 횟수다. 밤에 한 번, 아침에 한 번.

[IMG]한계령 굽잇길에서 본 설악 능선, 해 지기 전의 빛. ⓒ 물멍

체크아웃하고 다시 한계령을 넘어 돌아오는 길, 어제 본 능선이 반대 방향에서 다시 펼쳐진다. 같은 길인데 두 번 새롭다. 내비게이션 도착 시간을 일몰 전으로 맞추고 출발하라.','51',4,'2025-11-10 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='해 지기 전에 한계령, 탕은 밤과 아침 두 번');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='해 지기 전에 한계령, 탕은 밤과 아침 두 번' AND source='MANUAL' AND name='오색온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','1965년에 문을 연 순두부집 옆 온천','학사평 콩꽃마을 노포 세 곳과 척산의 뜨거운 물','/img/magazine/037.jpg','1965년. 김영애할머니순두부가 문을 연 해다. G1방송이 ''강원의 노포'' 시리즈에서 다룬 이 집을 시작으로, 척산온천 바로 옆 학사평 콩꽃마을에는 순두부집이 촘촘히 모여 있다. 미시령 아래 첫 마을, 속초 사람들이 순두부촌이라 부르는 동네다.

노포 순례의 동선은 단순하다.

① 김영애할머니순두부 — 초당순두부. 60년을 이어온 기준점이니 처음이라면 여기부터.

② 원조 재래식 할머니 순두부 — 상호에 들어간 ''재래식''이 영업 방침이다. 간수 대신 바닷물로 콩을 앉히는 옛 방식의 순두부를 낸다.

③ 시골이모순두부 — 현지인 지분이 높은 집. 앞 두 곳이 붐빌 때의 확실한 대안이다.

[IMG]학사평 순두부, 양념장을 얹기 전의 뽀얀 상태. ⓒ 물멍

세 집의 공통점은 콩이 주인공이라는 것. 순두부백반을 시키면 두부가 반찬이 아니라 주식이고, 간을 양념장으로 할지 그냥 먹을지가 이 동네의 오랜 논쟁거리다. 답은 없다. 반은 그냥, 반은 얹어 먹으면 된다.

순두부로 속을 데웠으면 이제 겉을 데울 차례다. 척산온천의 물은 53도. 전국 온천 중에서도 수온이 높은 축이라, 탕에 발을 넣는 순간 순두부의 온기가 장난이었다는 걸 알게 된다. 속초터미널에서 3-1번 버스로 15분. 순두부와 온천, 콩꽃마을의 하루는 두 가지 흰 김으로 요약된다.','51',4,'2025-11-12 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='1965년에 문을 연 순두부집 옆 온천');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='1965년에 문을 연 순두부집 옆 온천' AND source='MANUAL' AND name='척산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','속초 여행은 탕에서 끝내는 겁니다','설악동에서 척산온천으로, 마지막 날의 동선','/img/magazine/038.jpg','"어디 안 들르고 바로 갈 거야?" 속초 여행 마지막 날, 일행 중 누군가는 꼭 이렇게 묻는다. 그때 꺼낼 카드가 척산온천이다. 속초 사람들이 오래전부터 여행의 마무리 코스로 쓰던 곳.

마지막 날의 동선은 이렇다. 오전에는 설악동으로. 신흥사를 한 바퀴 돌거나, 줄이 짧으면 설악 케이블카로 권금성에 올라 울산바위를 눈에 담는다. 시내에서 설악동까지는 7번, 7-1번 버스가 다닌다.

내려와서 점심은 학사평 순두부촌. 척산온천과 같은 생활권이라 동선이 겹치지 않는다. 그러고 나서 오후 두세 시, 체크아웃한 짐을 든 채로 척산온천에 들어간다.

[IMG]오후 세 시의 탕, 창으로 설악 능선이 들어온다. ⓒ 물멍

53도 알칼리성 온천수는 여행 마지막 날의 몸에 정확히 작동한다. 사흘치 걸음이 뭉친 다리, 바닷바람 맞은 어깨가 순서대로 풀린다. 탕에서 나와 터미널로 가는 3-1번 버스는 15분. 버스가 시외터미널에 닿을 때쯤이면 이미 반쯤 잠들어 있을 것이다. 여행을 끝내는 방법으로 이보다 나은 걸 아직 찾지 못했다.','51',4,'2025-11-13 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='속초 여행은 탕에서 끝내는 겁니다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='속초 여행은 탕에서 끝내는 겁니다' AND source='MANUAL' AND name='척산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','발목 30초, 무릎 30초, 허리 30초 — 53도에 들어가는 법','속초 척산온천, 데우지 않은 원수가 목욕물보다 뜨겁다','/img/magazine/039.jpg','발목 삼십 초, 무릎 삼십 초, 허리 삼십 초. 척산온천에 들어가는 순서다. 수온 53도, 데우지 않은 원수가 이미 목욕물보다 뜨거운 물이라 어깨까지 한 번에 담그면 삼 분을 못 버틴다. 단계를 밟으면 십 분이 간다.

53이라는 숫자는 비교해야 보인다. 전국 온천 대부분이 30도 안팎의 미온천이다. 그 사이에서 53도는 흔치 않은 물이고, 이 숫자를 알고 나면 탕 앞에 서는 자세가 달라진다.

진가는 겨울에 나온다. 설악산에 첫눈 소식이 오고 미시령 쪽에서 바람이 내려오기 시작하면 척산온천은 속초의 난방 기구가 된다. 대한민국 구석구석도 이곳을 바다 도시 속초의 따끈한 겨울 행선지로 소개했다.

두 번째 입수가 진짜다. 나와서 찬 공기에 몸을 식혔다가 다시 들어가면, 이때부터 물이 뜨겁지 않고 깊게 느껴진다. 발목부터 다시 삼십 초, 이번엔 몸이 순서를 기억한다.

[QUOTE]미온천이 반신욕이라면 척산은 담금질이다. 나온 뒤의 개운함이 종류가 다르다.

[IMG]척산온천 탕 위로 오르는 김, 창밖은 눈 덮인 설악 자락. ⓒ 물멍

알칼리성 물이라 나올 때 피부는 매끈하다. 겨울 속초에서 대게와 물회만 먹고 돌아간다면 이 도시의 온도를 절반만 경험한 것이다. 나머지 절반은 53도다. 발목부터 삼십 초, 시작하라.','51',4,'2025-11-14 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='발목 30초, 무릎 30초, 허리 30초 — 53도에 들어가는 법');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='발목 30초, 무릎 30초, 허리 30초 — 53도에 들어가는 법' AND source='MANUAL' AND name='척산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','노란 꽃 아래 돌담길, 그다음은 게르마늄','3월의 산동면, 산수유꽃과 온천의 순서','/img/magazine/040.jpg','3월 중순, 구례군 산동면 전체가 노랗게 변한다. 산수유나무 수만 그루가 일제히 꽃을 여는 계절, 구례산수유꽃축제가 열리는 때다. 전국의 카메라가 이 산골로 모여든다.

꽃구경의 중심은 산수유마을이다. 돌담과 밭두렁을 따라 산수유길이 이어지는데, 상위마을 쪽 돌담길이 특히 사진가들의 사랑을 받는다. 노란 꽃과 검은 돌담의 대비, 그 아래로 흐르는 계곡물. 오전 빛이 좋으니 일찍 움직이는 편이 낫다.

[IMG]상위마을 돌담 위로 넘친 산수유꽃, 3월 셋째 주. ⓒ 물멍

꽃길을 두어 시간 걸으면 이른 봄 공기에 몸이 식는다. 그때 내려가는 곳이 지리산온천이다. 산수유마을과 같은 산동면, 꽃길에서 온천지구까지가 한동네다. 물은 32도 게르마늄천. 뜨겁지 않아 꽃놀이로 상기된 몸을 천천히 가라앉히기에 맞는 온도다.

저녁은 온천지구 인근에서 해결된다. 산수유텃밭식당의 산채 한상이나 송림민속가든의 흑돼지구이. 축제 기간엔 어디든 붐비니 저녁은 조금 이르게 먹는 게 요령이다. 꽃은 열흘이면 지지만, 물은 사철 같은 온도로 기다린다.','46',4,'2025-11-16 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='노란 꽃 아래 돌담길, 그다음은 게르마늄');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='노란 꽃 아래 돌담길, 그다음은 게르마늄' AND source='MANUAL' AND name='지리산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','기차에서 내려 25분, 지리산 온천마을','구례구역에서 시작하는 뚜벅이 온천행','/img/magazine/041.jpg','지리산 자락 온천에 차 없이 갈 수 있을까요? 됩니다. 구례는 전라선이 지나는 동네고, 구례구역에서 산동행 버스를 타면 25분 만에 지리산온천 지구에 내려요.

구례구역은 재미있는 역이에요. 이름은 구례인데 행정구역상 섬진강 건너에 있어서, 역을 나서면 강부터 만나요. 지리산으로 드는 관문 역할을 오래 해온 역이라 등산 배낭이 늘 보이고요. 여기서 버스로 산동면까지 들어가는 길은 창밖이 지루할 틈이 없어요. 섬진강을 끼고 달리다 지리산 자락으로 방향을 트는 노선이거든요.

온천지구에 내리면 그다음부터는 전부 도보 생활권이에요. 숙소도 탕도 식당도 걸어서 해결돼요. 32도 게르마늄천은 오래 담그는 물이라, 시간에 쫓기지 않는 뚜벅이 여행의 속도와 잘 맞아요. 게르마늄 성분은 피로회복에 좋다고 알려져 있죠. 기차로 내려온 피로까지 여기서 정산하면 돼요.

[QUOTE]차가 없으면 못 가는 온천이 있고, 차가 없어서 더 좋은 온천이 있다. 여긴 후자다.

돌아가는 날, 버스 시간을 넉넉히 잡으세요. 시골 버스는 도시의 시간표대로 움직이지 않으니까요. 그 여유까지가 이 여행의 일부예요.','46',4,'2025-11-17 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='기차에서 내려 25분, 지리산 온천마을');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='기차에서 내려 25분, 지리산 온천마을' AND source='MANUAL' AND name='지리산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','초록 국물 한 숟갈, 흑돼지 한 점, 그다음 32도','구례에서 지리산온천은 마지막 순서다','/img/magazine/042.jpg','국물이 초록빛이다. 토지다슬기식당의 다슬기수제비, 처음 보면 낯설지만 한 숟갈이면 이해가 끝난다. 속이 헹궈지는 맛. 구례 여행에서 온천은 마지막 순서고, 그 앞은 이렇게 밥으로 채운다.

섬진강과 지리산을 양쪽에 둔 동네라 구례의 상은 강과 산에서 반반씩 온다. 강에서 오는 건 다슬기다. 섬진강 다슬기를 넣어 끓인 수제비와 탕이 구례의 대표 음식이고, 토지다슬기식당은 생생정보통에 방영된 다슬기 전문점이다.

산에서 오는 건 흑돼지와 나물이다. 지리산 흑돼지는 송림민속가든에서 구이로, 산나물은 산수유마을 권역의 산수유텃밭식당에서 한상으로 받는다. 구이 한 번, 한상 한 번 — 산은 두 번에 나눠 받는다.

[IMG]토지다슬기식당의 다슬기수제비, 국물이 초록빛이다. ⓒ 물멍

강과 산을 한 바퀴 돌고 나서 지리산온천이다. 게르마늄천, 32도. 배부른 몸에도 부담이 없는 온도라는 게 중요하다. 뜨거운 탕은 식후에 피해야 하지만 이 물은 저녁을 먹고 소화를 시키며 천천히 담그기에 알맞다. 밥을 가볍게 먹을 필요가 없고, 탕이 가벼우면 되는 순서다.

[QUOTE]밥 잘 먹는 동네의 온천이 미온천이라는 건 우연이 아닐지도 모른다.

순서를 지켜라. 다슬기, 흑돼지, 나물, 그리고 32도. 온천을 먼저 가면 이 동네의 절반을 빈속으로 지나치게 된다.','46',4,'2025-11-19 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='초록 국물 한 숟갈, 흑돼지 한 점, 그다음 32도');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='초록 국물 한 숟갈, 흑돼지 한 점, 그다음 32도' AND source='MANUAL' AND name='지리산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','새벽 다섯 시 반, 세량지에 서는 사람들','물안개 출사와 게르마늄탕으로 짜는 화순 하루','/img/magazine/043.jpg','새벽 다섯 시 반, 화순 세량지 둑 위에 삼각대가 줄지어 선다. 수면에서 물안개가 오르고 산벚꽃이 물에 비치는 봄 새벽, CNN이 한국에서 가봐야 할 곳으로 꼽으면서 전국구가 된 저수지다. 둘레길이 800m 남짓이라 한 바퀴에 부담이 없고, 입장료도 주차비도 없다.

문제는 새벽 출사가 몸에 남기는 것들이다. 쪼그려 앉아 기다린 무릎, 이슬에 젖은 신발, 설친 잠. 화순이 좋은 건 이 비용을 정산할 온천이 같은 군 안에 있다는 점이다. 화순온천의 31도 게르마늄천. 새벽에 굳은 몸을 아침나절 내내 담가 푸는 데 이만한 온도가 없다.

[IMG]해 뜨기 직전의 세량지, 물안개가 수면을 덮었다. ⓒ 물멍

출사가 목적이 아니어도 상관없다. 카메라 없이 둑에 서 있는 사람들도 많다. 물안개가 걷히고 수면이 거울이 되는 십오 분 남짓, 저수지 하나가 산 전체를 반사하는 장면은 맨눈으로 보는 쪽이 오히려 낫다는 사람도 있다.

동선은 이렇다. 새벽 세량지, 오전 온천, 점심은 남도 한정식. 도곡온천 인근 원화리의 광화문연가가 한정식으로 이름난 집이다. 상다리가 실제로 휘는 걸 보고 싶다면 화순이 맞는 동네다.

오후에는 낮잠을 자도 되고, 탕에 한 번 더 들어가도 된다. 새벽에 부지런했던 사람만 누리는 종류의 게으름이다.','46',4,'2025-11-20 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='새벽 다섯 시 반, 세량지에 서는 사람들');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='새벽 다섯 시 반, 세량지에 서는 사람들' AND source='MANUAL' AND name='화순온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','천 개의 탑을 세우다 만 절','운주사 미완의 돌들과 온천의 저녁','/img/magazine/044.jpg','운주사는 완성되지 않은 절이다. 천불천탑, 그러니까 천 개의 불상과 천 개의 탑을 하룻밤에 세우려 했다는 전설이 내려오고, 지금도 골짜기 곳곳에 투박한 석불과 석탑이 흩어져 있다. 절터 전체가 사적으로 지정된, 화순이 품은 가장 이상한 공간이다.

이 절의 주인공은 누워 있다. 산등성이의 와불. 이 부처가 일어나는 날 새로운 세상이 온다는 이야기가 붙어 있는데, 실제로 가서 보면 일어날 생각이 전혀 없어 보이는 평온한 얼굴이다. 다듬다 만 듯한 돌부처들의 표정은 박물관 유리장 안의 불상과는 완전히 다른 인상을 남긴다. 잘생겨서가 아니라 이상해서 오래 보게 되는 얼굴들이다.

[QUOTE]운주사의 돌들은 완성을 포기한 게 아니라 완성이라는 개념을 무시한 것처럼 보인다.

골짜기를 천천히 오르내리면 두 시간이 간다. 그다음이 온천이다. 화순온천의 31도 게르마늄천은 돌밭을 걸은 다리를 서두르지 않고 풀어주는 물이다. 천 년 전 돌 깎던 사람들도 이 근처 어딘가에서 몸을 녹였을까, 탕 속에서 그런 실없는 생각을 하기 좋은 저녁이다.','46',4,'2025-11-22 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='천 개의 탑을 세우다 만 절');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='천 개의 탑을 세우다 만 절' AND source='MANUAL' AND name='화순온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','유스퀘어에서 40분, 짐은 수건 한 장','광주 사람의 당일치기 화순온천 계산법','/img/magazine/045.jpg','광주 유스퀘어 터미널에서 화순행 버스로 40분. 서울 사람이 근교 카페 가는 시간에 광주 사람은 온천에 도착합니다. 강원도쯤은 가야, 하룻밤은 자야 온천답다는 계산이 여기서 무너집니다.

거리가 가까우면 여행의 문법이 바뀝니다. 짐이 없어집니다. 수건과 갈아입을 속옷이면 충분합니다. 계획도 없어집니다. 토요일 아침에 눈을 떠서 결정해도 늦지 않습니다.

물은 게르마늄천, 31도입니다. 미온천이라 두 시간을 담가도 지치지 않습니다. 뜨거운 탕은 금방 나오게 되지만 이 물은 반나절을 통째로 맡길 수 있어, 당일치기와 궁합이 맞습니다.

화순군에는 온천지구가 둘입니다. 화순온천과 도곡온천. 단골들은 취향대로 갈라집니다.

[IMG]화순행 시외버스 차창, 광주 시내를 벗어나는 지점. ⓒ 물멍

점심은 남도 밥상입니다. 도곡 일대가 한정식으로 알려진 동네라, 탕에서 불린 허기를 반찬 이십 첩으로 채우고 돌아오는 게 화순식 일정입니다.

[QUOTE]하루를 다 쓰지 않고도 온천을 다녀왔다는 것, 이게 화순의 사치다.

오후 버스로 광주에 돌아오면 해가 아직 남아 있습니다. 이번 토요일 아침, 눈을 뜨고 나서 정하십시오. 수건 한 장이면 됩니다.','46',4,'2025-11-23 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='유스퀘어에서 40분, 짐은 수건 한 장');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='유스퀘어에서 40분, 짐은 수건 한 장' AND source='MANUAL' AND name='화순온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','마산역에서 버스 40분, 뚜벅이의 마금산 하루','차 없이 창원 북면 온천단지를 도는 가장 단순한 동선','/img/magazine/046.jpg','마산역 앞에서 북면행 버스를 타면 40분. 창밖 풍경이 아파트에서 논으로 바뀔 즈음 온천단지 정류장에 내려요.

오전은 몸 데우는 시간이에요. 마금산온천의 물은 55도 염화나트륨천이라 탕에 들어가는 순간 짭짤한 기운이 먼저 와요. 경남에서 처음으로 보양온천 지정을 받은 물이라, 동네 어르신들은 이 물을 ''약물''이라고 불러요. 두 시간쯤 담갔다 나오면 정오가 조금 넘어요.

점심은 온천단지 안 황우장사로. 정육코너에서 직접 손질하는 토종 한우 전문점인데, 혼자라면 선지해장국 한 그릇이 맞고 둘 이상이면 꽃등심을 구워요. 탕에서 빠진 염분을 국물로 채우는 순서라고 생각하면 돼요.

[IMG]온천단지 골목, 김이 오르는 목욕탕 굴뚝과 한우 식당 간판이 나란히 서 있다. ⓒ 물멍

오후엔 마금산온천 족욕체험장에 앉아요. 신발 벗고 발만 담그는 무료 시설인데, 버스 시간이 애매하게 남았을 때 여기만큼 좋은 대기실이 없어요. 발이 불을 때쯤 정류장으로 걸어가면 하루가 끝나요.

돌아가는 버스에서는 대체로 잠들어요. 그게 이 코스의 마지막 순서예요.','48',4,'2025-11-25 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='마산역에서 버스 40분, 뚜벅이의 마금산 하루');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='마산역에서 버스 40분, 뚜벅이의 마금산 하루' AND source='MANUAL' AND name='마금산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','55도 소금물에 몸을 담근다는 것','마금산 염화나트륨천은 왜 ''진한 물''로 불리나','/img/magazine/047.jpg','탕에 들어가고 삼십 초쯤 지나면 알게 됩니다. 이 물은 다른 데보다 무겁습니다.

마금산온천의 원수는 55도, 수질은 염화나트륨천입니다. 바닷물처럼 짠 성분이 녹아 있는 물인데, 염화물천의 소금기는 피부 표면에 얇은 막을 만들어 목욕 후에도 열이 잘 빠져나가지 않게 붙잡아 둡니다. 흔히 ''보온의 물''이라 부르는 이유입니다. 창원 북면의 이 물은 경남 최초로 보양온천 지정을 받았고, 지금도 온천단지의 목욕탕들이 같은 물줄기를 나눠 씁니다.

[QUOTE]수건으로 닦아도 살갗 어딘가에 소금기가 한 겹 남아 있는 기분, 그게 마금산의 지문이다.

뜨거운 물이 부담스러우면 탕 앞에서 오래 버티지 말고 짧게 여러 번 들어가는 편이 낫습니다. 염화물천은 길게 한 번보다 짧게 세 번이 몸에 순합니다. 나와서는 물을 많이 마시고, 점심으로는 근처 김박사명품해장국&냉면에서 뜨거운 해장국이나 찬 냉면 중 몸이 시키는 쪽을 고르면 됩니다.

온천은 결국 물 맛으로 기억됩니다. 마금산은 짠맛으로 기억되는 동네입니다.','48',4,'2025-11-26 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='55도 소금물에 몸을 담근다는 것');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='55도 소금물에 몸을 담근다는 것' AND source='MANUAL' AND name='마금산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','철새가 먼저 아는 겨울, 주남저수지에서 마금산까지','탐조대의 찬 공기와 염화나트륨탕의 순서','/img/magazine/048.jpg','겨울 주남저수지의 아침은 소리로 시작해요. 수면 위로 새 떼가 한꺼번에 날아오르는 소리요. 재두루미가 내려앉는 계절이면 탐조대 앞에 망원렌즈가 줄을 서요.

주남저수지는 창원이 자랑하는 철새도래지예요. 탐조대에서 새를 보고, 람사르문화관에서 몸을 녹이며 습지 전시를 훑고, 시간이 남으면 둘레길을 걸어요. 겨울 탐조의 문제는 하나예요. 가만히 서서 기다리는 동안 발끝부터 얼어붙는다는 것.

그래서 이 동선의 후반부가 마금산이에요. 주남저수지와 마금산온천은 같은 창원 북쪽 권역이라 차로 이어 붙이기 좋아요. 55도 염화나트륨천은 보온이 강점인 물이라, 한나절 얼었던 몸을 다시 데우는 용도로는 과할 만큼 적확해요.

[IMG]탐조대 난간에 올려둔 장갑 한 켤레. 렌즈 너머로 재두루미 무리가 내려앉는다. ⓒ 물멍

저녁은 온천단지의 황우장사에서 한우로 마무리하거나, 해장국 한 그릇으로 가볍게 접어도 돼요. 새벽부터 새를 쫓은 날은 대체로 후자가 이겨요.

새 보러 갔다가 목욕으로 끝나는 하루. 창원 북면의 겨울은 그렇게 접는 게 맞아요.','48',4,'2025-11-28 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='철새가 먼저 아는 겨울, 주남저수지에서 마금산까지');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='철새가 먼저 아는 겨울, 주남저수지에서 마금산까지' AND source='MANUAL' AND name='마금산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','바닷길 열리는 시간이 온천 시간을 정한다','제부도 → 궁평항 낙조 → 율암온천, 물때표로 짜는 화성 하루','/img/magazine/049.jpg','이 여행은 물때표에서 시작해요. 제부도 바닷길은 하루 두 번 열리고 두 번 닫혀요. 길이 열리는 시간에 섬에 들어갔다 나오고, 나머지 일정을 그 앞뒤에 붙이는 게 화성 당일치기의 뼈대예요. 율암온천은 그 ''뒤''에 놓을 때 가장 좋아요.

오전에 바닷길이 열리는 날이면 제부도부터. 갯벌 너머로 길이 드러나는 걸 보며 건너는 게 이 섬의 본론이에요.

섬에서 나와 궁평항으로 이동하면 오후예요. 궁평항은 화성 8경에 드는 낙조 포인트라 해가 기울기 시작하면 방파제 쪽으로 사람들이 모여요.

[IMG]궁평항 방파제, 해가 기울기 시작할 때 모여드는 사람들. ⓒ 물멍

낙조까지 보고 나면 몸이 바닷바람에 절어 있어요. 여기서 율암온천으로. 발안IC 근처라 서해안 어디서 출발해도 접근이 짧아요. 물은 29도 유황천 — 탕은 데운 물로 채워 쓰지만 유황 특유의 매끈함은 그대로예요.

숙박 시설이 없는 온천이에요. 애초에 당일치기 전용으로 설계된 셈이고, 그게 물때에 맞춰 움직이는 이 동네와 잘 맞아요. 저녁은 온천 근처 서해정에서 백숙. 국물이 깊어서 바람 맞은 날 마지막 코스로 어울려요.

[QUOTE]율암은 물때표의 마지막 줄에 적는 온천이다.

물때가 저녁에 걸리는 날이면 순서를 통째로 뒤집으면 돼요. 온천을 먼저, 바다를 나중에. 출발 전날 밤, 제부도 물때표부터 열어 보세요.','41',4,'2025-11-29 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='바닷길 열리는 시간이 온천 시간을 정한다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='바닷길 열리는 시간이 온천 시간을 정한다' AND source='MOIS' AND external_id='69' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','미지근한 온천은 실패인가요','29도 유황천, 율암의 물을 변호함','/img/magazine/050.jpg','온천수 온도가 29도라고 하면 다들 한 번 되묻습니다. 그거 미지근한 거 아니냐고.

맞습니다. 원수 자체는 체온보다 낮습니다. 율암온천은 데운 탕과 함께 운영되고, 뜨거운 물이 목적이라면 다른 동네가 나을 수도 있습니다. 그런데 온천의 값어치를 온도계만으로 매기면 유황천이 억울해집니다.

율암의 물은 유황천입니다. 탕에 들어서면 특유의 유황 냄새가 먼저 오고, 나올 때는 피부가 한 꺼풀 매끈해진 감각이 남습니다. 유황은 예부터 피부에 좋다고 알려진 성분이고, 서울 근교에서 유황천을 만나기가 생각보다 어렵다는 사실이 이 동네의 존재 이유입니다. 발안IC에서 10분. 수도권에서 당일로 유황물에 몸을 담그고 돌아올 수 있는 거리입니다.

[QUOTE]뜨거움은 어느 목욕탕이든 만들 수 있지만, 유황 냄새는 땅이 정한다.

목욕을 마치면 근처에서 몸보신으로 잇는 게 이 동네의 관례에 가깝습니다. 서해정의 백숙, 시골민물매운탕의 빠가사리 매운탕. 화성 팔탄면 일대는 온천 주변으로 토속 보양식 식당이 포진해 있어, 물과 밥의 궁합만큼은 온도와 무관하게 뜨겁습니다.','41',4,'2025-12-01 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='미지근한 온천은 실패인가요');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='미지근한 온천은 실패인가요' AND source='MOIS' AND external_id='69' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','융건릉, 용주사, 궁평항, 그리고 29도 — 뺄 수 있는 건 하나','발안IC에서 10분, 율암온천을 축으로 한 반나절 드라이브','/img/magazine/051.jpg','네 조각 중 하나를 빼야 한다면 ②를 빼요. ④는 빼면 이 목록이 성립하지 않아요. 서해안 끝에서 정조의 능까지 시 하나에 들어 있는 화성을, 발안IC에서 10분인 율암온천을 축으로 삼으면 반나절 드라이브 네 조각으로 정리돼요.

① 융건릉. 정조와 사도세자가 잠든 능역이에요. 소나무 숲 사이 참도를 걷는 데 한 시간이면 충분하고, 아침 산책 코스로 제일 좋아요.

② 용주사. 융건릉에서 가까운 절로, 정조가 아버지를 위해 세운 원찰이에요. 능과 절을 묶으면 오전이 완성돼요.

③ 궁평항. 오후 늦게 도착하도록 배치해요. 해송 숲과 방파제가 있고, 화성 8경에 꼽히는 낙조가 이 항구의 주력이에요. 해 지는 시간을 미리 확인하고 움직이는 게 요령이에요.

[IMG]궁평항 방파제 끝, 해가 수평선에 닿기 직전의 붉은 띠. ⓒ 물멍

④ 율암온천. 마지막 조각이에요. 29도 유황천 — 하루 종일 걷고 바람 맞은 몸을 유황물에 헹구고 나면 수도권으로 돌아가는 길이 한결 짧게 느껴져요. 저녁이 애매하면 온천 근처 태림에서 해산물 중식으로 마무리해요.

[QUOTE]능 하나, 절 하나, 항구 하나, 온천 하나. 마지막 하나가 나머지 셋을 정리한다.

순서는 능 → 절 → 항구 → 탕. 일몰 시각을 확인하고, 그 시각에서 거꾸로 출발 시간을 잡아 보세요.','41',4,'2025-12-02 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='융건릉, 용주사, 궁평항, 그리고 29도 — 뺄 수 있는 건 하나');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='융건릉, 용주사, 궁평항, 그리고 29도 — 뺄 수 있는 건 하나' AND source='MOIS' AND external_id='69' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','해발 620m에서 항복한 무릎, 32℃ 탄산천이 받는다','거창 가조 — 우두산 Y자형 출렁다리에서 내려와 탕까지, 하루의 순서','/img/magazine/052.jpg','아침 아홉 시, 거창 항노화힐링랜드 주차장. 등산화 끈 조이는 소리가 엔진 소리보다 먼저 들립니다.

목적지는 우두산 Y자형 출렁다리입니다. 국내에서 처음으로 교각 없이 세 방향을 잇는 현수교로, 해발 620미터 협곡 위에 Y자로 걸려 있습니다. 세 갈래 데크가 만나는 한가운데에 서면 세 방향 산줄기가 한 번에 눈에 들어옵니다.

코스는 두 가지입니다. 힐링랜드에서 다리까지만 다녀오는 짧은 길, 체력이 남으면 마장재를 거쳐 의상봉까지 능선을 잇는 긴 길. 어느 쪽을 골라도 내려올 때쯤 무릎이 먼저 항복합니다.

[IMG]Y자 다리 한가운데, 세 방향 데크가 만나는 지점에서 올려다본 의상봉 능선. ⓒ 물멍

그 무릎을 받는 물이 가조온천입니다. 원수 32도 탄산천. 뜨겁지 않은 대신 몸을 담그면 팔뚝에 좁쌀 같은 잔거품이 맺히며 혈관을 살살 엽니다. 등산으로 뭉친 다리에는 펄펄 끓는 탕보다 오래 담글 수 있는 이 온도가 낫습니다.

[QUOTE]산은 620미터에서 무릎을 꺾고, 탕은 32도에서 다시 편다.

저녁은 둘 중 하나입니다. 고기가 당기면 거창파인밸리리조트 안 비계산가든의 꽃등심, 국물이 당기면 홍천뚝배기의 뼈다귀 해장국. 산 위에서 쓴 힘을 탕과 밥으로 되갚는 순서입니다.

다음 주말 거창에 간다면 등산화 옆에 수건 한 장을 더 넣으세요. 다리 위에서 꺾인 무릎을 펴는 건 32도의 물입니다.','48',4,'2025-12-04 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='해발 620m에서 항복한 무릎, 32℃ 탄산천이 받는다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='해발 620m에서 항복한 무릎, 32℃ 탄산천이 받는다' AND source='MANUAL' AND name='가조온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','어탕국수의 고장에서 목욕을 배웠다','가조온천과 거창의 국물들','/img/magazine/053.jpg','이 동네 취재는 냄새로 기억돼요. 민물고기를 뼈째 고아낸 국물 냄새.

거창의 향토음식은 어탕국수예요. 민물 잡어를 통째로 고아 체에 내린 국물에 국수를 말아내는 음식인데, 거창읍에는 이걸 전문으로 하는 집들이 따로 있을 정도예요. 추어탕과 사촌쯤 되는 음식이지만, 미꾸라지만 쓰는 추어탕과 달리 어탕은 그날 잡히는 잡어를 다 쓴다는 점이 달라요.

가조온천을 다니는 사람들의 동선에 이 국물이 끼어 있어요. 온천 주변에는 거창추어탕 같은 국물집과 향토 한식집 소골둑이 있고, 탕에서 나온 몸이 원하는 건 대체로 이런 뜨끈한 쪽이에요.

순서는 이래요. 32도 탄산천에 오래 담가요. 가조의 물은 온도가 낮은 대신 탄산이 혈액순환을 거드는 물이라, 삼십 분이고 한 시간이고 버틸 수 있어요. 오래 담근 만큼 허기도 정직하게 와요. 그때 국물집으로 가는 거예요.

뜨거운 물에 몸을 데우고 뜨거운 국물로 속을 데우는 것. 온천 마을의 하루는 결국 온도를 두 번 채우는 일이라는 걸, 거창에서 배웠어요.','48',4,'2025-12-05 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='어탕국수의 고장에서 목욕을 배웠다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='어탕국수의 고장에서 목욕을 배웠다' AND source='MANUAL' AND name='가조온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','계곡물, 탄산물, 국물 — 거창에서 물 세 가지를 지나는 1박 2일','수승대 거북바위에서 가조온천 32℃ 탕, 홍천뚝배기 해장국까지','/img/magazine/054.jpg','계곡 한가운데 거북 한 마리가 앉아 있습니다. 수승대 거북바위. 옛 선비들이 시를 새겨 넣은 이 바위와 계곡을 내려다보는 누각 관수루, 물가의 정자 요수정까지가 명승으로 지정된 수승대의 세 꼭짓점입니다.

첫날은 여기서 시작합니다. 계곡을 따라 걷고, 관수루에 올라 물소리를 듣고, 바위에 새겨진 글자를 찾아 읽으면 반나절이 갑니다. 여름엔 물놀이 인파, 가을엔 단풍 인파가 몰리지만 평일 오전이면 계곡을 거의 통째로 씁니다.

오후에 가조면으로 넘어갑니다. 거창터미널에서 가조행 버스로 25분. 렌터카 없이도 닿는 거리입니다. 가조온천에 짐을 풀고 32도 탄산천에 몸을 담그면, 피부에 기포가 맺히는 미지근한 물이 오래 걸은 다리를 받아 줍니다.

[IMG]수승대 관수루에서 내려다본 계곡, 물살 가운데 거북바위가 등을 내밀고 있다. ⓒ 물멍

1박을 하는 이유는 하나입니다. 숙박이 되는 온천이라 밤에 한 번, 아침에 한 번 더 들어갈 수 있다는 것. 32도의 물은 두 번 들어가도 몸이 지치지 않습니다.

둘째 날 아침은 컨디션이 정합니다. 다리에 힘이 남으면 우두산 출렁다리를 얹고, 아니면 홍천뚝배기에서 뼈다귀 해장국 한 그릇으로 아침을 해결하고 천천히 빠져나옵니다.

[QUOTE]계곡물, 탄산물, 국물. 거창의 1박 2일은 물 세 가지를 순서대로 지나는 일이다.

수승대 계곡물에 발을 담그는 것으로 시작해 해장국 국물로 끝나는 이틀. 다음 연휴 거창행 버스표를 끊는다면, 순서만 이대로 지키세요.','48',4,'2025-12-07 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='계곡물, 탄산물, 국물 — 거창에서 물 세 가지를 지나는 1박 2일');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='계곡물, 탄산물, 국물 — 거창에서 물 세 가지를 지나는 1박 2일' AND source='MANUAL' AND name='가조온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','경주 여행의 마지막 일정은 뜨거워야 한다','보문단지 안에서 여행을 접는 법','/img/magazine/055.jpg','경주 여행은 발이 고생하는 여행이다.

왕릉 사이를 걷고, 황리단길을 밀려다니고, 박물관 전시실을 돌고 나면 하루 이만 보가 우습다. 그래서 경주는 마지막 일정을 목욕으로 접는 게 맞다. 보문온천이 보문관광단지 안에 있다는 사실은 이 도시의 지리적 농담처럼 느껴질 정도다. 호텔과 리조트가 모인 단지, 즉 여행자들이 마지막 밤을 보내는 바로 그 자리에서 44도 알칼리성 온천수가 나온다.

알칼리성 온천은 흔히 ''미인탕''으로 불린다. 피부 각질을 부드럽게 만들어 탕에서 나올 때 살갗이 매끈해지는 물이다. 44도라는 원수 온도는 데우지 않아도 탕으로 직행할 수 있는 온도이고, 종일 걸은 다리를 담그면 뭉친 데가 풀리는 게 느껴진다.

[QUOTE]불국사는 오전의 경주고, 온천은 밤의 경주다.

탕에서 나와 허기가 오면 단지 초입의 맷돌순두부로 간다. 동궁원 맞은편, 웨이팅이 있지만 회전이 빠른 두부집이다. 순두부 한 그릇을 비우고 숙소로 돌아가는 길, 보문호 쪽에서 물비린내 섞인 바람이 분다. 그게 경주 여행의 마지막 감각이면 나쁘지 않다.','47',4,'2025-12-08 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='경주 여행의 마지막 일정은 뜨거워야 한다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='경주 여행의 마지막 일정은 뜨거워야 한다' AND source='MANUAL' AND name='보문온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','보문호 둘레길, 아침 두 시간의 사용법','호수 한 바퀴와 늦은 아침상, 그리고 탕','/img/magazine/056.jpg','아침 일곱 시의 보문호는 수면이 유리처럼 눕는 시간이에요. 물안개가 걷히기 전이라면 호수 건너 리조트들이 반쯤 지워진 채 떠 있어요.

보문호 둘레길은 호수를 끼고 도는 산책로예요. 경주 시내처럼 유적을 밟을 일이 없으니 마음 놓고 속도를 내도 되고, 벚나무가 길을 따라 심겨 있어 봄이면 이 길이 경주 벚꽃의 주전장이 돼요. 물론 벚꽃 없는 계절의 한산함도 값어치가 있어요.

[IMG]물안개가 남은 보문호, 데크길 난간에 앉은 왜가리 한 마리. ⓒ 물멍

한 바퀴 돌고 나면 아침 겸 점심 시간이에요. 떡갈비와 한우 물회를 내는 보문뜰은 밑반찬이 정갈해서 부모님을 모신 아침상으로 좋고 — 오후 세 시부터 브레이크타임이 있으니 낮 일정은 미리 계산해야 해요 — 호수를 보며 먹고 싶다면 소노벨 경주 근처 올바릇식당의 꼬막비빔밥이 있어요.

오후의 마무리가 보문온천이에요. 걷고, 먹고, 44도 알칼리성 물에 담그는 순서. 알칼리 물은 피부를 매끄럽게 훑고 지나가는 감촉이라, 아침 산책으로 시작한 하루의 마침표로는 과분할 게 없어요.

둘레길은 부지런한 사람의 것이지만, 탕은 누구에게나 공평해요.','47',4,'2025-12-10 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='보문호 둘레길, 아침 두 시간의 사용법');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='보문호 둘레길, 아침 두 시간의 사용법' AND source='MANUAL' AND name='보문온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','KTX 2시간, 700번 버스 40분, 그다음은 슬리퍼','신경주역에서 보문온천까지 — 차 없이 이동이 끝나는 동네','/img/magazine/057.jpg','서울역에서 신경주역까지 KTX로 두 시간. 문제는 늘 그다음이었습니다. 신경주역은 시내에서 떨어져 있고, 보문단지는 거기서 또 한 번 더 가야 합니다.

답은 번호 하나입니다. 700번. 신경주역과 보문단지를 잇는 시내버스로, 40분이면 호수 앞 정류장에 내립니다. 렌터카 없이 경주를 도는 사람에게 이 세 자리 숫자가 동선의 등뼈가 됩니다.

버스에서 내린 뒤로는 두 발이면 충분합니다. 보문호 둘레길, 동궁원, 경주월드가 전부 단지 안이거나 그 언저리라 다시 차를 잡을 일이 없습니다. 놀이기구의 비명과 호수의 정적이 한 동네에서 나란히 들리는 곳, 그게 보문입니다.

[IMG]700번 버스 차창 너머로 지나가는 보문호. ⓒ 물멍

그리고 온천. 보문온천은 이 단지의 지하에서 올라오는 44도 알칼리성 물입니다. 단지 안 숙소들이 온천을 품고 있어, 짐을 푼 방에서 탕까지의 거리는 슬리퍼 차림으로 끝납니다. 44도라 탕은 충분히 뜨겁고, 알칼리성이라 물이 피부에 매끈하게 감깁니다.

[QUOTE]여행지에서 이동을 줄이는 가장 확실한 방법은, 이동할 필요가 없는 동네를 고르는 것이다.

돌아가는 날은 역순입니다. 다시 700번, 다시 신경주역. 차창 밖으로 보문호가 한 번 크게 지나가면 그게 경주의 마지막 장면입니다.

이번 주말 경주행 KTX를 끊었다면 렌터카 예약 창은 닫으세요. 필요한 건 700번 버스 앞자리와 슬리퍼 한 켤레입니다.','47',4,'2025-12-11 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='KTX 2시간, 700번 버스 40분, 그다음은 슬리퍼');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='KTX 2시간, 700번 버스 40분, 그다음은 슬리퍼' AND source='MANUAL' AND name='보문온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','억새 바람 맞은 몸은 유황물에 담가야 한다','10월의 간월재, 그리고 등억 온천단지','/img/magazine/058.jpg','10월의 간월재는 소리부터 다르다. 바람이 억새 평원을 훑고 지나갈 때마다 마른 잎들이 일제히 몸을 뒤집으며 파도 소리를 낸다.

간월재는 신불산과 간월산 사이의 고개다. 가을이면 능선을 덮은 억새가 은빛으로 눕고, 영남알프스라는 이름값이 이 계절에 만들어진다. 오르는 길은 여럿이다. 배내골 쪽 배내2 공영주차장에서 임도를 따라 오르는 완만한 길이 초행자에게 흔히 권해지고, 간월산장을 거치는 코스도 있다. 어느 길이든 고갯마루에 서면 억새 너머로 울주의 산줄기가 겹겹이 밀려온다.

[IMG]간월재 고갯마루, 은빛으로 누운 억새 사이 나무데크 위의 등산객들. ⓒ 물멍

산에서 내려온 몸의 종착지가 등억이다. 신불산 아래 등억온천단지의 물은 29도 유황천 — 데운 탕에 유황의 매끈함이 살아 있어, 산행으로 소금기 오른 피부를 헹구는 데 이만한 물이 없다. 등산화 벗고 탕에 다리를 뻗는 순간이 이 코스의 실질적인 정상이다.

[QUOTE]간월재의 정상석은 고개에 있지만, 하산의 정상은 탕 속에 있다.

언양터미널에서 차로 15분. 산과 물이 이렇게 붙어 있는 동네는 생각보다 드물다.','31',4,'2025-12-12 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='억새 바람 맞은 몸은 유황물에 담가야 한다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='억새 바람 맞은 몸은 유황물에 담가야 한다' AND source='MANUAL' AND name='등억알프스온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','탕에서 나와 석쇠 앞으로, 언양불고기 노포 셋','등억알프스온천 후 저녁의 세 가지 답','/img/magazine/059.jpg','언양읍은 불고기의 동네예요. 얇게 다진 한우를 석쇠에 눌러 굽는 언양불고기의 본고장이고, 읍내에는 아예 불고기거리가 형성돼 있어요. 등억 온천단지에서 차로 십여 분이니, 유황탕에서 나온 저녁의 답은 사실상 정해져 있는 셈이에요.

어느 집이냐가 문제일 뿐이에요.

원조 진불고기는 불고기거리의 원조급으로 꼽히는 집이에요. 석쇠 자국이 선명한 불고기가 기준점 같은 맛을 내요. 언양 기와집 불고기는 노포의 관록으로 승부하는 쪽이고, 언양불고기식당은 상호부터 정공법인 전문점이에요. 셋 다 언양불고기라는 같은 문법을 쓰지만 불맛의 농도와 반찬의 결이 조금씩 달라서, 등억을 여러 번 오는 사람들은 자기 단골을 하나씩 정해두는 편이에요.

순서는 바꾸지 않는 게 좋아요. 불고기 먼저 먹고 탕에 들어가면 나른해서 산 아래까지 온 보람이 흐려지고, 등산이든 산책이든 몸을 쓴 뒤 29도 유황천으로 씻고 마지막에 석쇠 앞에 앉아야 하루의 부피가 맞아요.

숯 냄새 밴 옷으로 돌아가는 차 안, 그게 언양의 마무리예요.','31',4,'2025-12-14 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='탕에서 나와 석쇠 앞으로, 언양불고기 노포 셋');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='탕에서 나와 석쇠 앞으로, 언양불고기 노포 셋' AND source='MANUAL' AND name='등억알프스온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'VILLAGE_STORY','영남알프스 아랫동네에서 보낸 이틀','등억 온천단지와 언양알프스시장, 폭포까지','/img/magazine/060.jpg','산 이름에 알프스가 붙은 동네는 시장 이름에도 알프스가 붙습니다. 언양알프스시장 — 등억 온천단지에서 가까운 언양읍의 재래시장입니다.

첫날은 시장에서 시작합니다. 장 보는 사람들 사이를 걷다가 국밥 한 그릇으로 점심을 해결하고, 오후에 등억으로 들어갑니다. 등억알프스온천의 물은 29도 유황천입니다. 신불산 자락 아래 단지라 탕에 앉으면 창밖이 온통 산인데, 유황 냄새와 산 그림자가 같이 오는 목욕은 도시의 사우나가 흉내 낼 수 없는 종류입니다. 숙박이 되는 단지라 하룻밤 묵으며 밤과 아침, 탕을 두 번 쓰는 게 이 동네의 정석입니다.

둘째 날은 물을 보러 갑니다. 배내골 쪽 신불산폭포자연휴양림에서 걸어 들어가는 파래소폭포는 폭포 아래 소(沼)가 둥글게 파인 곳으로, 여름엔 물보라만으로 서늘해집니다. 트레킹이 부담스러우면 언양 쪽 계곡을 가볍게 걷는 것으로 대신해도 됩니다.

내려오는 길, 언양불고기거리에서 석쇠불고기로 늦은 점심을 먹고 이틀을 접습니다. 산, 시장, 탕, 폭포, 불고기. 영남알프스 아랫동네의 목록은 이 다섯이면 채워집니다.','31',4,'2025-12-15 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='영남알프스 아랫동네에서 보낸 이틀');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='영남알프스 아랫동네에서 보낸 이틀' AND source='MANUAL' AND name='등억알프스온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','KTX 내리고 25분, 수안보 가는 가장 짧은 길','충주역 246번 버스와 꿩요리 골목까지, 차 없이 도는 수안보 반나절','/img/magazine/061.jpg','서울에서 수안보까지 필요한 건 기차표 한 장과 버스 카드뿐입니다. KTX를 타고 충주역에 내리면, 역 앞에서 246번 버스가 수안보 방면으로 갑니다. 25분. 창밖 풍경이 아파트에서 과수원으로, 과수원에서 산자락으로 바뀌는 데 걸리는 시간입니다.

수안보는 온천지구 전체가 걸어서 도는 동네입니다. 버스에서 내리면 온천 호텔과 목욕탕 간판이 이어지는 중심가가 바로 시작되고, 어디서 내려도 물 좋은 집까지 10분을 넘지 않습니다. 53도 알칼리성 온천수는 관절과 피로 회복으로 오래 이름을 알렸고, 뜨거운 물답게 탕에서 나온 뒤에도 몸이 한참 데워져 있습니다.

[IMG]수안보 온천지구 중심가. 버스에서 내리면 이 길이 곧 동선의 전부다. ⓒ 물멍

목욕을 마쳤다면 꿩요리 골목으로 갑니다. 수안보는 전국에서 드문 꿩요리 특화 지구라, 대장군식당과 삿갓촌 같은 꿩 코스 전문점이 온천가에 모여 있습니다. 꿩 샤브에 꿩만두까지 이어지는 코스를 받아 들면, 이 동네가 왜 온천만큼 밥상으로 기억되는지 알게 됩니다. 두부전골과 산채정식을 내는 청솔식당 같은 선택지도 있으니 꿩이 낯설어도 걱정은 없습니다.

돌아가는 길도 같은 246번입니다. 배차가 아주 촘촘한 편은 아니니, 식당에 앉기 전에 돌아가는 버스 시간을 한 번 확인해 두는 게 뚜벅이의 예의입니다.','43',4,'2025-12-17 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='KTX 내리고 25분, 수안보 가는 가장 짧은 길');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='KTX 내리고 25분, 수안보 가는 가장 짧은 길' AND source='MANUAL' AND name='수안보온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','사상에서 한 시간, 78도의 동네로','부산서부터미널에서 시외버스 타고 부곡온천 걸어 다니기','/img/magazine/062.jpg','부산서부시외버스터미널, 그러니까 사상에서 부곡행 시외버스를 타요. 한 시간이면 국내에서 가장 뜨거운 온천 동네에 내립니다. 부곡의 원수는 78도. 전국 온천법 등록 온천을 통틀어 최고 온도예요.

종점인 부곡시외버스터미널은 온천단지 한가운데 있어요. 내려서 캐리어를 끌고 갈 것도 없이, 온천중앙로를 따라 호텔과 대중탕이 늘어선 거리가 바로 펼쳐집니다. 유황 냄새가 옅게 배어 있는 골목을 10분쯤 걷다 보면 이 동네의 리듬이 읽혀요. 오전엔 목욕 가방을 든 어르신들, 오후엔 수건을 목에 두른 투숙객들.

[QUOTE]가장 뜨거운 물은 서울에서 가장 먼 곳이 아니라, 사상에서 버스 한 시간 거리에 있었다.

탕에서 나오면 온천중앙로 주변으로 밥집이 모여 있어요. 한정식을 차려내는 송이네 밥상, 뜨끈한 국물이 필요할 때 가는 한우곱창전골집 오색그린 부곡본점. 유황물에 데워진 몸으로 먹는 곱창전골은 부곡에서만 성립하는 조합입니다.

돌아갈 땐 다시 터미널로 걸어가면 끝. 정류장을 찾아 헤맬 일이 없는 동네라는 것, 그게 부곡이 뚜벅이에게 관대한 이유예요.','48',4,'2025-12-18 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='사상에서 한 시간, 78도의 동네로');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='사상에서 한 시간, 78도의 동네로' AND source='MANUAL' AND name='부곡온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','유성온천역 출구, 무료 족욕 39℃에서 본탕 53℃까지','대전 1호선 하나로 꿰는 온천·족욕·칼국수 뚜벅이 코스','/img/magazine/063.jpg','"이번 역은 유성온천, 유성온천역입니다." 역 이름에 온천이 들어가는 지하철역은 대전 1호선에 있습니다.

KTX로 대전역에 내렸다면 경로는 둘입니다. 급행2번 버스로 20분, 아니면 대전역에서 지하철 1호선을 타고 유성온천역까지 곧장. 어느 쪽이든 환승 스트레스가 없습니다.

유성의 순서는 발부터입니다. 유성온천역에서 걸어갈 수 있는 거리에 유성온천 족욕체험장이 있고, 신발을 벗고 바지를 걷고 앉으면 39도 안팎의 천연 온천수가 발목까지 차오릅니다. 무료입니다. 여기서 10분쯤 발을 데우고 본탕으로 가는 게 유성식 워밍업입니다.

[IMG]족욕체험장, 바지를 걷어 올린 발목들이 나란히 39℃ 물에 잠겨 있다. ⓒ 물멍

본탕의 물은 53도로 솟습니다. 라듐 성분이 녹아 있는 단순천으로, 근육통과 신경통 완화로 오래 알려진 물입니다. 39도 족욕으로 예열한 몸이라 53도짜리 탕에 들어가도 놀라지 않습니다.

[QUOTE]대전에선 온천에 들어가기 전에 온천을 먼저 맛본다.

목욕 뒤엔 칼국수입니다. 유성온천역 주변에 온천손칼국수 같은 칼국수집이 있고, 시내로 나갈 여유가 있다면 오씨칼국수나 두부두루치기의 진로집 같은 노포까지 지하철로 이어 붙일 수 있습니다. 온천과 칼국수를 지하철 노선 하나로 꿰는 도시는 대전뿐입니다.

다음 대전 출장이나 경유 때, 대전역에서 1호선을 타세요. 유성온천역 안내방송이 나오면 내려서 신발부터 벗으면 됩니다.','30',4,'2025-12-20 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='유성온천역 출구, 무료 족욕 39℃에서 본탕 53℃까지');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='유성온천역 출구, 무료 족욕 39℃에서 본탕 53℃까지' AND source='MANUAL' AND name='유성온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','환승 없이 온천까지, 1호선 종점 여행','서울에서 갈아타지 않고 닿는 온양온천역과 역전 시장 한 바퀴','/img/magazine/064.jpg','교통카드 한 장이면 됩니다.

서울 지하철 1호선을 타고 계속 앉아 있으면 온양온천역에 도착합니다. 환승도, 예매도 없습니다. 급할 것 없는 주말 아침, 책 한 권 들고 앉아 있으면 창밖이 도시에서 논으로 바뀌고, 어느새 역명판에 ''온양온천''이 뜹니다.

역에서 온천지구까지는 도보 10분. 57도 알칼리성 온천수는 피부가 매끈해지는 물로 통합니다. 온양은 조선 왕들이 온행을 왔던 유서 깊은 온천 동네라, 대중탕부터 호텔 온천까지 선택지가 역 주변에 몰려 있습니다.

[IMG]온양온천역 광장. 지하철 역명판과 온천 동네가 한 프레임에 들어온다. ⓒ 물멍

목욕을 마치면 역 바로 앞 온양온천전통시장으로 갑니다. ''배부르고 등 따뜻한 장터''라는 말로 소개될 만큼 먹거리 중심의 시장이라, 탕에서 뺀 기운을 채우기 좋습니다. 시골밥상 한상차림을 내는 밥집도 있고, 장날이면 좌판이 길게 늘어섭니다.

온양의 미덕은 계산이 서는 여행이라는 겁니다. 몇 시에 출발하든 지하철은 오고, 막차 시간은 앱이 알려주고, 역과 탕과 시장이 도보 10분 안에 다 있습니다. 온천 여행의 진입 장벽이 이렇게 낮아도 되나 싶을 정도로요.','44',4,'2025-12-21 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='환승 없이 온천까지, 1호선 종점 여행');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='환승 없이 온천까지, 1호선 종점 여행' AND source='MANUAL' AND name='온양온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','온천장역에서 내리면 생기는 일','동래온천 도보 8분 — 목욕, 파전, 곰장어로 이어지는 부산 원조 코스','/img/magazine/065.jpg','부산 지하철 1호선 온천장역. 개찰구를 나서는 순간부터 이 동네의 용건은 분명합니다. 역 이름부터가 온천장이니까요.

역에서 동래온천 지구까지는 걸어서 8분. 조선시대 기록에도 등장하는 부산 원조 온천으로, 62도 식염천이 솟습니다. 소금기 있는 물이라 몸이 오래 따뜻하게 유지되는 게 특징입니다. 온천지구의 상징인 대형 온천탕 허심청을 비롯해 크고 작은 탕이 걸어 다닐 수 있는 반경 안에 모여 있습니다.

동래의 진짜 완성은 목욕 후 밥상입니다. 이 동네엔 ''목욕하고 파전과 곰장어''라는 오래된 코스가 있습니다. 4대째 이어지는 동래할매파전에서 두툼한 동래파전을 받아 들거나, 온천장 곰장어골목으로 들어가 45년 노포 원조 소문난 산곰장어에서 짚불 곰장어를 굽는 겁니다. 탕에서 데운 몸에 막걸리 한 잔이 더해지면, 이 코스가 왜 몇십 년을 살아남았는지 몸으로 이해하게 됩니다.

[QUOTE]동래에서는 목욕이 전채고, 파전이 본식이다.

돌아가는 길도 온천장역. 지하철이 끊기기 전까지는 시간 계산이 필요 없는, 부산에서 가장 마음 편한 온천 동선입니다.','26',4,'2025-12-23 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='온천장역에서 내리면 생기는 일');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='온천장역에서 내리면 생기는 일' AND source='MANUAL' AND name='동래온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','해수욕장 말고, 해운대역에서 5분','바다로 가는 인파를 등지고 온천으로 걷는 법','/img/magazine/066.jpg','해운대역에서 내린 사람들은 대부분 바다 쪽으로 걷습니다. 그 흐름을 등지고 5분만 걸으면 다른 해운대가 나와요. 60도 식염천이 솟는 온천 동네, 해운대온천입니다.

해운대라는 지명이 온천 동네였다는 사실은 자주 잊힙니다. 해수욕장이 유명해지기 전부터 이곳엔 뜨거운 소금물이 솟았고, 지금도 해운대온천센터 같은 온천 시설이 도심 한가운데서 그 물을 받아쓰고 있어요. 관광지 물가의 한복판에서 동네 목욕탕의 표정을 만나는 반전이 좋습니다.

부산 지하철 2호선 해운대역에서 내리면 숙소도, 탕도, 밥집도 다 도보권이에요. 온천욕을 마치고 걸어서 해변까지 가는 데 10분 남짓. 겨울이라면 순서를 바꿔서, 바닷바람에 몸을 식힌 다음 탕에 들어가는 쪽을 추천해요. 식염천은 한 번 데워지면 오래가니까요.

마무리는 국밥입니다. 해운대는 국밥 노포의 동네이기도 해서, 59년 전통의 해운대원조할매국밥이 소고기국밥을, 오복돼지국밥이 돼지국밥을 말아냅니다. 탕에서 나와 국밥집까지 걷고, 국밥집에서 바다까지 걷는 것. 해운대에서 차가 필요한 순간은 한 번도 없어요.','26',4,'2025-12-24 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='해수욕장 말고, 해운대역에서 5분');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='해수욕장 말고, 해운대역에서 5분' AND source='MANUAL' AND name='해운대온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','막차 걱정은 예산역에서 끝내자','수덕사와 덕산온천을 버스 하나로 묶는 하루','/img/magazine/067.jpg','뚜벅이 여행의 8할은 막차 계산입니다. 덕산온천이 좋은 건, 그 계산이 단순하다는 데 있습니다. 장항선 예산역에 내려서 덕산 방면 버스를 타면 30분. 변수는 그 버스의 배차 간격 하나뿐이니, 역에 내리자마자 돌아올 차 시간부터 확인해 두면 나머지는 온전히 노는 시간입니다.

덕산의 하루는 수덕사에서 시작하는 게 순서입니다. 백제 고찰 수덕사는 덕산온천에서 버스로 한 정거장 거리의 산자락에 있고, 일주문에서 대웅전까지 오르는 길은 등에 땀이 배기 딱 좋은 경사입니다. 국보로 지정된 대웅전은 고려 때 세워진 목조건물로, 단청 없이 나뭇결이 그대로 드러나 있습니다.

산길에서 만든 피로를 푸는 게 덕산온천의 몫입니다. 45도 중탄산나트륨천이라 물이 순하고, 절 구경 후의 반신욕 코스로 오래 사랑받았습니다.

[IMG]수덕사 오르는 길. 이 계단의 피로가 온천의 밑천이 된다. ⓒ 물멍

저녁은 갈비입니다. 예산은 숯불 소갈비의 고장이고, 덕산 온천지구 주변으로 소복갈비, 대복갈비 같은 갈비집이 모여 있습니다. 절밥 같은 하루의 끝에 양념갈비라니 균형이 안 맞는 것 같지만, 원래 여행의 회계는 그렇게 맞추는 겁니다.','44',4,'2025-12-26 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='막차 걱정은 예산역에서 끝내자');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='막차 걱정은 예산역에서 끝내자' AND source='MANUAL' AND name='덕산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','역 이름에 낚여도 좋은 도고온천역','장항선 완행 기차와 31도 유황수의 느린 조합','/img/magazine/068.jpg','도고온천역. 역명판을 보는 순간 이미 반쯤 여행이 시작된 기분이 들어요. 장항선 완행열차가 서는 이 작은 역은, 이름 그대로 온천을 위해 존재하는 역입니다.

다만 정직하게 말하면, 역에서 온천까지는 걷기 애매한 거리예요. 역 앞에서 택시로 5분. 뚜벅이 순도 100%는 아니지만, 기차역에서 택시 기본요금 남짓으로 끝나는 이동이니 너그럽게 봐주기로 해요.

도고의 물은 31도 유황천입니다. 뜨겁지 않아요. 그게 단점이 아니라 정체성입니다. 열탕처럼 3분 만에 튀어나오는 물이 아니라, 30분이고 한 시간이고 몸을 맡겨두는 물. 유황 성분이 녹아 있어 오래 담글수록 피부가 반들반들해지는 걸 느낄 수 있어요. 온천단지의 대형 스파 시설인 파라다이스 스파 도고가 이 물을 받아쓰고 있어서, 반나절을 통째로 물에서 보내는 일정도 가능합니다.

밥은 아산 서부의 방식대로. 이 일대는 저수지 어죽 문화권이라, 가마솥붕어찜 같은 집에서 붕어찜과 어죽을 냅니다. 어죽은 디지털아산문화대전에 오른 향토음식이에요. 미지근한 물에 오래 불은 몸으로 뜨거운 어죽 한 그릇. 도고의 하루는 그렇게 온도를 맞춥니다.','44',4,'2025-12-27 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='역 이름에 낚여도 좋은 도고온천역');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='역 이름에 낚여도 좋은 도고온천역' AND source='MANUAL' AND name='도고온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','동해선이 뚫리고, 백암온천이 가까워졌다','평해역에서 버스 20분 — 기차로 가는 울진 유황온천','/img/magazine/069.jpg','2025년 1월 1일, 동해선 철도가 완전 개통했습니다. 부산에서 강릉까지 환승 없이 잇는 이 노선이 뚫리면서, 철도 불모지였던 울진에 역이 생겼습니다. 백암온천의 관문, 평해역도 그중 하나입니다.

그전까지 백암온천은 뚜벅이에게 각오가 필요한 목적지였습니다. 이제는 부산에서든 강릉에서든 동해선 열차를 타고 평해역에 내려, 백암 방면 버스로 20분이면 온정면 온천지구에 닿습니다. ''기차 타고 가는 동해안 온천''이라는 문장이 성립하게 된 겁니다.

백암의 물은 53도 유황천입니다. 동해안을 대표하는 유황온천으로, 물이 미끄럽고 부드럽다는 평이 오래 쌓여 있습니다. 온천지구는 산자락에 폭 안긴 작은 동네라, 숙소와 탕 사이를 걸어 다니는 데 부족함이 없습니다.

[QUOTE]철도가 놓이면 온천의 순서가 바뀐다. 이제 백암은 ''언젠가''가 아니라 ''이번 주말''의 목록에 있다.

먹는 일은 계절을 탑니다. 겨울이라면 이 동네가 울진 대게철과 겹치는 보양 여행지라는 점을 기억해 두세요. 온천지구 안에는 동광식당 같은 소박한 한식집이 있고, 해산물이 당기면 후포항이 멀지 않습니다. 뜨거운 유황물과 겨울 대게. 동해선 개통이 만든 새 조합입니다.','47',4,'2025-12-29 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='동해선이 뚫리고, 백암온천이 가까워졌다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='동해선이 뚫리고, 백암온천이 가까워졌다' AND source='MANUAL' AND name='백암온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','주흘관에서 조곡관까지 두 시간, 그다음 31℃','점촌역 기준으로 짠 문경새재·문경온천·약돌돼지 시간표','/img/magazine/070.jpg','오전, 점촌역. 여기서 시계를 맞추면 문경의 하루는 저절로 굴러갑니다.

문경 방면 시내버스로 갈아타고 30분이면 문경온천이 있는 문경읍입니다. 기차가 안 맞으면 시외버스로 점촌시외버스터미널에 들어와도 동선은 같습니다. 어느 쪽이든 차 없이 들어오는 길입니다.

낮, 문경새재. 조선시대 영남 선비들이 한양으로 넘던 고갯길입니다. 제1관문 주흘관에서 시작되는 흙길은 경사가 순해 운동화면 충분하고, 제2관문 조곡관까지만 다녀와도 왕복 두어 시간이 됩니다. 맨발로 걷는 사람이 많은 길이라 신발을 손에 든 행인이 낯설지 않습니다.

[IMG]조곡관 앞 흙길, 신발을 손에 들고 맨발로 걷는 사람들. ⓒ 물멍

오후 네 시, 문경온천. 물은 31도 칼슘중탄산천이라 뜨겁지 않고 순합니다. 고갯길에서 데워진 다리를 미지근한 물에 오래 담그면 뜨거운 탕과는 다른 방식으로 피로가 풀립니다. 두 시간 걸은 몸엔 이 온도가 정답이라는 걸 담가 보면 압니다.

[QUOTE]새재는 발로 넘고, 그 발은 31도가 받는다.

저녁, 약돌돼지. 약돌(거정석) 가루를 먹여 키운 약돌돼지와 약돌한우가 문경의 이름입니다. 온천지구의 온천약돌한우돼지정육식당에서 정육 구이로 먹거나, 새재 쪽 소문난식당에서 향토음식 청포묵조밥으로 마무리해도 됩니다.

돌아가는 버스에서는 대체로 잠듭니다. 그러라고 짠 시간표이니, 점촌역행 막차 시간만 확인하고 눈을 감으세요.','47',4,'2025-12-30 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='주흘관에서 조곡관까지 두 시간, 그다음 31℃');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='주흘관에서 조곡관까지 두 시간, 그다음 31℃' AND source='MANUAL' AND name='문경온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','속초까지 가서 목욕탕에 간다고?','터미널에서 3-1번 버스 15분, 척산온천과 순두부촌의 답변','/img/magazine/071.jpg','"속초까지 가서 목욕을 한다고?" 척산온천 이야기를 꺼내면 꼭 돌아오는 반문입니다. 바다와 시장을 두고 왜 산 밑 온천으로 가느냐는 거죠. 답은 순서에 있습니다. 척산은 속초 여행의 목적지가 아니라 마무리니까요.

서울에서 고속버스로 속초에 들어와 해변과 중앙시장을 실컷 걸었다면, 마지막 반나절을 척산에 씁니다. 속초 시외버스터미널 쪽에서 3-1번 버스를 타면 15분. 설악산 울산바위가 마주 보이는 산자락에 척산온천이 있습니다. 53도 알칼리성 온천수는 속초 시내 어디에도 없는, 이 동네만의 자원입니다.

탕에서 나오면 걸어갈 수 있는 거리에 저녁이 준비되어 있습니다. 척산온천 바로 옆이 학사평 콩꽃마을, 속초 순두부촌입니다. 1965년에 문을 연 김영애할머니순두부를 비롯해 재래식 순두부를 쑤는 노포들이 모여 있어서, 온천 가운을 벗고 순두부 한 상까지 이어지는 동선이 도보로 완성됩니다.

간수 대신 바닷물로 굳힌 초당식 순두부의 몽글한 결, 그 위로 피어오르는 김. 목욕 직후의 몸으로 받아 들면 이 조합을 반문했던 게 미안해집니다. 속초의 마지막 반나절, 바다보다 물이 좋은 시간입니다.','51',4,'2026-01-01 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='속초까지 가서 목욕탕에 간다고?');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='속초까지 가서 목욕탕에 간다고?' AND source='MANUAL' AND name='척산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','산수유 필 무렵, 구례구역에서 내리세요','산동 온천지구와 노란 봄의 도보 동선','/img/magazine/072.jpg','3월의 구례 산동은 온 동네가 노랗게 물듭니다. 산수유나무 수만 그루가 일제히 꽃을 터뜨리는 산수유마을이 있어서요. 그리고 그 마을 바로 옆에 32도 게르마늄 온천, 지리산온천이 있습니다. 꽃과 물을 하루에 묶을 수 있는 드문 동네입니다.

가는 법은 기차가 기본입니다. 전라선 구례구역에 내려 산동 방면 버스로 25분. 구례구역은 이름과 달리 강 건너 순천 땅에 있는 재미있는 역인데, 지리산 자락으로 들어가는 관문 역할을 오래 해왔습니다.

온천지구에 내리면 지리산온천랜드를 중심으로 한 관광단지가 걸어 다닐 만한 크기로 펼쳐집니다. 게르마늄 성분의 32도 물은 뜨겁기보다 포근한 쪽이라, 산수유마을을 두어 시간 걷고 온 다리를 오래 담그기에 맞춤합니다. 봄이 아니어도 괜찮습니다. 가을엔 산수유 열매가 빨갛게 달리고, 겨울엔 지리산 능선에 눈이 얹힙니다.

밥은 지리산과 섬진강 사이에서 고릅니다. 흑돼지구이를 굽는 송림민속가든, 섬진강 다슬기로 수제비를 끓이는 토지다슬기식당. 산수유텃밭식당처럼 산채를 차리는 집도 있습니다. 다슬기수제비의 초록빛 국물은 이 동네를 벗어나면 좀처럼 만나기 어렵습니다.

돌아오는 버스 창밖으로 노란 산비탈이 멀어질 때쯤, 손끝에서 유황과는 다른 순한 물 냄새가 납니다.','46',4,'2026-01-02 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='산수유 필 무렵, 구례구역에서 내리세요');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='산수유 필 무렵, 구례구역에서 내리세요' AND source='MANUAL' AND name='지리산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','광주에서 버스 40분, 남도 밥상 옆 온천','화순온천으로 가는 가장 실속 있는 반나절 코스','/img/magazine/073.jpg','온천 여행이 꼭 대이동일 필요는 없습니다. 광주 시민에게 화순온천은 버스 40분짜리 반나절 코스입니다. 광주종합버스터미널에서 화순 방면 버스를 타면, 무등산 자락을 돌아 화순 땅으로 넘어가는 데 40분이면 충분합니다.

화순온천은 화순군 북면 산자락의 온천지구로, 32도 안팎의 게르마늄천이 솟습니다. 금호리조트 계열의 스파 시설이 이 물을 받아쓰고 있어 온천욕과 물놀이를 한 건물에서 해결할 수 있습니다. 뜨거운 탕을 기대하면 낯설 수 있지만, 미지근한 게르마늄수에 오래 몸을 맡기는 게 이 동네의 사용법입니다.

알아두면 좋은 사실 하나. 화순군에는 온천지구가 둘 있습니다. 북면의 화순온천과 도곡면의 도곡온천. 헷갈리기 쉬우니 버스를 탈 때 행선지를 확인하는 게 좋습니다.

그리고 화순의 진짜 무기는 밥상입니다. 남도 한정식의 물가답게 상다리가 실하게 차려지는 동네라, 도곡온천 인근 원화리의 한정식집 광화문연가처럼 매체에 오른 집들이 있습니다. 온천에서 데운 몸으로 받는 남도 한 상. 광주에서 40분 거리라는 게 미안해질 만큼의 밀도입니다.

해 지기 전에 광주로 돌아와 저녁 약속을 잡을 수도 있는 온천. 그게 화순의 포지션입니다.','46',4,'2026-01-04 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='광주에서 버스 40분, 남도 밥상 옆 온천');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='광주에서 버스 40분, 남도 밥상 옆 온천' AND source='MANUAL' AND name='화순온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','55도, 국민보양온천이라는 공인','마산역에서 북면 가는 버스에 오르면 생기는 일','/img/magazine/074.jpg','숫자부터 말하겠습니다. 수온 55도, 염화나트륨천. 그리고 ''국민보양온천''이라는 정부 지정 타이틀. 창원 북면의 마금산온천이 가진 스펙입니다. 물이 진하다는 소문은 과장이 아니라 성분표입니다.

가는 길은 마산역에서 시작합니다. 역 앞에서 북면 방면 시내버스를 타면 40분. 창원 도심을 벗어나 낙동강 쪽으로 방향을 틀면, 온천장 간판이 하나둘 나타나는 북면 온천 동네에 닿습니다. 마금산과 천마산 사이 골짜기에 온천장과 모텔, 밥집이 옹기종기 모인 전형적인 온천 취락입니다.

소금기 머금은 55도 물은 탕에서 나온 뒤가 진짜입니다. 몸이 식질 않아요. 겨울날 버스 정류장에서 돌아갈 차를 기다리는 동안에도 등이 따뜻한 게 염화나트륨천의 힘입니다.

[IMG]북면 온천 동네의 저녁. 목욕을 마친 사람들이 하나둘 고깃집으로 흩어진다. ⓒ 물멍

마무리는 한우입니다. 온천단지 인근의 황우장사는 정육코너에서 직접 손질한 토종 한우를 굽는 집으로 현지인 단골이 많고, 해장국과 냉면을 내는 김박사명품해장국&냉면 같은 선택지도 있습니다. 온천에 진심인 동네는 밥집도 보양식 위주로 돌아간다는 것. 마금산이 그 증거입니다.','48',4,'2026-01-05 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='55도, 국민보양온천이라는 공인');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='55도, 국민보양온천이라는 공인' AND source='MANUAL' AND name='마금산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','경주의 마지막 밤은 보문호에서 데운다','신경주역 700번 버스, 호숫가 산책과 온천의 순서','/img/magazine/075.jpg','경주 여행의 끝에는 보문이 있어요. 불국사도 대릉원도 다 걸은 다음, 마지막 밤을 데우러 가는 곳. 44도 알칼리성 온천이 솟는 보문관광단지입니다.

가는 법은 명쾌해요. KTX 신경주역에서 700번 버스. 신경주역과 보문단지를 잇는 노선이라 여행자에게는 사실상 전용 셔틀입니다. 40분쯤 달려 보문호반에 내리면, 호텔과 리조트가 호수를 둘러싼 단지가 펼쳐져요.

보문에서의 도보 동선은 이렇게 짭니다.

① 해 지기 전, 보문호 순환 산책로 걷기. 호수를 따라 벚나무가 이어지는 길이라 봄엔 꽃터널, 가을엔 단풍길이 됩니다.
② 어스름해지면 온천. 보문단지의 호텔·리조트들이 44도 알칼리수를 받아쓰고 있어서, 투숙객이 아니어도 대중 온천 시설을 이용할 수 있는 곳을 고르면 됩니다.
③ 저녁은 단지 입구 쪽 두부요리 전문점 맷돌순두부. 웨이팅이 있을 만큼 회전이 빠른 집이에요. 떡갈비와 한우 물회를 내는 보문뜰, 보문호를 바라보며 꼬막비빔밥을 먹는 올바릇식당도 도보권의 선택지입니다.

밤의 보문호는 물빛에 단지의 불빛이 잠기는 시간이에요. 탕에서 데운 몸으로 호숫가를 한 바퀴 더 걷고 들어가면, 천년 고도의 하루가 그렇게 닫힙니다.','47',4,'2026-01-07 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='경주의 마지막 밤은 보문호에서 데운다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='경주의 마지막 밤은 보문호에서 데운다' AND source='MANUAL' AND name='보문온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','체온보다 낮은 29℃, 대신 동해가 수평선까지 열린다','정동진역에서 남쪽으로 — 바다부채길과 탑스텐 금진온천','/img/magazine/076.jpg','정동진역에 내리는 사람은 많습니다. 거기서 남쪽으로 방향을 잡는 사람은 드뭅니다.

해안단구 절벽 아래 헌화로를 따라 내려가면 금진 바닷가가 나오고, 그 언덕 위에 호텔 탑스텐이 서 있습니다. 이 호텔의 온천이 금진온천입니다. 정동진의 이름값에 가려 잘 보이지 않는 옆 동네의 물입니다.

뚜벅이 경로는 두 번의 기차와 한 번의 택시입니다. KTX로 강릉역, 강릉역에서 동해선 열차로 정동진역. 정동진역부터 호텔까지는 대중교통이 촘촘하지 않아 택시가 현실적이고, 거리가 짧아 부담은 크지 않습니다.

물은 29도 나트륨 중탄산천입니다. 체온보다 낮은 온도라 ''뜨끈한 탕''을 기대하면 놀라지만, 실내 스파와 함께 쓰도록 설계된 물이라 오래 머무는 데는 오히려 유리합니다. 그리고 이곳의 본체는 물이 아니라 전망입니다. 해안단구 위에서 동해가 수평선까지 통째로 열립니다.

[IMG]금진 언덕에서 내려다본 동해. 온천물보다 먼저 눈이 데워진다. ⓒ 물멍

걷기는 정동진 쪽에 있습니다. 정동진과 심곡항을 잇는 정동심곡바다부채길은 파도가 깎아낸 기암을 바로 옆에 두고 걷는 해안 탐방로입니다. 오전에 이 길을 걷고 오후에 29도 물에 드는 순서가 맞습니다.

[QUOTE]정동진은 해를 보러 가는 곳이고, 금진은 해가 뜬 뒤에 남는 곳이다.

저녁은 금진항과 정동진의 횟집 몫입니다. 정동횟집, 금진항옥계횟집 같은 집들이 동해안 자연산 회를 냅니다.

다음에 정동진역에 내리면 일출 인파와 반대 방향으로 걸어 보세요. 남쪽 언덕 위에 29도의 물과 수평선이 기다립니다.','51',4,'2026-01-08 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='체온보다 낮은 29℃, 대신 동해가 수평선까지 열린다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='체온보다 낮은 29℃, 대신 동해가 수평선까지 열린다' AND source='MOIS' AND external_id='4' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','망상해변까지 걸어가는 온천 호텔','동해선 열차로 닿는 동해보양온천의 바다-탕 왕복 동선','/img/magazine/077.jpg','아침에 해변을 맨발로 걷고, 모래를 털고 들어와 온천에 몸을 담근다. 이 왕복이 도보로 되는 곳이 동해시에 있습니다. 망상해변 곁의 동해보양온천컨벤션호텔입니다. 투숙객 후기에 ''망상 해수욕장까지 도보로 갈 수 있는 호텔''이라는 문장이 붙을 만큼, 바다와 탕 사이가 가깝습니다.

동해시는 2025년 동해선 완전 개통의 수혜지입니다. 부산에서도 강릉에서도 환승 없이 열차가 닿는 도시가 됐습니다. 동해역이나 묵호역에 내려 택시로 짧게 이동하면 망상 권역입니다. 서울에서 출발한다면 KTX로 강릉까지 간 뒤 동해선으로 갈아타는 경로가 됩니다.

이름에 ''보양온천''을 단 호텔답게, 이곳은 관광보다 요양의 문법으로 돌아갑니다. 온천 사우나에 몸을 맡기러 오는 중장년 투숙객이 많고, 부모님 모시고 오는 가족 단위가 자연스러운 분위기입니다.

도보 동선은 단순해서 좋습니다. 호텔에서 망상해변까지 걸어가 백사장을 끝까지 걷고 돌아오는 것. 여름 성수기가 지난 망상은 놀랄 만큼 조용해서, 파도 소리만 데리고 걷는 긴 산책이 됩니다. 짠 바람에 식은 몸을 다시 탕에 데우는 순간이 이 여행의 클라이맥스입니다. 화려한 일정 없이, 바다와 물만으로 채우는 1박. 그게 이 호텔의 사용법입니다.','51',4,'2026-01-09 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='망상해변까지 걸어가는 온천 호텔');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='망상해변까지 걸어가는 온천 호텔' AND source='MOIS' AND external_id='9' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','설악산 들머리에서 온천 가운을 입는 법','속초 터미널에서 한화리조트 설악까지, 산과 물의 배치','/img/magazine/078.jpg','설악산 여행의 숙제는 늘 숙소 위치예요. 시내에 자면 산이 멀고, 산 밑에 자면 밥집이 없고. 한화리조트 설악 쏘라노는 그 사이 어딘가, 미시령 방면 산자락에 자리를 잡았습니다. 그리고 이 리조트에는 30도 나트륨 중탄산천이 나옵니다.

서울에서 고속버스로 속초에 들어온 뒤, 터미널에서 택시로 리조트까지 이동하는 게 뚜벅이의 기본 경로예요. 속초 시내버스로 설악산 방면을 오가는 노선도 있으니, 시간이 맞으면 버스로도 접근할 수 있습니다.

중탄산천의 30도 물은 등산의 사후 처리에 특화되어 있어요. 설악산 소공원에서 비룡폭포나 울산바위를 다녀온 날, 뜨거운 탕이었다면 오히려 다리가 풀렸을 텐데, 체온에 가까운 부드러운 물은 뭉친 종아리를 천천히 달래줍니다.

밥은 리조트 담장 밖에 있습니다. 이 일대가 바로 학사평, 속초 순두부촌 언저리라 김영애할머니순두부 같은 순두부 노포가 가깝고, 설악동 방면으로는 점봉산산채 같은 산채 한식집이 있어요. 속초 향토음식 섭죽(홍합죽)을 쑤는 섭죽마을, 수제맥주를 뽑는 크래프트루트까지, 리조트 주변의 저녁 선택지는 생각보다 넓습니다.

산 타고, 물에 담그고, 순두부로 닫는 하루. 설악에서 이 순서를 흔드는 건 손해예요.','51',4,'2026-01-11 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='설악산 들머리에서 온천 가운을 입는 법');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='설악산 들머리에서 온천 가운을 입는 법' AND source='MOIS' AND external_id='16' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','만석닭강정 줄에 서기 전에, 30℃ 물에 먼저 들어간다','속초 체스터톤스 중탄산 스파 → 중앙시장 → 아바이마을 → 물회, 먹는 순서로 짠 하루','/img/magazine/079.jpg','주말 속초중앙시장, 닭강정 가게 앞 줄이 골목을 꺾어 돌아갑니다. 그 줄에 서기 전에 제안 하나. 순서를 뒤집어 온천부터 하는 겁니다.

속초의 체스터톤스호텔앤드레지던스에는 30도 나트륨 중탄산천이 나옵니다. 바다 도시 속초에서 온천수를 가진 드문 숙소로, 워케이션 시설로 소개될 만큼 전망과 부대시설에 공을 들인 곳입니다. 서울에서 고속버스로 속초터미널까지, 거기서 택시로 짧게 붙이면 도착입니다.

체온에 가까운 30도의 물은 아침용입니다. 펄펄 끓는 탕이 몸을 늘어지게 한다면, 이 물은 몸을 깨웁니다. 나오면 하루가 시작됩니다.

[IMG]아침의 스파, 창 너머로 속초 바다가 밝아 온다. ⓒ 물멍

속초의 동선은 먹는 순서로 짜야 속초답습니다. 중앙시장에서 만석닭강정 줄에 서고, 씨앗호떡을 후식으로 물고, 갯배를 타고 아바이마을로 건너가 오징어순대까지. 동명항 쪽으로 방향을 잡으면 물회의 영역입니다. 엑스포공원 인근 속초아장물회는 주문 즉시 회를 손질해 특제 육수에 말아내는 집으로, 비빔물회와 전복죽을 함께 냅니다.

[QUOTE]닭강정 줄은 도망가지 않는다. 먼저 물에 들어가라.

걷고 먹은 하루의 끝에 다시 미지근한 탕으로 돌아옵니다. 뜨거운 물이었다면 하루 두 번이 부담이었을 텐데, 30도는 아침저녁으로 드나들어도 몸이 지치지 않습니다. 이 숙소의 물을 쓰는 요령이 그것입니다.

이번 속초행은 순서만 바꾸세요. 탕, 닭강정, 호떡, 오징어순대, 물회, 그리고 다시 탕.','51',4,'2026-01-12 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='만석닭강정 줄에 서기 전에, 30℃ 물에 먼저 들어간다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='만석닭강정 줄에 서기 전에, 30℃ 물에 먼저 들어간다' AND source='MOIS' AND external_id='18' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','금요일 밤 9시, 7호선 타고 가는 20℃ 온천','부천 웅진플레이도시 — 지방 온천이 절대 못 주는 효용에 대하여','/img/magazine/080.jpg','금요일 밤 9시. 지방 온천은 이 시간에 갈 수 없어요. 부천 상동의 온천은 갈 수 있고요.

경기 부천 웅진플레이도시 얘기예요. 상동 신도시 한복판의 대형 스파·워터파크 시설인데, 지하에서 끌어올린 20도 나트륨 중탄산천을 씁니다. 온천법 기준을 통과한 물이라 서류상으로도, 물멍 데이터베이스상으로도 엄연한 온천이에요.

가는 길에 기차표는 없어요. 서울 지하철 7호선이 부천 상동 권역을 지나니, 가까운 역에 내려 버스나 택시로 짧게 붙이면 도착입니다. 퇴근길 가방을 그대로 들고 들어갈 수 있는 온천, 그게 이곳의 정체성이에요.

[IMG]금요일 밤, 퇴근 가방을 든 채 스파 입구로 들어가는 사람들. ⓒ 물멍

20도의 원수는 두 가지로 써요. 차갑게 그대로, 또는 데워서. 실내 스파와 찜질 시설이 함께 돌아가니 계절을 타지 않고, 수건과 세면도구를 챙길 필요도 없습니다. 온천 마을의 정취 같은 건 없어요. 대신 지방 온천이 절대 못 주는 효용이 하나 있죠. 금요일 밤 9시에 몸을 담글 수 있다는 것.

[QUOTE]정취는 없다. 대신 금요일 밤 9시가 있다.

밥은 신도시 방식이에요. 상동·중동 상권에 보쌈을 내는 영월보쌈, 고기를 굽는 미가원, 닭갈비제작소 중동점이 모여 있고, 인도 커리집 안나푸르나 상동점까지 선택지가 잡다하게 넓어요. 온천 동네 밥상은 아니지만 그게 도심 온천의 문법입니다.

멀리 갈 시간이 없는 주에는 가까운 물이 정답일 수 있어요. 이번 금요일, 퇴근하고 7호선을 타 보세요.','41',4,'2026-01-14 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='금요일 밤 9시, 7호선 타고 가는 20℃ 온천');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='금요일 밤 9시, 7호선 타고 가는 20℃ 온천' AND source='MOIS' AND external_id='44' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','성균관대역에서 내려 31℃ 탕, 그다음 파장시장 칼국수','화성행궁 반대편 — 지하철과 버스로 끝나는 북수원 온천 반나절','/img/magazine/081.jpg','수원의 온천은 화성행궁 반대편에 있습니다. 1호선 성균관대역에서 내리면 파장동이 멀지 않습니다.

역 앞에서 파장동 방면 버스로 한 번만 갈아타면 되고, 거리가 짧아 택시를 타도 부담이 크지 않습니다. 서울에서 지하철로 출발하는 사람에게는 환승 한 번짜리 온천입니다.

북수원스파플렉스의 물은 지하 깊은 곳에서 올라오는 나트륨-중탄산천, 원수 온도 31도입니다. 펄펄 끓는 탕을 기대하면 안 되지만 중탄산천 특유의 부드러운 물맛은 확실합니다. 미지근하게 한참 몸을 불리다 보면 뜨거운 탕이 왜 전부가 아닌지 알게 됩니다.

[IMG]파장시장 골목 안, 점심시간 칼국수집 앞에 줄이 선다. ⓒ 물멍

탕에서 나오면 걸을 곳은 파장시장입니다. 북수원시장이라고도 부르는 이 시장을 중심으로 칼국수 골목이 이어집니다. 바지락칼국수와 팥칼국수, 들깨옹심이를 내는 칼국수마당, 수원 토박이들이 꼽는 나드리칼국수가 다 이 일대에 있습니다. 온천에서 불린 몸에 뜨거운 국물을 붓는 순서가 정석입니다.

[QUOTE]31도에서 몸을 불리고, 칼국수 국물로 마저 데운다.

디저트가 필요하면 만두가 북수원점의 수제만두를 포장해도 됩니다. 서울에서 지하철로 출발해 반나절이면 탕과 시장을 다 돌고 돌아오는, 수도권에서 몇 안 되는 온천 동선입니다.

이번 주 반나절이 비었다면 1호선 성균관대역 방향 열차를 타세요. 화성행궁은 다음에 가도 됩니다.','41',4,'2026-01-15 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='성균관대역에서 내려 31℃ 탕, 그다음 파장시장 칼국수');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='성균관대역에서 내려 31℃ 탕, 그다음 파장시장 칼국수' AND source='MOIS' AND external_id='46' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','백암 순댓국 한 그릇 뒤에 온천이 있어요','서울남부터미널에서 시외버스로 가는 용인 백암','/img/magazine/082.jpg','순대 먹으러 백암 가자는 말은 들어봤어도, 온천하러 백암 가자는 말은 낯설죠. 그런데 용인스파랜드가 바로 그 백암에 있어요.

출발은 서울남부터미널이 편해요. 백암으로 가는 시외버스가 다니거든요. 용인 시내에서 출발한다면 용인공영버스터미널에서 백암 방면 시내버스를 타면 되고요. 백암 정류장에 내리면 일단 온천은 잠시 잊어도 됩니다. 이 동네는 전국 3대 순대로 꼽히는 백암순대의 본고장이니까요.

1940년대에 문을 연 중앙식당은 12시간 우린 국물을 쓰는 가장 오래된 집이고, 1964년 개업한 제일식당은 방송을 여러 번 타서 늘 붐벼요. 채소를 푸짐하게 넣어 담백한 게 백암순대의 성격이라, 온천 전에 먹어도 속이 무겁지 않아요.

[QUOTE]순대는 장날 음식이었다 — 백암 노포들이 5일장 상권에서 시작했다는 걸 알고 먹으면 국물 맛이 다르게 느껴져요.

배를 채웠으면 온천으로. 정류장 일대에서 스파랜드까지는 걸어가기엔 애매한 거리라 택시로 잠깐 이동하는 게 마음 편해요. 물은 27도 안팎의 나트륨-중탄산천. 뜨겁지 않은 대신 오래 담글 수 있는 물이에요. 순댓국의 온기와 중탄산천의 온기를 하루에 겹쳐 쓰는 것, 그게 백암식 반신욕이에요.','41',4,'2026-01-17 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='백암 순댓국 한 그릇 뒤에 온천이 있어요');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='백암 순댓국 한 그릇 뒤에 온천이 있어요' AND source='MOIS' AND external_id='50' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','포천까지는 쉽고, 신북부터는 시간표다','신북리조트 — 터미널 앞에서 택시냐 버스냐, 그 판단이 절반','/img/magazine/083.jpg','포천시외버스터미널 앞. 여기서부터 뚜벅이의 진짜 시간이 시작됩니다.

서울에서 포천 시내까지 들어오는 버스는 어렵지 않게 잡힙니다. 문제는 그다음입니다. 신북리조트는 포천 시내가 아니라 신북면에 있고, 터미널에서 신북면 방면 시내버스로 갈아타야 합니다. 이 구간의 배차는 넉넉하지 않습니다.

그래서 이 여행의 절반은 출발 전에 끝납니다. 포천시청 홈페이지에 시내버스 시간표가 올라와 있으니 시간을 먼저 잡아 두고, 애매하면 터미널 앞에서 택시를 타십시오. 버스냐 택시냐를 현장에서 고민하는 순간, 몸을 데울 시간이 줄어듭니다.

[IMG]포천시외버스터미널 앞 정류장. 신북면 방면 시내버스를 기다리는 오후. ⓒ 물멍

도착하면 보상이 있습니다. 신북의 물은 나트륨 계열 단순천. 순하고 부드러워 오래 담그기 좋은 물입니다. 리조트라 숙박이 되니, 당일치기로 쫓기지 말고 하룻밤 자면서 아침 탕까지 챙기는 쪽을 권합니다. 버스 시간에 쫓기며 몸을 덥히는 건 반칙입니다.

먹는 문제는 포천답게 풀립니다. 포천은 숯불 양념 소갈비, 이동갈비의 고장입니다. 다만 원조 상권인 이동면은 온천에서 또 한 번 이동해야 하는 거리입니다. 뚜벅이라면 무리해서 왕복하기보다 포천이동갈비본점처럼 택배 포장이 되는 집을 기억해 두는 편이 낫습니다.

[QUOTE]갈비는 집으로 부치고, 몸은 탕에 남겨둔다.

출발 전 시간표 한 번, 터미널 앞 판단 한 번. 그 두 번이면 신북의 순한 물에 밤과 아침, 두 번 들어갈 수 있습니다.','41',4,'2026-01-18 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='포천까지는 쉽고, 신북부터는 시간표다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='포천까지는 쉽고, 신북부터는 시간표다' AND source='MOIS' AND external_id='54' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','운천에서 내려 산정호수까지, 물가를 걷는 법','한화리조트 산정호수 안시의 하루 동선','/img/magazine/084.jpg','오전 — 산정호수의 관문은 운천이에요. 포천 북부의 이 작은 읍내까지 시외버스로 들어온 다음, 산정호수 방면 시내버스나 택시로 갈아타요. 갈아타는 구간은 길지 않지만 버스 배차는 촘촘하지 않으니, 시간이 안 맞으면 미련 없이 택시를 잡는 게 산정호수식이에요.

낮 — 리조트에 짐을 맡기고 바로 호수로 나가요. 산정호수 둘레길은 물가를 따라 도는 평탄한 길이라 운동화면 충분해요. 명성산 능선이 호수에 그대로 내려앉는 구간이 있는데, 거기서 다들 걸음이 느려져요.

[IMG]둘레길 데크 위, 오후의 산정호수는 바람이 불 때만 주름진다. ⓒ 물멍

저녁 — 호수 주변은 먹을 곳이 모여 있어요. 물가 풍경을 보며 숯불 이동갈비를 굽는 이동 강변 갈비, 칼칼한 국물의 버섯전골을 내는 금산가든이 산책 후 코스로 자연스러워요. 주차장 바로 앞 산정호수 맛집은 아침마다 채소 육수를 우려 부대찌개를 끓이는 집이고요.

밤 — 마지막이 온천이에요. 한화리조트의 물은 31도의 나트륨 계열 단순천. 자극 없는 물이라 걷느라 지친 다리를 담그고 한참 있기 좋아요. 호수를 걷고, 갈비를 굽고, 순한 물에 마무리하는 것. 산정호수의 하루는 이 순서가 맞아요.','41',4,'2026-01-20 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='운천에서 내려 산정호수까지, 물가를 걷는 법');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='운천에서 내려 산정호수까지, 물가를 걷는 법' AND source='MOIS' AND external_id='55' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','고현 말고 장승포행, 환승 없이 바다 앞에 내린다','거제 리베라호텔 — 열세 가지 해물전골과 소금물 탕','/img/magazine/085.jpg','시외버스 행선지를 잘 보십시오. 고현행이 아니라 장승포행입니다.

섬이라고 배를 탈 필요는 없습니다. 거제는 다리로 이어져 있어 시외버스가 그대로 들어갑니다. 거제시가 안내하는 시외버스 노선은 고현과 장승포 두 갈래인데, 리베라호텔거제가 있는 쪽은 장승포입니다. 장승포행을 잡으면 환승 없이 바다 앞에 내리고, 고현으로 들어갔다면 시내버스로 장승포까지 한 번 더 움직여야 합니다.

내리면 항구입니다. 부두를 따라 걷다 보면 지심도로 가는 배가 뜨는 터미널이 나옵니다. 그 앞에 해미촌이 있습니다. 거제 앞바다에서 나는 해산물 열세 가지를 철판에 담아내는 해물철판전골이 이 집의 간판입니다. 통문어를 통째로 넣은 해물뚝배기의 생생이는 현지인들이 먼저 꼽는 집입니다.

[IMG]장승포항 부두. 지심도행 여객선 터미널 앞으로 해미촌 간판이 보인다. ⓒ 물멍

온천은 그다음입니다. 리베라호텔의 물은 나트륨-염화물천, 소금기가 있는 물입니다. 염류천은 보온이 강점이라 탕에서 나온 뒤에도 몸이 쉽게 식지 않습니다. 바닷바람에 식은 몸을 짠 물로 데우는 것 — 해안 온천에서만 성립하는 조합입니다.

[QUOTE]바닷바람으로 식히고, 바닷물 같은 탕으로 데운다. 장승포의 순서다.

호텔이니 하룻밤 묵으십시오. 아침 바다까지 챙기면 동선이 닫힙니다. 오늘 할 일은 하나, 매표창구에서 ''장승포''라고 말하는 것입니다.','48',4,'2026-01-21 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='고현 말고 장승포행, 환승 없이 바다 앞에 내린다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='고현 말고 장승포행, 환승 없이 바다 앞에 내린다' AND source='MOIS' AND external_id='73' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','사상에서 레일 끝까지, 가야대역에 내리면 스파','남강스파 앤 피트니스 — 24도 단순천과 삼계동 외식 골목','/img/magazine/086.jpg','사상역에서 경전철을 타고, 내리지 말고 끝까지 가요. 레일이 멈추는 곳이 가야대역이에요.

부산김해경전철의 종점이 있는 동네가 삼계동이고, 남강스파 앤 피트니스가 여기 있어요. 부산 사상에서 출발한 경전철은 김해 시내를 관통해 레일이 끝나는 데까지 데려다줘요. 갈아탈 것도, 시간표를 외울 것도 없어요. 뚜벅이에게 이만큼 명쾌한 접근은 드물어요.

가야대역 개찰구를 나서면 삼계 신도시 상권이에요. 스파까지는 역에서 멀지 않은 생활권이라 걸어도 되고, 애매하면 마을을 도는 버스나 택시로 짧게 이으면 돼요.

[IMG]가야대역 승강장. 레일이 끝나는 자리 너머로 삼계동 아파트 단지가 보인다. ⓒ 물멍

물부터 말할게요. 남강스파의 원수는 24도 단순천이에요. 미지근한 물이라 시설에서 데운 탕과 냉탕을 오가는 식으로 즐기게 돼요. 순한 물이라 피트니스로 땀을 뺀 뒤에 담그기 좋고, 이름 그대로 운동과 목욕이 한 건물에서 끝나는 동네 거점형 스파예요.

밥은 골목이 대신 골라줘요. 한돈을 보름 숙성해 내는 요즘삼겹살, 육수를 다섯 가지 중에 고르는 샤브20, 해물을 쏟아붓는 바다칼국수&해물전골. 탕에 오래 있었던 날엔 진한 육수의 혼다라멘도 맞아요.

[QUOTE]종점에서 내리는 사람은 목적지가 분명한 사람이다.

부산에서 반나절이면 돼요. 이번 주말, 사상역에서 경전철 타고 종점까지 가보세요. 내릴 곳을 고민할 필요가 없다는 게 이 코스의 전부예요.','48',4,'2026-01-23 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='사상에서 레일 끝까지, 가야대역에 내리면 스파');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='사상에서 레일 끝까지, 가야대역에 내리면 스파' AND source='MOIS' AND external_id='87' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','사상에서 장유까지, 워터파크로 가는 가장 싼 길','김해롯데워터파크 뚜벅이 접근 공식','/img/magazine/087.jpg','차 없으면 워터파크 못 간다는 말, 장유에서는 틀립니다.

김해롯데워터파크는 김해 남쪽 장유 신도시에 있습니다. 부산에서 간다면 부산서부터미널, 그러니까 사상에서 장유로 들어가는 시외버스 노선이 오래된 정석 루트입니다. 김해 시내에서 출발한다면 장유 방면 시내버스가 다니고, 롯데워터파크 홈페이지에도 시내·시외버스 접근 안내가 따로 정리돼 있을 만큼 대중교통 손님이 많은 곳입니다. 정확한 승차 위치는 출발 전 홈페이지와 지도 앱으로 한 번만 맞춰보면 됩니다.

물놀이 시설이 주인공처럼 보이지만, 이곳의 물은 온천법에 등록된 온천수입니다. 24도의 단순천이라 물 자체가 순하고, 야외 슬라이드에서 식은 몸을 온수 시설에서 되돌리는 리듬으로 쓰게 됩니다. 한겨울보다 간절기에 진가가 나오는 물입니다.

다 놀고 나면 배가 고픈 게 정상입니다. 장유와 율하 일대는 김해에서 외식 상권이 가장 두터운 동네입니다. 한우 화로구이를 내는 가인화로구이 김해율하점, 숙성 양념 돼지갈비의 낙원갈비집 김해장유점이 가족 단위 손님을 받아내는 규모고, 코다리조림 하나로 버티는 황금코다리 김해장유점 같은 단일 메뉴 집도 있습니다. 물에서 보낸 하루의 마무리로는 어느 쪽이든 넉넉합니다.','48',4,'2026-01-24 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='사상에서 장유까지, 워터파크로 가는 가장 싼 길');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='사상에서 장유까지, 워터파크로 가는 가장 싼 길' AND source='MOIS' AND external_id='89' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','밀양역에서 아리랑시장까지, 국밥과 온천의 동선','호텔아리나에서 자고 걷는 밀양 1박','/img/magazine/088.jpg','방아잎을 아세요? 경상도 밖에서는 낯선 이 향채를 국밥에 얹어 먹는 동네가 밀양이에요.

밀양은 기차의 도시예요. 경부선 밀양역에 KTX와 무궁화호가 서니까, 뚜벅이에게는 출발부터 유리해요. 역에서 시내까지는 시내버스나 택시로 이동하는데, 밀양 시내 자체가 크지 않아 부담이 없어요.

첫 목적지는 밀양아리랑시장. 시장 안 노포 단골집이 밀양돼지국밥의 얼굴이에요. 부산식의 뽀얀 국물과 달리 밀양은 소머리 육수 계열의 맑은 국물을 쓰는데, 여기에 방아잎을 얹으면 그때부터 밀양 음식이 돼요. 방송을 여러 번 탄 집이라 점심때는 줄을 각오해야 해요. 원조 상권을 제대로 파고들고 싶다면 무안면 식육식당 골목이 본진인데, 동부식육식당과 무안식육식당이 그쪽 이름들이에요. 다만 무안면은 시내에서 다시 버스를 타야 하니 당일 일정이면 시장 쪽으로 충분해요.

[IMG]아리랑시장 국밥집, 뚝배기 위에 방아잎 두 장이 올라온다. ⓒ 물멍

국밥 후에는 밀양강변을 따라 영남루 쪽으로 걷고, 하루의 끝은 호텔아리나예요. 26도의 황산염천은 진정 효과가 있다고 알려진 물이라, 걸어 다닌 날의 마무리로 맞춤해요. 호텔이라 자고 일어나 아침 탕까지 하면, 기차 타고 온 보람이 완성돼요.','48',4,'2026-01-26 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='밀양역에서 아리랑시장까지, 국밥과 온천의 동선');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='밀양역에서 아리랑시장까지, 국밥과 온천의 동선' AND source='MOIS' AND external_id='90' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','노포역에서 버스 한 번, 36도 덕계의 저녁','천성산짐엔스파, 부산 지하철로 여는 양산 온천','/img/magazine/089.jpg','부산 도시철도 1호선의 북쪽 끝 노포역. 시외버스터미널과 환승센터가 붙어 있는 이 역이 양산 웅상으로 가는 관문입니다. 천성산짐엔스파가 있는 덕계 생활권은 노포에서 버스로 넘어가는 동네라, 환승센터에서 웅상·덕계 방면 버스를 타면 됩니다. 노선이 여럿이니 정류장 안내판에서 덕계 경유를 확인하고 타는 것이 요령입니다.

이 온천의 카드는 수온입니다. 36도. 사람 체온과 거의 같은 나트륨-중탄산천이 나옵니다. 뜨거운 탕이 부담스러운 사람에게 36도는 마법 같은 온도입니다. 들어간 줄도 모르게 들어가서, 나올 이유를 못 찾는 물이거든요. 이름에 ''짐''이 붙은 데서 알 수 있듯 피트니스를 겸하는 곳이라, 운동과 온천을 묶어 다니는 동네 단골이 많은 유형의 스파입니다.

탕에서 나온 뒤의 답은 국밥입니다. 덕계는 부산 접경답게 돼지국밥 문화가 진합니다. 사골 육수를 쓰는 착한돼지국밥은 아침 8시부터 문을 열어서, 아침 탕을 마치고 나온 사람의 시간표와 정확히 맞물립니다. 덕계동의 동동국밥 양산덕계점은 국밥에 우동을 함께 파는 집이고요.

지하철, 버스 한 번, 체온과 같은 물, 그리고 국밥. 부산 사는 뚜벅이가 저녁 반나절로 완성할 수 있는 가장 단순한 온천행입니다.','48',4,'2026-01-27 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='노포역에서 버스 한 번, 36도 덕계의 저녁');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='노포역에서 버스 한 번, 36도 덕계의 저녁' AND source='MOIS' AND external_id='93' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','진주역에 내리면 냉면이 먼저, 탕은 두 번째','윙스온천 스파앤피트니스 — KTX로 닿는 혁신도시 하루','/img/magazine/090.jpg','차가운 면 위에 따뜻한 육전. 진주에서 탕에 들어가기 전에 먼저 해야 할 일이에요.

서울에서 진주까지 KTX가 다닌다는 걸 아직 모르는 사람이 많아요. 경전선을 타고 내려온 열차가 서는 진주역은 시 외곽 남쪽에 있는데, 공교롭게도 윙스온천이 있는 혁신도시 충무공동과 가까운 쪽이에요. 역에서 혁신도시까지는 시내버스나 택시로 금방이라, 진주 뚜벅이 동선치고는 드물게 효율이 좋아요.

순서는 냉면부터예요. 진주냉면은 육전을 얹어 먹는 물냉면이고, 이 장르의 대표가 하연옥이에요. 본점이 이름을 알렸고 하대동에도 분점이 있어요. 뜨거운 탕에 들어가기 전, 면의 냉기와 육전의 온기로 몸을 먼저 깨워두는 거예요.

[IMG]하연옥의 진주냉면. 물냉면 위에 육전이 얹혀 나온다. ⓒ 물멍

윙스온천은 혁신도시 생활권의 스파앤피트니스예요. 신도시 상권 안에 있어서 탕을 나서면 바로 카페와 식당이 이어져요. 저녁이 되면 충무공동 쪽 한우집들이 불을 켜고, 태영한우 진주혁신도시점 같은 구이집이 그 상권의 얼굴이에요.

해가 지면 남강으로 나가세요. 진주성과 촉석루가 강물 위에 불빛으로 내려앉아요. 진주가 왜 물의 도시라 불리는지, 설명 대신 풍경이 답해요.

[QUOTE]냉면으로 깨우고, 탕으로 풀고, 남강으로 닫는다.

기차로 왔다 기차로 가는 하루에 세 가지면 돼요. 냉면, 온천, 남강 야경. 서울역에서 진주행 KTX 시간부터 찾아보세요.','48',4,'2026-01-29 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='진주역에 내리면 냉면이 먼저, 탕은 두 번째');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='진주역에 내리면 냉면이 먼저, 탕은 두 번째' AND source='MOIS' AND external_id='95' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','68도, 경산 남산면으로 가는 남산1번 버스','상대온천관광호텔, 대구 옆 동네의 뜨거운 물','/img/magazine/091.jpg','68도입니다. 이 원고에서 숫자는 이것 하나면 됩니다. 상대온천의 원수 온도는 전국 온천 중에서도 손에 꼽게 뜨겁습니다.

그 뜨거운 물이 나오는 곳은 의외로 한적한 농촌, 경산 남산면입니다. 대구 도심에서 지하철과 버스를 이어 경산 시내로 들어온 뒤, 남산면으로 들어가는 남산1번 버스를 타는 것이 뚜벅이의 기본 공식입니다. 면 단위 노선이라 배차 간격이 도시 같지 않으니, 지도 앱에서 시간을 확인하고 움직여야 합니다. 시간이 어긋나면 경산 시내에서 택시로 잇는 것이 현실적입니다.

탕 안의 이야기는 단순합니다. 나트륨-염화물천, 그러니까 짠 기 있는 물이 68도로 솟습니다. 염류천은 보온이 강해서 탕을 나온 뒤에도 몸에 열이 오래 남습니다. 겨울에 진가가 나오는 물이고, 실제로 대구·경산 사람들이 겨울마다 찾아드는 유형의 온천장입니다. 관광호텔을 겸하고 있어 자고 갈 수도 있습니다.

남산면 일대는 백숙과 토종닭을 내는 시골 식당들이 드문드문 있는 정도라, 제대로 된 식사는 경산 시내로 나와서 해결하는 편이 낫습니다. 간장게장으로 이름난 풍천관, 숯불 닭갈비를 굽는 닭바위, 솥밥 누룽지가 별미인 더반이 시내 쪽 선택지입니다. 뜨거운 물에 몸을 데우러 갔다가, 밥은 도시에서. 상대온천은 그런 왕복의 온천입니다.','47',4,'2026-01-30 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='68도, 경산 남산면으로 가는 남산1번 버스');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='68도, 경산 남산면으로 가는 남산1번 버스' AND source='MOIS' AND external_id='140' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','KTX로 경주, 버스로 시내, 두 발로 황리단길','에스지빌라앤스파와 묶는 경주 시내권 도보 여행','/img/magazine/092.jpg','경주는 뚜벅이의 도시가 됐어요. KTX 경주역에 내려 시내로 들어가는 버스를 타면, 그다음부터는 웬만한 건 두 발로 다 돼요. 대릉원 고분 사이를 걷고, 첨성대를 지나고, 황리단길로 빠지는 이 동선은 전부 평지 도보권이거든요.

걷다 보면 배가 고파지는 지점이 정확히 황리단길이에요. 한옥을 고쳐 만든 취향가옥은 압력솥으로 조리한 소갈비찜에 육전 밀면을 붙여 파는 집이고, 다인매운등갈비찜은 매일 새로 삶은 생고기만 쓴다는 원칙으로 버티는 집이에요. 돌판 스테이크를 숯불로 구워내는 범외양간처럼 장르가 다른 집도 섞여 있어서, 골목을 한 바퀴 돌며 고르는 재미가 있어요.

[QUOTE]고분 사이를 걷는 도시는 경주뿐이라, 여기선 산책이라는 말의 무게가 달라요.

하루 종일 걸었다면 마무리는 온천이에요. 에스지빌라앤스파는 숙박을 겸하는 빌라형 스파로, 33도의 나트륨-중탄산천을 쓰는 곳이에요. 중탄산천은 물이 미끈하고 부드러워서 걷기 여행의 마감으로 잘 맞아요. 정확한 위치와 이용 방식은 예약 플랫폼에서 확인하고 가는 걸 권해요. 숙소형 스파는 당일 이용 조건이 시기마다 달라지니까요. 확실한 건 하나예요. 경주에서 하루 이만 보를 걸은 다리에게는 미지근하고 부드러운 물이 필요하다는 것.','47',4,'2026-02-01 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='KTX로 경주, 버스로 시내, 두 발로 황리단길');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='KTX로 경주, 버스로 시내, 두 발로 황리단길' AND source='MOIS' AND external_id='141' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','부챗살 바위를 걷고, 33도 물에서 버스를 기다린다','경주 양남해수온천랜드 — 파도소리길과 24시간 탕','/img/magazine/093.jpg','동해가 부챗살 모양으로 굳어 있습니다. 경주 양남면 주상절리, 그 바위를 따라 해안을 걷는 길의 이름이 파도소리길입니다. 이름 그대로 길 내내 파도 소리가 따라옵니다.

양남은 경주 시내에서 동남쪽 바닷가로 한참 내려간 어촌입니다. 뚜벅이의 기본은 경주 시내에서 양남 방면 시내버스인데, 면 단위 노선이라 배차가 성깁니다. 경주시 버스정보나 지도 앱으로 시간을 먼저 잡아 두십시오. 울산 쪽에서 들어오는 경로도 있으니 출발지에 따라 두 방향을 비교해 볼 만합니다.

[IMG]양남 주상절리. 부챗살로 펼쳐진 바위 위로 파도가 부서진다. ⓒ 물멍

길을 다 걸었으면 몸을 데울 차례입니다. 양남해수온천랜드는 이름처럼 바닷가 온천으로, 33도의 나트륨-중탄산천을 씁니다. 부드러운 물에 몸을 담그고 있으면, 방금 걸어온 해안의 바람이 그제야 소금기로 느껴집니다.

이 온천이 뚜벅이에게 특별한 이유는 하나 더 있습니다. 24시간형 시설이라는 점입니다. 돌아가는 버스 시간이 어중간할 때, 정류장 대신 탕이 대기실이 됩니다.

밥은 어촌답게 먹으면 됩니다. 양남해물칼국수는 해물칼국수 한 종목으로 승부하는 집이고, 골목횟집은 경북관광공사가 현지인 집으로 소개한 붕장어 전문입니다.

[QUOTE]양남의 하루는 전부 바다에서 나온다. 길도, 물도, 붕장어도.

버스 시간표를 먼저 잡고, 걷고, 담그고, 붕장어를 굽는 것. 이 순서만 지키면 배차 간격은 더는 문제가 아닙니다.','47',4,'2026-02-02 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='부챗살 바위를 걷고, 33도 물에서 버스를 기다린다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='부챗살 바위를 걷고, 33도 물에서 버스를 기다린다' AND source='MOIS' AND external_id='150' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','보문호는 10번 버스를 타고 돕니다','더케이호텔 온천사우나와 보문단지 하루','/img/magazine/094.jpg','경주 시내와 보문관광단지 사이에는 순환버스가 다닙니다. 경주시가 아예 ''10번 버스타고 경주여행''이라는 코스로 안내할 만큼, 10번·11번 계열 버스는 뚜벅이의 발입니다. 시내 정류장에서 타면 보문호반의 호텔들 앞을 차례로 지나가니, 더케이호텔 앞에서 내리면 됩니다.

더케이호텔의 온천사우나는 보문단지 안에서도 물로 승부하는 곳입니다. 지하 깊은 곳에서 올라오는 33도의 나트륨-중탄산천을 쓰는데, 알칼리성의 미끈한 물맛이 뚜렷합니다. 호텔 투숙객이 아니어도 온천사우나를 이용할 수 있는 날이 많아, 보문 산책과 묶기 좋습니다.

동선은 이렇게 짭니다. ① 오전에 보문호 수변길을 반 바퀴 걷고 ② 낮에 온천사우나에서 두어 시간을 보낸 뒤 ③ 늦은 오후 버스로 시내 쪽 교동으로 넘어갑니다.

교동으로 가는 이유는 밥 때문입니다. 별채반 교동쌈밥은 곤달비비빔밥과 쌈밥으로 경주 한정식의 기준 노릇을 하는 집이고, 황남맷돌순두부와 전통맷돌순두부는 경주시가 공식 소개하는 순두부집들입니다. 고기가 당기는 날은 보문단지 안 경주천년한우 보문점에서 해결하고 호수 야경까지 보고 들어가는 편이 낫고요. 버스 한 노선으로 호수, 온천, 쌈밥이 다 꿰어지는 것. 보문이 뚜벅이에게 관대한 이유입니다.','47',4,'2026-02-04 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='보문호는 10번 버스를 타고 돕니다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='보문호는 10번 버스를 타고 돕니다' AND source='MOIS' AND external_id='153' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','한우단지 옆 온천, 천북까지 가는 느린 길','블루밸리콘도온천과 경주 천북면 고기 골목','/img/magazine/095.jpg','''경주까지 가서 웬 고기냐''는 말은 천북면을 모르고 하는 소리입니다.

경주 북쪽, 포항과 맞닿은 천북면은 한우 숯불구이 식당이 밀집해 ''천북 한우단지''로 불리는 동네입니다. 방송을 탄 물천한우와 옛날경주숯불, 한국인의밥상에 나온 착한밥상까지, 면 단위 시골에 고기 상권이 이만큼 형성된 곳은 드뭅니다. 그리고 그 동네에 블루밸리콘도의 온천이 있습니다.

솔직하게 말하겠습니다. 천북은 뚜벅이에게 쉬운 동네가 아닙니다. 경주 시내에서 천북 방면으로 들어가는 시내버스가 있지만 배차가 성기고, 포항 생활권과 걸쳐 있어 경로가 헷갈리기 쉽습니다. 경주시 버스정보시스템에서 시간을 먼저 확인하고, 마지막 구간은 택시를 섞을 각오를 하는 것이 정신 건강에 좋습니다. 콘도형 숙소이니 아예 1박으로 잡고 이동 횟수 자체를 줄이는 것이 천북식 해법입니다.

느리게 도착한 만큼 보상은 확실합니다. 온천은 33도의 나트륨-중탄산천. 부드러운 물에 낮의 이동 피로를 풀고, 저녁에는 걸어서 한우단지로 갑니다. 숯불 위 등심과 미지근하고 미끈한 탕. 서로 관계없어 보이는 이 둘이 하루 안에서 만나는 곳은 전국에서 천북 정도입니다.','47',4,'2026-02-05 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='한우단지 옆 온천, 천북까지 가는 느린 길');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='한우단지 옆 온천, 천북까지 가는 느린 길' AND source='MOIS' AND external_id='155' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','구미역에 내리면 온천까지 걸어갑니다','발리스파, 역세권 45도 온천이라는 반칙','/img/magazine/096.jpg','뚜벅이 온천의 이상형은 단순합니다. 기차역에서 내려서 걸어가는 것. 구미가 그걸 해냅니다.

발리스파는 구미시 원평동, 구미중앙로11길에 있습니다. 원평동은 구미역 앞 원도심이고, 중앙로는 역에서 뻗어 나가는 상가 거리입니다. 경부선 열차로 구미역에 내려 중앙로 상권으로 걸어 들어가면 되는, 전국에서도 드문 도보 역세권 온천입니다. 24시간 연중무휴로 돌아가는 찜질 스파라 기차 시간이 어중간해도 문제가 없습니다.

물이 장식이 아니라는 점이 중요합니다. 원수 45도. 데우지 않아도 탕이 되는 온도의 물이 도심 한복판에서 나옵니다. 이름 때문에 발리풍 인테리어가 먼저 회자되지만, 이 집의 본질은 45도짜리 원수입니다.

[IMG]구미역 앞 중앙로, 퇴근길 사람들 틈에 찜질복 가방을 든 사람이 섞여 걷는다. ⓒ 물멍

먹는 것도 역 앞에서 끝납니다. 구미역 근처 싱글벙글복어는 밀복지리로 해장 겸 식사가 되는 집이고, 찹쌀수제비와 막국수의 진주국수, 구미 사람들만 안다는 북어물찜의 신사랑방도 시내권입니다. 기차, 도보, 뜨거운 원수, 복지리. 자차 없는 사람이 오히려 유리한 온천행이 있다면 바로 이 조합입니다.','47',4,'2026-02-06 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='구미역에 내리면 온천까지 걸어갑니다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='구미역에 내리면 온천까지 걸어갑니다' AND source='MOIS' AND external_id='157' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','하루 몇 번 오는 버스 끝에 61도 물이 있다','문경 에스티엑스리조트 — 점촌에서 농암까지, 알고 가면 계획','/img/magazine/097.jpg','농암 방면 시내버스는 하루에 몇 번 안 다녀요. 먼저 그것부터 말해둘게요.

에스티엑스리조트는 문경 남쪽 산자락, 농암면 쪽 깊숙한 곳에 있어요. 문경의 교통 거점은 점촌이고, 시외버스로 점촌까지는 어렵지 않게 들어와요. 문제는 거기서 산중까지예요. 현실적인 답은 점촌에서 택시를 타거나, 리조트에 미리 교통편을 문의해 두는 거예요. 이 구간의 불편은 알고 가면 계획이고, 모르고 가면 사고예요.

그런데도 가는 이유가 있어요. 물이 61도거든요. 나트륨-중탄산천이 이 온도로 솟는 곳은 전국에서도 몇 안 돼요. 산속이라 밤에는 불빛도 소리도 없어서, 뜨거운 물과 찬 공기의 대비만 남아요.

[IMG]산자락의 리조트 노천탕. 어둠 속에서 김만 하얗게 오른다. ⓒ 물멍

그래서 처음부터 1박으로 짜세요. 당일치기로 이 산길을 왕복하는 건 온천이 아니라 극기훈련이에요. 숙박형 리조트라는 조건이 이 코스에선 선택이 아니라 전제예요.

오가는 길의 시간은 점촌에 쓰세요. 1975년부터 순대를 빚어온 진미순대가 점촌의 노포고, 문경 특산 약돌돼지를 굽는 문경약돌돼지한마리, 비주얼로 이름을 알린 한성짬뽕도 점촌 생활권이에요.

[QUOTE]버스 기다리는 시간이 밥 먹는 시간이 되면, 배차 간격은 단점이 아니다.

점촌 도착 시간과 리조트 교통편, 이 두 가지만 미리 맞춰 두세요. 나머지는 61도가 알아서 해요.','47',4,'2026-02-08 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='하루 몇 번 오는 버스 끝에 61도 물이 있다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='하루 몇 번 오는 버스 끝에 61도 물이 있다' AND source='MOIS' AND external_id='161' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','안동역은 2020년에 옮겨갔고, 물은 41도 그대로다','안동온천 스파랜드 — 구시장 찜닭골목에서 월영교까지','/img/magazine/098.jpg','안동역에 내렸는데 구도심이 보이지 않습니다. 당연합니다. 역과 터미널이 2020년에 시내 서쪽 송현동으로 옮겨갔기 때문입니다.

그래서 안동 뚜벅이의 첫 일은 시내버스입니다. 안동시 버스정보시스템에서 구도심행 노선을 확인해 두면 헤맬 일이 없습니다. 이 한 번의 환승이 안동 여행의 첫 관문입니다.

시내에 들어왔으면 순서는 정해져 있습니다. 찜닭이 먼저입니다. 구시장 찜닭골목에는 안동시골찜닭과, 남은 양념에 밥을 비비는 맛으로 알려진 종가찜닭이 이웃해 있습니다. 간고등어가 당기면 방송을 여러 번 탄 일직식당, 둘 다 먹고 싶으면 간고등어와 찜닭을 한 상에 올리는 안동김대감이라는 절충안이 있습니다.

[IMG]구시장 찜닭골목. 양념 냄새가 골목 입구까지 나와 있다. ⓒ 물멍

안동에만 있는 장르도 하나 챙기십시오. 제사 없이 제삿밥을 차려주는 헛제사밥까치구멍집은 백년가게 인증을 받은 집입니다.

배가 부르면 걷습니다. 낙동강 위 월영교까지 걸어가 다리를 건너갔다 오는 것이 안동 시내 도보 코스의 정석입니다.

그리고 온천입니다. 안동온천 스파랜드의 원수는 41도의 나트륨-중탄산천. 데울 필요 없이 그대로 탕이 되는 온도에, 중탄산천의 미끈함이 얹힙니다. 간이 짙은 안동 음식으로 채운 하루를 부드러운 물로 헹궈내는 순서입니다.

[QUOTE]유교의 도시가 목욕의 도시였다는 걸, 몸이 먼저 안다.

역이 어디로 옮겨갔든 물은 그 자리에 있습니다. 버스 노선 하나만 확인하고 내려가십시오.','47',4,'2026-02-09 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='안동역은 2020년에 옮겨갔고, 물은 41도 그대로다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='안동역은 2020년에 옮겨갔고, 물은 41도 그대로다' AND source='MOIS' AND external_id='177' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','쫄면 노포 두 집과 51도 탕, 청량리에서 환승 없이','영주온천랜드 — KTX-이음으로 가는 원도심 분식 순례','/img/magazine/099.jpg','쫄면의 도시가 어디냐고 물으면 인천이라는 답이 많습니다. 영주 사람들의 답은 다릅니다.

근거는 노포 두 집입니다. 33년 전통의 중앙분식은 영주 원조 쫄면집으로 불리고, 40년을 이어온 나드리쫄면은 백년가게로 선정됐습니다. 쫄면 하나로 노포가 두 집이나 버티는 도시는 흔치 않습니다.

가는 길은 단순합니다. 청량리에서 KTX-이음을 타면 환승 없이 영주역입니다. 중앙선 고속화의 수혜를 가장 알기 쉽게 받은 도시입니다. 역에서 시내까지는 시내버스로 잇고, 영주 원도심은 규모가 아담해서 일단 들어가면 그다음은 도보로 충분합니다.

[IMG]영주 원도심 분식집. 쫄면 한 그릇 위로 김이 오른다. ⓒ 물멍

매운 게 부담스러운 일행에게도 자리가 있습니다. 72시간 전통 방식으로 묵을 쑤는 영주전통묵집식당의 메밀묵밥, 부석태 재래콩으로 청국장을 끓이는 두부마을 택지2호점입니다.

먹는 사이사이 근대문화거리를 걷다가, 마무리는 영주온천랜드입니다. 원수 51도의 나트륨-중탄산천이라 물이 뜨겁고 부드럽습니다. 쫄면의 매운 기운이 남은 몸을 탕에 담그면, 이마에 맺히는 땀이 오늘 하루의 요약본입니다.

[QUOTE]쫄면 하나로 노포 두 집이 버티는 도시는 흔치 않다.

돌아가는 KTX-이음 좌석에서는 십중팔구 잠듭니다. 청량리 도착 알람을 맞춰 두는 것까지가 영주 뚜벅이 일정입니다.','47',4,'2026-02-11 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='쫄면 노포 두 집과 51도 탕, 청량리에서 환승 없이');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='쫄면 노포 두 집과 51도 탕, 청량리에서 환승 없이' AND source='MOIS' AND external_id='184' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','풍기역 앞은 온통 인삼 냄새','소백산풍기온천리조트, 기차로 가는 인삼 고을 온천','/img/magazine/100.jpg','역에서 내리자마자 냄새가 먼저 옵니다. 풍기는 인삼의 고장이고, 중앙선 풍기역 앞 거리부터 인삼 가게들이 늘어서 있습니다. 소백산 자락의 이 작은 읍이 뚜벅이 온천 여행지가 되는 이유는 단순합니다. 기차역과 온천이 같은 생활권 안에 있기 때문입니다.

풍기역에는 중앙선 열차가 서고, 역에서 소백산풍기온천리조트까지는 읍내 이동 수준이라 택시로 금방입니다. 걷기를 좋아한다면 읍내 구경을 겸해 천천히 이동해도 되는 거리감입니다.

온천의 물은 51도의 나트륨-중탄산천. 소백산을 바라보는 자리에서 뜨겁고 미끈한 물에 몸을 담그는 것이 이 리조트의 본론입니다. 숙박동이 있어 소백산 산행과 묶어 1박 일정을 짜는 사람이 많고, 온천만 이용하고 기차로 돌아가는 당일 손님도 받아냅니다.

탕을 나온 뒤의 풍기는 간식의 동네입니다. 풍기읍에서 40년을 튀겨온 정도너츠는 인삼과 사과, 생강을 넣은 도너츠로 기차 안 간식까지 해결해주고, 일곱 가지 약초 육수의 영주칠향계는 삼계탕으로 한 끼를 책임집니다. 이웃 순흥면의 50년 떡집 순흥기지떡의 발효떡도 포장해 갈 만합니다. 인삼 냄새로 시작해 도너츠 봉지로 끝나는 것, 그것이 풍기역 온천행의 처음과 끝입니다.','47',4,'2026-02-12 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='풍기역 앞은 온통 인삼 냄새');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='풍기역 앞은 온통 인삼 냄새' AND source='MOIS' AND external_id='186' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','영천 터미널에서 시작하는 만두-온천-곰탕 삼각형','차 없이 영천 가는 사람의 하루 동선','/img/magazine/101.jpg','군만두 한 판, 온천 한 탕, 곰탕 한 그릇. 차 없이 영천에 가는 날의 계획은 이 세 줄이면 충분합니다.

영천은 뚜벅이에게 진입 장벽이 낮은 도시입니다. 대구·포항 쪽에서 시외버스가 영천버스터미널로 들어오고, 무궁화호가 서는 영천역도 있습니다. 어느 쪽으로 내리든 도시 규모가 아담해서, 시내 이동은 짧은 버스나 택시 한 번으로 정리됩니다. 광천온천랜드까지의 마지막 구간은 지도 앱 검색이 가장 정확하니, 터미널에 내려서 확인하고 움직이는 편을 권합니다.

순서는 이렇게 짜봤습니다. ① 도착하자마자 삼송꾼만두 영천본점. 45년째 만두를 빚어 백년가게로 지정된 집인데, 속이 꽉 찬 군만두는 줄 서기 전에 가는 게 상책입니다. ② 배를 채웠으면 광천온천랜드로. 58도짜리 원수가 나오는 곳이라 물이 뜨겁고, 성분은 순한 단순천이라 오래 담가도 부담이 적습니다. ③ 나와서는 영천공설시장 곰탕골목. 3대째 이어온 포항할매집의 소머리곰탕이 이 골목의 오래된 답안지입니다.

[IMG]영천공설시장 곰탕골목, 점심 무렵의 솥에서 김이 오른다. ⓒ 물멍

시장에서는 영천 사람들이 제사상에 올리는 돔배기, 그러니까 간을 해 토막 낸 상어고기도 구경할 수 있습니다. 곰탕이 무겁게 느껴지는 날엔 영천새우칼국수의 푸짐한 칼국수나, 1975년부터 한자리를 지킨 화평대군 식당의 육회비빔밥으로 바꿔도 됩니다.

탕에서 데운 몸으로 시장을 한 바퀴 돌고 터미널로 돌아오면 반나절이 갑니다. 거창한 관광지 없이도 하루가 꽉 차는, 그런 종류의 도시입니다.','47',4,'2026-02-14 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='영천 터미널에서 시작하는 만두-온천-곰탕 삼각형');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='영천 터미널에서 시작하는 만두-온천-곰탕 삼각형' AND source='MOIS' AND external_id='188' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','9000번 종점, 청동 손 앞에서 36.2도로 녹는다','호미곶온천랜드 — 한반도 최동단 뚜벅이 코스','/img/magazine/102.jpg','9000번. 포항에서 이 숫자 하나가 여행 코스를 통째로 대신해요.

포항 시내에서 출발해 호미반도 해안을 돌아 호미곶 해맞이광장까지 가는 노선이에요. 자차 없이 한반도 최동단을 밟는 가장 현실적인 방법이고요. 창밖 오른쪽에 바다를 두고 달리다 종점 부근에서 내리면, 해맞이광장의 청동 손이 파도 위에 떠 있어요.

사진 찍고 바람 맞다 보면 몸이 금세 식어요. 그때 근처 호미곶온천랜드 차례예요.

[QUOTE]수온 36.2도. 뜨겁다기보다, 체온보다 아주 조금 따뜻한 물이에요.

이 온천의 물은 나트륨-염화물 계열이지만 성분이 순해서 단순천으로 분류돼요. 펄펄 끓는 탕을 기대하면 심심할 수 있어요. 대신 바닷바람에 언 몸을 천천히 되돌리기엔 이 온도가 맞아요. 미지근한 탕에 오래 앉아 있는 것, 그게 호미곶식 목욕이에요.

나와서는 버스로 구룡포 방향이에요. 등대지기 식당의 물회, 바다랑대게의 구룡포식 모리국수 중에 고르면 돼요. 구룡포 일본인 가옥거리까지 걸으면 여든여덟밤처럼 오래된 가옥을 고친 카페가 있고, 겨울이면 과메기 말리는 풍경과 카페 유리창이 한 프레임에 잡혀요.

[IMG]호미곶 해맞이광장, 바다에서 솟은 청동 손 위로 갈매기가 앉았다. ⓒ 물멍

숙제는 하나뿐이에요. 돌아오는 9000번은 배차가 넉넉하지 않으니, 광장에 도착하자마자 돌아가는 시간부터 확인하세요. 그다음은 36.2도가 알아서 해요.','47',4,'2026-02-15 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='9000번 종점, 청동 손 앞에서 36.2도로 녹는다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='9000번 종점, 청동 손 앞에서 36.2도로 녹는다' AND source='MOIS' AND external_id='209' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','죽도시장 곰탕골목과 목욕탕의 오래된 협업','포항 도심 온천 뚜벅이 사용법','/img/magazine/103.jpg','목욕탕과 시장은 오래 붙어 다닌 조합입니다. 포항에서는 그 조합이 아직 현역입니다.

포항건강랜드는 포항 도심에 있는 온천 사우나입니다. 수온 36.2도의 나트륨-염화물 계열 단순천이라 물이 순하고, 관광지형 스파가 아니라 도시 사람들이 평일에 드나드는 생활형 온천에 가깝습니다. KTX를 타고 포항역에 내리든 시외버스로 포항터미널에 내리든, 시내버스 노선이 도심으로 촘촘하게 이어지니 접근 자체는 어렵지 않습니다. 정확한 하차 정류장은 지도 앱에 맡기는 편이 낫습니다.

이 온천의 진짜 카드는 걸어서 엮을 수 있는 죽도시장입니다. 수요미식회에 나온 장기식당은 3대째 65년 동안 곰탕을 끓여 왔고, 평남식당도 40년 넘게 소머리곰탕과 한우수육으로 버텨 온 노포입니다. 탕에서 나온 직후의 헐렁한 몸으로 뜨거운 곰탕 국물을 넘기는 순서, 이게 포항 도심 반나절의 뼈대입니다.

[IMG]죽도시장 곰탕골목 입구, 노포 간판들이 겹겹이 걸려 있다. ⓒ 물멍

물회파라면 선택지가 갈립니다. 매콤달콤한 육수를 부어 먹는 포항식 물회의 원조급으로 꼽히는 환여횟집 본점, 생활의 달인에 나온 38년 경력의 마라도회식당. 어느 쪽이든 밥을 말기 시작하면 되돌아갈 수 없습니다.

아침 일찍 도착했다면 순서를 뒤집어도 됩니다. 터미널 근처 조방돼지국밥은 아침 일곱 시부터 문을 여는 국밥집이니, 국밥으로 시작해 온천으로 마무리하는 역방향도 성립합니다.','47',4,'2026-02-17 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='죽도시장 곰탕골목과 목욕탕의 오래된 협업');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='죽도시장 곰탕골목과 목욕탕의 오래된 협업' AND source='MOIS' AND external_id='216' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','보리밥 먹으러 갔다가 온천까지 하고 오는 동네','광주 지산동, 무등산 자락의 반나절','/img/magazine/104.jpg','등산도 아니고 관광도 아닌데 무등산 자락까지 갈 이유가 있냐고요? 지산동에는 두 가지가 있어요. 보리밥, 그리고 온천이에요.

호텔무등파크는 광주 동구 지산동, 무등산 쪽으로 올라가는 초입에 있어요. 광주 도심에서 시내버스로 닿는 거리라 뚜벅이 난도는 낮은 편이고, 정류장 이름이 노선마다 달라서 출발 전에 지도 앱으로 확인하는 게 정확해요. 이 동네 온천물은 칼슘-중탄산 계열이에요. 수온이 24도라 데워서 쓰지만, 중탄산천 특유의 부드러운 감촉은 그대로예요. 탕에 들어가면 물이 살에 감기는 느낌이 확실히 달라요.

목욕 전후의 식사는 고민할 필요가 없어요. 지산동에는 무등산 보리밥거리가 있거든요. 열세 가지 나물 반찬에 시래기 된장국을 내는 팔도강산이 이 거리의 대표 주자고, 온천 가까이엔 할머니집 온천 보리밥이라는 상호의 집도 있어요. 고추장과 참기름을 넣고 쓱쓱 비빈 보리밥에 막걸리 한 잔을 곁들이는 게 이 거리의 오래된 문법이에요.

[QUOTE]나물 열세 가지를 다 집어 넣으면, 비비는 데만 한참이 걸려요.

소화를 시키고 싶으면 바로 옆 지산유원지 방향으로 걸으면 돼요. 무등산 능선을 눈에 걸어 두고 걷다가, 내려와서 탕에 몸을 담그면 반나절이 끝나요. 광주 시내에서 지하철 없이도 굴러가는, 밥-산-물 순서의 단순한 하루예요.','29',4,'2026-02-18 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='보리밥 먹으러 갔다가 온천까지 하고 오는 동네');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='보리밥 먹으러 갔다가 온천까지 하고 오는 동네' AND source='MOIS' AND external_id='223' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','대구가 된 시골, 군위에서 하룻밤','백송온천관광호텔까지 느리게 가는 법','/img/magazine/105.jpg','군위는 이제 대구입니다. 2023년에 경북에서 대구광역시로 편입됐지만, 풍경은 여전히 경북 북부의 시골 읍내입니다.

이 간극이 뚜벅이에게는 기회가 됩니다. 광역시 소속이라 대구 방면 교통편이 계속 정비되는 중인데, 정작 내리면 관광버스도 인파도 없는 조용한 동네가 기다리고 있기 때문입니다. 시외버스가 군위 터미널로 들어오니, 대구에서 출발한다면 터미널 노선을 먼저 확인하는 게 순서입니다. 군내 버스는 배차가 뜸해서, 터미널에서 백송온천관광호텔까지의 마지막 이동은 시간표를 미리 붙잡아 두거나 택시를 부르는 편이 현실적입니다.

백송온천관광호텔은 숙박이 되는 온천입니다. 물은 나트륨-염화물 계열의 염류천. 수온 20도의 냉광천수를 데워 쓰는데, 염류천은 목욕 후 몸에 남는 보온감이 특징이라 겨울 여행과 궁합이 좋습니다. 탕에서 나와 한참이 지나도 손끝이 따뜻한 그 감각 때문에 염류천을 찾는 사람들이 있습니다.

[IMG]군위 읍내의 이른 저녁, 낮은 지붕들 너머로 해가 진다. ⓒ 물멍

당일치기로 오가기엔 교통편 간격이 아쉬운 동네라, 아예 하룻밤 묵는 일정을 권합니다. 저녁 탕, 아침 탕을 두 번 채우고 읍내를 천천히 걷다 돌아가는 것. 볼 것이 많아서가 아니라 볼 것이 적어서 쉬어지는 여행이 있는데, 군위가 그렇습니다.','27',4,'2026-02-20 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='대구가 된 시골, 군위에서 하룻밤');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='대구가 된 시골, 군위에서 하룻밤' AND source='MOIS' AND external_id='224' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','앞산 내려와서 어디 가냐고 물으면','봉덕동 홈스파월드, 대구 등산객의 뒷문','/img/magazine/106.jpg','"내려와서 어디 가시게요?" 앞산에서 만난 등산객들의 대화는 대체로 하산 이후를 향해요. 대구 남구 쪽 답안 중 하나가 봉덕동의 홈스파월드예요.

홈스파월드는 앞산 자락 봉덕동에 있는 온천 사우나예요. 공룡공원 근처, 남구체육센터 건너편이라는 위치가 등산객에게는 절묘해요. 앞산은 대구 시내에서 시내버스로 붙는 산이라 애초에 뚜벅이 친화적인데, 하산 후 정리까지 대중교통 동선 안에서 끝난다는 뜻이거든요. 시내로 돌아가는 버스도 봉덕동 큰길에서 바로 잡을 수 있어요.

물은 칼슘-황산염 계열이에요. 황산염천은 예로부터 진정 효과로 분류돼 온 물이라, 종일 산에서 두들긴 다리를 담그는 용도로는 제격이에요. 찜질방과 수영장까지 붙어 있는 대형 시설이라 반나절을 통째로 맡겨도 지루하지 않고요.

[QUOTE]등산 앱의 기록이 끝나는 지점에서, 목욕 가방의 일정이 시작돼요.

추천 순서는 이래요. 오전에 앞산 능선을 적당히 타고, 이른 오후에 내려와 탕과 찜질방에서 두어 시간을 녹여요. 아이와 함께라면 공룡공원의 공룡 조형물 앞에서 사진 한 장 찍는 코스가 자연스럽게 끼어들고요. 대구 여행 일정에 산 하나를 넣을까 말까 고민 중이라면, 이 조합 때문에라도 넣을 만해요.','27',4,'2026-02-21 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='앞산 내려와서 어디 가냐고 물으면');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='앞산 내려와서 어디 가냐고 물으면' AND source='MOIS' AND external_id='225' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','시내버스로 가는 워터파크가 있습니다','가창 스파밸리, 대구 뚜벅이의 계곡 대체재','/img/magazine/107.jpg','대구 도심에서 30분 남짓. 스파밸리는 달성군 가창면, 그러니까 대구 시내에서 남쪽 산골짜기로 접어드는 초입에 있는 워터파크형 온천입니다.

워터파크는 보통 자차 여행지로 분류되지만, 스파밸리는 예외에 가깝습니다. 가창면으로 들어가는 대구 시내버스 노선이 있어서, 환승 한 번 정도로 도심에서 닿습니다. 노선과 정류장은 개편이 잦으니 출발 당일 지도 앱에서 확인하는 것을 전제로 하되, 어쨌든 시내버스 요금으로 계곡 초입까지 실려 간다는 사실이 중요합니다.

물은 나트륨-중탄산 계열입니다. 중탄산천은 물이 부드럽게 감기는 게 특징이라, 슬라이드보다 온수풀과 노천 존에서 진가가 나옵니다. 여름에는 물놀이 인파로 붐비지만, 뚜벅이에게 권하고 싶은 계절은 오히려 겨울입니다. 김이 오르는 야외 온수풀에 어깨까지 담그고 가창 골짜기의 능선을 올려다보는 것, 이게 이 시설의 가장 좋은 장면이기 때문입니다.

[IMG]겨울 노천 온수풀, 수면 위로 김이 오르고 뒤로 가창의 산줄기가 겹친다. ⓒ 물멍

주말 하루를 통째로 비워서 가는 곳으로 계획하십시오. 수영복과 세면도구를 챙긴 가방 하나면 준비는 끝입니다. 돌아오는 버스에서 노곤하게 조는 구간까지가 이 코스의 일부입니다.','27',4,'2026-02-23 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='시내버스로 가는 워터파크가 있습니다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='시내버스로 가는 워터파크가 있습니다' AND source='MOIS' AND external_id='228' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','팔공산 온천 반나절, 준비물은 세 가지','심천랜드로 가는 뚜벅이 체크리스트','/img/magazine/108.jpg','팔공산 자락 온천행의 준비물은 세 가지예요. 교통카드, 수건, 그리고 내려오는 버스 시간을 확인하는 습관.

팔공산심천랜드온천은 대구 동구, 팔공산 방면에 있는 온천이에요. 물은 칼슘-중탄산 계열이고 수온은 24도. 데워서 쓰는 물이지만 중탄산천답게 감촉이 매끄러워서, 산에서 내려온 몸을 부리기에 좋아요.

뚜벅이 동선은 이렇게 정리돼요.

① 가는 길 — 팔공산은 대구에서 드물게 급행버스가 산으로 가는 동네예요. 동화사 방면으로 급행1번이 다니고, 팔공산 순환 노선인 팔공1번도 있어요. 심천랜드 앞까지 어느 노선이 서는지는 정류장 개편이 있을 수 있으니 당일 지도 앱으로 확인하고 타세요.

② 낮 시간 — 동화사 쪽으로 올라가 절 마당과 숲길을 걷거나, 가벼운 등산으로 팔공산 능선 초입을 밟아요. 본격 산행이 부담스러우면 사찰 산책만으로도 두어 시간이 흘러요.

③ 마무리 — 내려와서 심천랜드 탕에 몸을 담가요. 창밖으로 산의 실루엣이 걸리는 시간대, 그러니까 해 지기 직전이 가장 좋은 입장 타이밍이에요.

[IMG]동화사 가는 길의 겨울 숲, 버스에서 내린 등산객들이 흩어진다. ⓒ 물멍

시내로 돌아가는 막차 시간만 챙기면, 팔공산은 차 없는 사람에게도 충분히 열려 있는 산이에요.','27',4,'2026-02-24 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='팔공산 온천 반나절, 준비물은 세 가지');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='팔공산 온천 반나절, 준비물은 세 가지' AND source='MOIS' AND external_id='231' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','산에서 내려와 노천탕, 팔공산의 정석','팔공산온천관광호텔에서 자고 가는 일정','/img/magazine/109.jpg','등산의 완성이 하산주라는 학파가 있고, 노천탕이라는 학파가 있습니다. 팔공산은 후자의 성지에 가깝습니다.

팔공산온천관광호텔은 대구 동구 팔공산 자락의 숙박형 온천입니다. 지하 687미터에서 끌어올린다고 알려진 온천수는 칼슘-중탄산 계열. 중탄산천 특유의 부드러운 물이 노천탕에 채워져 있어서, 찬 공기에 얼굴을 내놓고 몸만 데우는 겨울 목욕의 재미를 제대로 누릴 수 있는 곳입니다.

뚜벅이 관점에서 팔공산의 장점은 명확합니다. 대구 도심에서 동화사 방면으로 급행1번 버스가 다니고, 팔공1번 같은 순환 노선도 산자락을 돕니다. 광역시 시내버스로 산 아래까지 실려 간 다음, 온천과 숙박을 한 건물에서 해결하는 구조라 차가 없어도 일정이 무너지지 않습니다. 호텔 앞 정류장 위치는 노선마다 다르니 지도 앱으로 마지막 구간만 확인하면 됩니다.

권하는 일정은 1박입니다. 첫날 오후에 도착해 동화사까지 다녀오고, 저녁에 노천탕. 다음 날 아침 일찍 한 번 더 탕에 들어갔다가 느지막이 시내로 내려가는 구성입니다. 아침 노천탕은 밤사이 식은 산 공기와 물의 온도 차가 가장 벌어지는 시간이라, 이 호텔에서 가장 좋은 순간을 꼽으라면 단연 그때입니다.

[QUOTE]노천탕의 계절은 여름이 아니라, 김이 가장 잘 보이는 계절입니다.','27',4,'2026-02-26 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='산에서 내려와 노천탕, 팔공산의 정석');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='산에서 내려와 노천탕, 팔공산의 정석' AND source='MOIS' AND external_id='234' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','수성못 한 바퀴, 그다음 온천 한 탕','3호선 타고 가는 대구의 호수 옆 온천','/img/magazine/110.jpg','해 질 무렵의 수성못은 걷는 사람들로 둘레가 채워져요. 러닝 크루, 유모차, 손잡은 노부부. 그 둘레길의 연장선에 온천이 하나 있어요.

호텔수성은 수성못 유원지 바로 옆에 붙은 호텔이에요. 대구 도시철도 3호선 수성못역에서 못 방향으로 걸어가면 되는 위치라, 뚜벅이 접근성으로는 대구 온천 중에서도 상위권이에요. 3호선은 지상을 달리는 모노레일이라 창밖 구경 자체가 이동의 보너스고요.

이 호텔의 물은 나트륨-황산염 계열이에요. 황산염천은 진정 계열의 물로 분류되는데, 수성못을 두어 바퀴 돌아 다리가 뻐근해진 상태와 궁합이 좋아요. 수온 22도의 원수를 데워 쓰는 방식이라 탕 온도는 일반적인 온탕 수준으로 유지돼요.

동선은 단순해요. 오후에 수성못역에 내려서 못 둘레를 천천히 한 바퀴 돌아요. 한 바퀴에 30~40분쯤 잡으면 되고, 물 위로 노을이 앉기 시작하면 걸음을 멈추고 벤치에 잠깐 앉아요. 어두워지기 전에 호텔 온천으로 들어가 몸을 데우고, 나와서는 못 주변에 불이 켜진 카페 거리에서 하루를 닫으면 돼요.

[IMG]해 질 무렵 수성못 둘레길, 물 위로 3호선 모노레일의 불빛이 비친다. ⓒ 물멍

대구 여행에서 하루 저녁이 비었을 때, 지하철 한 번으로 완성되는 코스예요.','27',4,'2026-02-27 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='수성못 한 바퀴, 그다음 온천 한 탕');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='수성못 한 바퀴, 그다음 온천 한 탕' AND source='MOIS' AND external_id='236' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','오시리아역에서 내리면 벌어지는 일','동해선 전철로 가는 기장의 온천 단지','/img/magazine/111.jpg','전철역 하나가 관광단지의 이름이 된 경우는 흔치 않습니다. 동해선 오시리아역이 그렇습니다.

부산 도심에서 동해선 전철을 타면 환승 없이 오시리아역에 내릴 수 있습니다. 역 이름이 곧 목적지입니다. 오시리아 관광단지에는 롯데월드 어드벤처 부산 같은 테마파크부터 리조트, 상업시설이 몰려 있고, 그 한 축에 아난티 단지의 온천이 있습니다.

아난티 오시리아의 물은 나트륨-중탄산 계열에 염화물이 섞인 염류천입니다. 수온 48도로 솟는 물이라 데울 필요가 없는 진짜 온천이고, 염류천답게 탕에서 나온 뒤에도 몸에 온기가 오래 남습니다. 바닷가 온천 특유의, 물이 살짝 무겁게 감기는 감촉도 이 계열의 특징입니다.

뚜벅이 일정은 이렇게 굴러갑니다. 오전에 오시리아역 도착, 단지 안을 걸어서 이동하며 바다 방향으로 산책. 낮에는 테마파크나 상업시설에서 시간을 보내고, 해가 기울면 온천으로 들어가 하루의 피로를 헹굽니다. 단지 안 이동 거리가 짧지 않으니 편한 신발이 필수입니다.

[IMG]오시리아역 개찰구를 나서는 사람들, 손마다 당일치기 가방이 들려 있다. ⓒ 물멍

부산역에서 출발해도 전철 두어 번이면 닿는 거리라, 부산 여행 일정에 반나절 단위로 끼워 넣기 좋은 카드입니다.','26',4,'2026-03-01 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='오시리아역에서 내리면 벌어지는 일');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='오시리아역에서 내리면 벌어지는 일' AND source='MOIS' AND external_id='293' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','바다 산책과 48도짜리 물의 교대 근무','아난티코브를 뚜벅이로 즐기는 순서','/img/magazine/112.jpg','기장 바다 앞의 아난티코브에서는 두 가지 온도가 교대로 일해요. 바닷바람의 온도, 그리고 48도로 솟는 온천의 온도예요.

먼저 가는 법부터. 동해선 전철 오시리아역에서 내려요. 부산 도심에서 전철로 이어지는 노선이라 차가 없어도 부담이 없고, 역에서 단지까지는 걷거나 짧은 이동수단을 이용하게 돼요. 초행이라면 역에서 지도 앱을 켜고 바다 쪽으로 방향만 잡으면 헤맬 일이 없어요.

아난티코브의 매력은 온천에 들어가기 전부터 시작돼요. 단지가 해안을 따라 낮게 앉아 있어서, 상업 공간과 바다 사이를 걷는 산책 자체가 목적이 되는 구조예요. 서점을 구경하고, 커피를 들고 바다 앞을 걷고, 몸이 적당히 식었을 때 온천으로 들어가는 순서가 자연스러워요.

물은 나트륨-중탄산 계열에 염화물을 품은 염류천이에요. 48도 원수라 물이 힘이 있고, 보온 효과가 좋은 계열이라 탕을 나선 뒤 다시 바닷바람 앞에 서도 한동안 끄떡없어요. 산책으로 식히고 탕으로 데우는 순환을 두 바퀴쯤 돌리는 게 이 동네의 사치예요.

[QUOTE]식으러 나갔다가, 데우러 돌아오는 곳이에요.

당일치기라면 해가 있을 때 산책을 끝내고 마지막 순서를 온천으로 잡으세요. 젖은 머리로 전철에 앉아 부산 도심으로 돌아가는 길, 창밖이 어두워지는 그 구간이 하루의 마침표가 돼요.','26',4,'2026-03-02 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='바다 산책과 48도짜리 물의 교대 근무');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='바다 산책과 48도짜리 물의 교대 근무' AND source='MOIS' AND external_id='294' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','기장에는 오래된 온천호텔이 하나 있습니다','관광단지 말고, 구식으로 즐기는 기장의 물','/img/magazine/113.jpg','같은 기장 물이라도 그릇이 다릅니다. 오시리아의 리조트가 신식 그릇이라면, 동부산온천호텔은 구식 그릇입니다.

동부산온천호텔은 부산 기장군에 있는 숙박형 온천호텔입니다. 물은 나트륨-중탄산 계열에 염화물이 섞인 염류천이고 수온은 48도. 데우지 않아도 되는 뜨거운 원수라는 점에서는 이웃한 대형 리조트들과 같은 급의 물을 쓰는 셈인데, 시설의 결은 다릅니다. 화려한 부대시설 대신 탕과 객실이라는 본업에 집중하는, 예전 방식의 온천호텔입니다.

뚜벅이 접근은 동해선 전철이 기본입니다. 부산 도심에서 동해선을 타고 기장 방면으로 이동한 뒤, 역에서부터는 거리가 있는 편이라 버스나 택시로 마지막 구간을 잇는 그림입니다. 초행이라면 역에 내려 지도 앱으로 남은 거리를 확인하고 이동 수단을 정하는 것이 안전합니다.

이런 곳은 목적을 단순하게 잡을수록 만족도가 오릅니다. 뜨거운 물에 몸을 오래 담그고, 자고, 아침에 한 번 더 담그고 나오는 것. 염류천은 보온 효과가 특징이라, 아침 탕을 마치고 나선 몸으로 기장의 찬 바닷바람을 맞아 보면 이 물의 성격을 바로 이해하게 됩니다.

[IMG]이른 아침 온천호텔 복도, 목욕 바구니를 든 투숙객이 지나간다. ⓒ 물멍

요란한 것들 사이에서 조용한 쪽을 고르고 싶은 날의 선택지입니다.','26',4,'2026-03-04 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='기장에는 오래된 온천호텔이 하나 있습니다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='기장에는 오래된 온천호텔이 하나 있습니다' AND source='MOIS' AND external_id='299' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','버스 갈아타는 김에 목욕까지 하는 사상','서부산 교통 허브 옆 온천, 스파캐슬','/img/magazine/114.jpg','사상은 부산에서 가장 바쁜 환승 동네 중 하나예요. 부산서부(사상)터미널로 시외버스가 드나들고, 도시철도 2호선과 부산김해경전철이 사상역에서 만나요. 이 교통의 소용돌이 한복판에 온천이 있다는 건 뚜벅이에게 꽤 실용적인 정보예요.

스파캐슬은 사상 일대의 숙박 겸 온천 시설이에요. 물은 나트륨-중탄산 계열, 수온은 37도. 체온을 살짝 웃도는 온도의 원수라 물이 순하게 느껴지고, 중탄산천 특유의 부드러운 감촉이 얹혀요.

이 온천의 사용법은 여행의 앞뒤에 끼워 넣는 거예요. 남해안 어딘가로 떠나는 아침 버스를 타기 전날 밤, 사상에서 자면서 몸을 데워 두는 방법. 반대로 장거리 버스에서 굳은 몸으로 사상에 내렸을 때, 숙소 체크인 전에 탕부터 들르는 방법. 어느 쪽이든 터미널과 지하철역이 가까운 동네라는 조건이 목욕의 가치를 올려 줘요.

[QUOTE]환승 대기 시간이 두 시간이라면, 그건 대기가 아니라 목욕 시간이에요.

사상에서 2호선을 타면 서면이나 광안리 방향으로도 한 번에 이어지니, 부산 일정의 첫 밤을 사상에서 보내는 설계도 생각보다 나쁘지 않아요. 여행 가방을 끌고 들어가 몸부터 푸는 것, 서부산식 체크인이에요.','26',4,'2026-03-05 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='버스 갈아타는 김에 목욕까지 하는 사상');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='버스 갈아타는 김에 목욕까지 하는 사상' AND source='MOIS' AND external_id='323' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','공업 도시의 목욕탕은 왜 물이 좋은가','사상 담덕스파에서 생각한 것들','/img/magazine/115.jpg','관광지도에 없는 동네의 목욕물이 더 좋은 경우가 있습니다. 부산 사상이 그렇습니다.

사상은 공단과 터미널의 동네입니다. 여행자보다 노동자가 많고, 캐리어보다 작업 가방이 많은 곳입니다. 담덕스파는 그런 사상에서 나트륨-중탄산 계열의 온천수를 쓰는 목욕 시설입니다. 수온 37도의 원수는 체온과 가장 가까운 구간의 물이라, 뜨거움으로 승부하는 대신 오래 담글 수 있는 것으로 승부합니다. 중탄산천의 부드러움은 하루치 피로가 쌓인 몸에서 가장 정확하게 느껴집니다.

접근은 간단합니다. 도시철도 2호선과 부산김해경전철이 교차하는 사상역 일대가 생활권이라, 부산 도심 어디서 출발해도 전철로 닿습니다. 김해공항에서 경전철로 이어지는 동선이기도 해서, 비행기에서 내려 부산 일정을 시작하기 전에 들르는 첫 정거장으로 삼을 수도 있습니다.

[IMG]사상역 고가 아래, 퇴근길 사람들이 횡단보도에 모여 있다. ⓒ 물멍

이런 목욕탕에서는 관광객 티를 내지 않는 것이 예의입니다. 조용히 씻고, 조용히 담그고, 옆자리 어르신의 속도를 따라가 보십시오. 유명 온천의 전망탕에서는 배울 수 없는 것, 그러니까 목욕이 구경이 아니라 생활이라는 감각을 사상에서 배우게 됩니다.','26',4,'2026-03-06 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='공업 도시의 목욕탕은 왜 물이 좋은가');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='공업 도시의 목욕탕은 왜 물이 좋은가' AND source='MOIS' AND external_id='325' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','승학산 억새 보고 내려와 몸 담그는 코스','1호선으로 가는 사하구의 동네 온천','/img/magazine/116.jpg','부산 1호선을 타고 괴정역에 내리면, 관광 부산과는 다른 부산이 시작돼요. 사하구 괴정동. 승학온천스포츠랜드는 이 생활 동네의 온천이에요.

물은 나트륨-중탄산 계열의 순한 단순천이고, 수온은 34도예요. 화려한 시설로 승부하는 곳이 아니라 동네 사람들의 목욕 루틴을 받아 주는 곳이라, 여행자에게는 오히려 신선한 종류의 공간이에요.

이 온천을 코스로 만들어 주는 건 뒷산이에요. 사하구의 승학산은 가을 억새로 이름난 산이고, 구청이 관리하는 숲길이 능선까지 이어져 있어요. 동네 뒷산치고는 조망이 시원해서, 정상부에 서면 낙동강 하구 방향의 풍경이 넓게 열려요.

추천 동선은 이래요. 오전에 괴정역 도착, 승학산 숲길로 올라 억새 능선을 걷고, 이른 오후에 내려와 승학온천에서 땀을 씻어요. 34도의 순한 물은 등산 직후에 들어가도 심장에 부담이 적어서, 하산 목욕용으로는 이상적인 온도예요.

[IMG]가을 승학산 능선, 억새 사이로 등산객의 모자만 떠서 움직인다. ⓒ 물멍

마무리는 1호선 한 번으로 자갈치나 남포동까지 이동해 저녁을 먹는 그림이에요. 관광지 사이에 낀 반나절을 생활 동네에서 보내고 싶은 날, 괴정동은 꽤 괜찮은 답이에요.','26',4,'2026-03-08 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='승학산 억새 보고 내려와 몸 담그는 코스');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='승학산 억새 보고 내려와 몸 담그는 코스' AND source='MOIS' AND external_id='327' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','바다 위 365m를 걷고, 염화물천으로 몸을 되돌리는 반나절','부산 송도 — 구름산책로에서 윈덤 그랜드 부산의 탕까지, 뚜벅이 공식','/img/magazine/117.jpg','발밑 유리 아래에서 파도가 터집니다. 송도구름산책로, 바다 위로 365m를 걸어 나가는 무료 산책로입니다. 되돌아 나온 해변 끝에 온천을 품은 고층 호텔이 서 있습니다. 윈덤 그랜드 부산.

이 호텔의 물은 나트륨-염화물 계열 염류천입니다. 원수는 23℃, 그대로는 차서 데워 씁니다. 온도는 기계가 올리지만 성분은 그대로라, 염화물천 특유의 보온감이 남습니다. 바닷바람에 식은 몸을 되돌리는 용도로는 이 성분이 맞습니다.

송도에는 지하철역이 없습니다. 그래서 공식은 두 단계입니다. 1호선 자갈치역이나 남포역까지 지하철, 거기서 송도해수욕장 방면 시내버스로 환승. 남포동에서 송도까지는 버스로 금방이라 환승이라기보다 짧은 연장전에 가깝습니다.

도착하면 순서는 셋입니다. ① 구름산책로를 걸어 바다 위로 나갔다 오기 ② 해변 위를 가로지르는 송도해상케이블카 캐빈이 지나가는 하늘 올려다보기 ③ 몸이 식을 만큼 식었을 때 호텔로 들어가 탕. 이 순서로 반나절짜리 해양 코스가 닫힙니다.

[IMG]송도구름산책로의 유리 바닥, 파도 거품이 발밑에서 터진다. ⓒ 물멍

송도는 우리나라에서 가장 먼저 개장한 해수욕장으로 알려진 바다입니다. 그 오래된 바다 위에 새 산책로가 놓였고, 새 호텔 안에는 바다 성분의 물이 있습니다. 오래된 것과 새것이 한 프레임에 있는 게 지금 송도의 표정입니다.

[QUOTE]바다 위를 걸어 몸을 식히고, 바다 성분의 물로 다시 데운다.

다음 부산행에 반나절이 비면 남포역에서 송도행 버스에 오르십시오. 유리 바닥을 먼저 밟고, 탕은 그다음입니다.','26',4,'2026-03-09 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='바다 위 365m를 걷고, 염화물천으로 몸을 되돌리는 반나절');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='바다 위 365m를 걷고, 염화물천으로 몸을 되돌리는 반나절' AND source='MOIS' AND external_id='328' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','광안리에서 젖은 머리로 야경 보기','지하철 2호선과 아쿠아펠리스의 밤','/img/magazine/118.jpg','광안리의 밤은 다리가 켜지는 순간 시작돼요. 광안대교에 조명이 들어오면 해변의 모든 카메라가 같은 방향을 봐요. 그 해변 앞에 물놀이 시설을 품은 호텔, 아쿠아펠리스가 있어요.

가는 법은 부산 여행의 기본기 그대로예요. 도시철도 2호선을 타고 광안역이나 금련산역에서 내려 바다 방향으로 걸어 내려가면 광안리해수욕장이 나와요. 해변에 닿으면 그다음은 지도가 필요 없어요. 백사장을 따라 걷다 보면 호텔 건물이 시야에 들어오거든요.

아쿠아펠리스는 온천수를 쓰는 워터파크형 스파와 숙박이 한 건물에 있는 구조예요. 창 너머로 바다를 두고 물에 떠 있는 경험이 이 집의 본론이고, 특히 해가 진 다음이 진짜예요. 따뜻한 물에 몸을 담근 채로 어두워진 바다와 광안대교의 불빛을 건너다보는 시간이요.

[QUOTE]수영장 물은 따뜻하고, 유리 너머 바다는 까맣고, 다리는 반짝여요.

일정 짜기도 쉬워요. 늦은 오후에 도착해 해변을 산책하고, 저녁을 먹고, 밤에 스파. 숙박까지 잡으면 아침 광안리의 한적한 백사장이 보너스로 따라와요. 부산 지하철 하나로 완성되는 1박 코스라, 뚜벅이 초심자에게 먼저 권하고 싶은 동네예요.','26',4,'2026-03-11 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='광안리에서 젖은 머리로 야경 보기');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='광안리에서 젖은 머리로 야경 보기' AND source='MOIS' AND external_id='329' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','교통카드 한 장으로 닿는 온천법 온천, 관악구 봉천동','봉일스파랜드 — 2호선과 마을버스로 가는 주말 온천 예행연습','/img/magazine/119.jpg','교통카드 한 장. 서울 안에서 온천법이 인정한 온천수에 닿는 데 필요한 준비물은 그게 전부입니다. 관악구 봉천동, 봉일스파랜드.

겉보기는 동네 사우나입니다. 차이는 수도꼭지 너머에 있습니다. 물은 나트륨-중탄산 계열, 원수 24℃를 데워 씁니다. 온도는 보일러가 만들지만 성분은 땅이 정한 그대로라, 탕에 앉으면 중탄산천 특유의 매끄러운 감촉이 먼저 전해집니다.

가는 길은 서울답습니다. 봉천동은 지하철 2호선 생활권. 서울 어디서 출발하든 지하철과 마을버스 조합으로 닿습니다. 세부 하차 지점은 지도 앱 검색이 가장 정확하니, 목욕 바구니는 두고 휴대폰만 챙기면 됩니다.

권하는 시간은 주말 아침입니다. 관악산이나 동네 뒷길을 한 시간쯤 걷고, 아직 한산한 이른 탕에 들어가는 순서. 걸어서 올린 체온을 중탄산수가 이어받습니다.

[IMG]토요일 아침의 봉천동 골목, 목욕 가방을 든 어르신이 앞서 걷는다. ⓒ 물멍

여행이라 부르기엔 소박합니다. 대신 용도가 분명합니다. 주말 온천 여행의 예행연습. 서울의 온천수로 물맛을 익히고, 재미가 붙으면 그때 지방의 온천으로 반경을 넓히면 됩니다.

[QUOTE]온천으로 가는 첫 차표는, 사실 교통카드 한 장이었다.

이번 주말 멀리 갈 계획이 없다면 2호선에 올라 봉천동에서 내리십시오. 온천은 이미 서울 안에 있습니다.','11',4,'2026-03-12 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='교통카드 한 장으로 닿는 온천법 온천, 관악구 봉천동');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='교통카드 한 장으로 닿는 온천법 온천, 관악구 봉천동' AND source='MOIS' AND external_id='351' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'WALKING_GUIDE','버스 시간표 한 장 캡처하면 갈 수 있는 온천','군산 옥구읍 힐스톤온천리조트 — 뚜벅이의 1박 공식','/img/magazine/120.jpg','버스 시간표부터 캡처하세요. 군산 옥구읍 힐스톤온천리조트로 가는 뚜벅이 여행의 기술은 그 한 장이 전부예요.

먼저 고백. 힐스톤은 군산 시내가 아니라 옥구읍, 시내에서 떨어진 들판 쪽에 있어요. 옥구읍 방면 시내버스는 배차 간격이 넓어서, 시간표 없이 정류장에 서면 한참을 기다리게 돼요.

군산까지는 문제없어요. 장항선 열차가 군산역에 서고, 고속·시외버스가 시내 터미널로 들어와요. 문제는 마지막 구간. 버스 시간이 안 맞으면 택시로 끊는 게 정신 건강에 이로워요. 시내에서 아주 먼 거리는 아니라 요금 부담이 크진 않아요.

이 수고의 대가는 물이에요. 나트륨-염화물 계열 염류천. 보온 효과가 좋은 성분이라, 탕에서 나온 뒤에도 온기가 이불처럼 남아요. 들판 정류장에서 기다린 시간이 여기서 회수돼요.

[QUOTE]버스 시간표를 캡처해 두는 것, 이 여행의 유일한 기술이에요.

그래서 일정은 1박이에요. 리조트라 숙박이 되니 교통 스트레스를 하루치로 나눌 수 있어요. 낮엔 군산 시내에서 근대건축 골목과 빵집 앞 줄서기, 저녁에 옥구읍으로 넘어와 온천과 숙박. 다음 날 아침 탕을 한 번 더 하고 시내로 돌아가 남은 일정을 이어요.

[IMG]옥구읍 들판의 정류장, 시간표를 캡처한 휴대폰 화면 너머로 버스가 온다. ⓒ 물멍

불편함이 조금 섞여야 여행이 기억에 남는다는 쪽이라면, 지금 군산 시내버스 시간표부터 캡처하세요. 나머지는 물이 해 줘요.','52',4,'2026-03-14 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='버스 시간표 한 장 캡처하면 갈 수 있는 온천');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='버스 시간표 한 장 캡처하면 갈 수 있는 온천' AND source='MOIS' AND external_id='402' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','벚꽃 지기 전에, 보문호 한 바퀴','경주 봄 여행의 마지막 조각은 44도 알칼리 온천이다','/img/magazine/121.jpg','경주의 봄은 보문호에서 절정을 찍어요. 벚나무가 호수를 빙 둘러 서 있어서, 만개 시기엔 어느 방향으로 걸어도 꽃 터널이에요. 대릉원 돌담길에서 축제가 열리는 그 주간, 시내는 사람으로 미어터지지만 보문단지는 호수가 넓어서 숨 쉴 틈이 있어요.

추천 동선은 단순해요. 오전에 보문호를 따라 천천히 걷고, 오후엔 단지 안 온천에 몸을 담그는 것. 보문온천의 물은 44도 알칼리성이라 꽃샘추위에 굳은 어깨가 스르르 풀려요. 벚꽃 구경은 다리가 하는 일이라, 저녁의 탕이 유난히 달아요.

[IMG]해 질 무렵 보문호 수면 위로 벚꽃잎이 떠간다. ⓒ 물멍

밥은 보문단지 입구 쪽에서 해결해요. 동궁원 맞은편 맷돌순두부는 두부요리 전문점인데 웨이팅이 길어도 회전이 빨라요. 부모님을 모시고 왔다면 떡갈비와 한우 물회를 내는 보문뜰이 낫고요. 보문호를 바라보며 꼬막비빔밥을 먹을 수 있는 올바릇식당은 포장 예약도 받아요.

가는 길도 어렵지 않아요. KTX 신경주역에서 700번 버스로 40분. 벚꽃 철엔 차가 밀리니 오히려 버스 차창 밖 구경이 남는 장사예요. 꽃은 일주일이면 지지만, 온천은 사철 그대로니까 조급할 것도 없어요.','47',4,'2026-03-15 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='벚꽃 지기 전에, 보문호 한 바퀴');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='벚꽃 지기 전에, 보문호 한 바퀴' AND source='MANUAL' AND name='보문온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','산동은 3월에 노랗게 끓는다','구례 산수유꽃축제와 게르마늄 온천의 조합','/img/magazine/122.jpg','노랗다. 3월의 구례 산동면은 마을 전체가 노랗습니다. 산수유나무 수만 그루가 일제히 꽃을 터뜨리는 이 시기, 매년 구례산수유꽃축제가 열립니다. 꽃이 크고 화려한 종류가 아니라 좁쌀 같은 꽃이 무리 지어 피는 쪽이라, 멀리서 보면 마을에 노란 안개가 낀 것처럼 보입니다.

[QUOTE]산수유꽃은 가까이서 한 송이를 보는 꽃이 아니라, 멀리서 마을 전체로 보는 꽃이다.

그리고 이 꽃 마을 바로 옆에 지리산온천이 있습니다. 게르마늄 성분의 32도 온천수. 뜨겁지 않아 오래 담글 수 있는 물이라, 반나절 꽃길을 걸은 다리를 천천히 풀기에 맞춤합니다. 수온이 낮다고 실망할 물이 아닙니다. 미지근한 탕에 삼십 분쯤 잠겨 있으면 몸속부터 데워지는 감각이 옵니다.

[IMG]산동면 돌담 너머로 산수유꽃이 흐드러졌다. ⓒ 물멍

끼니는 산동에서 해결합니다. 산수유마을권의 산수유텃밭식당이 산채 한식을 내고, 흑돼지구이는 송림민속가든, 다슬기수제비는 생생정보통에 나온 토지다슬기식당이 있습니다. 섬진강 다슬기와 지리산 흑돼지가 이 동네 밥상의 두 기둥입니다.

교통은 구례구역에서 산동행 버스로 25분. 축제 기간 주말엔 도로가 밀리니 아침 일찍 움직이는 편이 좋습니다.','46',4,'2026-03-17 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='산동은 3월에 노랗게 끓는다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='산동은 3월에 노랗게 끓는다' AND source='MANUAL' AND name='지리산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','물안개 세량지, 그다음은 온천','화순의 봄 새벽과 게르마늄탕 반나절 코스','/img/magazine/123.jpg','새벽 다섯 시 반, 세량지 수면에서 안개가 피어올라요. 산벚꽃이 물에 거꾸로 비치고, 그 위로 물안개가 천천히 흐르는 장면. CNN이 꼽았다는 수식은 이제 식상하지만, 봄 새벽의 세량지 앞에 서면 그 수식이 왜 붙었는지 바로 납득돼요.

[IMG]동트기 전 세량지, 산벚꽃이 수면에 번져 있다. ⓒ 물멍

세량지는 둘레길이 800m 남짓이라 산책이라기보다 감상에 가까워요. 사진 찍는 사람들이 삼각대를 세우는 새벽 명당은 이미 붐비니, 꽃 시기엔 해 뜨기 전에 도착하는 걸 전제로 잡아야 해요.

문제는 새벽 일정 뒤의 피로인데, 화순엔 그걸 해결할 물이 있어요. 게르마늄 성분의 화순온천. 31도의 미온탕이라 잠 못 잔 몸을 확 깨우기보다 천천히 주물러주는 쪽이에요. 새벽 촬영으로 곤두선 신경이 탕 안에서 눅어요.

[IMG]오전의 온천탕, 김 너머로 창밖 산등성이가 흐릿하다. ⓒ 물멍

허기는 남도식으로 채워요. 화순은 한정식 문화권이라 상이 통째로 차려져 나와요. 도곡 쪽 원화리의 광화문연가가 한정식으로 알려져 있고, 읍내엔 화순식당 같은 백반집이 있어요. 광주터미널에서 화순행 버스로 40분이면 닿으니, 광주 여행에 하루 얹기에도 무리가 없어요.','46',4,'2026-03-18 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='물안개 세량지, 그다음은 온천');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='물안개 세량지, 그다음은 온천' AND source='MANUAL' AND name='화순온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','영랑호 꽃길 걷고 53도에 몸을 맡기다','속초의 봄, 벚꽃축제와 척산온천 반일 코스','/img/magazine/124.jpg','숫자로 시작하겠습니다. 벚꽃길을 찾아 영랑호에 몰린 인파가 한 주말에 3만 명. 속초의 봄이 그렇습니다. 석호 둘레를 따라 벚나무가 이어지고, 그 뒤로 설악산 능선이 병풍처럼 서 있어 어디서 찍어도 꽃과 설산이 한 프레임에 들어옵니다. 매년 이맘때 영랑호 벚꽃축제가 열립니다.

동선은 두 토막이면 충분합니다. ① 오전, 영랑호 둘레길을 걷습니다. 호수라 바람이 잔잔하고 길이 평탄해 부모님과 함께 걷기에도 무리가 없습니다. ② 오후, 척산온천으로 이동합니다. 속초터미널에서 3-1번 버스로 15분, 시내에서 이 정도로 가까운 온천은 강원도에서도 드뭅니다.

척산의 물은 53도 알칼리성입니다. 바닷바람에 굳은 몸이 들어가는 순간 항복하는 온도입니다. 속초 사람들이 여행 마무리 코스로 꼽는 데는 이유가 있습니다.

탕에서 나오면 걸어서 닿는 거리에 학사평 순두부촌이 있습니다. 1965년부터 자리를 지킨 김영애할머니순두부, 재래식 간수 맛을 고집하는 원조 재래식 할머니 순두부, 현지인이 꼽는 시골이모순두부까지. 콩꽃마을이라는 이름답게 순두부 노포가 줄지어 있으니, 뜨끈한 탕 뒤에 뜨끈한 순두부로 마침표를 찍으면 됩니다.','51',4,'2026-03-20 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='영랑호 꽃길 걷고 53도에 몸을 맡기다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='영랑호 꽃길 걷고 53도에 몸을 맡기다' AND source='MANUAL' AND name='척산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','입술에 닿으면 짠 55℃, 그 앞에 주남저수지 유채꽃','창원 북면 마금산온천의 4월 — 꽃이 먼저, 소금물은 나중','/img/magazine/125.jpg','입술에 물이 닿으면 짠맛이 돌아요. 창원 마금산온천의 물은 염화나트륨천, 미네랄이 진해서 혀끝에 남을 정도예요. 원수는 55℃. 여기에 국민보양온천 지정까지 더해진 동네가 창원 북면이에요.

4월에 이 물을 권하는 이유는 온천 바깥에 있어요. 차로 멀지 않은 주남저수지. 겨울엔 철새 탐조객으로 붐비는 길인데, 봄엔 저수지 둑을 따라 유채꽃이 노랗게 깔려요. 탐조객이 빠진 둑길은 한결 한적해서, 자전거를 빌려 달리는 사람들이 보여요.

순서는 꽃이 먼저, 물이 나중이에요. 오전에 주남 둑길을 걷고, 오후에 온천단지로 돌아와 55℃ 소금물에 몸을 절이는 거예요. 나른한 봄 피로엔 진한 물이 약이에요.

[IMG]주남저수지 둑길, 유채꽃 사이로 자전거 한 대가 지나간다. ⓒ 물멍

저녁은 온천단지 안에서 끝나요. 황우장사는 정육코너에서 고기를 직접 골라 굽는 토종 한우 전문점이자 현지인 단골집이에요. 다음 날 아침 속풀이는 김박사명품해장국&냉면이 맡아요.

교통도 헐렁하지 않아요. 마산역에서 북면행 버스로 40분. 온천 마을치고 도시와 가까워서 1박 여정이 빡빡하지 않아요.

[QUOTE]철새가 떠난 둑에 유채가 오고, 그 뒤엔 55℃ 소금물이 기다린다.

유채는 기다려 주지 않아요. 마산역에서 북면행 버스에 오르고, 꽃부터 보세요.','48',4,'2026-03-21 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='입술에 닿으면 짠 55℃, 그 앞에 주남저수지 유채꽃');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='입술에 닿으면 짠 55℃, 그 앞에 주남저수지 유채꽃' AND source='MANUAL' AND name='마금산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','해발 620m에서 흔들리고, 32℃ 탄산천에서 기포가 맺힌다','거창 우두산 Y자 출렁다리와 가조온천 — 봄 산행의 낙차','/img/magazine/126.jpg','해발 620m, 발밑에 교각이 없습니다. 거창 우두산 자락 항노화힐링랜드의 Y자형 출렁다리. 국내 최초로 교각 없이 협곡 위에 걸린 다리가 세 방향으로 갈라지고, 봄이면 그 아래 골짜기가 연둣빛으로 차오릅니다.

등산화는 필요 없습니다. 무장애 데크길이 다리까지 정비되어 있어 운동화로 오릅니다. 다리 한가운데 서면 세 갈래 길이 허공에서 만나고, 종아리는 그때부터 굳기 시작합니다.

[IMG]Y자형 출렁다리 한가운데, 세 갈래 길이 허공에서 만난다. ⓒ 물멍

내려오면 가조온천입니다. 물은 탄산천, 온도는 32℃. 미지근한 물에 가만히 있으면 피부에 자잘한 기포가 맺히기 시작합니다. 탄산이 혈관을 넓혀 혈액순환을 돕는 성분이라, 후끈하진 않은데 나온 뒤 몸이 오래 따뜻합니다. 출렁다리에서 굳은 종아리가 여기서 풀립니다.

거창의 저녁은 향토식입니다. 대표 음식은 민물 잡어를 뼈째 고아낸 어탕국수. 온천 인근엔 추어탕의 거창추어탕, 뼈다귀 해장국의 홍천뚝배기, 향토 한식집 소골둑이 있습니다.

교통은 계산이 필요합니다. 거창터미널에서 가조행 버스가 25분. 다만 힐링랜드까지 한 번에 묶으려면 자차가 편합니다.

[QUOTE]다리 위에서 620m를 흔들리고, 탕 속에서 32℃에 가라앉는다.

이 여행의 순서는 낙차입니다. 높은 곳에서 먼저 흔들리고, 미지근한 물에서 가라앉으십시오. 골짜기가 연둣빛인 동안에.','48',4,'2026-03-23 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='해발 620m에서 흔들리고, 32℃ 탄산천에서 기포가 맺힌다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='해발 620m에서 흔들리고, 32℃ 탄산천에서 기포가 맺힌다' AND source='MANUAL' AND name='가조온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','찻사발 축제의 문경, 뒤풀이는 온천','문경새재 봄 축제와 칼슘중탄산탕','/img/magazine/127.jpg','가마에서 갓 나온 찻사발을 손에 올려보는 계절이에요. 봄의 문경새재에서는 문경찻사발축제가 열려요. 장인들이 낸 다완을 구경하고, 찻자리에 앉아보고, 흙을 만져보는 열흘. 벚꽃 끝물과 신록 사이, 새재 일대가 일 년 중 가장 활기를 띠는 때예요.

[QUOTE]사발 하나를 오래 들여다보게 되는 축제는 흔치 않다.

축제 마당을 돌고 새재 옛길을 1관문까지만 왕복해도 두어 시간이 훌쩍 가요. 흙길이라 발바닥은 편한데 다리는 은근히 뻐근해지죠. 그때 문경온천이 등판해요. 칼슘중탄산 성분의 31도 온천수. 뜨겁지 않아서 걷기로 달아오른 몸을 식히듯 데우는, 봄 산책과 궁합이 좋은 물이에요.

[IMG]새재 옛길 초입, 연둣빛 신록 사이로 흙길이 이어진다. ⓒ 물멍

밥심은 문경답게 챙겨요. 새재 향토음식인 청포묵조밥은 소문난식당이 알려져 있고, 석쇠구이는 새재할매집이 유명해요. 온천지구 안에서 약돌 먹인 돼지와 한우를 정육식당 방식으로 굽는 온천약돌한우돼지정육식당도 있고요. 약돌돼지 석쇠구이에 묵조밥 한 상이면 문경의 봄을 다 먹은 셈이에요.

점촌역에서 문경행 버스로 30분. 축제 기간엔 임시 편성이 붙기도 하니 시간표만 미리 확인하세요.','47',4,'2026-03-24 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='찻사발 축제의 문경, 뒤풀이는 온천');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='찻사발 축제의 문경, 뒤풀이는 온천' AND source='MANUAL' AND name='문경온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','발안IC에서 10분, 29℃ 유황천으로 끝나는 당일 코스','화성 율암온천 — 우리꽃식물원, 팔탄면 백숙, 그리고 서해안고속도로','/img/magazine/128.jpg','발안IC에서 10분. 서울에서 한 시간 거리에 유황천이 있습니다. 경기 화성 율암온천, 수도권에서 가장 가까운 유황온천 중 하나입니다. 숙박 시설을 기대할 동네가 아니라, 처음부터 당일로 설계하는 곳입니다.

① 오전, 우리꽃식물원. 화성시가 운영하는 식물원으로 이름 그대로 야생화 중심입니다. 팔도의 산과 들을 본뜬 정원에 봄이면 자생화가 차례로 올라옵니다. 튤립 축제의 소란 대신 이름표를 읽으며 천천히 도는 속도가 이곳의 규칙입니다.

② 점심, 팔탄면 보양식. 이 일대는 백숙과 민물매운탕 문화권입니다. 깊은 국물의 백숙·삼계탕은 서해정, 빠가사리 매운탕은 시골민물매운탕. 해산물 중식이 당기는 날엔 태림이 있습니다.

[IMG]우리꽃식물원의 봄 정원, 이름표 앞에 쪼그려 앉은 사람. ⓒ 물멍

③ 오후, 율암온천. 원수는 29℃ 유황천이라 탕 온도는 시설이 맞춥니다. 대신 유황 특유의 미끈하게 감기는 물맛은 그대로입니다. 한 시간쯤 잠겼다 나오면 돌아가는 서해안고속도로가 하나도 안 밉습니다.

[QUOTE]온천이라면 멀리 볼 생각부터 하는 사람에게, 발안IC는 반례다.

이번 주말 하루가 비었다면 숙소 검색창은 닫으십시오. 아침에 나가 저녁에 돌아오는 유황온천, 율암의 용법은 그것입니다.','41',4,'2026-03-26 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='발안IC에서 10분, 29℃ 유황천으로 끝나는 당일 코스');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='발안IC에서 10분, 29℃ 유황천으로 끝나는 당일 코스' AND source='MOIS' AND external_id='69' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','곡교천 유채꽃 뒤에, 31℃에서 30분 불리는 유황탕','아산 도고온천의 봄 — 도고온천역에서 택시 5분','/img/magazine/129.jpg','곡교천 둔치가 노래지면 아산의 봄이에요. 가을 은행나무길로만 알던 사람들이 봄에 한 번 더 놀라는 곳. 둔치를 따라 유채꽃이 넓게 깔리고, 산책로를 걷다 보면 강바람에 유채 향이 실려 와요.

꽃놀이 뒤 목적지는 도고온천이에요. 장항선 도고온천역에서 택시로 5분. 역 이름에 ''온천''이 박힌 몇 안 되는 동네예요.

이 물은 버티는 탕이 아니라 불리는 탕이에요. 유황천인데 원수가 31℃로 미지근해서, 뜨거운 탕에서 3분 버티기 대신 미온탕에서 30분 몸을 불리는 쪽이에요. 유황 성분 덕에 나올 때 피부가 매끈해요.

[IMG]도고의 탕, 수면 위로 유황수 특유의 뿌연 김이 얇게 깔린다. ⓒ 물멍

허기는 민물로 채워요. 아산 서부는 저수지가 많아 어죽과 붕어찜이 향토음식으로 뿌리내렸어요. 가마솥붕어찜은 붕어찜과 어죽으로 알려져 있고, 송악저수지 아래 붕어마을은 어죽 노포로 먹방 영상에도 나왔어요. 온천 후 얼큰한 어죽 한 그릇, 정확히 맞는 답이에요.

비 오는 날의 대안도 있어요. 도고면 가까이 사철 꽃을 틀어주는 세계꽃식물원. 날씨가 심술을 부리면 실내로 피신하면 돼요.

[QUOTE]3분 버티는 탕이 아니라, 30분 불리는 탕.

곡교천 유채가 노란 동안 장항선을 타세요. 도고온천역에서 내리면 택시 5분, 그다음은 30분이에요.','44',4,'2026-03-27 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='곡교천 유채꽃 뒤에, 31℃에서 30분 불리는 유황탕');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='곡교천 유채꽃 뒤에, 31℃에서 30분 불리는 유황탕' AND source='MANUAL' AND name='도고온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','도심 한복판에서 라듐천에 발 담그기','대전 유성, 봄의 유림공원과 무료 족욕장','/img/magazine/130.jpg','온천 여행은 시골로 가는 것이라는 통념을 유성이 깹니다. 대전 한복판, 지하철이 다니는 도심에 53도 라듐천이 솟습니다. KTX 대전역에서 급행2번 버스로 20분. 전국에서 접근성으로 이길 온천이 거의 없습니다.

봄의 유성을 걷는 순서는 이렇습니다. 먼저 유림공원. 갑천 변의 이 공원은 봄꽃 시기에 유성 사람들의 마당이 됩니다. 꽃밭 사이 산책로가 잘 정비되어 유모차와 휠체어도 다닙니다. 공원을 한 바퀴 돌았으면 유성온천 문화공원 쪽으로 이동합니다. 여기에 유성의 상징이 있습니다. 무료 족욕체험장. 온천수가 흐르는 야외 족욕탕에 앉아 신발을 벗으면, 옆자리 어르신이 자연스럽게 말을 걸어오는 곳입니다.

[QUOTE]족욕장 물에 발을 넣는 순간, 여기가 온천도시라는 말이 관광 문구가 아니라 생활이라는 걸 알게 된다.

본탕이 당기면 온천 호텔들의 대중탕으로 들어가면 됩니다. 라듐 단순천은 근육통과 신경통 완화로 오래 이름난 물입니다.

[IMG]봄 오후의 족욕체험장, 바지를 걷어 올린 발목들이 나란하다. ⓒ 물멍

마무리는 대전답게 칼국수입니다. 유성 지역뉴스에 소개된 온천손칼국수가 가깝고, 시내로 나가면 대전 3대 명물로 꼽히는 오씨칼국수, 두부두루치기 노포 진로집이 있습니다. 꽃, 족욕, 칼국수. 반나절이면 다 됩니다.','30',4,'2026-03-29 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='도심 한복판에서 라듐천에 발 담그기');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='도심 한복판에서 라듐천에 발 담그기' AND source='MANUAL' AND name='유성온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','왕복 두 시간 반, 걸어야만 닿는 42℃ 자연용출 원탕','울진 덕구계곡 여름 트레킹 — 국내 유일 자연용출 온천과 후포항','/img/magazine/131.jpg','왕복 두 시간 반. 이 온천의 원탕은 차로 못 갑니다. 울진 응봉산 자락 덕구온천, 리조트 대온천탕도 있지만 여름의 정답은 덕구계곡을 거슬러 오르는 길 끝에 있습니다.

계곡을 따라 다리를 여러 번 건너며 오르면 온천수가 솟는 원탕이 나옵니다. 국내에서 유일하게 땅에서 저절로 솟는 자연용출 온천. 펌프 없이 바위 틈에서 김이 올라옵니다.

여름에 권하는 이유는 둘입니다. 계곡 물소리가 트레킹 내내 따라오고, 숲그늘이 짙어 한낮에도 걸을 만합니다. 원탕에는 42℃ 중탄산 온천수에 발을 담글 족욕 자리가 있습니다. 계곡의 찬 공기 속에서 뜨거운 물에 발을 넣는 그 온도차가 두 시간 반의 보상입니다.

[IMG]덕구계곡 원탕, 바위 틈에서 솟은 온천수가 김을 올린다. ⓒ 물멍

내려와서는 리조트 온천에서 제대로 몸을 씻습니다. 산행 후의 중탄산탕은 물이 부드러워 오래 담가도 지치지 않습니다.

허기는 울진식입니다. 대게의 본고장이지만 여름은 금어기라 박달대게 상은 어렵습니다. 대신 후포항 쪽 대게 전문점들이 철에 맞는 해산물 상을 냅니다. 3대째 이어온 원조대게후포리, 대게앤쿡, 대원대게센타가 이름난 집입니다.

[QUOTE]펌프가 아니라 산이 올리는 물, 그래서 걸어서만 닿는다.

대중교통이 불편한 동네라 자차를 권합니다. 울진터미널에서 30km. 운동화 끈을 묶고, 원탕까지 걸어 올라가십시오.','47',4,'2026-03-30 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='왕복 두 시간 반, 걸어야만 닿는 42℃ 자연용출 원탕');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='왕복 두 시간 반, 걸어야만 닿는 42℃ 자연용출 원탕' AND source='MANUAL' AND name='덕구온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','주전골 물소리 끝에 알칼리탕','양양 오색, 여름 계곡 트레킹의 정석','/img/magazine/132.jpg','물소리가 먼저 와요. 오색약수터에서 주전골로 들어서는 순간, 계곡 물소리가 매미 소리를 덮어요. 설악산 주전골은 기암절벽 사이로 3.2km 이어지는 계곡 탐방로예요. 경사가 완만하고 데크가 잘 놓여 있어서, 등산이라기보다 계곡을 관통하는 산책에 가까워요. 주말 하루에 수천 명이 걷는 길인데도 물소리가 커서 붐빈다는 느낌이 덜해요.

[QUOTE]주전골에서는 사진을 찍으려고 멈추는 게 아니라, 물소리 때문에 멈춘다.

출발 전에 오색약수 한 모금을 마셔요. 톡 쏘는 탄산 섞인 철분 맛. 약수로 속을 깨우고, 계곡을 왕복하고, 마지막에 오색온천이에요. 42도 알칼리성 온천수라 트레킹으로 후끈해진 몸을 씻어내리기 좋아요. 한계령 길목 산속이라 해가 지면 여름에도 서늘한데, 그때 뜨거운 탕이 진가를 발휘해요.

[IMG]주전골 초입, 물빛이 초록에서 옥색으로 바뀌는 지점. ⓒ 물멍

밥은 약수터 옆 산채마을에서 해결돼요. 오색약수로 밥을 짓는다는 약수식당, 산채정식의 오색단골식당, 더덕구이가 간판인 산촌식당. 나물 반찬이 상을 덮는 산채백반은 땀 흘린 여름 점심으로 이만한 게 없어요. 대중교통이 애매한 위치라 자차가 편해요. 한계령을 넘는 드라이브는 덤이에요.','51',4,'2026-03-31 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='주전골 물소리 끝에 알칼리탕');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='주전골 물소리 끝에 알칼리탕' AND source='MANUAL' AND name='오색온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','찬 물은 작괘천, 뜨거운 물은 등억, 저녁은 석쇠 불고기','울주 등억알프스온천의 여름 — 계곡·유황탕·언양불고기 세 가지 물','/img/magazine/133.jpg','돗자리부터 깔려요. 언양 작천정 앞 작괘천은 너럭바위 지대가 넓어서, 여름이면 바위 위에 돗자리가 깔리고 아이들이 물에 뛰어들어요. 입장료 없는 동네 피서지. 늦여름엔 계곡가 배롱나무가 붉게 피어서 꽃과 물을 같이 봐요.

울주 사람들이 여름마다 찾는 물은 두 군데예요. 하나는 이 차가운 물, 하나는 뜨거운 물.

뜨거운 물은 등억알프스온천. 영남알프스 산자락 등억리의 유황천이에요. 신불산 등산을 마친 산꾼들이 내려와 몸을 푸는 탕이라 여름에도 한산하지 않아요. 계곡에서 차가워진 몸을 유황탕에 담그면 냉탕과 온탕을 자연과 온천으로 오가는 셈이 돼요. 유황수 특유의 매끄러움은 덤이고요.

[IMG]작괘천 너럭바위, 돗자리 너머로 배롱나무의 붉은 꽃. ⓒ 물멍

저녁 메뉴는 정해져 있어요. 언양불고기. 얇게 다진 한우를 석쇠에 눌러 굽는 이 지역 음식으로, 언양읍엔 불고기거리가 형성돼 있어요.

선택지는 셋이에요. 원조급으로 꼽히는 원조 진불고기, 노포 언양 기와집 불고기, 언양불고기식당. 석쇠 불향이 밴 불고기 한 판이면 여름 하루의 마무리로 부족함이 없어요.

[QUOTE]냉탕은 계곡이, 온탕은 유황이, 마무리는 석쇠가 맡는다.

언양터미널에서 온천까지 차로 15분. 이번 여름 울산이 덥다고 느껴지면, 작괘천에 발부터 담그고 등억으로 올라가세요.','31',4,'2026-04-02 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='찬 물은 작괘천, 뜨거운 물은 등억, 저녁은 석쇠 불고기');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='찬 물은 작괘천, 뜨거운 물은 등억, 저녁은 석쇠 불고기' AND source='MANUAL' AND name='등억알프스온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','15m 위에서 떨어지는 물을 어깨로 받는 동네','구례 산동 — 수락폭포 물맞이와 지리산온천 32도 미온탕의 여름 냉온욕','/img/magazine/134.jpg','숨이 먼저 멎어요. 15m 위에서 떨어진 물이 어깨를 때리는 순간이에요. 구례 산동면 수락폭포. 폭포를 바라보는 게 아니라 그 아래에 직접 들어가는, 전국에서 드문 물맞이 폭포예요.

예로부터 여름이면 산동 어르신들이 이 물줄기 아래 서서 어깨와 허리를 다스렸어요. 그 내력으로 문화체육관광부 추천여행지에 물맞이 장소로 올라 있고요. 중기마을 주차장에 차를 대고 600m만 걸으면 폭포 앞이에요.

장맛비가 지나간 직후가 가장 세요. 물줄기가 굵어져 어깨에 닿는 타격감이 올라가는데, 처음엔 숨이 턱 막히다가 몇 번 맞고 나면 두들겨 맞은 어깨가 이상하게 개운해요.

[IMG]수락폭포 물줄기 아래, 우비 차림의 사람들이 어깨를 내밀고 서 있다. ⓒ 물멍

찬물에 두들겨진 몸의 다음 행선지는 바로 옆 지리산온천. 게르마늄 성분의 32도 미온천이에요. 폭포는 냉, 온천은 온 — 15m의 낙차와 32도의 탕을 오가는 산동식 냉온욕이 완성돼요. 봄 산수유로 알려진 동네가 여름엔 이렇게 물의 동네가 돼요.

[QUOTE]폭포는 어깨를 두들기고, 32도 미온탕은 그 어깨를 달랜다.

허기는 산동 밥상이 받아요. 토지다슬기식당의 다슬기수제비, 송림민속가든의 흑돼지구이, 산수유텃밭식당의 산채 한식. 물맞이로 서늘해진 속엔 섬진강 다슬기 국물이 먼저예요.

구례구역에서 산동행 버스로 25분. 우비 하나 챙겨서 가세요. 어깨를 내밀고 15m를 받는 것, 그게 산동 여름의 첫 순서예요.','46',4,'2026-04-03 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='15m 위에서 떨어지는 물을 어깨로 받는 동네');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='15m 위에서 떨어지는 물을 어깨로 받는 동네' AND source='MANUAL' AND name='지리산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','고견계곡 그늘과 탄산 기포의 오후','거창 가조, 계곡-사찰-온천 여름 동선','/img/magazine/135.jpg','"여름 가조는 계곡부터예요." 온천 동네에서 이런 말을 듣게 될 줄은 몰랐어요. 가조 사람들이 여름 손님에게 먼저 권하는 건 우두산 자락의 고견계곡이에요. 숲그늘 아래로 맑은 물이 흐르는 골짜기를 따라 오르면 천년 고찰 고견사가 나오고, 그 길목에 견암폭포가 물을 쏟아요. 폭포 앞은 한여름에도 서늘해서, 오르는 동안 흘린 땀이 그 자리에서 식어요.

계곡 산책을 마쳤으면 산 아래 가조온천으로 내려와요. 여기서 이 동네의 반전이 나와요. 가조의 물은 탄산천이거든요. 32도 미온수에 몸을 담그면 피부에 탄산 기포가 조르르 맺혀요. 여름에 뜨거운 탕은 엄두가 안 나는 사람에게 이 미지근한 탄산탕은 최적의 답이에요. 시원한 계곡 공기를 쐬고 온 몸에, 뜨겁지 않게 혈액순환만 돌려주는 물.

밥은 거창식이에요. 이 고장 향토음식은 민물고기를 뼈째 고아낸 어탕국수. 온천 주변으론 관광공사 여행기사에 소개된 거창추어탕과 뼈다귀 해장국의 홍천뚝배기, 리조트 안 꽃등심집 비계산가든이 있어요. 입소문 난 향토 한식집 소골둑도 가까워요.

대중교통은 거창터미널에서 가조행 버스 25분이지만, 계곡 들머리까지 붙이려면 자차가 현실적이에요.','48',4,'2026-04-05 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='고견계곡 그늘과 탄산 기포의 오후');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='고견계곡 그늘과 탄산 기포의 오후' AND source='MANUAL' AND name='가조온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','물을 세 번 갈아입는 속초의 여름 — 바다, 폭포, 53도','속초해수욕장에서 비룡폭포, 그리고 척산온천까지 — 한 번의 삼단 물놀이','/img/magazine/136.jpg','파라솔이 펴지기 전의 백사장. 속초해수욕장의 아침은 물도 사람도 아직 차분해요. 여름 속초에서 하루를 꽉 채우는 방법은 하나예요. 물을 세 번 바꾸는 것.

첫 번째 물은 바다예요. 성수기 한낮의 속초해수욕장은 파라솔로 빼곡해지지만, 오전은 그 전이에요. 바다는 아침에 쓰고 나오는 게 맞아요.

두 번째 물은 폭포예요. 한낮 더위가 올라오면 설악산 소공원 쪽으로 방향을 틀어 비룡폭포까지 걸어요. 계곡을 따라 오르는 길이라 숲그늘이 끊기지 않고, 폭포 앞에 서면 물보라 섞인 바람이 정면으로 와요. 해변의 열기가 거기서 끝나요.

[IMG]비룡폭포 물보라 앞, 젖은 바위가 검게 빛난다. ⓒ 물멍

세 번째 물은 53도예요. 척산온천의 알칼리성 온천수. 해수욕의 소금기와 산행의 땀을 한 번에 헹구는 마무리 물이에요. 속초터미널에서 3-1번 버스로 15분이라 어느 동선 끝에든 붙어요. 에어컨 바람에 시달린 몸이 뜨거운 탕에서 풀리는 감각은 겨울 온천과는 다른 종류의 쾌감이에요.

[QUOTE]바다는 아침에, 폭포는 한낮에, 53도는 저녁에.

마지막은 물이 아니라 그릇이에요. 탕 옆 동네 학사평 순두부촌. 1965년부터 이어온 김영애할머니순두부, 그리고 같은 순두부촌의 원조 재래식 할머니 순두부. 뜨끈한 한 그릇으로 세 번의 물을 닫아요.

속초에 가면 바다만 보고 오지 마세요. 오전 바다, 오후 폭포, 저녁 53도. 순서만 지키면 하루가 저절로 채워져요.','51',4,'2026-04-06 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='물을 세 번 갈아입는 속초의 여름 — 바다, 폭포, 53도');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='물을 세 번 갈아입는 속초의 여름 — 바다, 폭포, 53도' AND source='MANUAL' AND name='척산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','폭포 아래서 더위 씻고 꿩 샤브 한 상','수안보의 여름 — 수옥폭포와 53도 알칼리탕','/img/magazine/137.jpg','20m. 절벽을 타고 떨어지는 수옥폭포의 높이입니다. 수안보에서 차로 멀지 않은 괴산 땅, 주차장에서 걸어서 10분이면 폭포 앞에 섭니다. 세 단으로 꺾여 떨어지는 물줄기 아래 소(沼)가 넓게 펼쳐져, 여름이면 발 담그는 사람들로 폭포 앞이 왁자합니다. 접근이 이렇게 쉬운 폭포는 전국에서도 드뭅니다.

[QUOTE]폭포 소리가 큰 곳에서는 더위 얘기를 하는 사람이 없다.

폭포에서 식힌 몸은 수안보로 돌아와 데웁니다. 수안보의 물은 53도 알칼리성. 관절과 피로 회복으로 오래 이름을 얻은, 왕들이 다녀갔다는 그 물입니다. 여름 온천이 무슨 소리냐 싶겠지만, 냉방과 찬 음식에 시달린 여름 몸이야말로 뜨거운 물이 필요합니다. 폭포의 냉기와 온천의 열기를 하루에 오가는 것, 그게 여름 수안보의 사용법입니다.

[IMG]수옥폭포 아래 소, 물안개 사이로 아이들 웃음소리가 번진다. ⓒ 물멍

저녁상은 수안보에서만 가능한 메뉴로 갑니다. 꿩요리입니다. 수안보는 전국에서 드문 꿩요리 특화 지구로, 꿩 샤브부터 꿩만두까지 코스로 내는 전문점이 모여 있습니다. 꿩 코스의 대장군식당, 8가지 꿩 코스의 삿갓촌, 그 밖에 장군식당과 감나무집이 이름난 집들입니다. 담백한 꿩 샤브는 여름 보양식으로 손색이 없습니다. KTX 충주역에서 246번 버스로 25분입니다.','43',4,'2026-04-08 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='폭포 아래서 더위 씻고 꿩 샤브 한 상');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='폭포 아래서 더위 씻고 꿩 샤브 한 상' AND source='MANUAL' AND name='수안보온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','입술이 파래진 아이를 31도 탕에 데려가는 순서','문경 쌍용계곡 물놀이에서 칼슘중탄산 미온탕까지 — 여름 가족 동선','/img/magazine/138.jpg','튜브를 낀 아이가 계곡물에 첨벙 뛰어듭니다. 문경 쌍용계곡, 여름 오전의 풍경입니다. 문경8경에 드는 이 계곡은 너른 암반 위로 물이 흐르고 수심이 대체로 완만해, 가족 단위 물놀이객이 해마다 소나무 그늘 아래 돗자리를 폅니다.

계곡물은 한여름에도 이가 시릴 만큼 찹니다. 오후 서너 시, 물놀이를 접을 무렵이면 입술이 파래진 아이들이 하나둘 물 밖으로 나옵니다. 여기서 하루를 끝내면 남는 건 감기 기운뿐입니다.

[IMG]쌍용계곡 암반 위로 흐르는 물, 소나무 그늘 아래 돗자리가 펼쳐져 있다. ⓒ 물멍

그때 필요한 것이 문경온천입니다. 칼슘중탄산 성분의 온천수, 원수 31도. 뜨거운 탕이었다면 찬물에 곤두선 근육이 놀랐을 텐데, 31도의 순한 물은 계곡물에 식은 몸을 급하지 않게 덥힙니다. 미온탕 안에서 근육이 서서히 풀리는 감각이 여름 계곡 물놀이의 마무리 의식입니다.

저녁은 약돌입니다. 약돌을 먹여 키운 약돌돼지와 약돌한우를, 온천지구 안 온천약돌한우돼지정육식당에서 정육 방식으로 골라 구울 수 있습니다. 새재 쪽으로 나가면 청포묵에 조밥을 비비는 묵조밥의 소문난식당, 석쇠구이의 새재할매집. 매콤한 석쇠구이 불향이 물놀이로 바닥난 체력을 채웁니다.

[QUOTE]계곡물이 곤두세운 근육을, 31도가 천천히 내려놓는다.

점촌역에서 문경행 버스로 30분. 다만 쌍용계곡까지 한 동선에 묶는 여름 일정은 자차가 편합니다. 아이 입술이 파래지기 전에 계곡을 접고, 31도 탕으로 가십시오. 순서가 바뀌면 여름 감기가 남고, 순서를 지키면 잠이 남습니다.','47',4,'2026-04-09 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='입술이 파래진 아이를 31도 탕에 데려가는 순서');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='입술이 파래진 아이를 31도 탕에 데려가는 순서' AND source='MANUAL' AND name='문경온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','바닷물 27도, 온천물 60도, 해운대','해수욕장 도보 5분 거리의 식염천','/img/magazine/139.jpg','60도. 해운대온천의 원수 온도입니다. 전국 온천 중에서도 손꼽히게 뜨거운 이 물이, 전국에서 가장 붐비는 해수욕장 옆 골목에서 솟습니다. 부산 지하철 2호선 해운대역에서 걸어서 5분. 온천에 가기 위한 이동이 사실상 없는, 도시 그 자체가 온천인 동네입니다.

여름 해운대의 사용법은 온도차 놀이입니다. 낮에는 해수욕장의 바닷물에, 저녁에는 식염천 탕에. 바닷물과 온천물 모두 소금기를 품었다는 점이 재미있는 대목입니다. 해수욕으로 끈적해진 몸을 뜨거운 식염천으로 헹구면, 소금기가 소금물에 씻겨나가는 묘한 개운함이 있습니다.

[QUOTE]해운대의 하루는 바다에서 절여지고 온천에서 데쳐진다.

오후 한나절이 비면 청사포로 넘어갑니다. 바다 위로 191m 뻗은 U자형 스카이워크, 다릿돌전망대가 있습니다. 발아래 유리 바닥으로 파도가 지나가는 무료 전망대로, 해 질 무렵 풍경이 특히 좋습니다.

[IMG]다릿돌전망대 끝, 유리 바닥 아래로 여름 바다가 일렁인다. ⓒ 물멍

마무리는 부산식입니다. 온천욕 후 국밥 한 그릇. 59년 전통의 해운대원조할매국밥이 소고기국밥을, 오복돼지국밥 해운대와 노포 의령식당이 돼지국밥을 냅니다. 뜨거운 탕에 뜨거운 국밥. 이열치열의 완성형이 해운대에 있습니다.','26',4,'2026-04-11 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='바닷물 27도, 온천물 60도, 해운대');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='바닷물 27도, 온천물 60도, 해운대' AND source='MANUAL' AND name='해운대온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','한여름 밤, 53도 유황탕 창밖엔 물소리와 풀벌레뿐','울진 온정면 백암온천 — 낮은 신선계곡, 밤은 유황천, 사람 소리 없는 성수기','/img/magazine/140.jpg','탕 창밖에서 계곡 물소리가 들립니다. 그리고 풀벌레. 사람 소리는 없습니다. 울진 온정면 백암온천 관광특구의 한여름 밤입니다.

동해안 대표 유황온천이라는 이름값을 생각하면 이상한 풍경입니다. 피서 인파는 전부 해수욕장으로 몰리고, 산속 온천 마을은 성수기라는 말이 무색하게 한산합니다. 붐비는 게 싫은 사람에게 이 한산함이야말로 성수기 전략입니다.

낮은 신선계곡에서 보냅니다. 백암산 자락의 이 계곡은 울진군이 백암온천과 묶어 소개하는 여름 코스로, 이름 그대로 물빛이 맑아 발을 담그면 바닥 자갈이 그대로 보입니다. 숲이 깊어 한낮에도 계곡 안은 서늘합니다.

[IMG]신선계곡의 소(沼), 옥색 물 아래 자갈이 훤히 비친다. ⓒ 물멍

해가 지면 53도입니다. 백암의 물은 유황천. 손끝으로 비비면 미끄덩할 만큼 부드러워, 계곡에서 하루를 보낸 피부를 매만지기에 이만한 물이 없습니다. 밤 탕에 앉아 있으면 창밖 어둠 속에서 낮에 발 담갔던 그 계곡의 물소리가 이어집니다.

[QUOTE]피서객은 바다로 갔고, 유황탕은 물소리와 풀벌레에게 남았다.

밥은 소박하게 갑니다. 온천지구 안의 한식 기사식당 동광식당, 순대국의 큰맘할매순대국, 저렴하고 푸짐하다는 후기의 LG생활연수원 레스토랑. 제대로 된 해산물이 당기면 후포항이 멀지 않습니다.

동해선 평해역에서 백암행 버스로 20분. 이번 여름엔 해수욕장 대신 이쪽으로 오십시오. 사람 소리 없는 성수기가 여기 있습니다.','47',4,'2026-04-12 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='한여름 밤, 53도 유황탕 창밖엔 물소리와 풀벌레뿐');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='한여름 밤, 53도 유황탕 창밖엔 물소리와 풀벌레뿐' AND source='MANUAL' AND name='백암온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','쇠 맛 나는 물 한 모금으로 열고 42도로 닫는 하루','양양 남설악 오색 — 약수, 주전골 단풍, 산채 밥상, 알칼리탕의 순서','/img/magazine/141.jpg','바가지에 뜬 물에서 쇠 맛이 납니다. 오색약수. 톡 쏘는 탄산과 철분 맛이 나는 이 한 모금이 주전골 트레킹의 오래된 출발 신호입니다.

남설악의 가을은 흘림골과 주전골, 두 이름으로 요약됩니다. 흘림골 쪽은 오르내림이 있어 등산화가 필요하지만, 오색약수터에서 시작하는 주전골 구간은 계곡을 따라 데크가 이어져 운동화로도 충분합니다. 10월 중하순, 계곡물 위로 단풍이 겹치는 구간에서는 걸음이 자꾸 끊깁니다.

[IMG]오색약수터 앞, 바가지를 든 등산객들이 줄을 서 있다. ⓒ 물멍

내려오면 몸이 원하는 순서가 정해져 있습니다. 먼저 밥. 약수터 옆 산채마을촌의 약수식당은 오색약수로 지은 밥을 내고, 오색단골식당의 산채비빔밥, 산촌식당의 더덕구이도 이 동네에서 오래 검증된 선택지입니다. 나물 반찬이 상을 덮는 밥상 앞에서는 하산의 허기가 오히려 고맙습니다.

그다음이 42도입니다. 오색온천의 알칼리성 온천수는 뜨겁지도 미지근하지도 않은, 산행 뒤의 다리에 정확히 맞는 온도입니다. 약수의 탄산, 나물의 산, 탕의 알칼리 — 오색이라는 지명이 하루 안에서 순서대로 채워집니다.

[QUOTE]오색의 하루는 쇠 맛으로 열리고 42도로 닫힌다.

한계령 길목이라 자차가 편한 동네입니다. 그 수고를 감수하고 올 이유는 이 순서 안에 전부 있습니다. 10월 중하순에 맞춰 날을 잡고, 바가지부터 드십시오.','51',4,'2026-04-14 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='쇠 맛 나는 물 한 모금으로 열고 42도로 닫는 하루');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='쇠 맛 나는 물 한 모금으로 열고 42도로 닫는 하루' AND source='MANUAL' AND name='오색온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','억새 바다에 다녀온 무릎을 위한 유황천','간월재 은빛 물결 그리고 등억알프스온천 29도의 반전','/img/magazine/142.jpg','해발 900미터쯤에서 바람의 소리가 바뀌어요. 나무를 흔들던 소리가 풀을 쓸어 넘기는 소리로. 간월재 억새 군락지에 올라섰다는 뜻이에요.

가을의 영남알프스는 신불산과 간월산 사이 능선이 통째로 은빛으로 변해요. 특히 간월재는 늦가을까지 억새가 일렁이는 걸로 이름난 곳이라, 단풍이 늦는 해에는 등산객이 이쪽으로 몰린다는 말이 나올 정도예요. 정상까지 갈 필요도 없어요. 간월재까지만 올라도 억새 바다 한가운데 서 있게 되니까요.

[QUOTE]단풍은 나무의 일이고, 억새는 바람의 일이다. 간월재에선 바람을 구경한다.

내려와서 갈 곳은 두 군데예요. 하나는 언양읍. 얇게 다진 한우를 석쇠에 구워내는 언양불고기의 본고장이라 읍내에 불고기거리가 있어요. 언양불고기식당, 원조 진불고기, 기와집 불고기 같은 노포들 사이에서 고민하는 시간도 코스의 일부예요.

다른 하나가 등억알프스온천이에요. 수온 29도의 유황천이라 처음 몸을 넣으면 ''어, 미지근한데?'' 싶지만, 산행으로 달아오른 몸에는 이 온도가 오히려 오래 앉아 있게 해줘요. 유황 냄새가 은근하게 올라오는 탕에서 무릎을 주무르다 보면, 오늘 넘은 능선이 창밖에 그대로 서 있어요. 언양터미널에서 차로 15분. 억새의 계절에만 완성되는 조합이에요.','31',4,'2026-04-15 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='억새 바다에 다녀온 무릎을 위한 유황천');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='억새 바다에 다녀온 무릎을 위한 유황천' AND source='MANUAL' AND name='등억알프스온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','금문교를 건너면 원탕이 나온다','덕구계곡 단풍 트레킹 — 국내 유일 자연용출 온천의 발원지까지','/img/magazine/143.jpg','다리를 세다 보면 도착하는 온천이 있다는 걸 아시는지요.

덕구온천 뒤편, 응봉산 자락의 덕구계곡에는 세계의 유명 다리들을 본떠 만든 작은 교량들이 계곡을 따라 놓여 있습니다. 금문교를 축소한 붉은 다리를 건너고, 다음 다리, 또 다음 다리를 건너며 4킬로미터 남짓 오르면 원탕이 나옵니다. 국내 온천 가운데 유일하게 펌프 없이 스스로 솟는, 자연용출의 발원지입니다.

가을의 이 길은 트레킹 코스라기보다 단풍 회랑에 가깝습니다. 계곡물 소리와 발밑의 낙엽, 그리고 다리 하나를 건널 때마다 바뀌는 시야. 원탕에 도착하면 김이 오르는 온천수에 손을 담가볼 수 있고, 여기서 발길을 돌려 내려오면 왕복 두 시간 반 안팎입니다.

내려온 다음의 동선은 두 갈래입니다. ① 리조트 온천에 바로 들어가 42도 중탄산천에 몸을 풀거나 ② 차를 몰고 바다 쪽으로 나가 저녁을 먼저 해결하거나. 울진은 대게의 본고장이라 원조대게후포리 같은 3대째 이어지는 대게 전문점과 대게앤쿡, 대원대게센타 같은 집들이 기다립니다. 가을 대게는 겨울만 못하다지만, 산행 뒤의 허기 앞에서는 충분한 성찬입니다.

울진터미널에서 30킬로미터, 자차가 편한 위치입니다. 걸어서 발원지를 눈으로 본 뒤에 담그는 온천은, 같은 물이라도 온도가 다르게 느껴집니다.','47',4,'2026-04-17 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='금문교를 건너면 원탕이 나온다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='금문교를 건너면 원탕이 나온다' AND source='MANUAL' AND name='덕구온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','새재를 걷고, 묵조밥을 먹고, 31도에 눕기','문경새재 단풍길의 하루를 시간 순으로','/img/magazine/144.jpg','문경의 가을은 걷는 계절이에요. 그리고 이 동네의 하루는 순서가 거의 정해져 있어요.

오전, 문경새재도립공원. 옛길은 흙길이라 운동화 밑창으로 낙엽 밟히는 감촉이 그대로 올라와요. 제1관문에서 제2관문까지가 완만해서 가장 많이 걷는 구간이에요. 왕복 두 시간이면 넉넉하고, 단풍철에는 길 양옆이 통째로 물들어요. 맨발로 걷는 사람들이 심심찮게 보이는 것도 이 길의 오래된 풍경이고요.

점심은 새재 입구에서 해결해요. 문경 향토음식인 묵조밥을 내는 소문난식당의 청포묵조밥이 걷고 난 속에 순하게 들어가요. 고기가 당기면 온천지구 쪽의 온천약돌한우돼지정육식당으로. 약돌(거정석) 먹여 키운 약돌돼지와 약돌한우가 문경의 명물이라, 정육식당에서 바로 골라 구워 먹는 방식이에요.

[IMG]제1관문을 지나는 흙길, 낙엽이 길 가장자리에 몰려 있다. ⓒ 물멍

오후 서너 시, 문경온천. 수온 31도의 칼슘중탄산천이라 뜨거운 탕을 기대하면 놀랄 수 있는데, 걷기로 데워진 몸에는 이 미지근함이 길게 머물기 좋은 온도예요. 새재를 걸은 종아리가 물속에서 천천히 풀려요.

점촌역에서 문경행 버스로 30분. 뚜벅이로도 하루가 계산되는, 가을 걷기 여행의 모범답안 같은 동네예요.','47',4,'2026-04-18 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='새재를 걷고, 묵조밥을 먹고, 31도에 눕기');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='새재를 걷고, 묵조밥을 먹고, 31도에 눕기' AND source='MANUAL' AND name='문경온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','왕들이 넘던 고개 아래, 왕의 물','하늘재와 월악산 단풍, 그리고 수안보 53도','/img/magazine/145.jpg','수안보의 물은 ''왕의 물''로 불려 왔습니다. 조선의 임금들이 이 온천을 찾았다는 기록이 이 동네의 오래된 자부심입니다. 지하 250미터 암반에서 솟는 53도 알칼리성 온천수. 가을의 수안보는 이 물에 역사 하나를 더 얹어서 즐기는 동네입니다.

수안보에서 차로 넘어가는 하늘재는 우리나라에서 가장 오래된 고갯길로 꼽히는 곳입니다. 월악산 자락의 이 고개는 걷는 옛길로 남아 있어서, 단풍철에는 문경 쪽과 충주 쪽을 잇는 낙엽길이 됩니다. 포장도로의 편리함 대신 흙길의 시간을 택한 고개라, 가을에 걸으면 계절이 이 길의 편을 들어준다는 생각이 듭니다.

[QUOTE]고개는 넘라고 있고, 온천은 넘은 다음에 있다.

걷고 내려온 저녁의 수안보는 꿩의 동네입니다. 전국에서 드물게 꿩요리가 특화된 지구라, 대장군식당의 꿩 코스, 삿갓촌의 여덟 가지 꿩 코스처럼 샤브부터 만두까지 꿩 하나로 상을 차리는 집들이 모여 있습니다. 가을 산책 뒤의 온천, 온천 뒤의 꿩 샤브. 이 순서는 수백 년 전 이 고개를 넘던 사람들의 회복법과 크게 다르지 않았을 겁니다.

KTX 충주역에서 246번 버스로 25분. 왕의 물은 의외로 뚜벅이에게도 열려 있습니다.','43',4,'2026-04-20 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='왕들이 넘던 고개 아래, 왕의 물');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='왕들이 넘던 고개 아래, 왕의 물' AND source='MANUAL' AND name='수안보온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','케이블카로 오른 단풍, 순두부로 닫는 하루','속초 가을 여행의 마지막 정류장, 척산온천','/img/magazine/146.jpg','속초터미널에서 3-1번 버스로 15분. 척산온천은 속초 여행의 동선 끝에 붙는 온천이에요. 그런데 가을에는 이 ''마지막 코스''가 주인공이 돼요.

일단 낮의 설악산. 권금성으로 오르는 설악 케이블카는 가을 단풍철이 일 년 중 가장 붐비는 시기예요. 걷지 않고도 단풍 든 암봉 위에 설 수 있으니까요. 케이블카에서 내려 권금성 바위 위에 서면 설악의 능선과 동해가 한 화면에 들어와요. 등산화 없이 만나는 설악의 가을로는 이만한 방법이 없어요.

내려와서는 학사평으로 가요. 척산온천 바로 옆 동네가 콩꽃마을이라 불리는 학사평 순두부촌이거든요. 1965년에 문을 연 김영애할머니순두부를 비롯해 재래식 순두부를 내는 노포들이 모여 있어요. 간수 대신 바닷물로 굳혔다는 이야기가 전해지는 뽀얀 순두부 한 그릇이면, 쌀쌀해진 저녁 공기가 갑자기 고마워져요.

[IMG]학사평 순두부촌, 김이 오르는 뚝배기와 양념장. ⓒ 물멍

그리고 척산온천. 수온 53도 알칼리성 온천수라 탕에 들어가는 순간 몸이 알아서 한숨을 쉬어요. 케이블카로 아낀 체력까지 전부 이완에 쓰는 거예요. 단풍, 순두부, 온천. 속초의 가을은 이 세 단어로 문을 닫는 게 제일 예뻐요.','51',4,'2026-04-21 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='케이블카로 오른 단풍, 순두부로 닫는 하루');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='케이블카로 오른 단풍, 순두부로 닫는 하루' AND source='MANUAL' AND name='척산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','해발 620미터, Y자로 갈라진 다리 위에서','우두산 출렁다리와 가조온천 탄산천 — 거창의 가을 조합','/img/magazine/147.jpg','다리 한가운데서 길이 세 갈래로 갈라집니다. 발밑은 해발 620미터의 협곡. 거창 우두산의 Y자형 출렁다리는 국내에서 보기 드문 세 방향 현수교라, 다리 위에서 갈림길을 만나는 이상한 경험을 하게 됩니다.

출렁다리가 있는 항노화힐링랜드는 우두산 자락에 조성된 산림휴양 단지입니다. 주차장에서 다리까지 완만한 데크 숲길이 이어져 있어 등산 채비 없이도 오를 수 있고, 가을에는 이 숲길 자체가 단풍 터널이 됩니다. 다리 위에서 내려다보는 협곡의 단풍은, 출렁임 때문에 두 배로 아찔합니다.

내려오면 가조온천이 기다립니다. 수온 32도의 탄산천. 탕에 몸을 넣고 가만히 있으면 피부에 잔거품이 맺히는 물입니다. 탄산이 혈관을 열어 혈액순환을 돕는다는 그 물이라, 미지근한 온도에도 몸속은 천천히 데워집니다. 출렁다리에서 굳은 다리가 풀리는 데는 이쪽이 오히려 전문입니다.

허기는 거창식으로 채웁니다. 온천 인근의 거창추어탕, 뼈다귀 해장국을 내는 홍천뚝배기가 온천 뒤의 속을 데우는 집들이고, 거창의 향토음식인 어탕국수 — 민물 잡어를 뼈째 고아 국수를 만 음식 — 도 이 지역에 온 김에 만나야 할 맛입니다.

거창터미널에서 가조행 버스가 있지만 힐링랜드까지 생각하면 자차가 편합니다. 흔들리는 다리와 잔잔한 탄산탕, 가을 거창의 낙차는 그 사이에 있습니다.','48',4,'2026-04-23 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='해발 620미터, Y자로 갈라진 다리 위에서');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='해발 620미터, Y자로 갈라진 다리 위에서' AND source='MANUAL' AND name='가조온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','피아골이 불타는 계절, 게르마늄에 몸을 담근다','구례 단풍 이중주 — 계곡의 화염과 천년 사찰','/img/magazine/148.jpg','구례의 가을은 선택형이에요. 계곡이냐, 절이냐.

계곡을 고르면 피아골이에요. ''단풍의 화염''이라는 말이 따라다니는 지리산 남쪽의 단풍 계곡. 해마다 11월 초에는 표고막터 일대에서 피아골 단풍축제가 열릴 만큼, 이 골짜기의 가을은 구례의 연중행사예요. 물에 비친 단풍까지 합쳐 두 번 불탄다는 계곡이죠.

절을 고르면 화엄사예요. 지리산 자락의 천년 고찰인데, CNN이 한국의 아름다운 사찰로 꼽았다는 이야기가 늘 붙어 다녀요. 단풍철의 화엄사는 전각의 단청과 산의 단풍이 서로 경쟁하는 것처럼 보여요.

[QUOTE]피아골은 시끄럽게 불타고, 화엄사는 조용히 불탄다.

어느 쪽을 골랐든 마무리는 산동면이에요. 지리산온천의 물은 게르마늄을 품은 32도의 온천수. 뜨끈한 탕을 기대했다면 온도가 낮게 느껴질 수 있지만, 단풍 산행으로 데워진 몸을 천천히 식히며 오래 담그기에는 이 온도가 맞아요. 봄이면 노랗게 물드는 산수유마을이 바로 옆 동네라, 겨울눈이 맺힌 산수유 가지를 미리 봐두는 것도 이 온천만의 예고편이고요.

허기지면 섬진강의 맛으로. 토지다슬기식당의 다슬기수제비가 온천 뒤의 속을 풀어주고, 송림민속가든의 흑돼지구이는 산행 뒤의 단백질을 책임져요. 구례구역에서 산동행 버스로 25분. 화염의 계곡과 미지근한 탕, 낙차가 큰 가을이에요.','46',4,'2026-04-24 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='피아골이 불타는 계절, 게르마늄에 몸을 담근다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='피아골이 불타는 계절, 게르마늄에 몸을 담근다' AND source='MANUAL' AND name='지리산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','백암산이 물드는 순서대로 내려와서','울진 백암온천 — 등산과 유황천의 오래된 궁합','/img/magazine/149.jpg','백암온천의 뒷산은 그냥 배경이 아닙니다. 백암산은 이 온천 지구의 물이 시작되는 산이고, 가을이면 온천에서 올려다보는 산등성이가 통째로 물듭니다.

백두대간의 산세와 동해의 바다를 같이 품은 관광특구라는 설명이 붙는 동네지만, 가을의 백암은 무엇보다 등산객의 온천입니다. 백암산 산행을 마친 다리로 들어가는 53도 유황천. 물이 부드럽다는 평이 오래 쌓인 동해안 대표 유황온천이라, 탕에 들어가면 피부가 먼저 그 말을 이해합니다. 유황 특유의 매끄러움이 산행의 뻐근함 위로 덮이는 감각은, 이 동네가 수백 년 동안 팔아온 상품이 아니라 그냥 지형의 결과입니다.

온천 지구 인근의 신선계곡도 가을 산책 코스로 오래 불려온 이름입니다. 본격 산행이 부담스러운 동행이 있다면 계곡 쪽 산책으로 나눠 걷고 온천에서 다시 만나는 편성도 됩니다.

밥은 소박하게 해결됩니다. 온정면 온천 지구의 동광식당은 기사식당 계보의 한식집이고, 큰맘할매순대국의 순대국 한 그릇도 하산 후의 속에는 충분합니다. 화려한 미식보다 뜨끈한 국물이 어울리는 동네입니다.

동해선 평해역에서 백암행 버스로 20분. 기차로 닿는 동해안 온천이라는 점도, 뚜벅이 등산객에게는 반가운 조건입니다.','47',4,'2026-04-26 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='백암산이 물드는 순서대로 내려와서');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='백암산이 물드는 순서대로 내려와서' AND source='MANUAL' AND name='백암온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','지하철 타고 가는 단풍놀이가 있다면','금강공원의 가을과 동래온천, 그리고 비 오면 파전','/img/magazine/150.jpg','부산 지하철 1호선 온천장역. 개찰구를 나와 8분을 걸으면 조선시대부터 이어진 온천 지구가 나오고, 조금 더 가면 금정산 자락의 단풍이 나와요. 대도시에서 이렇게 계획 없이 성립하는 가을 코스는 흔치 않아요.

동래의 가을 산책은 금강공원이 맡아요. 금정산 기슭의 이 오래된 공원은 부산의 단풍 명소로 꼽히는 곳이라, 11월이면 산책로가 낙엽으로 덮여요. 뉴트로 감성이라는 수식이 붙을 만큼 시간이 천천히 흐르는 공원이라, 단풍놀이라기보다 동네 어르신들 사이에 섞여 걷는 쪽에 가까워요. 금정산성 쪽으로 발을 늘리면 산행이 되고, 공원만 돌면 산책으로 끝나요. 강도는 스스로 정하면 돼요.

내려와서는 62도. 동래온천은 식염천이라 물이 짭짤한 기운을 품고 있는데, 원수 온도가 62도로 뜨거운 편이라 탕에 들어가는 순간 어깨까지 확 데워져요. 조선시대 기록에 등장하는 부산 원조 온천의 물맛이에요.

그리고 이 동네의 오래된 공식 하나. 목욕 후엔 파전이에요. 4대째 이어지는 동래할매파전이 동래파전의 원조 노포로 버티고 있고, 온천동의 소문난동래파전도 방송을 탄 집이에요. 두툼한 파전에 막걸리 한 잔이면, 지하철로 온 가을 여행치고는 과분한 마무리예요.','26',4,'2026-04-27 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='지하철 타고 가는 단풍놀이가 있다면');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='지하철 타고 가는 단풍놀이가 있다면' AND source='MANUAL' AND name='동래온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','눈 오는 날, 노천탕의 김은 두 배로 오른다','겨울 덕구 — 42.4도 자연용출 온천과 울진대게의 계절','/img/magazine/151.jpg','노천탕 물 위로 눈이 떨어지면 소리가 나지 않아요. 닿는 순간 사라지니까요. 겨울 덕구온천에서 가장 사치스러운 구경은 그거예요. 응봉산 자락에 눈이 쌓이는 동안, 나는 42도 물속에 어깨까지 잠겨 있는 것.

덕구의 물은 국내에서 유일하게 펌프 없이 스스로 솟는 자연용출 온천수예요. 하루 2천 톤씩, 42.4도로 솟은 물이 식지 않은 채 탕까지 내려와요. 데우지도 식히지도 않은 물이라는 건 겨울에 특히 실감 나요. 노천탕에서 얼굴은 차고 몸은 뜨거운 상태로 응봉산 설경을 마주 보고 있으면, 일본 온천 부럽지 않다는 후기들이 왜 쌓이는지 알게 돼요.

그리고 겨울 울진에는 온천만큼 확실한 두 번째 이유가 있어요. 대게철이거든요. 살이 차오른 겨울 대게를 찌는 집들 — 3대 50년을 넘긴 원조대게후포리, 대게앤쿡, 대원대게센타 — 이 차로 닿는 거리에 있어요. 온천과 대게찜을 묶은 겨울 보양 코스는 한국관광공사 여행기사로 소개될 만큼 이 동네의 공인된 조합이에요.

울진터미널에서 30킬로미터, 겨울엔 더더욱 자차 여행지예요. 눈길 운전이 부담이면 눈 예보 없는 날을 골라도 돼요. 어차피 물은 365일 같은 온도로 솟고 있으니까요.','47',4,'2026-04-28 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='눈 오는 날, 노천탕의 김은 두 배로 오른다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='눈 오는 날, 노천탕의 김은 두 배로 오른다' AND source='MANUAL' AND name='덕구온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','대게 찌는 김, 유황탕의 김','겨울 백암온천과 후포항 — 울진식 보양의 정석','/img/magazine/152.jpg','겨울 울진의 공기에는 두 종류의 김이 섞여 있습니다. 후포항에서 대게 찌는 김, 그리고 백암온천 지구의 탕에서 오르는 김. 이 둘을 하루에 다 쐬는 것이 울진식 겨울 보양의 정석입니다.

순서는 바다가 먼저입니다. 후포항은 울진대게의 집산지라, 대게철인 겨울이면 위판장과 대게 골목이 가장 바쁜 계절을 맞습니다. 해마다 이맘때를 겨냥해 울진대게와 붉은대게 축제가 열리는 것도 이 항구의 겨울이 곧 대게이기 때문입니다. 쪄낸 다리를 하나씩 비우다 보면 창밖의 겨울 바다가 반찬이 됩니다.

배를 채웠으면 산 쪽으로 20분. 백암온천의 53도 유황천이 두 번째 김을 맡습니다. 물이 부드럽기로 오래 이름난 탕이라, 찬 바닷바람에 굳은 몸이 매끄러운 물속에서 풀립니다. 대게로 속을 데우고 유황천으로 겉을 데우면, 겨울이라는 계절에게 진 빚이 없어집니다.

숙소를 온천 지구에 잡으면 다음 날 아침 한 번 더 탕에 들어갈 수 있습니다. 아침 식사는 지구 내 동광식당의 백반이나 큰맘할매순대국으로 소박하게. 동해선 평해역에서 백암행 버스로 20분이라 기차 여행으로도 짜임이 나옵니다. 온천과 대게찜이 유혹하는 겨울 보양 여행 — 관광공사 기사 제목 그대로의 동네입니다.','47',4,'2026-04-30 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='대게 찌는 김, 유황탕의 김');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='대게 찌는 김, 유황탕의 김' AND source='MANUAL' AND name='백암온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','78도. 겨울이 이기지 못하는 숫자','국내 최고 수온 부곡온천에서 보내는 한파 주말','/img/magazine/153.jpg','78. 부곡온천의 원수 온도예요. 국내 온천 중 가장 뜨거운 물이 솟는 동네라, 탕에 쓰는 물은 식혀서 받아야 할 정도예요. 한파주의보가 뜬 주말일수록 이 숫자는 설득력이 커져요.

창녕 부곡면은 한 시절 대한민국 신혼여행의 수도였어요. 부곡하와이라는 이름을 기억하는 세대에게 이 동네는 워터파크와 온천의 원조 성지였고, 2017년 그곳이 문을 닫은 뒤에도 온천은 그대로 남았어요. 유황 성분을 품은 78도의 물은 유행과 무관하게 계속 솟고 있으니까요.

[QUOTE]놀이공원은 문을 닫아도, 땅속의 보일러는 끄는 법이 없다.

겨울 부곡의 사용법은 단순해요. 온천중앙로 주변 숙소에 짐을 풀고, 탕과 밥 사이를 오가는 것. 온천 단지 중심가에 한정식과 보양식 집들이 모여 있어서 동선이 짧아요. 송이네 밥상의 한정식으로 점잖게 시작해도 되고, 한우곱창 오색그린 부곡본점의 곱창전골로 화끈하게 가도 돼요. 생선구이에 돌솥밥을 내는 집도 있고요.

부산서부터미널에서 시외버스로 1시간이면 닿아서, 경남권 뚜벅이에게는 겨울 당일 온천으로도 계산이 서요. 화려한 관광지를 기대하면 심심할 수 있지만, 겨울 온천의 본질 — 뜨거운 물, 따뜻한 밥, 이른 잠 — 만 남긴 동네라고 생각하면 이보다 충실한 곳도 드물어요.','48',4,'2026-05-01 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='78도. 겨울이 이기지 못하는 숫자');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='78도. 겨울이 이기지 못하는 숫자' AND source='MANUAL' AND name='부곡온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','1호선 끝에서 장날을 만나면','온양온천 — 환승 없이 닿는 겨울 온천과 4·9일의 풍물5일장','/img/magazine/154.jpg','서울에서 환승 없이 온천에 갈 수 있다는 사실은 매번 새삼스럽습니다. 지하철 1호선의 남쪽 끝자락, 온양온천역. 개찰구에서 온천 지구까지 도보 10분입니다.

겨울의 온양은 날짜를 맞춰 가면 두 배가 됩니다. 끝자리 4일과 9일, 온양온천역 앞에 풍물5일장이 서는 날입니다. 역 광장 일대로 좌판이 펼쳐지는 이 장은 전국에서도 규모로 이름난 5일장이라, 겨울이면 어물전의 생선과 김이 오르는 먹거리 골목이 추위를 밀어냅니다. 상설로 열리는 온양온천전통시장도 붙어 있어서, 장날이 아니어도 먹거리 동선은 성립합니다.

장을 한 바퀴 돌아 몸이 식었을 때가 입탕 시각입니다. 온양의 물은 57도 알칼리성. 피부가 매끈해지는 물이라는 평가가 이 온천의 오래된 간판입니다. 세종을 비롯한 조선 임금들의 행궁이 있던 자리라는 역사까지 겹치면, 1,350원짜리 지하철 여정의 끝치고는 도착지가 과분합니다.

[IMG]온양온천역 앞 5일장, 어물전 좌판 위로 입김이 섞인다. ⓒ 물멍

돌아오는 전철에서는 대개 잠듭니다. 뜨거운 물에 불린 몸으로 흔들리는 겨울 전철만큼 잠이 잘 오는 곳도 없으니까요. 종점에서 종점으로, 가장 값싸고 확실한 겨울 반신욕 출장입니다.','44',4,'2026-05-03 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='1호선 끝에서 장날을 만나면');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='1호선 끝에서 장날을 만나면' AND source='MANUAL' AND name='온양온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','새벽엔 망원경, 오후엔 55도','주남저수지 철새와 마금산온천 — 창원 북면의 겨울 편성','/img/magazine/155.jpg','겨울 주남저수지의 하루는 해뜰녘에 절정이에요. 밤새 저수지에서 잔 철새들이 일제히 날아오르는 시간. 재두루미가 목을 길게 빼고 활주하듯 이륙하는 장면은, 망원경 없이 맨눈으로도 심장이 빨라져요.

주남저수지는 겨울마다 철새들이 내려앉는 남녘의 대표 도래지예요. 탐조는 새들이 예민하지 않도록 둑 위에서 조용히, 망원경이나 카메라 줌으로. 겨울 탐조의 유일한 단점은 추위인데, 창원 북면에는 그 단점을 정확히 상쇄하는 시설이 있어요.

마금산온천. 경남 최초로 국민보양온천으로 지정된 곳이라, 주남저수지와 마금산온천을 묶은 코스는 한국관광공사 여행기사로 소개될 만큼 공인된 겨울 동선이에요. 물은 55도 염화나트륨천 — 한 마디로 진해요. 새벽 탐조로 곱은 손가락이 탕 속에서 펴지는 데 오 분이 안 걸려요.

허기는 온천 단지 인근에서 해결해요. 토종 한우를 정육코너에서 직접 골라 굽는 황우장사가 이 동네의 이름난 집이고, 해장국과 냉면을 같이 하는 김박사명품해장국&냉면도 온천 지역 맛집으로 꼽혀요. 새벽의 새, 오후의 탕, 저녁의 한우. 마산역에서 북면행 버스로 40분 거리에서 완성되는, 겨울에만 열리는 편성표예요.','48',4,'2026-05-04 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='새벽엔 망원경, 오후엔 55도');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='새벽엔 망원경, 오후엔 55도' AND source='MANUAL' AND name='마금산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','꿩 샤브가 끓는 동안 눈이 왔다','겨울 수안보 — 온천 마을의 보양 코스 사용설명서','/img/magazine/156.jpg','겨울 수안보의 저녁 식탁에는 다른 동네에 없는 새가 오릅니다. 꿩입니다. 이 온천 마을은 전국에서 드문 꿩요리 특화 지구라, 겨울 보양이라는 말이 이곳에서는 관용구가 아니라 차림표입니다.

코스는 대개 이렇게 흘러갑니다. ① 얇게 저민 꿩고기를 끓는 육수에 스치듯 데치는 꿩 샤브 ② 꿩고기를 다져 빚은 꿩만두 ③ 마지막 죽까지. 대장군식당이 수안보 꿩 코스의 대표 주자로 꼽히고, 삿갓촌은 여덟 가지 요리로 코스를 늘려 냅니다. 장군식당, 감나무집 같은 꿩요리 집들이 한 동네에 모여 있는 풍경 자체가 전국적으로 드뭅니다.

식탁의 온도를 담당하는 것이 꿩이라면, 몸의 온도는 물이 맡습니다. 지하 250미터 암반에서 53도로 솟는 알칼리성 온천수는 조선 임금들이 찾았다는 기록 때문에 왕의 물이라 불립니다. 관절과 피로 회복에 좋다는 평판으로 수백 년을 버틴 물이라, 겨울 여행의 마디마디 — 도착 직후, 저녁 식사 전, 다음 날 아침 — 세 번쯤 담그는 것이 이 동네의 표준 사용법입니다.

눈이 오면 모든 것이 절반씩 느려지고 두 배씩 좋아집니다. KTX 충주역에서 246번 버스로 25분. 꿩 코스가 끓는 동안 창밖에 눈이 쌓이기 시작하면, 그 겨울 여행은 이미 성공입니다.','43',4,'2026-05-06 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='꿩 샤브가 끓는 동안 눈이 왔다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='꿩 샤브가 끓는 동안 눈이 왔다' AND source='MANUAL' AND name='수안보온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','산사의 겨울, 호수의 밤, 45도의 사이','수덕사와 예당호 사이에 덕산온천이 있다','/img/magazine/157.jpg','겨울 수덕사는 소리가 줄어든 절이에요. 낙엽이 지고 관광객이 줄어든 덕숭산 자락에 풍경 소리와 눈 밟는 소리만 남아요. 고려 때 지어진 대웅전 — 국내에서 손꼽히게 오래된 목조건물 — 앞마당에 서면, 겨울이 절에는 오히려 어울리는 계절이라는 생각이 들어요.

덕산온천은 이 절의 아랫동네예요. 절 구경하고 몸 풀기, 라는 코스가 자연스럽게 성립하는 지형. 물은 45도 중탄산나트륨천이라 부드럽게 뜨겁고, 겨울 산사의 찬 공기를 쐰 뒤라면 그 온도가 더 정확하게 느껴져요.

해가 지면 예당호로 가요. 저수지 위로 402미터를 가로지르는 예당호 출렁다리는 밤이 되면 LED 조명이 들어와서, 겨울 호수의 어둠 위에 빛의 다리가 떠요. 낮의 산사와 밤의 호수 — 예산의 겨울은 명암 대비가 확실한 동네예요.

[IMG]눈 내린 수덕사 대웅전 처마, 풍경이 얼어붙은 듯 멈춰 있다. ⓒ 물멍

밥은 갈비로 정해져 있어요. 예산은 숯불 소갈비의 고장이라 소복갈비, 대복갈비 같은 갈비 노포들이 덕산 온천 단지 주변에 모여 있어요. 삽다리곱창이라는 또 다른 명물도 있고요. 예산역에서 덕산행 버스로 30분. 절, 탕, 갈비, 호수의 순서만 지키면 실패가 어려운 겨울 하루예요.','44',4,'2026-05-07 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='산사의 겨울, 호수의 밤, 45도의 사이');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='산사의 겨울, 호수의 밤, 45도의 사이' AND source='MANUAL' AND name='덕산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','퇴근길에 온천이 가능한 도시','겨울 유성 — 도심 한복판의 라듐천과 칼국수의 도시','/img/magazine/158.jpg','온천에 가려고 꼭 산골로 가야 할까요. 대전 유성은 그 질문에 가장 오래 반박해온 도시입니다.

유성온천은 호텔과 아파트 사이에서 솟는 도심 온천입니다. 물은 53도의 라듐 단순천. 근육통과 신경통 완화로 이름을 얻은 물이라, 겨울이면 어깨가 굳은 사람들이 가장 정직한 이유로 모여듭니다. KTX 대전역에서 급행2번 버스로 20분이면 온천 지구라, 출장길에 슬쩍 끼워 넣는 온천욕이 실제로 가능한 몇 안 되는 동네입니다.

유성온천공원에는 온천수를 흘려보내는 야외 족욕체험장이 조성되어 있습니다. 39도 안팎의 온천수에 발만 담그는 무료 시설인데, 신발과 양말을 벗는 수고만으로 온천 도시의 물을 검증할 수 있는 셈입니다. 노천 시설이라 운영은 계절을 타니, 겨울에는 문을 열었는지 확인하고 가는 편이 안전합니다.

탕에서 나온 뒤의 식사는 이 도시의 다른 명물이 잇습니다. 대전은 칼국수의 도시라 불릴 만큼 칼국수 집이 많은 동네입니다. 유성 쪽에는 지역 뉴스에 소개된 온천손칼국수 같은 집이 있고, 시내로 나가면 대전 3대 노포로 꼽히는 오씨칼국수, 두부두루치기의 진로집까지 사정권입니다. 뜨거운 탕, 뜨거운 면. 겨울 유성의 공식은 두 줄이면 충분합니다.','30',4,'2026-05-09 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='퇴근길에 온천이 가능한 도시');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='퇴근길에 온천이 가능한 도시' AND source='MANUAL' AND name='유성온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','62도 식염천에서 곰장어 골목까지, 온천장역 도보 8분','겨울 부산 동래 — 허심청의 탕과 곰장어 골목의 연탄 연기, 반나절이면 충분','/img/magazine/159.jpg','겨울 평일 오전, 허심청의 탕에는 부산 어르신들이 먼저 와 있어요. 동양 최대 규모로 불리는 동래온천장의 대형 스파. 수십 종의 탕이 층을 이루는 실내에서 62도로 솟는 식염천 원수가 온도별로 나뉘어 손님을 받아요. 관람석 없이 부산의 목욕 문화 한가운데 앉게 되는 것, 그게 이 온천의 진짜 콘텐츠예요.

물부터 다른 물이에요. 동래의 온천수는 조선시대 기록부터 등장하는 부산 원조 온천수. 식염천이라 물에 짠 기운이 돌고, 그래서 몸이 오래 따뜻해요. 바닷바람 부는 부산의 겨울에 이 보온력은 관광이 아니라 실용이에요.

[IMG]온천장 곰장어골목, 연탄불 위에서 굽히는 곰장어와 골목을 채운 연기. ⓒ 물멍

탕에서 나오면 곰장어 골목이에요. 45년 전통의 원조 소문난 산곰장어를 비롯해 짚불과 양념으로 곰장어를 굽는 집들이 온천장에 모여 있어요. 연탄불 위에서 꿈틀대는 곰장어에 소주 한 잔이면, 이 동네가 왜 목욕과 술안주의 도시인지 설명이 끝나요. 파전이 당기는 날엔 4대째의 동래할매파전으로 방향을 틀면 되고요.

[QUOTE]62도 식염천으로 데운 몸을, 연탄불 곰장어로 한 번 더 데운다.

지하철 1호선 온천장역에서 도보 8분. 부산역에서 지하철 한 번이면 닿아요. 숙박 없이도, 자차 없이도, 눈 없이도 성립하는 겨울 온천이에요.

이번 겨울 부산 일정에 반나절만 비워 두세요. 목욕 가방 대신 캐리어를 끌고 온천장역에 내리면 돼요.','26',4,'2026-05-10 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='62도 식염천에서 곰장어 골목까지, 온천장역 도보 8분');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='62도 식염천에서 곰장어 골목까지, 온천장역 도보 8분' AND source='MANUAL' AND name='동래온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'SEASONAL','발안IC에서 10분, 29도 유황 원수탕과 다섯 시 전의 낙조','화성 율암온천과 궁평항 — 서울에서 한 시간, 숙박 없는 겨울 반나절','/img/magazine/160.jpg','서해안고속도로 발안IC를 빠져나와 10분. 서울에서 출발했다면 한 시간 남짓 만에 유황천 앞입니다. 겨울 온천 여행의 가장 큰 장벽은 거리인데, 화성 팔탄면의 율암온천은 그 장벽을 처음부터 치워 놓은 경우입니다.

물은 수온 29도의 유황천입니다. 원수가 미지근한 대신 유황의 매끄러움이 뚜렷해서, 데운 탕과 원수탕을 오가며 피부로 비교하는 재미가 있습니다. 숙박 시설을 낀 대형 온천 단지가 아니라 당일치기에 맞춰진 온천이라는 점이 오히려 정체성입니다. 짐도, 예약도, 휴가도 필요 없습니다.

[IMG]궁평항 피싱피어 너머로 내려앉는 겨울 해. ⓒ 물멍

탕에서 나온 오후의 방향은 서쪽입니다. 차로 서해 쪽으로 달리면 궁평항, 화성 8경에 드는 낙조 포인트입니다. 겨울 해는 일찍 지므로 오후 다섯 시 전에는 방파제에 서 있어야 합니다. 겨울 서해는 여름보다 공기가 맑아 낙조의 색이 진합니다. 제부도와 궁평항을 잇는 17킬로미터 황금해안길이 열리면서 해안 산책 동선도 길어졌습니다.

허기는 온천 주변의 보양식이 맡습니다. 서해정의 백숙과 삼계탕은 온천욕 후 방문객들에게 오래 사랑받아 왔고, 빠가사리 매운탕을 내는 시골민물매운탕은 얼큰한 쪽을 원하는 일행의 답입니다.

[QUOTE]29도 유황탕, 백숙 한 상, 다섯 시 전의 낙조. 반나절이면 다 들어간다.

유황탕, 백숙, 낙조. 반나절짜리 겨울 코스의 밀도로는 수도권 최상급입니다. 토요일 오전에 발안IC로 나가십시오. 저녁엔 이미 집입니다.','41',4,'2026-05-12 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='발안IC에서 10분, 29도 유황 원수탕과 다섯 시 전의 낙조');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='발안IC에서 10분, 29도 유황 원수탕과 다섯 시 전의 낙조' AND source='MOIS' AND external_id='69' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'ONSEN_SCIENCE','달걀 냄새가 반가워지는 순간, 유황천','부곡의 김 속에서 코가 먼저 배우는 화학','/img/magazine/161.jpg','탕에 들어가기 전에 냄새가 먼저 옵니다. 삶은 달걀 흰자 근처에서 나는 그 냄새, 황화수소입니다. 유황천의 서명 같은 것이라 이 냄새가 나면 물을 의심할 필요가 없습니다.

유황 성분은 물속에서 피부 표면의 단백질과 반응합니다. 각질층의 결합을 느슨하게 풀어주기 때문에 탕에서 나온 뒤 피부를 만지면 한 꺼풀 벗겨낸 듯 매끈한 느낌이 남습니다. 예부터 유황천이 피부에 좋다고 이야기돼 온 배경에는 이런 화학이 있습니다.

[IMG]부곡온천 노천탕 수면 위로 아침 김이 오르는 장면. ⓒ 물멍

경남 창녕의 부곡온천은 최고 수온 78℃를 기록하는 국내에서 가장 뜨거운 온천이면서 유황 성분이 많은 곳으로 알려져 있습니다. 충남의 도고온천, 경북의 백암온천도 유황계로 분류됩니다. 같은 유황천이라도 농도와 수온이 달라 체감은 제각각입니다.

이용 팁 두 가지. 첫째, 은반지나 은목걸이는 탈의실에 두고 들어가세요. 유황과 반응해 거뭇하게 변색됩니다. 둘째, 탕에서 나온 뒤 몸을 너무 박박 씻어내지 마세요. 성분을 어느 정도 남겨두는 편이 유황천을 제대로 쓰는 방법입니다.','48',4,'2026-05-13 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='달걀 냄새가 반가워지는 순간, 유황천');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='달걀 냄새가 반가워지는 순간, 유황천' AND source='MANUAL' AND name='부곡온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,1 FROM magazines m, places p WHERE m.title='달걀 냄새가 반가워지는 순간, 유황천' AND source='MANUAL' AND name='도고온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,2 FROM magazines m, places p WHERE m.title='달걀 냄새가 반가워지는 순간, 유황천' AND source='MANUAL' AND name='백암온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'ONSEN_SCIENCE','몸에 기포가 붙는 물, 탄산천 관찰기','가조에서 팔뚝을 들여다본 15분','/img/magazine/162.jpg','탕에 팔을 담그고 1분쯤 지났을 때였어요. 팔뚝의 솜털을 따라 좁쌀 같은 기포가 줄지어 맺히기 시작했습니다. 손으로 쓸면 사이다 잔을 흔든 것처럼 우수수 떨어져 올라가고, 가만히 있으면 다시 맺혀요. 탄산천에서만 볼 수 있는 장면입니다.

원리는 단순합니다. 물속에 녹아 있던 이산화탄소가 피부라는 표면을 만나 기체로 돌아오는 것. 이 기포가 피부에 닿으면 말초혈관이 확장됩니다. 그래서 탄산천은 수온이 미지근해도 몸이 금방 발그레해지고, 나온 뒤에도 온기가 오래 갑니다.

[QUOTE]탄산천의 실력은 뜨거움이 아니라 미지근함에서 나온다.

경남 거창의 가조온천이 탄산계로 분류되는 대표적인 곳이에요. 탄산천에서는 뜨거운 탕만 찾는 습관을 잠시 접어두세요. 이산화탄소는 온도가 높을수록 물에서 빨리 날아가 버리니까, 오히려 미지근한 원탕 쪽이 성분은 진합니다.

팁 하나. 기포가 잘 안 보인다면 몸을 문지르지 말고 3분만 가만히 있어 보세요. 움직일수록 기포는 맺히기 전에 떨어져 나갑니다. 탄산천은 정지해 있는 사람에게 먼저 말을 거는 물입니다.','48',4,'2026-05-15 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='몸에 기포가 붙는 물, 탄산천 관찰기');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='몸에 기포가 붙는 물, 탄산천 관찰기' AND source='MANUAL' AND name='가조온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'ONSEN_SCIENCE','비누도 안 탔는데 물이 미끌거리는 이유, pH','수안보·온양·오색의 촉감을 pH로 풀어 본 알칼리성 온천 문답','/img/magazine/163.jpg','탕에 들어간 손이 손을 스치는데, 비누를 만진 것처럼 미끄러집니다. 수안보나 온양의 탕에서 처음 겪는 사람이 한 번씩 묻는 질문이 있습니다. "뭘 탄 건가요?"

Q. 뭘 탄 건가요?
A. 아무것도 안 탔습니다. pH가 높은 알칼리성 온천수의 원래 촉감이에요. 알칼리성 물은 피부 표면의 오래된 각질과 피지를 아주 살짝 녹입니다. 그 녹은 층이 손끝과 피부 사이에서 미끄러지는 것이 그 감촉의 정체입니다.

Q. 그럼 피부가 상하는 건 아닌가요?
A. 온천수 수준의 알칼리는 세정제보다 훨씬 순합니다. 다만 원리상 ''천연 필링''에 가깝기 때문에 탕에서 나온 뒤에는 피부가 평소보다 건조해지기 쉬워요. 알칼리성 온천일수록 입욕 후 보습을 챙기라는 말이 나오는 이유입니다.

[IMG]탕 안에서 팔 안쪽으로 물을 쓸어 보는 손. ⓒ 물멍

Q. 어디서 경험할 수 있나요?
A. 충주의 수안보온천, 아산의 온양온천, 양양의 오색온천이 알칼리성으로 분류되는 대표적인 곳입니다. 특히 온양온천은 수도권에서 지하철 1호선으로 닿기 때문에 알칼리성 온천 입문용으로 자주 언급돼요.

Q. 미끌거림이 안 느껴지면 가짜인가요?
A. 그렇지는 않아요. 같은 원탕이라도 그날의 희석 정도, 내 피부 상태에 따라 체감은 달라집니다. 손등보다 각질이 얇은 팔 안쪽으로 물을 쓸어 보면 차이가 더 잘 느껴집니다.

[QUOTE]미끌거림의 정체는 첨가물이 아니라 pH다.

다음에 알칼리성 탕에 들어가면 손등 말고 팔 안쪽부터 쓸어 보세요. 그리고 나와서는 로션을 바르세요. 이 문답의 결론은 그 두 동작입니다.','43',4,'2026-05-16 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='비누도 안 탔는데 물이 미끌거리는 이유, pH');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='비누도 안 탔는데 물이 미끌거리는 이유, pH' AND source='MANUAL' AND name='수안보온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,1 FROM magazines m, places p WHERE m.title='비누도 안 탔는데 물이 미끌거리는 이유, pH' AND source='MANUAL' AND name='온양온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,2 FROM magazines m, places p WHERE m.title='비누도 안 탔는데 물이 미끌거리는 이유, pH' AND source='MANUAL' AND name='오색온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'ONSEN_SCIENCE','짭짤한 물이 이불이 되는 원리, 식염천','염화나트륨천의 보온 메커니즘','/img/magazine/164.jpg','탕에서 나와 10분이 지났는데도 등이 후끈합니다. 식염천, 그러니까 염화나트륨 성분이 많은 온천의 전형적인 뒷맛이에요.

원리는 피부 위에서 일어납니다. 물속의 염분이 피부 표면의 단백질과 만나 아주 얇은 막을 만들어요. 이 막이 땀의 증발을 늦춥니다. 몸의 열은 대부분 수분이 증발하면서 빠져나가는데, 그 출구를 소금막이 반쯤 닫아버리는 겁니다. 온천 애호가들이 식염천을 ''열의 이불''이라고 부르는 이유예요.

[IMG]마금산온천 탕 가장자리, 증발한 물이 남긴 하얀 염분 자국. ⓒ 물멍

창원의 마금산온천이 염화나트륨천으로 분류되고, 부산의 동래온천과 해운대온천도 식염계로 묶입니다. 바다를 낀 부산의 두 온천은 목욕 문화가 오래 쌓인 동네라, 식염천의 온기를 노포 목욕탕의 공기와 함께 경험할 수 있어요.

이용 팁. 식염천은 보온력이 좋은 만큼 탕 안에서 체온이 빨리 오릅니다. 다른 수질보다 입욕 시간을 조금 짧게 잡고, 나와서 이불 효과를 누리는 쪽이 현명해요. 겨울밤, 숙소까지 걸어가야 하는 뚜벅이에게 특히 고마운 물입니다.','48',4,'2026-05-18 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='짭짤한 물이 이불이 되는 원리, 식염천');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='짭짤한 물이 이불이 되는 원리, 식염천' AND source='MANUAL' AND name='마금산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,1 FROM magazines m, places p WHERE m.title='짭짤한 물이 이불이 되는 원리, 식염천' AND source='MANUAL' AND name='동래온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,2 FROM magazines m, places p WHERE m.title='짭짤한 물이 이불이 되는 원리, 식염천' AND source='MANUAL' AND name='해운대온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'ONSEN_SCIENCE','''게르마늄''이라는 단어를 지워도 지리산온천에 갈 이유','확인된 것 둘, 확인 안 된 것 하나 — 게르마늄 온천 팩트체크','/img/magazine/165.jpg','"게르마늄 온천, 만병에 좋습니다." 온천 간판과 광고에서 이 문장을 본 사람이 많을 겁니다. 게르마늄만큼 광고 문구가 성분보다 앞서가는 원소도 드뭅니다. 그래서 오늘은 확인된 것과 아닌 것을 세 칸으로 나눕니다.

확인된 것 ①. 게르마늄은 실재하는 원소이고, 일부 온천수에는 미량이 녹아 있습니다. 전남 구례의 지리산온천과 화순의 화순온천이 게르마늄 성분으로 분류되는 대표적인 곳입니다.

확인된 것 ②. 이 온천들의 물 자체는 좋은 온천수입니다. 수온, 용출량, 목욕 후의 개운함은 게르마늄이라는 단어와 무관하게 성립해요. 간판에서 원소 이름을 지워도 물은 그대로입니다.

[IMG]지리산온천 탕에서 김이 오르는 수면. ⓒ 물멍

확인 안 된 것. ''게르마늄이 만병을 다스린다''류의 주장입니다. 게르마늄 입욕의 의학적 효과는 아직 엄밀하게 입증된 단계가 아니에요. 먹는 게르마늄 보조제는 오히려 안전성 논란이 있었던 이력도 있습니다. 물에 몸을 담그는 것과 성분을 섭취하는 것은 전혀 다른 문제라는 점만 기억하면 됩니다.

[QUOTE]온천의 실력은 원소 이름이 아니라 물 그 자체에 있다.

그러니 게르마늄 온천에 갈 이유는 충분하되, 그 이유가 꼭 게르마늄일 필요는 없습니다. 지리산 자락의 공기, 따뜻한 물, 목욕 뒤의 노곤함. 그것만으로 남는 장사예요. 간판 대신 물을 보고 고르십시오.','46',4,'2026-05-19 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='''게르마늄''이라는 단어를 지워도 지리산온천에 갈 이유');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='''게르마늄''이라는 단어를 지워도 지리산온천에 갈 이유' AND source='MANUAL' AND name='지리산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,1 FROM magazines m, places p WHERE m.title='''게르마늄''이라는 단어를 지워도 지리산온천에 갈 이유' AND source='MANUAL' AND name='화순온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'ONSEN_SCIENCE','때를 먼저 밀지 마라 — 중탄산 이온이 일하는 15분','울진 덕구온천과 예산 덕산온천, ''부드럽다''에 붙는 화학식 HCO3-','/img/magazine/166.jpg','''물이 부드러워요.'' 온천 후기에서 가장 자주 나오고, 가장 설명이 안 되는 다섯 글자입니다. 중탄산천에서는 이 다섯 글자 뒤에 화학식이 붙어요. HCO3-, 중탄산 이온.

이 이온은 피부 표면의 피지, 그러니까 기름기와 만나면 그것을 살짝 유화시킵니다. 비누가 하는 일을 아주 약하게, 대신 탕에 잠긴 전신에서 동시에 하는 셈이에요. 그래서 중탄산천에서 나오면 씻어낸 것도 없는데 몸이 가벼워진 느낌이 듭니다.

이 이온을 가진 온천이 이름까지 닮은 두 곳에 있어요. 경북 울진의 덕구온천은 중탄산천, 충남 예산의 덕산온천은 중탄산나트륨계. 덕구는 동해안 쪽 산자락, 덕산은 내포 평야 쪽이라 가는 길의 풍경은 정반대인데, 탕에 들어가면 같은 이온이 같은 일을 합니다.

[IMG]덕구온천 탕 수면 위로 오르는 김. 부드러움의 정체는 HCO3-다. ⓒ 물멍

이용 팁은 성분이 아니라 순서에 있습니다. 중탄산천에서는 때를 먼저 밀지 마세요. 물이 각질과 피지를 불려 주는 시간을 15분쯤 준 다음, 가볍게 씻는 편이 피부에 훨씬 순합니다. 유화라는 화학이 일할 시간을 주는 겁니다.

[QUOTE]부드러움은 성분이 절반, 순서가 절반이다.

다음에 덕구나 덕산에 간다면 때수건은 탕 밖에 두고 들어가세요. 15분 뒤에 꺼내도 늦지 않습니다.','47',4,'2026-05-21 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='때를 먼저 밀지 마라 — 중탄산 이온이 일하는 15분');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='때를 먼저 밀지 마라 — 중탄산 이온이 일하는 15분' AND source='MANUAL' AND name='덕구온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,1 FROM magazines m, places p WHERE m.title='때를 먼저 밀지 마라 — 중탄산 이온이 일하는 15분' AND source='MANUAL' AND name='덕산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'ONSEN_SCIENCE','성분표 첫 두 글자, Na냐 Ca냐 — 문경온천의 뽀득함','나트륨파와 칼슘파, 온천수 두 계보를 한 줄로 외우는 법','/img/magazine/167.jpg','Na, 아니면 Ca. 온천 성분표의 첫 두 글자가 그날 탕의 촉감을 미리 알려 줍니다. 온천수의 계보는 크게 이 둘로 갈려요. 나트륨이 이끄는 물과 칼슘이 이끄는 물.

나트륨(Na)계는 식염천, 중탄산나트륨천처럼 미끌거리거나 보온이 강한 쪽이에요. 앞서 다룬 계보입니다.

칼슘(Ca)계는 성격이 다릅니다. 칼슘 이온은 피부 표면에서 진정 작용을 하는 쪽으로 알려져 있고, 촉감도 미끌거림보다 담백하고 단단한 느낌에 가까워요. 목욕 후 피부가 뽀득거리는 쪽을 좋아하는 사람이라면 칼슘계가 취향일 확률이 높습니다.

경북 문경의 문경온천이 칼슘중탄산계로 분류되는 대표적인 곳입니다. 칼슘과 중탄산이 한 물에 있으니, 중탄산의 순한 세정력과 칼슘의 담백한 촉감을 한 탕에서 동시에 겪는 셈이에요.

[IMG]문경온천 실내탕 창으로 들어온 오후 빛이 수면에 부서지는 순간. ⓒ 물멍

외우는 건 한 줄이면 됩니다. Na로 시작하면 미끌·후끈 계열, Ca로 시작하면 담백·진정 계열. 이 한 줄만 들고 가도 탕에 몸을 넣는 순간 ''아, 이래서''라는 말이 절로 나와요.

[QUOTE]온천을 두 배로 즐기는 가장 값싼 방법은 성분표를 읽는 습관이다.

다음 온천에서는 입구에 붙은 성분표를 그냥 지나치지 말고, 첫 두 글자만 읽고 들어가세요.','47',4,'2026-05-22 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='성분표 첫 두 글자, Na냐 Ca냐 — 문경온천의 뽀득함');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='성분표 첫 두 글자, Na냐 Ca냐 — 문경온천의 뽀득함' AND source='MANUAL' AND name='문경온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'ONSEN_SCIENCE','라듐이라는 이름에 놀라지 않아도 되는 이유','유성온천과 단순천의 재발견','/img/magazine/168.jpg','성분표에서 ''라듐''이라는 글자를 보고 멈칫한 적 있으신가요. 대전 유성온천이 라듐 성분을 포함한 단순천으로 분류된다는 이야기를 들으면 더 그렇습니다.

먼저 안심할 것. 온천수의 라듐·라돈은 극미량이고, 온천 목욕이라는 이용 방식에서 문제 삼을 수준이 아닙니다. 오히려 20세기 초 유럽과 일본에서는 미량 방사능천을 요양 목적으로 찾아다녔고, 지금도 라돈천 요양 문화가 남아 있는 지역이 있어요. 여기서 어떤 효능을 단정할 생각은 없습니다. 다만 ''라듐=위험한 물''이라는 등식은 온천의 맥락에서는 성립하지 않는다는 것만 분명히 해두죠.

다음으로 ''단순천''이라는 분류. 이름 때문에 밋밋한 물로 오해받지만, 단순천은 특정 성분이 기준치를 넘지 않는 순한 물이라는 뜻입니다. 자극이 적으니 피부가 예민한 사람, 어린이, 어르신, 그리고 긴 목욕을 좋아하는 사람에게 오히려 유리해요.

[QUOTE]단순천의 ''단순''은 결핍이 아니라 관용이다.

유성은 대전 도심에서 바로 닿는 온천이라 접근성으로도 단순천의 미덕과 닮았습니다. 문턱이 낮은 물. 온천 여행의 첫 페이지로 이만한 곳이 없습니다.','30',4,'2026-05-24 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='라듐이라는 이름에 놀라지 않아도 되는 이유');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='라듐이라는 이름에 놀라지 않아도 되는 이유' AND source='MANUAL' AND name='유성온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'ONSEN_SCIENCE','타이머 들고 해본 반신욕 20분','명치 아래만 담그는 목욕의 기록','/img/magazine/169.jpg','타이머를 20분에 맞추고 명치 아래까지만 물에 담갔습니다. 어깨는 공기 중에. 처음 3분은 솔직히 심심했어요. 전신욕의 확 감기는 맛이 없으니까요.

5분. 다리와 허리에서 올라온 열이 상체로 번지기 시작합니다. 어깨는 물 밖인데 이마에 땀이 맺혀요. 반신욕의 핵심이 여기 있습니다. 심장과 폐가 물의 압력을 받지 않으니 부담은 적고, 하체에서 데워진 혈액이 온몸을 돌며 열을 배달하는 구조.

10분. 땀이 본격적으로 흐릅니다. 전신욕이었다면 슬슬 어지러울 시점인데, 상체가 시원하니 버틸 만해요. 물 온도는 38~40℃ 정도의 미지근한 쪽이 정석입니다. 뜨거운 물로 하면 반신욕의 장점이 사라져요.

15분. 머릿속이 한가해집니다. 스마트폰 없이 15분을 버틴 게 얼마 만인지.

20분. 타이머가 울렸고, 일어서는데 무릎 아래가 가뿐했습니다.

기록을 요약하면 이렇습니다. 반신욕은 미지근한 물, 명치 아래, 20분 안팎이라는 세 가지 조건이 맞을 때 완성되는 목욕법이에요. 셋 중 하나라도 욕심을 내면(뜨겁게, 어깨까지, 더 오래) 그냥 힘든 전신욕이 됩니다. 절제가 기술인 목욕입니다.',NULL,4,'2026-05-25 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='타이머 들고 해본 반신욕 20분');
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'ONSEN_SCIENCE','온냉교대욕 입문: 혈관 체조의 순서','뜨거움과 차가움을 오가는 데도 절차가 있다','/img/magazine/170.jpg','온탕과 냉탕을 오가는 목욕법을 ''혈관 체조''라고 부르곤 해요. 뜨거우면 혈관이 넓어지고 차가우면 좁아지니, 이 왕복 자체가 혈관의 수축·이완 운동이 된다는 발상입니다. 다만 순서 없이 하면 체조가 아니라 충격이 돼요. 절차를 정리합니다.

① 온탕 3~5분. 몸의 심부까지 데운다는 느낌으로. 어깨까지 담가도 좋아요.

② 냉탕 30초~1분. 심장에서 먼 발끝, 손끝부터 천천히 들어갑니다. 머리까지 담글 필요는 없어요. 호흡이 가빠지면 바로 나옵니다.

③ 휴식 2~3분. 이 단계를 건너뛰는 사람이 가장 많은데, 사실 여기가 본편이에요. 앉아서 몸이 스스로 온도를 찾아가는 걸 기다립니다.

④ ①~③을 2~3회 반복. 마지막은 냉탕이 아니라 휴식으로 끝냅니다.

주의사항도 절차의 일부입니다. 심혈관 질환이 있거나 혈압이 높은 사람에게는 급격한 온도차 자체가 부담이라 권하지 않아요. 음주 후는 말할 것도 없고요. 그리고 냉탕 입수의 목표는 ''오래 버티기''가 아닙니다. 혈관에 신호를 주는 데는 짧은 시간이면 충분해요. 참을성 자랑은 밖에서 하고, 탕 안에서는 순서를 지키는 사람이 이깁니다.',NULL,4,'2026-05-26 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='온냉교대욕 입문: 혈관 체조의 순서');
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'ONSEN_SCIENCE','들어가기 전 한 컵, 나와서 한 컵 — 사우나 수분 장부 쓰는 법','체중계는 내려갔지만 빠진 건 물이다: 수분 보충 문답','/img/magazine/171.jpg','사우나 한 세션 뒤, 체중계 바늘이 내려가 있습니다. 좋은 소식 같지만 아닙니다. 빠져나간 건 지방이 아니라 거의 전부 물이거든요. ''사우나 다이어트''가 착시인 이유예요.

Q. 목이 마르지 않은데도 마셔야 하나요?
A. 네. 갈증은 후행 지표입니다. 목이 마르다고 느낄 때는 이미 수분이 부족해진 뒤예요. 그래서 요령은 순서를 바꾸는 것. 들어가기 전에 한 컵, 나와서 한 컵. 갈증을 기다리지 않고 일정으로 만들어 버립니다.

Q. 뭘 마시는 게 좋은가요?
A. 기본은 물이면 충분합니다. 땀을 아주 많이 흘린 날엔 이온음료가 나쁘지 않아요. 땀으로는 물만 나가는 게 아니라 나트륨 같은 전해질도 같이 나가니까요.

[IMG]탈의실 정수기 앞 종이컵 두 개. 하나는 들어가기 전, 하나는 나온 뒤. ⓒ 물멍

Q. 피해야 할 건요?
A. 술. 알코올은 이뇨 작용으로 수분을 더 내보내는 데다, 탈수 상태의 음주는 취기도 빨리 옵니다. 목욕탕 앞 생맥주의 낭만은 목욕이 다 끝난 뒤로 미뤄 두세요.

Q. 커피는요?
A. 한 잔 수준이면 크게 문제 삼지 않아도 됩니다. 다만 커피를 물 대신으로 계산하지는 마세요. 수분 장부는 물로 적는 게 원칙입니다.

[QUOTE]갈증은 알림이 아니라 연체 통지서다.

오늘 사우나 가방에 물병 하나만 더 넣으세요. 들어가기 전 한 컵, 거기서 장부가 시작됩니다.',NULL,4,'2026-05-28 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='들어가기 전 한 컵, 나와서 한 컵 — 사우나 수분 장부 쓰는 법');
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'ONSEN_SCIENCE','42℃의 물과 38℃의 물은 다른 스위치를 누른다','자율신경으로 읽는 탕 온도의 과학','/img/magazine/172.jpg','같은 온천물인데 42℃ 탕에서는 정신이 번쩍 들고, 38℃ 탕에서는 잠이 옵니다. 우연이 아니라 신경의 문제예요.

우리 몸에는 스스로 굴러가는 자율신경이 있고, 액셀 역할의 교감신경과 브레이크 역할의 부교감신경이 시소를 탑니다. 뜨거운 물, 대략 42℃ 이상은 교감신경 쪽 스위치입니다. 심박이 빨라지고 몸이 각성 모드로 전환돼요. 아침에 잠을 깨는 데는 좋지만, 밤에 들어가면 눈이 말똥말똥해지는 이유이기도 합니다.

반대로 38℃ 안팎의 미지근한 물은 부교감신경 쪽 스위치예요. 심박이 느려지고 소화기관이 움직이고 몸이 휴식 모드로 넘어갑니다. 미지근한 탕에서 하품이 나오는 건 물이 시시해서가 아니라 브레이크가 제대로 걸렸다는 신호입니다.

[QUOTE]탕의 온도를 고르는 일은 오늘 밤의 컨디션을 예약하는 일이다.

그러니 온도 선택을 시간표로 만들 수 있어요. 아침 목욕이나 낮의 재충전에는 뜨거운 탕을 짧게. 잠들기 한두 시간 전에는 미지근한 탕을 길게. 온천에 뜨거운 탕과 미지근한 탕이 나란히 있는 건 취향의 문제가 아니라, 두 개의 다른 스위치를 놓아둔 것에 가깝습니다.',NULL,4,'2026-05-29 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='42℃의 물과 38℃의 물은 다른 스위치를 누른다');
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'ONSEN_SCIENCE','옷 입기 전 30초, 온천의 매끈함이 사흘로 늘어난다','물속에서 나왔는데 피부가 당기는 이유와 보습의 순서','/img/magazine/173.jpg','방금까지 물속에 있었는데, 피부가 당깁니다.

범인은 증발이에요. 탕에서 나온 직후 피부는 물을 잔뜩 머금은 상태인데, 이 수분이 공기 중으로 날아가면서 원래 피부가 갖고 있던 수분과 유분까지 함께 끌고 나갑니다.

온천일수록 더합니다. 온천수는 각질과 피지를 부드럽게 씻어내는 성질이 있어서, 알칼리성 온천이나 유황천을 다녀온 날은 피부의 기름 장벽이 평소보다 얇아져 있어요. 좋은 목욕일수록 뒷정리가 필요한 셈입니다.

해법은 제품이 아니라 순서. 하나, 수건으로 물기를 문질러 닦지 말고 눌러 닦을 것. 둘, 피부가 아직 촉촉할 때 — 탈의실에서 옷을 입기 전에 — 로션이나 크림을 바를 것.

보습제의 역할은 수분을 새로 넣는 게 아니라 지금 있는 수분이 못 도망가게 뚜껑을 덮는 것입니다. 그래서 피부가 다 말라 버린 뒤에 바르면 효과가 반토막 나요.

[IMG]로커 문에 걸린 수건, 그 옆 선반의 작은 로션 한 통. ⓒ 물멍

[QUOTE]물멍의 여운은 사실 로션이 지킨다.

온천 여행 짐을 쌀 때 수건 옆에 작은 보습제 하나. 로커룸에서 30초면 끝나는 이 습관이 온천의 매끈함을 하루짜리에서 사흘짜리로 늘려 줍니다. 오늘 밤 짐 쌀 때 넣으세요.',NULL,4,'2026-05-31 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='옷 입기 전 30초, 온천의 매끈함이 사흘로 늘어난다');
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'ONSEN_SCIENCE','늦은 점심, 마을 한 바퀴, 해 기울 때 탕 — 식후 한 시간의 법칙','빈속도 만석도 아닌, 식사와 입욕 사이의 안전거리','/img/magazine/174.jpg','"밥 먼저요, 탕 먼저요?" 온천 마을 입구에서 가장 자주 나오는 질문입니다. 답은 둘 다 아니에요. 정확히는, 둘 다 극단은 피하라는 것.

빈속 입욕부터. 공복 상태에서는 혈당이 낮아, 뜨거운 물로 혈관이 확장되면 어지럼증이 오기 쉬워요. 아침 첫 탕을 노리는 사람이라면 바나나 한 개, 두유 한 팩 수준이라도 뭔가 넣고 들어가는 편이 안전합니다.

반대편, 식사 직후 입욕. 소화는 위장으로 혈액이 몰려야 진행되는 작업인데, 뜨거운 탕에 들어가면 혈액이 피부 쪽으로 분산됩니다. 위장 입장에서는 일하는 중에 인력을 빼앗기는 셈이라 소화가 더뎌지고 속이 더부룩해져요.

그래서 안전거리는 식사 후 한 시간. 위가 큰일을 끝냈을 때 탕에 듭니다. 온천 마을의 오후로 옮기면 순서는 이렇습니다. 늦은 점심을 천천히, 마을을 한 바퀴, 해가 기울기 시작할 때 탕. 산책이 소화와 입욕 사이의 완충재가 돼 주거든요.

[IMG]해 질 무렵 온천 마을 골목, 탕으로 향하는 사람의 뒷모습. ⓒ 물멍

술은 별도 조항입니다. 반주를 곁들였다면 그날의 탕은 과감히 다음 날 아침으로 미루세요. 알코올과 뜨거운 물의 조합은 타협의 여지가 없습니다.

[QUOTE]배부른 채로 눕는 것보다 배부른 채로 담그는 게 나을 건 없다.

다음 온천 여행, 점심 시간에 한 시간을 더한 숫자를 탕 시간으로 미리 적어 두세요.',NULL,4,'2026-06-01 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='늦은 점심, 마을 한 바퀴, 해 기울 때 탕 — 식후 한 시간의 법칙');
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'ONSEN_SCIENCE','''토토노우''라는 상태에 대하여','일본 사우나 열풍이 발명한 단어 하나','/img/magazine/175.jpg','일본 사우나 애호가들이 쓰는 동사가 하나 있습니다. 토토노우(ととのう). 원래는 ''정돈되다''라는 평범한 말인데, 사우나 문화에서는 특별한 상태를 가리키는 전문용어가 됐어요.

정의는 이렇습니다. 사우나에서 몸을 달구고, 냉수욕으로 급히 식히고, 외기욕 의자에 앉아 쉰다. 이 세 단계를 한 세트로 두세 번 반복하면 어느 순간 머릿속이 맑아지면서 몸이 가볍게 떠 있는 듯한 이완 상태가 온다는 것. 그 상태가 토토노우입니다. 뜨거움과 차가움을 오가며 자율신경이 크게 출렁인 뒤, 휴식 단계에서 이완이 한꺼번에 몰려오는 현상이라고 설명돼요.

흥미로운 건 이 열풍의 주역이 온천 대국 일본의 기성세대가 아니라 젊은 세대라는 점입니다. 사우나 만화와 드라마가 불을 붙였고, 지금은 한국의 사우나·온천 애호가들 사이에서도 통용되는 말이 됐어요.

[QUOTE]토토노우의 비밀은 사우나실이 아니라 그다음 의자에 있다.

한국식으로 옮기면 조건은 이미 갖춰져 있습니다. 뜨거운 탕과 냉탕, 그리고 평상. 우리가 늘 하던 목욕에 ''휴식을 건너뛰지 않는다''는 규칙 하나만 더하면, 그 단어가 가리키는 상태는 국적을 가리지 않고 찾아옵니다.',NULL,4,'2026-06-03 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='''토토노우''라는 상태에 대하여');
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'ONSEN_SCIENCE','달리고 나서 다 같이 탕으로 간다','러닝크루가 사우나를 발견했을 때','/img/magazine/176.jpg','토요일 아침 강변을 달린 크루가 해산하지 않고 우르르 목욕탕으로 향합니다. 최근 2030 러닝크루 사이에서 낯설지 않은 풍경이에요. 사우나가 혼자 조용히 하는 일에서, 같이 모여서 하는 일로 바뀌고 있습니다.

운동과 목욕의 궁합에는 근거가 있어요. 달리기 직후의 근육에는 대사 산물이 쌓여 있는데, 따뜻한 물은 혈류를 늘려 이 회수 작업을 도와줍니다. 다만 순서에 요령이 있습니다. 달리기가 끝난 직후는 심박이 아직 높은 상태라, 바로 뜨거운 탕에 들어가기보다 숨을 고르고 가볍게 씻은 뒤 입욕하는 편이 안전해요. 냉탕은 격한 운동 직후의 달아오른 몸에는 오히려 부담이 될 수 있으니, 온탕으로 시작하는 게 정석입니다.

그리고 사회적인 효과가 있습니다. 러닝은 페이스가 다르면 대화가 끊기지만, 탕 안에서는 모두가 같은 속도예요. 달리며 못 다한 이야기가 물속에서 이어집니다. 옷과 기록과 페이스가 사라진 자리에 남는 평등함, 목욕탕이라는 공간이 원래 갖고 있던 오래된 미덕이 운동 커뮤니티와 만나 재발견되는 중입니다.

주말 코스 짜기의 새 공식. 강변 10km, 그리고 반경 2km 안의 탕 하나.',NULL,4,'2026-06-04 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='달리고 나서 다 같이 탕으로 간다');
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'ONSEN_SCIENCE','보일러 물은 100℃여도 온천이 아니다 — 온천법의 세 관문','법전에서 가장 따뜻한 숫자, 섭씨 25도의 논리','/img/magazine/177.jpg','섭씨 25도. 대한민국 법전에서 가장 따뜻한 숫자는 이렇게 시작합니다. 온천법이 정한 온천의 정의는 땅속에서 솟아나는, 섭씨 25도 이상의 온수로서 그 성분이 인체에 해롭지 않은 것. 조문은 한 줄이지만 관문은 셋이에요.

첫째 관문, 땅속에서 솟아야 합니다. 보일러로 데운 물은 아무리 뜨거워도 온천이 아니에요.

둘째 관문, 25℃. 사람 체온보다 한참 낮은 이 기준이 의아할 수 있는데, 우리나라 땅속 평균 온도를 고려하면 25℃의 지하수는 이미 지구 내부의 열을 받은 물이라는 게 이 기준의 논리입니다. 미지근한 온천수를 데워서 공급하는 곳이 있는 이유이기도 해요.

셋째 관문, 성분이 인체에 해롭지 않을 것. 뜨겁기만 해서는 안 되고 수질 검사를 통과해야 법의 ''온천''이 됩니다.

[IMG]온천법 조문을 펼쳐 놓은 책상, ''섭씨 25도''에 그은 밑줄. ⓒ 물멍

이 정의가 남긴 건 감성이 아니라 장부입니다. 온천으로 등록되면 수온과 성분이 공적으로 기록되고 관리돼요. 물멍이 온천마다 수온·수질 데이터를 이야기할 수 있는 것도 이 법이 만들어 놓은 기록 덕분입니다.

[QUOTE]법전에서 이보다 따뜻한 숫자를 아직 찾지 못했다. 섭씨 25도.

다음 온천 팜플렛에서 수온 숫자부터 찾아보세요. 25 위에 적힌 그 숫자가, 이 물이 세 관문을 통과했다는 증거입니다.',NULL,4,'2026-06-06 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='보일러 물은 100℃여도 온천이 아니다 — 온천법의 세 관문');
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'ONSEN_SCIENCE','별점이 없던 시절부터 쌓인 숫자 — 연간이용인원으로 온천 고르기','행정안전부 ''전국 온천 현황'', 대한민국 목욕의 장부 읽는 법','/img/magazine/178.jpg','78℃에서 25℃까지. 행정안전부 ''전국 온천 현황'' 한 표에 전국의 물 온도가 줄지어 있습니다. 매년 나오는 이 자료엔 온천 지구와 이용업소, 수온, 수질, 그리고 연간 이용객 수까지 적혀 있어요. 말하자면 대한민국 목욕의 장부입니다.

장부의 진가는 연간이용인원 항목에 있습니다. 온천마다 한 해 동안 몇 명이 다녀갔는지가 숫자로 남아요. 별점도 리뷰도 없던 시절부터 쌓여 온 기록이라, 어느 온천이 실제로 사랑받는 곳인지 광고 없이 보여 주는 지표입니다.

수온 열은 위에서부터 읽으면 됩니다. 최고 수온 78℃의 부곡온천부터 법정 기준선인 25℃ 언저리까지. 수질 열로 넘어가면 유황, 중탄산, 염화물 같은 성분 계보가 이름 옆에 붙어 있어요.

[IMG]책상 위에 펼쳐 놓은 전국 온천 현황 자료와 형광펜. ⓒ 물멍

공공데이터포털에서 누구나 내려받을 수 있는 자료입니다. 물멍 지도의 ''인기순'' 정렬도 이 연간이용인원을 그대로 씁니다.

[QUOTE]검색창의 사진보다 장부의 숫자 한 줄이 더 정직할 때가 많다.

낯선 지역에서 다음 온천을 고르기 전, 이 장부를 10분만 넘겨 보세요. 여행 계획이 감이 아니라 데이터에서 시작되는 경험은 생각보다 재밌습니다.',NULL,4,'2026-06-07 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='별점이 없던 시절부터 쌓인 숫자 — 연간이용인원으로 온천 고르기');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='별점이 없던 시절부터 쌓인 숫자 — 연간이용인원으로 온천 고르기' AND source='MANUAL' AND name='부곡온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'ONSEN_SCIENCE','계란이 익는 물을 42℃로: 부곡온천 냉각 공학 세 가지','창녕 부곡, 국내에서 가장 뜨거운 78℃를 사람 앞에 내놓는 법','/img/magazine/179.jpg','78℃. 계란이 익는 온도의 물이 경남 창녕 땅에서 올라옵니다. 부곡온천의 원수, 국내에서 가장 뜨거운 온천수예요. 당연히 이대로는 아무도 못 들어갑니다. 그래서 부곡에서 지켜볼 것은 탕이 아니라, 78℃를 42℃로 만드는 과정입니다.

방법 하나, 시간. 원수를 저탕조에 받아 두면 물은 스스로 식습니다.

방법 둘, 혼합. 식힌 물이나 온도가 낮은 물과 섞어 목표 온도를 맞춥니다.

방법 셋, 열교환. 뜨거운 원수의 열을 다른 물이나 난방으로 옮기는 방식인데, 버려질 뻔한 열이 건물을 데우는 자원이 됩니다. 고온천이 있는 온천지에서 온수와 난방이 넉넉한 데는 이런 사정이 있어요.

[IMG]부곡온천 저탕조 위로 오르는 김. 78℃가 42℃가 되는 첫 단계. ⓒ 물멍

여기서 애호가의 딜레마가 나옵니다. 식히는 과정을 거칠수록 물은 안전해지지만, 공기와 닿고 시간이 지나며 휘발성 성분은 조금씩 날아가요. 그래서 고온천에서는 ''원탕에 가까운 탕''이 대접받습니다.

부곡은 2023년 온천법에 따른 온천도시로 지정되며 이 뜨거운 물의 가치를 공식적으로 인정받았어요.

[QUOTE]너무 뜨거워서 그대로는 쓸 수 없는 자원을 다루는 기술, 그게 부곡의 탕에 잠겨 있다.

부곡에 가면 탕 온도 표시 앞에서 한 번만 빼기를 해 보세요. 78에서 그 숫자를 뺀 값이, 이 마을이 매일 하는 일입니다.','48',4,'2026-06-09 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='계란이 익는 물을 42℃로: 부곡온천 냉각 공학 세 가지');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='계란이 익는 물을 42℃로: 부곡온천 냉각 공학 세 가지' AND source='MANUAL' AND name='부곡온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'ONSEN_SCIENCE','화강암을 지나온 물은 순하다 — 한국 온천이 일본과 다른 이유','빗물이 온천수가 되기까지, 지질이 수질을 빚는 수천 년의 공정','/img/magazine/180.jpg','빗물 한 방울이 땅속으로 스며듭니다. 수백 미터에서 수 킬로미터를 내려가 지구 내부의 열로 데워지고, 균열을 따라 다시 올라오기까지 걸리는 시간은 짧게는 수십 년, 길게는 수천 년.

그 시간 동안 물은 지나온 암석을 조금씩 녹여 자기 몸에 기록해요. 온천수 성분표는 사실 그 물이 통과한 지층의 이력서입니다. 유황 냄새, 미끌거림, 짭짤함 — 답은 물이 아니라 땅에 있어요.

한반도의 온천이 대체로 순한 알칼리성 단순천 계열인 것도 지질의 결과입니다. 우리 땅의 온천 상당수는 화강암 지대를 통과해 올라오는데, 화강암은 물에 녹아드는 성분이 비교적 적은 암석이에요.

화산 활동이 활발한 일본의 온천이 산성에 성분도 진한 것과 대비되는 지점이죠. 어느 쪽이 우월한 게 아닙니다. 순한 물은 순한 물대로 오래 담글 수 있다는 다른 미덕을 갖습니다.

[IMG]탕 바닥에 비친 화강암 결. 이 물이 지나온 지층의 서명. ⓒ 물멍

[QUOTE]미끌거림은 암석의 서명이고, 냄새는 지층의 문장이다.

그러니 탕에 몸을 담그는 일은 그 지역의 지하 수 킬로미터를 감각으로 읽는 일이기도 합니다. 온천 여행이 지역마다 다른 이유는 하나예요. 땅이 다르기 때문입니다.

다음 탕에서는 물속에서 손가락을 비벼 보세요. 그 촉감이 수십 년에서 수천 년 전 빗물이 쓴 첫 문장입니다.',NULL,4,'2026-06-10 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='화강암을 지나온 물은 순하다 — 한국 온천이 일본과 다른 이유');
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'ONSEN_SCIENCE','42℃는 어른의 숫자다 — 아이는 38℃, 10분','어린이 입욕의 온도·시간·순서를 숫자로 다시 쓰기','/img/magazine/181.jpg','42℃, 20분. 어른에게는 적당한 목욕이지만, 아이에게는 두 숫자 다 틀렸어요.

이유는 몸의 구조에 있습니다. 아이는 몸집에 비해 피부 면적이 넓어 열을 어른보다 빨리 흡수하고, 체온을 조절하는 능력은 아직 완성되지 않았어요. 같은 물에 들어가도 아이의 몸이 먼저 데워지고, 먼저 한계에 닿습니다.

그래서 온도는 38℃. 미온탕을 기본으로 삼고, 뜨거운 탕은 구경만 시켜 주세요. 시간은 5~10분. 담갔다가 나와서 쉬는 짧은 왕복을 반복하는 쪽이 한 번 오래 있는 것보다 안전해요. 아이 얼굴이 발갛게 달아오르거나 말수가 줄면, 그건 이미 신호가 온 뒤입니다.

[IMG]미온탕 가장자리에 걸터앉은 아이의 발, 수면 위로 김이 옅게 오른다. ⓒ 물멍

물도 어른이 챙겨야 해요. 아이는 놀이에 밀려 목마르다는 말을 잊어버리니까, 시계를 보는 건 어른의 몫입니다. 어른보다 자주, 묻지 말고 건네 주세요.

수질은 순한 쪽으로. 자극이 적은 단순천이나 알칼리성 온천이 무난하고, 성분이 진한 물이라면 시간을 더 짧게 잡습니다. 나온 뒤 보습은 어른보다 아이에게 더 급해요. 어린 피부는 장벽이 얇아 건조가 먼저 옵니다.

[QUOTE]어른의 목욕 상식은 아이에게 그대로 옮겨지지 않는다.

탕에 들어가기 전 몸 씻기, 탕 안에서 수영하지 않기. 이 두 규칙을 배우는 것까지가 여행이에요. 아이가 물을 무서워하지 않고 목욕을 좋아하게 됐다면 그날의 수확은 거기서 끝. 온도계 대신 아이 얼굴을 보면서, 38℃에서 10분만 시작해 보세요.',NULL,4,'2026-06-12 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='42℃는 어른의 숫자다 — 아이는 38℃, 10분');
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'ONSEN_SCIENCE','타투와 목욕탕 — 법은 없고, 규칙은 카운터에 있다','한국엔 금지법이 없다. 그래서 업소마다 다르고, 일본은 또 다르다','/img/magazine/182.jpg','"타투 있는데 온천 가도 되나요?" 온천 여행 커뮤니티에 주기적으로 올라오는 질문이에요. 답은 짧은데, 짧아서 오해가 생깁니다.

법부터. 한국에는 문신이 있는 사람의 목욕장 출입을 금지하는 법이 없습니다. 출입을 막는 건 법이 아니라 각 업소가 정하는 이용 규칙, 이른바 하우스 룰이에요. 카운터 뒤에 붙은 종이 한 장이 그 업소의 법입니다.

그래서 현실은 업소마다 다릅니다. 아무 제한이 없는 곳이 다수지만, 과도한 문신 노출을 제한한다는 안내문을 붙인 곳도 있어요. 기준도 ''전신 문신'', ''위압감을 주는 경우''처럼 제각각이라, 결국 그날 그 업소의 재량입니다. 걱정된다면 방문 전 전화 한 통이 안내문 열 장보다 확실해요.

[IMG]목욕탕 카운터 옆 벽면에 붙은 이용 안내문. ⓒ 물멍

일본은 다른 나라입니다. 문신 손님의 입욕을 거절하는 온천·목욕 시설이 여전히 많고, 커버 스티커를 붙이는 조건으로 허용하는 곳, 전세탕(가족탕)을 안내하는 곳도 있어요. 일본 온천 여행이라면 이건 변수가 아니라 상수로 계산에 넣어 두세요.

[QUOTE]규정이 허락해도, 아물지 않은 피부는 허락하지 않는다.

마지막으로 규정과 무관한 이야기 하나. 문신을 새로 받은 직후라면 탕은 피해야 합니다. 시술 부위는 아직 아물지 않은 상처라, 공중탕 입욕은 감염 위험을 키워요. 회복 기간이 끝날 때까지는 샤워로 버티는 게 피부를 위한 선택입니다. 그러니 순서는 이렇게 — 피부가 아물었는지 먼저 보고, 그다음 업소에 전화하세요.',NULL,4,'2026-06-13 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='타투와 목욕탕 — 법은 없고, 규칙은 카운터에 있다');
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'ONSEN_SCIENCE','하루 네 탕은 등산이다 — 온천 도장깨기의 몸 회계','수집 욕구와 입욕 생리학의 타협안, 숫자 세 개','/img/magazine/183.jpg','하루 네 탕. 온천 도장깨기에 빠진 사람의 주말 일정표에는 이 숫자가 흔히 적혀 있습니다. 지도에 방문한 온천을 하나씩 칠해 가는 재미, 응원합니다. 다만 몸 쪽 장부도 같이 맞춰 보려 합니다.

입욕은 겉보기엔 휴식이지만 몸에게는 일입니다. 뜨거운 물에서 심박은 오르고, 땀으로 수분과 전해질이 빠지고, 자율신경은 계속 스위치를 바꿉니다. 목욕 한 번의 피로가 가벼운 산책이라면, 하루 네 탕은 등산입니다. 온천을 돌수록 피곤해지는 역설은 여기서 나옵니다.

[IMG]탈의실 벽시계 아래, 물병을 든 채 앉아 쉬는 사람. ⓒ 물멍

타협안은 숫자 세 개입니다. 첫째, 하루 입욕은 두세 곳까지, 탕과 탕 사이에 두 시간 이상. 둘째, 풀코스는 첫 번째 온천에서만. 두 번째부터는 가볍게 담그고 물의 개성만 확인하는 시음 방식으로 바꿉니다. 셋째, 물은 탕 수만큼 마시고, 마지막 입욕은 잠들기 두 시간 전에 끝냅니다.

[QUOTE]도장은 지도에 찍는 것이지 몸에 찍는 것이 아니다.

기록의 관점에서도 셈이 다릅니다. 하루에 몰아 찍은 네 개의 도장보다, 계절을 바꿔 다시 찾은 한 곳의 기록이 나중에 더 읽을 만합니다. 수집의 완성도는 개수가 아니라 기억의 해상도로 정해집니다.

그러니 다음 주말 일정표의 네 번째 탕은 지우고, 그 자리에 두 시간짜리 빈칸을 남겨 두십시오. 도장은 다음 계절에 찍어도 늦지 않습니다.',NULL,4,'2026-06-15 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='하루 네 탕은 등산이다 — 온천 도장깨기의 몸 회계');
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','수안보에서 꿩을 먹는다는 것','샤브에서 만두까지, 온천마을이 지켜온 꿩요리 계보','/img/magazine/184.jpg','꿩은 겨울 새다. 지방이 적고 살이 담백해서 옛날에는 설날 떡국 국물도 꿩으로 냈다. 그 꿩요리가 지금 전국에서 가장 밀도 높게 남아 있는 동네가 충북 충주 수안보다.

계보의 꼭대기에는 코스가 있다. 대장군식당은 수안보를 대표하는 꿩 코스요리 전문점으로, 중도일보 ''맛있는 여행''에도 소개된 집이다. 얇게 저민 꿩 가슴살을 끓는 육수에 살짝 흔들어 건지는 샤브가 코스의 중심이고, 여기서부터 만두·불고기로 이어진다. 삿갓촌은 여기서 한 발 더 나가 꿩 샤브를 포함한 8가지 꿩 코스를 낸다. 두세 명이 가면 한 마리로 여덟 가지 맛을 보는 셈이다.

[QUOTE]꿩 샤브는 국물에 세 번 흔들면 끝이다. 더 두면 닭이 된다.

장군식당과 감나무집도 꿩요리 맛집으로 등재된 집들이라, 온천단지 안에서 ''오늘은 어느 집 꿩인가''를 고르는 게 수안보식 저녁 고민이다. 꿩이 부담스러운 일행이 있다면 청솔식당의 두부전골이나 산채정식으로 빠지는 길도 있다.

순서는 탕이 먼저다. 53℃ 알칼리성 온천에 몸을 불리고 나오면 담백한 꿩 샤브 국물이 들어갈 자리가 정확히 생긴다. 코스는 시간이 걸리니 저녁 예약을 걸어두고 탕에 들어가는 편이 좋습니다.','43',4,'2026-06-16 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='수안보에서 꿩을 먹는다는 것');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='수안보에서 꿩을 먹는다는 것' AND source='MANUAL' AND name='수안보온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','78℃ 유황탕 다음 순서, 부곡 밥집 4곳','온천중앙로에서 저녁을 해결하는 법','/img/magazine/185.jpg','부곡의 물은 78℃, 국내에서 가장 뜨겁다. 유황탕에서 제대로 데워진 몸은 생각보다 빨리 허기진다. 온천단지 중심가인 온천중앙로 일대에서 검증된 집만 추린다.

① 송이네 밥상 — 부곡면 한정식집. 상 가득 깔리는 반찬에 후기들이 몰리는 집으로, 온천욕으로 하루를 마친 저녁에 어울린다. 1박 일정의 첫날 저녁으로 시키기 좋다.

② 한우곱창 오색그린 부곡본점 — 한우곱창전골 전문. 얼큰한 전골 국물은 탕에서 땀을 뺀 다음이 제일 맛있는 타이밍이다. 인원이 둘 이상일 때 가라.

③ 생선구이&돌솥밥 — 상호가 곧 메뉴다. 노릇한 생선구이에 돌솥밥 조합이라 아침 겸 점심으로도 무겁지 않다. 탕에 들어가기 전 든든하게 깔아두는 용도로 좋다.

④ 영산세유정 — 부곡 옆 영산면의 한식당. 당근 동네생활에서 현지인이 추천한 집이니, 차가 있고 온천단지 밥집을 한 바퀴 돈 재방문자라면 원정 가치가 있다.

[IMG]온천중앙로의 저녁, 식당 간판에 하나둘 불이 들어온다. ⓒ 물멍

부곡은 자고 가는 동네다. 저녁은 전골이나 한정식으로 길게, 다음 날 아침은 생선구이로 짧게. 그 사이에 유황탕 두 번이면 주말이 끝나 있어요.','48',4,'2026-06-18 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='78℃ 유황탕 다음 순서, 부곡 밥집 4곳');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='78℃ 유황탕 다음 순서, 부곡 밥집 4곳' AND source='MANUAL' AND name='부곡온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','유성 라듐탕과 칼국수의 도시','온천 옆 한 그릇, 그리고 시내 원정 두 집','/img/magazine/186.jpg','대전 사람에게 칼국수는 외식이 아니라 일상이다. 이 도시의 칼국수 사랑은 유성온천이라고 예외가 아니어서, 라듐천에 몸을 담그고 나온 사람들의 발이 자연스럽게 칼국숫집으로 향한다.

온천 근처에서라면 온천손칼국수다. 유성구 지역뉴스에 소개된 손칼국수집으로, 이름 그대로 온천과 칼국수를 한 동선에 묶기 제일 좋은 위치다. 뜨끈한 탕 뒤에 뜨끈한 면이 과하다 싶겠지만, 53℃ 물에 근육을 풀고 난 몸은 이상하게 국물을 부른다.

반나절 여유가 있다면 대전 시내로 원정을 가라. 오씨칼국수는 성심당·진로집과 함께 대전 3대 명물로 꼽히는 칼국수 노포다. 그리고 그 진로집은 두부두루치기의 집이다. 벌건 양념에 뭉근하게 조려진 두부를 앞에 두면 칼국수 면 사리를 추가하지 않을 방법이 없다.

[QUOTE]대전에서는 칼국수가 취향이 아니라 디폴트다.

동선은 두 가지다. 온천만 즐기고 온천손칼국수로 마무리하는 반나절 코스, 아니면 시내에서 진로집·오씨칼국수를 찍고 유성으로 돌아와 탕으로 하루를 닫는 풀코스. 어느 쪽이든 국물은 보장됩니다.','30',4,'2026-06-19 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='유성 라듐탕과 칼국수의 도시');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='유성 라듐탕과 칼국수의 도시' AND source='MANUAL' AND name='유성온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','온양온천역 앞 장터에서 배부르고 등 따뜻하게','지하철 타고 가는 시장 먹거리 산책','/img/magazine/187.jpg','지하철 1호선 종점 언저리, 온양온천역 개찰구를 나오면 곧장 장터 냄새가 난다. 역 앞이 바로 온양온천전통시장이다. 한국관광공사 여행기사가 ''배부르고 등 따뜻한 장터''라고 부른 곳 — 온천과 시장이 도보 생활권 안에 같이 있는 드문 동네다.

시장 골목의 미덕은 계획이 필요 없다는 것이다. 전 부치는 소리가 나는 쪽으로 걷고, 김 오르는 솥 앞에서 멈추면 된다. 장날에 맞춰 가면 골목이 좌판으로 한 겹 더 두꺼워진다. 손에 든 먹거리로 애매하게 배를 채웠다면, 시골밥상 한상차림으로 상을 제대로 받는 방법도 있다. 온양 맛집 후기로 확인되는 집이다.

[IMG]온양온천전통시장 골목, 솥에서 김이 오르고 장 보러 나온 손들이 오간다. ⓒ 물멍

순서를 짜자면 이렇다. 서울에서 환승 없이 지하철로 내려와, 57℃ 알칼리성 온천에 먼저 몸을 불린다. 매끈해진 피부로 시장 골목을 한 바퀴 — 목욕 후의 허기는 장터 음식이 제일 정직하게 받아준다. 차가 있다면 송악저수지 쪽 어죽과 붕어찜까지 사정권이지만, 뚜벅이라면 역·탕·시장 삼각형 안에서 하루가 충분히 완성돼요.','44',4,'2026-06-21 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='온양온천역 앞 장터에서 배부르고 등 따뜻하게');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='온양온천역 앞 장터에서 배부르고 등 따뜻하게' AND source='MANUAL' AND name='온양온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','탕 다음은 파전, 파전 다음은 곰장어','동래 온천장의 오래된 저녁 순서','/img/magazine/188.jpg','동래에는 순서가 있다. 목욕을 하고, 파전을 먹고, 그래도 아쉬우면 곰장어 골목으로 간다. 이 코스는 누가 만든 게 아니라 조선시대부터 온천에 몸을 담그러 온 사람들이 수백 년에 걸쳐 다져놓은 것이고, 한국관광공사 여행기사로 소개될 정도로 지금도 유효하다.

파전의 정점은 동래할매파전이다. 4대째 이어지는 동래파전 원조 노포로, 지역N문화 ''오래된 가게''에 등재돼 있다. 동래파전은 흔한 부침개가 아니다. 쪽파 위에 해물을 얹고 반죽을 최소한으로 써서, 겉은 지지고 속은 찜에 가깝게 익힌다. 처음 먹으면 ''덜 익었나'' 싶은 그 촉촉함이 원형이다. 생생정보통에 나온 소문난동래파전까지, 온천동 안에서 파전 비교 시식도 가능하다.

[QUOTE]동래파전은 바삭함을 겨루는 음식이 아니다. 촉촉함이 원형이다.

해가 지면 온천장 곰장어골목이다. 원조 소문난 산곰장어는 이 골목에서 45년을 버틴 노포로, 짚불과 양념 중에 고르게 된다. 다이닝코드에 등재된 온천입구기장곰장어도 골목의 선택지다.

식염천에 몸을 데우고 나온 저녁, 파전에 막걸리 한 잔, 곰장어로 마무리. 부산 지하철 1호선 온천장역에서 도보 8분이면 이 모든 순서가 시작됩니다.','26',4,'2026-06-22 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='탕 다음은 파전, 파전 다음은 곰장어');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='탕 다음은 파전, 파전 다음은 곰장어' AND source='MANUAL' AND name='동래온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','해운대 국밥, 소냐 돼지냐','온천 나와서 갈리는 두 개의 국물','/img/magazine/189.jpg','해운대에서 탕을 나서면 질문은 하나로 좁혀진다. 소고기국밥이냐, 돼지국밥이냐.

소 쪽의 대표는 해운대원조할매국밥이다. 59년 전통의 소고기국밥 노포로, 벌건 국물에 소고기와 콩나물이 들어가는 부산식이다. 얼큰하고 달큰한 국물이라 바닷바람 맞고 온천까지 마친 몸에 정확히 꽂힌다. 첫 방문이라면 여기부터가 정석이다.

돼지 쪽은 층이 두껍다. 오복돼지국밥 해운대는 캐치테이블에 등재될 만큼 줄이 서는 집이고, 뽀얀 국물의 정석을 보여준다. 의령식당은 담백한 국물로 알려진 노포인데, 메뉴판에 우동이 같이 있는 게 오히려 오래된 집이라는 증거다. 진한 걸 원하면 오복, 깔끔한 걸 원하면 의령 쪽이다.

판정은 이렇게 내린다. 아침 목욕 후라면 담백한 돼지국밥, 저녁이라면 얼큰한 소고기국밥. 60℃ 식염천에서 땀을 빼고 나온 직후에는 어느 쪽이든 밥 말기 전에 국물부터 세 숟갈 — 이게 해운대식이다.

[IMG]뚝배기에서 김이 오르는 국밥 한 상, 깍두기는 리필이 국룰이다. ⓒ 물멍

지하철 2호선 해운대역에서 온천까지 도보 5분. 바다, 탕, 국밥이 전부 걸어서 닿는 거리에 있어요.','26',4,'2026-06-23 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='해운대 국밥, 소냐 돼지냐');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='해운대 국밥, 소냐 돼지냐' AND source='MANUAL' AND name='해운대온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','수덕사 아랫동네는 갈비 냄새가 난다','덕산온천 단지의 숯불갈비 지도','/img/magazine/190.jpg','예산 덕산은 절과 탕과 갈비의 동네다. 수덕사에서 내려와 45℃ 중탄산나트륨 온천에 몸을 풀고 나면, 온천단지 골목에서 숯불 냄새가 마중을 나온다. 예산은 한국관광공사 여행기사가 짚었듯 숯불 전통 소갈비와 삽다리곱창의 고장이다.

중심은 소복갈비다. 트리플과 다이닝코드에 나란히 등재된 예산 대표 갈비 노포로, 돼지와 소 양념갈비를 모두 굽는다. 달큰한 양념이 숯불에 그을리는 냄새는 목욕 후의 허기에 반칙에 가깝다. 가족 단위라면 양념 돼지갈비로 양을 확보하고, 소갈비를 조금 섞는 조합이 실속 있다.

한우로 정면 승부를 보고 싶다면 대복갈비다. 다이닝코드 예산 한우갈비 맛집으로 등재된 집. 덕산면 안에서 해결하려면 소고기 구이 전문 고덕갈비도 있다.

[QUOTE]절 밥으로 비운 속을 숯불갈비로 채우는 게 덕산의 균형이다.

동선은 단순하다. 오전에 수덕사, 낮에 온천, 저녁에 갈비. 갈비는 굽는 시간이 필요한 음식이니 탕에서 서두를 이유가 없다. 몸이 데워진 만큼 숯불 앞에 앉아 있는 시간도 느긋해집니다.','44',4,'2026-06-25 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='수덕사 아랫동네는 갈비 냄새가 난다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='수덕사 아랫동네는 갈비 냄새가 난다' AND source='MANUAL' AND name='덕산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','31℃ 미지근한 탕, 뜨거운 어죽 한 솥','도고온천과 저수지 물고기 밥상','/img/magazine/191.jpg','도고의 물은 31℃. 뜨겁게 지지는 탕이 아니라 미지근하게 오래 담그는 유황수다. 한 시간쯤 몸을 맡기고 나오면 속이 출출한데, 이 동네의 답은 저수지에서 나온다.

아산 서부는 어죽 문화권이다. 어죽이 디지털아산문화대전에 향토음식으로 등재돼 있을 정도로, 저수지에서 잡은 민물고기를 뼈째 고아 쌀과 국수를 함께 끓여내는 음식이 일상에 박혀 있다. 가마솥붕어찜은 다이닝코드에 등재된 붕어찜·어죽집으로, 상호에 조리도구가 들어간 집 치고 허투루 끓이는 집이 없다. 붕어찜은 조림 양념이 배어들 시간이 필요한 음식이라 전화를 걸어두고 가는 편이 안전하다.

송악저수지 아래 붕어마을은 먹방 영상으로도 소개된 노포 어죽집이다. 얼큰한 어죽 한 그릇에 매운탕까지, 민물고기 요리의 진한 쪽을 담당한다. 비린 맛 걱정은 첫술에서 끝난다 — 제대로 고은 어죽은 비리지 않고 구수하다.

온천 바로 옆에서 간단히 해결하려면 도고면의 한식당 새참만땅 도고온천점이 있다.

장항선 도고온천역에서 택시로 5분. 미지근한 물에 오래, 뜨거운 죽은 천천히. 도고의 속도는 전체적으로 한 박자 느립니다.','44',4,'2026-06-26 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='31℃ 미지근한 탕, 뜨거운 어죽 한 솥');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='31℃ 미지근한 탕, 뜨거운 어죽 한 솥' AND source='MANUAL' AND name='도고온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','백암에서는 밥집을 고르지 않는다','온천지구 밥 세 끼와 겨울 대게 원정','/img/magazine/192.jpg','백암온천관광특구는 화려한 먹자골목이 아니다. 대신 끼니마다 제 역할을 하는 집들이 온천지구 안에 조용히 자리를 지킨다. 이 동네의 먹거리는 ''고르는'' 게 아니라 ''순서대로 만나는'' 쪽에 가깝다.

낮 밥은 동광식당이다. 온정면 온천지구의 한식 기사식당 — 기사식당이라는 네 글자가 곧 보증서다. 매일 먹어도 질리지 않는 백반이 기본기이고, 등산이나 온천 전에 든든하게 깔아두기 좋다. 저녁이 가벼웠으면 하는 날은 큰맘할매순대국의 순대국 한 그릇이 답이다. 온천지구 안이라 유황탕에서 나와 몇 걸음이면 뜨끈한 국물 앞이다.

의외의 카드는 LG생활연수원 레스토랑이다. 연수원 안 식당이지만 저렴하고 푸짐하다는 후기가 도는 곳으로, 백암에 하루 이상 머문다면 한 끼쯤 시도할 만하다.

그리고 겨울. 백암의 진짜 먹거리 이벤트는 대게철에 온다. 한국관광공사 여행기사도 백암온천을 울진 대게찜과 한 묶음으로 소개한다. 후포항이 가까우니 탕과 대게를 하루에 넣는 일정이 실제로 굴러간다.

[QUOTE]백암의 밥은 화려하지 않다. 대신 세 끼 모두 실패가 없다.

동해선 평해역에서 버스 20분. 유황천에 몸을 데우고, 끼니는 순서대로 해결하면 됩니다.','47',4,'2026-06-28 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='백암에서는 밥집을 고르지 않는다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='백암에서는 밥집을 고르지 않는다' AND source='MANUAL' AND name='백암온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','대게는 두 시간짜리 음식이다, 그래서 탕이 먼저다','울진 덕구온천 노천탕에서 후포 대게집까지, 겨울의 순서','/img/magazine/193.jpg','대게 한 마리를 먹는 데 두 시간이 걸린다. 겨울 울진의 하루는 이 숫자에서 거꾸로 짜인다. 먹고 나면 탕으로 돌아갈 기력이 없으니, 탕이 먼저다.

오전은 덕구온천. 국내 유일의 자연용출 노천탕에서 42℃ 중탄산천에 몸을 데운다. 눈 오는 날이면 머리는 차고 몸은 뜨거운, 노천탕만 줄 수 있는 두 온도가 한 몸에 동시에 온다.

[IMG]눈 내리는 덕구 노천탕, 수면 위로 김이 오르고 어깨 위로 눈이 내린다. ⓒ 물멍

오후는 대게. 울진은 대게의 본고장이고, 덕구온천과 대게찜을 묶은 겨울 보양 코스는 한국관광공사 여행기사에 실릴 만큼 공인된 조합이다. 원조대게후포리는 3대 53년째 울진대게를 다뤄 온 집이다. 대게는 찌는 기술보다 고르는 눈이 절반인데, 53년 동안 게를 만져 온 손이 그 눈을 보증한다.

다이닝코드에 등재된 대게앤쿡과 대원대게센타는 일반 대게부터 속이 꽉 찬 박달대게까지 다룬다. 예산이 허락하면 박달대게로 가라. 다리 하나의 밀도가 다르다.

[QUOTE]대게는 찌는 기술보다 고르는 눈이 절반이다.

먹는 순서도 정해져 있다. 몸을 데우고, 게살을 바르고, 마지막에 게딱지에 밥을 비빈다. 덕구는 자차 권장 — 울진터미널에서 30km — 이지만, 42℃와 박달대게를 하루에 넣는 방정식 하나면 겨울 왕복 기름값은 계산에서 빠진다. 눈 예보가 뜨는 주말, 오전 탕부터 시작하라.','47',4,'2026-06-29 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='대게는 두 시간짜리 음식이다, 그래서 탕이 먼저다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='대게는 두 시간짜리 음식이다, 그래서 탕이 먼저다' AND source='MANUAL' AND name='덕구온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','돼지에게 약돌을 먹이는 동네','문경 약돌구이와 새재묵조밥의 내력','/img/magazine/194.jpg','문경 사람들은 돼지한테 돌가루를 먹인다. 거정석 — 이 동네 말로 약돌 — 을 갈아 사료에 섞이면 고기 잡내가 줄고 육질이 단단해진다는 게 문경의 오랜 주장이고, 그렇게 키운 약돌돼지와 약돌한우는 전현무계획3 같은 방송을 타며 문경 명물이 됐다.

온천에서 이 계보를 맛보려면 멀리 갈 것도 없다. 문경온천지구의 온천약돌한우돼지정육식당은 이름에 동네의 정체성을 전부 욱여넣은 정육식당이다. 정육 코너에서 고기를 끊어 그 자리에서 굽는 방식이라 가격 대비 두께가 정직하다. 31℃ 칼슘중탄산천은 뜨겁지 않아 오래 담그는 탕이니, 느긋하게 몸을 풀고 나와 숯불 앞에 앉는 흐름이 자연스럽다.

계보의 다른 줄기는 문경새재 쪽에 있다. 소문난식당의 청포묵조밥은 새재를 넘던 시절의 향토음식으로, 조밥에 청포묵과 나물을 얹어 슥슥 비비는 소박한 한 그릇이다. 고기 전 애피타이저로도, 가벼운 점심으로도 맞다. 석쇠구이가 당기면 지역뉴스에 소개된 새재할매집 — 양념육을 석쇠에 눌러 굽는 불맛이 약돌구이와는 또 다른 결이다.

점촌역에서 버스 30분. 새재를 걷고, 묵조밥으로 점심, 탕으로 오후, 약돌구이로 저녁. 문경의 하루는 이렇게 접힙니다.','47',4,'2026-07-01 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='돼지에게 약돌을 먹이는 동네');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='돼지에게 약돌을 먹이는 동네' AND source='MANUAL' AND name='문경온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','약수로 지은 밥은 색부터 다르다','오색 산채마을의 아침상','/img/magazine/195.jpg','오색약수는 철분과 탄산 때문에 쏘는 맛이 난다. 이 물로 밥을 지으면 밥알이 푸르스름한 빛을 띠는데, 그 밥을 상에 올리는 동네가 설악산 주전골 입구 산채마을이다.

약수식당은 오색약수터 옆에서 약수로 지은 밥과 산채백반을 내는 집이다. 새벽 산행을 마치고 내려온 등산객이 첫 숟갈을 뜨는 곳 — 나물 대여섯 가지에 약수밥 한 공기면 한계령을 넘어온 피로가 밥상 위에서 정리된다. ''약수로 속을 달래고 온천으로''라는 한국관광공사 기사 제목이 이 동네의 사용법을 정확히 요약한다.

다이닝코드에 등재된 오색단골식당은 산채비빔밥과 산채정식을, 산촌식당은 더덕구이를 다룬다. 석쇠에 굽는 더덕은 향이 진해서, 고기 없이도 상이 허전하지 않다는 걸 증명하는 메뉴다.

[QUOTE]산에서 내려온 사람의 첫 끼는 무조건 나물이어야 한다는 게 이 골목의 불문율이다.

순서는 산 → 밥 → 탕이다. 주전골이나 설악 능선을 걷고, 산채로 속을 채우고, 마지막에 42℃ 알칼리성 온천으로 다리를 푼다. 오색은 한계령 길목이라 자차가 편한 동네 — 대신 그만큼 조용한 아침상을 받을 수 있어요.','51',4,'2026-07-02 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='약수로 지은 밥은 색부터 다르다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='약수로 지은 밥은 색부터 다르다' AND source='MANUAL' AND name='오색온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','1965년부터 끓고 있는 학사평의 가마솥','척산온천 옆 순두부촌 르포','/img/magazine/196.jpg','미시령을 넘어 속초로 들어오면 처음 만나는 마을이 학사평이다. 콩꽃마을이라는 별칭처럼 이 일대는 순두부 노포가 밀집한 순두부촌이고, 척산온천이 바로 그 옆이다. 탕과 순두부가 도보 생활권 — 속초 여행자에게 이보다 효율적인 배치는 없다.

골목의 최고참은 김영애할머니순두부다. 1965년 개업, G1방송 ''강원의 노포'' 시리즈에 소개된 집. 60년 가까이 같은 자리에서 콩을 갈아온 집의 순두부는 몽글몽글하다는 말로는 부족하고, 콩의 단맛이 그대로 넘어온다. 간수 대신 바닷물로 굳히는 초당식이라 심심한 듯 깊다.

트리플에 등재된 원조 재래식 할머니 순두부는 상호 그대로 재래식 제조를 고수하는 집이고, 시골이모순두부까지 — 이 골목에서는 어느 집 문을 열어도 아침부터 김이 오른다. 순두부는 아침 음식이다. 전날 과식했든 과음했든, 하얀 순두부 한 그릇이 속을 리셋한다.

[IMG]학사평 순두부촌의 아침, 가마솥에서 콩물이 끓고 있다. ⓒ 물멍

추천 순서는 아침 순두부 → 오전 척산온천이다. 속을 데우고 53℃ 알칼리성 탕에서 몸을 데우면 오전이 끝나기 전에 여행의 본전을 뽑는다. 속초터미널에서 3-1번 버스로 15분입니다.','51',4,'2026-07-04 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='1965년부터 끓고 있는 학사평의 가마솥');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='1965년부터 끓고 있는 학사평의 가마솥' AND source='MANUAL' AND name='척산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','32℃ 게르마늄탕 다음 날 아침, 다슬기 국물','구례 산동 — 섬진강 다슬기, 지리산 흑돼지, 산수유 순서로','/img/magazine/197.jpg','국물이 초록이다. 파르스름하게 도는 다슬기 국물은 보기엔 낯설어도 첫술이면 이해된다 — 시원하다는 말은 이 국물을 위해 있다.

다슬기는 부지런한 음식이다. 섬진강 여울에서 하나하나 주워, 삶아서 알을 빼고, 그 국물로 수제비를 끓인다. 구례에서는 이 수고를 상 위에서 만난다. 토지다슬기식당은 생생정보통에 방영된 다슬기 전문점으로, 시킬 것은 다슬기수제비 아니면 다슬기탕 둘 중 하나다. 해장 국물로도 통하니, 전날 산수유막걸리가 과했다면 더더욱이다.

[IMG]토지다슬기식당의 다슬기수제비, 초록빛 국물 위로 김이 오른다. ⓒ 물멍

고기가 필요한 저녁은 송림민속가든이다. 다이닝코드에 등재된 구례 흑돼지집으로, 지리산 자락 흑돼지구이는 온천마을 저녁의 정석이다. 산수유마을 쪽 산수유텃밭식당은 산채 한식을 내는데, 봄 산수유축제철에 노란 꽃 구경과 묶기 좋은 자리다.

그런데 동선을 정하는 건 식당이 아니라 물의 온도다. 지리산온천은 32℃ 게르마늄천 — 뜨겁지 않아 오래 담그는 물이다. 그래서 하루가 느긋해진다. 낮에 산수유마을 한 바퀴, 오후에 긴 탕, 저녁에 흑돼지.

[QUOTE]시원하다는 말은 이 국물을 위해 있다.

다슬기 국물은 다음 날 아침 자리에 남겨 두는 게 요령이다. 구례구역에서 산동행 버스 25분, 봄이면 차창 밖이 온통 노랗다. 버스 시간표를 보기 전에, 첫날 저녁과 둘째 날 아침 메뉴부터 정하라.','46',4,'2026-07-05 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='32℃ 게르마늄탕 다음 날 아침, 다슬기 국물');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='32℃ 게르마늄탕 다음 날 아침, 다슬기 국물' AND source='MANUAL' AND name='지리산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','화순에서는 상다리가 먼저 데워진다','게르마늄탕 곁의 남도 한정식','/img/magazine/198.jpg','광주에서 버스로 40분. 화순은 남도 밥상의 문법이 그대로 살아 있는 동네다. ''양도 맛도 풍성한 화순 맛집'' 류의 기획기사가 꾸준히 나오는 데는 이유가 있다 — 여기서는 반찬 수를 세는 것 자체가 실례다.

대표 선수는 광화문연가다. 도곡온천 인근 원화리의 한정식집으로 시사매거진에 소개된 집. 남도 한정식은 코스가 아니라 ''한 상''이다. 홍어부터 게장, 조림, 전, 나물까지 상이 한 번에 차려지고, 젓가락이 갈 곳을 고르는 것부터가 식사의 시작이다. 둘보다는 넷이 유리한 음식 — 상이 넓을수록 남도는 관대해진다. 예약을 걸어두고 탕에 들어가는 순서가 맞다.

한 상이 부담스러운 끼니에는 트리플에 등재된 화순식당 같은 동네 한식집이 받쳐준다.

[QUOTE]남도 한정식의 첫 번째 예의는 배를 비워 가는 것이다.

화순온천의 물은 31℃ 게르마늄천이라 오래 담그는 쪽이다. 그러니 계산이 선다. 점심을 가볍게, 오후 내내 탕, 저녁에 한정식 풀코스. 순서를 지키면 그 넓은 상이 하나도 버겁지 않아요.','46',4,'2026-07-07 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='화순에서는 상다리가 먼저 데워진다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='화순에서는 상다리가 먼저 데워진다' AND source='MANUAL' AND name='화순온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','55℃ 짠물에 절인 몸, 정육 코너 앞에 세우기','창원 마금산온천 — 한우 저녁과 선지해장국 아침의 한 세트','/img/magazine/199.jpg','55℃. 창원 북면 마금산온천의 물은 염화나트륨이 진하기로 이름난 짠물이고, 국민보양온천으로 지정된 탕이다. 몸을 절이듯 담그고 나오면 저녁 메뉴는 사실상 정해져 있다. 이 동네의 답은 한우다.

황우장사는 마금산온천단지 인근의 토종 한우 전문점이다. 정육코너에서 직접 손질한 고기를 내는 방식이라, 꽃등심의 마블링을 눈으로 확인하고 나서 상에 올린다. 현지인 단골이 많다는 건 관광지 물가가 아니라는 뜻이기도 하다.

[IMG]황우장사 정육코너, 유리 너머로 손질된 꽃등심이 놓여 있다. ⓒ 물멍

여럿이 갔다면 황우스페셜로 부위를 섞어라. 그리고 다음 날 아침, 같은 집의 선지해장국으로 돌아온다. 구이집의 해장국은 소를 통으로 다루는 집만 낼 수 있는 메뉴다. 저녁과 아침을 한 집에서 해결하는 이 왕복이 황우장사의 정석 사용법이다.

해장 전문으로 가려면 김박사명품해장국&냉면이다. 북면 온천 지역 맛집으로 소개된 집으로, 뜨거운 해장국과 찬 냉면을 한 상에서 해결하는 조합은 탕에서 달아오른 몸에 의외로 정확하게 맞는다.

[QUOTE]진한 물, 진한 고기, 진한 국물 — 마금산은 전부 진한 쪽으로 통일돼 있다.

마산역에서 북면행 버스 40분. 차가 있다면 주남저수지 방면으로 한 겹 더 — 민물 요리 식당들이 거기 있다. 탕에 들어가기 전에 저녁 인원수부터 세어 두라. 황우스페셜은 여럿일 때 제값을 하는 메뉴다.','48',4,'2026-07-08 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='55℃ 짠물에 절인 몸, 정육 코너 앞에 세우기');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='55℃ 짠물에 절인 몸, 정육 코너 앞에 세우기' AND source='MANUAL' AND name='마금산온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','10시 발안IC, 12시 백숙, 2시 29℃ 유황탕','화성 율암온천 — 숙박 없이 보양식 두 끼를 넣는 하루','/img/magazine/200.jpg','오전 열 시, 발안IC. 여기서 율암온천까지 10분 — 서울 근교에서 유황천에 닿는 가장 짧은 동선이다. 오늘 일정은 시계로 짠다.

낮 열두 시, 백숙. 서해정은 깊고 진한 국물의 백숙·삼계탕으로 온천욕 손님들에게 통하는 집이다. 백숙은 주문 후 끓이는 데 시간이 걸리니, 탕에 들어가기 전 전화로 앉혀 두고 가는 게 화성 팔탄면의 요령이다. 닭 한 마리를 셋이 나누고 죽까지 긁으면, 그게 오후 온천욕의 연료가 된다.

[IMG]서해정의 백숙 한 솥, 뚜껑을 열자 김이 천장까지 오른다. ⓒ 물멍

오후 두 시, 유황탕. 율암의 물은 29℃로 뜨겁지 않다. 대신 유황수에 오래 담그는 물이라, 배부른 몸을 한 시간쯤 느리게 푸는 데 오히려 맞는다. 뜨거운 물이었다면 백숙 뒤에 들어갈 엄두를 못 냈을 것이다.

오후 다섯 시, 저녁. 얼큰한 쪽이면 시골민물매운탕 — 빠가사리 매운탕을 일행 규모에 맞춰 크기별로 시킬 수 있다. 기름진 쪽이 당기면 해산물을 쓰는 중식집 태림에서 요리 한두 접시로 마무리하는 변칙도 있다.

[QUOTE]율암은 잠자리가 없는 대신, 당일치기의 밀도로 승부한다.

저녁 일곱 시, 다시 서울. 숙박 없이 보양식 두 끼와 유황탕이 아홉 시간 안에 들어간다. 이번 주말, 오전 열 시 발안IC에서 시작하라 — 단, 서해정에 전화는 그 전에.','41',4,'2026-07-10 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='10시 발안IC, 12시 백숙, 2시 29℃ 유황탕');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='10시 발안IC, 12시 백숙, 2시 29℃ 유황탕' AND source='MOIS' AND external_id='69' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','가조 탄산탕 앞뒤로 국물 세 그릇','거창에서 속부터 데우는 법','/img/magazine/201.jpg','거창 가조는 비계산 아래 분지 마을이다. 탄산천은 32℃ — 톡 쏘는 미지근한 물에 오래 담그는 탕이라, 이 동네 먹거리도 화끈한 구이보다 뭉근한 국물 쪽에 무게가 실린다.

① 거창추어탕 — 한국관광공사 여행기사가 가조온천 주변 음식점으로 짚은 집. 추어탕은 미지근한 탕에서 나온 몸의 속을 데우는 데 이만한 게 없다. 아침 겸 점심으로 먼저 한 그릇.

② 홍천뚝배기 — 같은 기사에 소개된 뼈다귀 해장국집. 살 바르는 재미가 있는 묵직한 한 그릇이라 온천욕 후 허기가 클 때 맞다.

③ 소골둑 — 지역 소식 기사에 ''입소문이 자자한'' 집으로 소개된 향토 한식당. 국물 두 그릇 사이에 밥상 한 끼를 끼우는 용도다.

④ 비계산가든 — 거창파인밸리리조트 안의 꽃등심집. 국물 순례를 마친 저녁, 고기로 마침표를 찍고 싶을 때의 카드다.

하나 더. 거창의 대표 향토음식은 어탕국수다. 민물 잡어를 뼈째 고아 낸 국물에 국수를 마는 음식으로, 거창읍에 전문점들이 있다. 가조에서 차로 읍내까지 나갈 여유가 있다면 원정 가치가 충분하다.

거창터미널에서 가조행 버스 25분. 탄산 기포가 몸에 맺히는 탕과 국물 릴레이 — 가조의 하루는 안팎으로 따뜻해요.','48',4,'2026-07-11 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='가조 탄산탕 앞뒤로 국물 세 그릇');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='가조 탄산탕 앞뒤로 국물 세 그릇' AND source='MANUAL' AND name='가조온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','부모님 모시고 보문단지에서 실패하지 않는 법','순두부, 떡갈비, 꼬막비빔밥 — 3대가 앉는 밥상','/img/magazine/202.jpg','경주 보문단지는 온 가족이 오는 동네다. 그래서 밥집 선택의 기준도 하나로 좁혀진다. 3대가 한 상에 앉아 전부 만족할 것.

첫 끼는 맷돌순두부다. 보문단지 입구, 동궁원 맞은편의 두부요리 전문점으로 웨이팅이 있지만 회전이 빨라 체감 대기는 짧다. 보글보글 끓는 순두부찌개는 아이부터 어르신까지 수저 속도가 같아지는 몇 안 되는 메뉴다.

저녁은 보문뜰. 떡갈비와 한우 물회를 내는 집인데, 가성비가 좋고 밑반찬이 정갈해 부모님 동반에 적합하다는 평가가 후기의 공통분모다. 15~17시 브레이크타임만 피하면 된다 — 온천 시간을 그 사이에 배치하면 동선이 저절로 맞는다.

다음 날 점심은 올바릇식당의 꼬막비빔밥. 소노벨 경주 인근에서 보문호를 바라보며 먹을 수 있고, 포장 예약이 되니 귀갓길 KTX 도시락으로 싸 가는 수도 있다.

[IMG]보문호가 내다보이는 창가 자리, 꼬막비빔밥에 참기름이 돈다. ⓒ 물멍

보문온천은 44℃ 알칼리성 — 첨성대와 대릉원을 걸은 부모님 무릎에 딱 맞는 온도다. 경주 시내로 나가면 황남빵과 쌈밥거리가 기다리지만, 사실 보문단지 안에서만 사흘 밥상이 다 돌아갑니다.','47',4,'2026-07-13 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='부모님 모시고 보문단지에서 실패하지 않는 법');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='부모님 모시고 보문단지에서 실패하지 않는 법' AND source='MANUAL' AND name='보문온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','석쇠 위에서 완성되는 언양의 백 년 기술','등억 유황탕과 언양불고기거리','/img/magazine/203.jpg','언양불고기는 굽는 음식이 아니라 다지는 음식이다. 한우를 얇게 다져 양념하고, 석쇠에 넓게 펴 눌러 숯불에 굽는다. 고기 사이로 불이 지나가며 생기는 그을림 — 이게 언양의 백 년 기술이고, 언양읍에는 이 기술 하나로 불고기거리가 형성돼 있다.

원조 진불고기는 그 거리의 원조급 노포다. 석쇠에서 막 내린 불고기는 젓가락으로 뜯는 게 아니라 결대로 떨어진다. 언양 기와집 불고기 역시 언양을 대표하는 불고기 노포로 꼽히는 집이고, 식신에 등재된 언양불고기식당까지 — 세 집 모두 같은 음식을 다른 손맛으로 굽는다. 거리를 걸으며 굴뚝 연기가 진한 집을 고르는 것도 방법이다.

[QUOTE]언양불고기의 맛은 고기 반, 석쇠 자국 반이다.

등억알프스온천은 언양터미널에서 차로 15분, 영남알프스 신불산 자락이다. 물은 29℃ 유황천 — 등산으로 데워진 몸을 미지근하게 식히며 푸는 물이라, 산행 직후에 들어가는 게 가장 맛있는 사용법이다.

그래서 울주의 하루는 이렇게 조립된다. 아침 영남알프스 산행, 오후 등억 유황탕, 저녁 언양불고기거리. 산, 물, 불 — 세 가지 원소를 하루에 다 쓰는 코스입니다.','31',4,'2026-07-14 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='석쇠 위에서 완성되는 언양의 백 년 기술');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='석쇠 위에서 완성되는 언양의 백 년 기술' AND source='MANUAL' AND name='등억알프스온천' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','정동진에서 회 먹는 순서가 있다','탕에 들어가기 전과 후, 호텔탑스텐 주변 횟집 동선','/img/magazine/204.jpg','오후 세 시의 정동진역 앞은 조용해요. 기차가 한 번 지나가고 나면 파도 소리만 남죠. 이 시간에 도착했다면 순서를 정해야 해요. 회를 먼저 먹을지, 탕에 먼저 들어갈지.

저라면 회가 먼저예요. 정동진역 쪽 정동횟집은 광어회가 기본인데, 두툼하게 썰어 나오는 편이라 배가 어느 정도 차야 탕에서 어지럽지 않아요. 바로 해변가의 어부횟집은 물회 쪽이 강해요. 여름 끝물이라면 살얼음 뜬 물회 한 그릇이 온천 전 몸을 깨우는 데 더 낫습니다.

[IMG]정동진 해변가 횟집 수조 앞, 오후 햇빛에 광어 지느러미가 흔들린다. ⓒ 물멍

호텔탑스텐의 물은 29도짜리 중탄산천이에요. 뜨겁지 않고 미지근하게 몸을 감싸는 물이라, 회를 먹고 한 시간쯤 소화시킨 뒤 들어가도 부담이 없어요. 탕에서 나와 허기가 돌면 선택지가 둘로 갈립니다.

하나는 호텔 안에서 해결하는 것. 탑스텐호텔 스카이라운지는 티본스테이크를 내는데, 젖은 머리로 엘리베이터만 타면 되니 저녁 바다를 보며 먹기엔 이만한 동선이 없어요.

다른 하나는 차로 조금 내려가는 것. 금진항의 금진항옥계횟집은 자연산 회를 다루는 집이라, 낮에 양식 광어를 먹었다면 저녁엔 이쪽에서 자연산으로 비교해보는 재미가 있어요. 항구 앞이라 밤에는 배 불빛밖에 없지만, 그게 오히려 좋습니다.','51',4,'2026-07-16 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='정동진에서 회 먹는 순서가 있다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='정동진에서 회 먹는 순서가 있다' AND source='MOIS' AND external_id='4' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','씹지 말고 넘기세요 — 묵호 곰치국과 온천의 왕복','동해보양온천에서 묵호항까지, 해장 한 그릇과 언덕 하나','/img/magazine/205.jpg','숟가락에서 미끄러집니다. 뻘건 국물에 두부처럼 뭉텅뭉텅 들어간 곰치 살은 씹는 생선이 아니라 마시는 생선에 가깝습니다. 묵호에서 이 국을 처음 받은 사람은 대개 여기서 한 번 멈춥니다.

곰치는 못생긴 생선입니다. 흐물흐물하고 미끈거려서 어부들이 버리던 고기였다는 이야기가 따라다닙니다. 그 곰치를 신 김치와 함께 끓인 것이 묵호의 곰치국이고, 동해에 왔다면 이 국을 피해 가기가 더 어렵습니다.

순서는 탕이 먼저입니다. 동해보양온천컨벤션호텔에서 몸을 풀고 나오면 헛헛해지는데, 그 상태로 묵호항 쪽으로 갑니다. 칠형제곰치국은 곰치국과 가자미조림으로 알려진 집입니다. 곰치국이 부담스러운 일행이 있다면 동해바다곰치국 — 백반 차림을 같이 하니 이쪽이 안전합니다. 어느 집이든 아침 일찍부터 문을 여는 편이라, 숙박했다면 해장 동선으로 맞아떨어집니다.

[IMG]칠형제곰치국의 곰치국 한 그릇, 뻘건 국물 속에 곰치 살이 뭉텅뭉텅 잠겨 있다. ⓒ 물멍

[QUOTE]곰치 살은 씹는 게 아니라 국물과 함께 넘기는 것이다.

국을 비웠으면 소화는 걸어서 시킵니다. 묵호항 뒤편 언덕의 논골담길은 벽화 골목을 따라 오르면 도째비골 해랑전망대까지 이어집니다. 언덕 꼭대기에서 항구를 내려다보고, 내려와서 온천으로 돌아가 한 번 더 몸을 담급니다.

동해의 하루는 이 왕복이 전부여도 됩니다. 탕, 곰치국, 언덕, 다시 탕. 아침 일찍 문을 여는 집들이니, 알람을 한 시간 당기세요.','51',4,'2026-07-17 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='씹지 말고 넘기세요 — 묵호 곰치국과 온천의 왕복');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='씹지 말고 넘기세요 — 묵호 곰치국과 온천의 왕복' AND source='MOIS' AND external_id='9' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','순두부는 양념장 없이 두 술 먼저 — 설악의 저녁 세 갈래','한화리조트 설악에서 콩·바다·산 중 하나를 고르는 법','/img/magazine/206.jpg','양념장 없이 두 술. 김영애할머니순두부의 순두부를 받으면 먼저 그렇게 떠 보세요. 몽글몽글한 콩 맛이 양념보다 먼저 도착해요.

이 집은 한화호텔앤리조트 설악에서 가까운, 이 일대 순두부집 중에서도 이름이 앞에 놓이는 집이에요. 리조트의 물은 30도의 중탄산천 — 뜨겁지 않은 부드러운 물이라, 탕에서 나온 직후라면 순한 것에서 순한 것으로 이어지는 저녁이 됩니다. 이게 첫 번째 갈래, 콩이에요.

두 번째 갈래는 바다. 설악동 식당가가 산의 문법을 따른다면 속초 시내는 바다의 문법을 따르고, 리조트는 그 중간에 서 있어요. 속초해녀마을은 해산물 요리 전문점으로 이 근방 상위권에 꼬박꼬박 오르는 집이고, 향토음식이 궁금하다면 섭죽마을에서 섭죽을 시키세요. 섭은 자연산 홍합을 부르는 강원도 말인데, 죽인데도 국밥처럼 든든해서 탕 후 저녁으로 모자람이 없어요.

[IMG]설악동 식당가의 초저녁, 순두부 끓는 김이 유리문에 서린다. ⓒ 물멍

세 번째 갈래는 산. 설악동 방면의 점봉산산채는 산채 한식을 차려내는 집이에요. 나물 반찬이 줄줄이 깔리는 상을 받으면 등산을 안 했어도 한 것 같은 기분이 들죠.

[QUOTE]설악동은 산의 문법, 속초 시내는 바다의 문법 — 리조트는 그 사이에 있다.

그리고 맥주가 필요한 밤. 속초 시내의 크래프트루트는 수제맥주와 피자를 내는 브루펍인데, 온천과 산과 바다를 하루에 다 쓴 날의 마무리로 이보다 맞는 곳을 아직 못 찾았어요. 오늘 저녁은 셋 중 하나만 고르세요 — 나머지 둘은 내일 탕에서 나온 뒤에도 그 자리에 있으니까요.','51',4,'2026-07-19 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='순두부는 양념장 없이 두 술 먼저 — 설악의 저녁 세 갈래');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='순두부는 양념장 없이 두 술 먼저 — 설악의 저녁 세 갈래' AND source='MOIS' AND external_id='16' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','속초중앙시장은 줄부터 서고 생각한다','체스터톤스에서 걸어 나가는 시장 간식 동선','/img/magazine/207.jpg','닭강정 상자를 안 들고 속초중앙시장을 빠져나오는 사람을 본 적이 있던가요. 만석닭강정 중앙시장분점 앞 줄은 평일에도 줄어들 기미가 없어요. 달콤하고 매콤한 양념이 식어도 맛있다는 게 이 집의 오래된 영업 비밀이라, 상자째 포장해 숙소에서 밤에 먹는 사람이 절반이에요.

체스터톤스호텔앤드레지던스에서 시장까지는 속초 시내 동선 안이에요. 탕에서 나른해진 몸으로 시장을 한 바퀴 도는 것 자체가 후식 같은 일정이죠.

다만 닭강정은 간식이지 식사가 아니에요. 밥 같은 밥이 필요하면 엑스포공원 쪽의 속초아장물회로 가세요. 주문이 들어가면 그때 회를 손질해서 특제 육수에 말아내는 물회 전문점인데, 비빔물회에 전복죽·오징어순대까지 갖춰서 한 끼의 구색이 완성돼요. 탕에서 데운 몸에 차가운 물회를 붓는 그 온도차가 이 도시에서 먹는 물회의 핵심이고요.

[QUOTE]온천의 뜨거움은 물회의 차가움을 위한 준비운동이다.

의외의 카드도 하나 적어둘게요. 맥코리아라는 왕돈까스집이에요. 바닷가 도시까지 와서 돈까스냐 싶겠지만, 여행 이틀째쯤 해산물에 지친 위장이 보내는 신호를 받으면 이 이름이 떠오를 거예요. 접시를 덮는 크기라 나눠 먹어도 됩니다.','51',4,'2026-07-20 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='속초중앙시장은 줄부터 서고 생각한다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='속초중앙시장은 줄부터 서고 생각한다' AND source='MOIS' AND external_id='18' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','양양의 아침은 오후 세 시에 끝난다','더앤리조트 스파온과 황태국 한 그릇의 시간표','/img/magazine/208.jpg','감나무식당은 아침 일곱 시에 문을 열고 오후 세 시면 닫습니다. 저녁 장사를 안 하는 황태국 전문점이라, 이 집의 황태해장국을 먹으려면 여행 일정을 국밥에 맞춰야 합니다. 송이철에는 송이황태국밥이 나오는데, 그때는 웨이팅이 더 깁니다.

그래서 양양에서의 순서는 이렇게 됩니다. 아침에 국부터 먹고, 그다음 탕에 들어가는 것. 더앤리조트 스파온의 원수는 56도까지 올라가는 뜨거운 중탄산천이라, 황태국으로 속을 데운 뒤 들어가면 몸 안팎의 온도가 맞아떨어집니다.

[IMG]오전 여덟 시 감나무식당, 황태국 뚝배기에서 김이 수직으로 오른다. ⓒ 물멍

점심이나 저녁의 선택지는 넉넉합니다. 영광정메밀국수 본점은 3대째 50년을 이어온 막국숫집으로, 동치미막국수에 감자전을 곁들이는 것이 정석입니다. 수요미식회에 나온 이력이 있어 주말엔 붐빕니다. 가을이라면 송이골로 가서 송이 돌솥정식을, 바다 쪽 입맛이면 옛뜰에서 해녀가 채취한 자연산 섭으로 끓인 섭국을 드세요. 30년 전통이라는 말이 과장이 아닌 국물입니다.

회가 당기는 저녁엔 다래횟집이 있습니다. 자연산 모둠회에 얼큰한 매운탕까지 이어지는 코스라, 하루를 황태국으로 열고 매운탕으로 닫으면 양양의 국물을 처음과 끝으로 다 쓴 셈이 됩니다.','51',4,'2026-07-21 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='양양의 아침은 오후 세 시에 끝난다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='양양의 아침은 오후 세 시에 끝난다' AND source='MOIS' AND external_id='32' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','1965년산 짬뽕과 고추냉이 갈비','한탄리버스파호텔 주변, 철원의 노포와 별미들','/img/magazine/209.jpg','철원에서 가장 오래된 맛의 연도는 1965입니다. 고향식당이 중화요리를 시작한 해입니다. 육십 년째 끓이고 있는 이 집 짬뽕은 해물과 고기가 푸짐하게 올라간 칼칼한 국물로, 관광지 식당이 아니라 동네 노포의 얼굴을 하고 있습니다.

철원의 별미는 의외의 조합에서 나옵니다. 철원오대갈비는 물고추냉이 잎으로 돼지갈비를 숙성합니다. 매운맛이 아니라 알싸한 향이 배는 쪽인데, 여기에 철원오대쌀로 지은 밥이 따라 나옵니다. 갈비보다 밥이 먼저 비워지는 집이 있다면 대개 쌀이 좋은 고장이고, 철원이 그렇습니다.

[QUOTE]철원에서는 갈비집의 실력을 밥맛으로 먼저 안다.

한탄리버스파호텔의 물은 39도. 몸을 담그기에 꼭 알맞은 온도의 중탄산천이라 오래 앉아 있게 됩니다. 탕에서 나와 한탄강 물줄기를 따라가면 고석정 일대인데, 이 근방의 한탄강매운탕은 한탄강 민물고기로 끓이는 메기 매운탕에 수제비를 넣어 줍니다. 민물 매운탕 특유의 흙내가 없다는 것이 단골들의 공통된 증언입니다. 어탕국수로 가볍게 먹는 방법도 있습니다.

고기로 마무리하고 싶은 날은 동송 쪽입니다. 동송 한우직판장식당은 고석정·주상절리길에서 가까운 직판장 식당이라, 철원한우를 부담이 덜한 가격대로 구울 수 있습니다. 주상절리길을 걷고 온 저녁이라면 더 그렇습니다.','51',4,'2026-07-23 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='1965년산 짬뽕과 고추냉이 갈비');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='1965년산 짬뽕과 고추냉이 갈비' AND source='MOIS' AND external_id='38' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','석쇠에서 기름이 떨어지는 순간, 가평은 두 편으로 갈린다','남이가든의 숯불과 한옥닭갈비의 철판, 그리고 연인산온천 42℃ 유황천','/img/magazine/210.jpg','석쇠 아래로 기름 한 방울이 떨어지고, 불꽃이 튀어 올라요. 남이섬 인근 남이가든의 저녁은 이 소리로 시작해요. 가평 닭갈비는 불의 종류로 편이 갈리는데, 이 집은 숯불파의 대표 주자예요. 석쇠 위에서 기름을 떨구며 구운 닭은 불향이 배어 담백하고, 밥반찬보다 안주에 가까운 얼굴을 하고 있죠.

같은 동네의 한옥닭갈비는 반대편이에요. 철판 위에서 양배추·떡과 함께 볶고, 양념이 눌어붙기 시작할 때 볶음밥까지 가는 것이 철판파의 완성형이에요. 숯불은 굽는 소리로, 철판은 눌어붙는 냄새로 손님을 불러요.

[IMG]숯불 석쇠 위 닭갈비에서 떨어진 기름이 불꽃으로 튀어 오른다. ⓒ 물멍

어느 편에 섰든 마무리는 막국수예요. 힐링닭갈비처럼 닭갈비와 메밀막국수를 한 상에서 끝내는 집도 있지만, 막국수 자체가 목적이라면 송원막국수로 가세요. 생방송투데이에 나온 집으로, 수육을 곁들여 막국수 한 그릇을 비우고 나면 닭갈비 없이도 한 끼가 성립한다는 걸 알게 돼요.

순서는 닭갈비가 먼저예요. 연인산온천리조트의 물은 42℃ 유황천인데, 유황탕은 체력 소모가 있는 편이라 빈속으로 들어가면 손해예요. 경기도에서 유황천은 드문 패라, 달걀 삶은 듯한 물내를 맡으며 몸을 데우는 경험 자체가 가평까지 오는 이유가 돼요.

[QUOTE]가평에서 불은 둘이지만, 탕은 42℃ 하나다.

떠나기 전 트렁크에 자리를 남겨 두세요. 가평은 잣의 고장이라 잣국수와 잣막걸리가 닭갈비 뒤를 따라다녀요. 배는 닭갈비로 찼어도, 잣막걸리 한 병 실을 자리는 남아 있을 거예요.','41',4,'2026-07-24 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='석쇠에서 기름이 떨어지는 순간, 가평은 두 편으로 갈린다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='석쇠에서 기름이 떨어지는 순간, 가평은 두 편으로 갈린다' AND source='MOIS' AND external_id='42' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','젖은 머리가 마르기 전에, 부천 중동·상동의 밥상','웅진플레이도시 워터파크에서 미가원·영월보쌈·안나푸르나까지','/img/magazine/211.jpg','시계보다 위장이 먼저 퇴장 시간을 알려요. 웅진플레이도시에서 스파와 워터파크를 오가다 보면 그래요. 물에서 노는 것만큼 배가 빨리 꺼지는 일도 드물죠. 다행히 이곳은 부천 중동·상동 신도시 상권 한복판이라, 젖은 머리가 마르기 전에 밥상 앞에 앉을 수 있어요.

고기가 당기는 날은 미가원이에요. 이 일대 맛집 순위에서 꾸준히 상위권에 있는 고기구이집으로, 물놀이로 태운 열량을 단백질로 정직하게 갚는 코스예요.

속이 예민한 날은 영월보쌈이에요. 삶은 고기라 편해서, 스파에서 오래 몸을 불린 날의 저녁으로는 구이보다 보쌈이 낫다는 게 제 결론이에요.

[QUOTE]물놀이의 마무리는 불 앞이 아니라 김 오르는 수육 앞이 낫다.

일행에 아이나 매운맛 담당이 있다면 닭갈비제작소 중동점이 무난한 합의점이에요. 한 발 더 가면 상동의 안나푸르나 상동점. 인도 커리에 갓 구운 난을 찢어 먹는 집인데, 워터파크 나들이의 마무리로 커리는 의외로 잘 어울려요. 몸은 이미 반쯤 휴양지 모드니까요.

[IMG]영월보쌈의 수육 한 접시. 젖은 머리가 마르기 전에 김이 먼저 오른다. ⓒ 물멍

웅진플레이도시의 온천수는 20℃ 중탄산천이에요. 뜨끈하게 지지는 탕이 아니라 시설로 노는 물이죠. 그러니 여기선 물이 주인공이 아니라 밥이 주인공이어도 괜찮아요. 오늘은 고기, 보쌈, 닭갈비, 커리 중 하나만 고르고, 나머지 셋은 다음 물놀이 몫으로 남겨 두세요.','41',4,'2026-07-26 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='젖은 머리가 마르기 전에, 부천 중동·상동의 밥상');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='젖은 머리가 마르기 전에, 부천 중동·상동의 밥상' AND source='MOIS' AND external_id='44' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','31℃ 탕에서 두 시간, 그다음 바지락 껍데기가 쌓인다','북수원온천과 파장동 칼국수 골목 — 칼국수마당, 나드리칼국수, 만두가','/img/magazine/212.jpg','그릇 옆에 바지락 껍데기가 수북이 쌓여 갑니다. 수원 파장동의 칼국숫집에서, 목욕 두 시간 뒤에 벌어지는 일입니다. 목욕탕 앞에 칼국숫집이 많은 동네는 믿어도 됩니다.

북수원스파플렉스 북수원온천이 있는 파장동은 파장시장(북수원시장)을 낀 오래된 동네입니다. 서민 먹거리의 밀도가 높고, 그중에서도 칼국수가 유독 강세입니다. 탕에서 두 시간을 보내고 나온 몸이 원하는 것은 결국 뜨거운 국물과 밀가루라는 것을, 이 동네 상권은 오래전에 파악한 듯합니다.

칼국수마당은 바지락칼국수가 기본이지만 팥칼국수와 들깨옹심이까지 냅니다. 수원 토박이들의 추천 목록에 오르내리는 이름이라, 여름엔 바지락으로 겨울엔 팥으로 계절을 넘기는 단골이 많습니다. 근처의 나드리칼국수도 파장동 칼국수 지도에서 빠지지 않는 상호입니다. 두 집을 놓고 취향을 가르는 것이 이 동네 방문자의 오랜 숙제입니다.

[IMG]파장동 칼국숫집, 바지락 껍데기가 그릇 옆에 수북이 쌓여 간다. ⓒ 물멍

국물 전에 딤섬이 필요하다면 만두가 북수원점입니다. 수제만두집이라 칼국수 앞에 만두 한 판을 먼저 놓는 조합도 가능합니다.

북수원온천의 물은 31℃ 중탄산천입니다. 뜨겁게 지지는 물이 아니라 미지근하게 오래 담그는 물이라 목욕 시간이 길어지고, 그만큼 나왔을 때 허기도 정직하게 큽니다.

[QUOTE]31℃ 물에서 보낸 두 시간은 칼국수 곱빼기로 돌아온다.

파장동에서는 순서를 고민할 필요가 없습니다. 탕에 오래 있다가, 나와서 곱빼기를 시키면 됩니다.','41',4,'2026-07-27 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='31℃ 탕에서 두 시간, 그다음 바지락 껍데기가 쌓인다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='31℃ 탕에서 두 시간, 그다음 바지락 껍데기가 쌓인다' AND source='MOIS' AND external_id='46' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','옥천냉면, 실향민이 남긴 국물의 지도','쉐르빌온천에서 옥천면 냉면촌까지','/img/magazine/213.jpg','1952년, 황해도에서 내려온 실향민이 양평 옥천면에 냉면집을 열었습니다. 옥천냉면 황해식당의 시작입니다. 칠십 년이 지난 지금 옥천면에는 냉면집이 촌을 이루고 있고, 사람들은 이 국수를 평양냉면도 함흥냉면도 아닌 ''옥천냉면''이라는 고유명사로 부릅니다.

옥천냉면의 정체성은 돼지 육수와 마늘향입니다. 소고기 육수의 맑은 평양식과 달리 돼지뼈로 낸 국물이라 더 구수하고, 마늘 기운이 은근히 올라옵니다. 그리고 완자. 두툼하게 부친 돼지고기 완자를 냉면에 곁들이는 것이 이 동네의 문법이라, 황해식당에서도 냉면과 완자는 사실상 한 세트로 주문됩니다.

[QUOTE]옥천에서 완자 없이 냉면만 먹고 가는 것은 절반만 먹고 가는 것이다.

촌이 형성된 동네답게 선택지도 있습니다. 옥천냉면 본점, 옥천전통냉면 같은 상호들이 같은 동네에서 각자의 단골을 데리고 있습니다. 어느 집이 원조인가 하는 논쟁은 여행자가 낄 자리가 아니니, 줄이 짧은 집으로 들어가면 됩니다.

쉐르빌온천 관광호텔의 물은 34도의 중탄산천입니다. 체온보다 살짝 낮은 미지근함이라 오래 담그게 되는 물인데, 그렇게 몸을 데운 뒤 차가운 냉면 국물을 들이켜는 순서가 양평에서는 제일 자연스럽습니다. 뜨거운 물과 찬 국수 사이의 온도차, 그것이 이 코스의 전부이자 핵심입니다.','41',4,'2026-07-29 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='옥천냉면, 실향민이 남긴 국물의 지도');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='옥천냉면, 실향민이 남긴 국물의 지도' AND source='MOIS' AND external_id='47' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','백암순대는 왜 전국 3대가 되었나','용인스파랜드에서 백암면으로, 순대 계보 답사','/img/magazine/214.jpg','전국 3대 순대를 꼽을 때 빠지지 않는 이름이 백암순대다. 용인 처인구 백암면, 오일장이 서던 시골 면 소재지가 순대의 성지가 된 데는 계보가 있다.

가장 오래된 축은 중앙식당이다. 1940년대에 문을 연 백암순대 전문점으로, 사골을 12시간 우려낸 국물에 순대를 만다. 이 국물의 시간이 백암 순댓국의 기준점이 됐다. 그다음 세대가 1964년 개업한 제일식당이다. 미디어에 여러 번 소개되며 문전성시라는 말이 어울리는 집이 됐고, 지금 ''백암순대'' 하면 외지인이 가장 먼저 찾는 상호이기도 하다.

백암순대의 개성은 채소다. 당면으로 속을 채우는 순대와 달리 채소를 푸짐하게 넣어 담백하고, 그래서 국밥에 말아도 국물이 탁해지지 않는다. 백암식당은 생생정보 등 방송을 탄 노포로 이 스타일의 순댓국을 내고, 옥산가든은 순대에 한우를 함께 다뤄 순대 한 접시에 고기 한 점을 얹는 상차림이 가능하다.

[IMG]백암면 순댓국집, 뚝배기 속 순대가 국물 위로 반쯤 떠 있다. ⓒ 물멍

용인스파랜드의 온천수는 27.3도 중탄산천. 뜨거운 탕은 시설의 몫이고, 원수는 순한 쪽이다. 스파에서 반나절을 보내고 백암면까지 달려 순댓국 한 그릇으로 마무리하는 동선은, 용인이라는 넓은 도시를 가장 배부르게 쓰는 방법이다.','41',4,'2026-07-30 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='백암순대는 왜 전국 3대가 되었나');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='백암순대는 왜 전국 3대가 되었나' AND source='MOIS' AND external_id='50' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','이동갈비 거리에서 원조를 찾는 법: 연기 나는 집에 앉는다','포천 신북리조트 31℃ 단순천과 이동갈비마을 세 집 사용 설명서','/img/magazine/215.jpg','주말 오후, 포천 이동면 거리의 기본값은 갈비 연기예요. 숯불에 굽는 양념 소갈비가 거리 하나를 먹여 살린 지 수십 년. 한국관광공사에 ''이동갈비마을''로 등록된 이 거리에서 여행자의 첫 질문은 늘 같아요. 어느 집이 원조냐.

답부터 말하면, 원조 논쟁은 거리 전체의 오래된 마케팅이에요. 대신 세 집의 쓰임새가 달라요. 소문난이동갈비 포천이동본점은 예약 플랫폼에 오른 인기 매장이라 대기 없이 들어가려면 예약이 안전해요. 갈비생각은 자체 홈페이지까지 운영하는 전문점이고요.

집까지 갈비를 데려가고 싶다면 포천이동갈비본점이에요. 포장·택배를 병행하는 집이라, 트렁크에 한 짝 싣고 돌아가는 손님이 이 거리엔 흔해요.

[IMG]이동갈비 거리, 숯불 위 양념 소갈비에서 연기가 오른다. ⓒ 물멍

갈비의 짝은 포천 막걸리예요. 양조장의 고장답게 어느 갈비집 냉장고에도 막걸리가 채워져 있어요. 다만 탕을 남겨둔 낮이라면 잔은 미뤄두세요.

신북리조트의 물은 31℃ 단순천이에요. 순하고 부드러워 자극 없이 오래 담글 수 있는 타입이죠. 순서는 취향인데, 저는 탕 먼저를 권해요. 갈비 양념이 밴 손으로 탕에 들어가는 것보다, 말끔히 데워진 몸으로 숯불 앞에 앉는 쪽이 갈비에 대한 예의 같아서요.

[QUOTE]이동갈비 거리에서 원조를 찾는 가장 정확한 방법은 그냥 앉는 것이다.

그러니 간판을 고르느라 거리를 세 바퀴 돌지 마세요. 연기가 마음에 드는 집 앞에서 멈추고, 앉으세요.','41',4,'2026-08-01 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='이동갈비 거리에서 원조를 찾는 법: 연기 나는 집에 앉는다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='이동갈비 거리에서 원조를 찾는 법: 연기 나는 집에 앉는다' AND source='MOIS' AND external_id='54' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','산정호수 한 바퀴, 밥 세 끼','한화리조트 포천 산정호수 둘레길의 식사 시간표','/img/magazine/216.jpg','산정호수 둘레길은 한 바퀴 도는 데 넉넉잡아 한 시간. 문제는 그 한 시간이 식욕을 세 배로 만든다는 거예요.

낮 12시, 둘레길을 막 끝냈다면 금산가든이에요. 산정호수 산책 후 들르기 좋은 향토음식점으로, 버섯전골 국물이 깊고 칼칼해요. 산채비빔밥으로 가볍게 가는 방법도 있죠. 걷고 난 몸에 뜨거운 전골 국물이 들어가면 오전의 바람이 그제야 빠져나가요.

오후 3시, 탕의 시간. 한화호텔앤드리조트의 온천수는 31도 단순천이라 자극 없이 부드러워서, 점심 소화를 시키며 느긋하게 담그기 좋아요. 호수를 걷고 물에 잠기는, 포천식 반신욕 코스예요.

저녁 6시, 갈비의 시간. 이동 강변 갈비는 물가 풍경을 보며 숯불 이동갈비를 굽는 집이에요. 반려견 동반이 되는 집이라 개와 함께 온 여행자들에겐 귀한 선택지죠. 생갈비와 양념갈비를 반반 시켜 비교하는 것이 정석이고요.

[IMG]해 질 무렵 산정호수, 물 위로 오리배 두 척이 정박해 있다. ⓒ 물멍

다음 날 아침까지 포천에 있다면 산정호수 맛집이라는 상호의 식당이 주차장 바로 앞에 있어요. 매일 아침 채소 육수를 우려 만드는 부대찌개가 간판 메뉴라, 떠나기 전 마지막 끼니로 뜨끈한 찌개 한 냄비를 비우고 출발하면 됩니다.','41',4,'2026-08-02 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='산정호수 한 바퀴, 밥 세 끼');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='산정호수 한 바퀴, 밥 세 끼' AND source='MOIS' AND external_id='55' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','장승포 철판 위 열세 가지 바다','리베라호텔거제에서 만나는 해물전골과 뚝배기','/img/magazine/217.jpg','철판 하나에 열세 가지 해산물이 올라간다. 장승포 지심도 터미널 앞 해미촌의 해물철판전골 이야기다. 거제 앞바다에서 나는 것들을 철판에 둘러 담아 끓이는데, 조개가 입을 벌리는 순서대로 건져 먹다 보면 전골 하나로 거제의 어시장을 훑은 기분이 된다.

리베라호텔거제 관악의 온천은 나트륨-염화물천, 그러니까 바닷물을 닮은 소금기 있는 물이다. 염류천은 보온에 강해서 탕에서 나온 뒤에도 몸이 오래 따뜻하다. 바다를 닮은 물에 몸을 담그고 나와 바다를 그대로 끓인 전골 앞에 앉는 것. 거제에서는 안팎이 다 짭짤한 하루가 가능하다.

[QUOTE]거제에서는 탕의 물도, 저녁의 국물도 바다에서 왔다.

현지인 쪽 카드는 생생이다. 통문어를 통째로 넣은 해물뚝배기로 이름난 집인데, 뚝배기 위로 문어 다리가 걸쳐 나오는 비주얼이 먼저 유명해졌고 맛이 그 명성을 지탱한다. 성게비빔밥도 이 집의 주력이라, 전골의 왁자한 상차림보다 혼자 조용히 먹는 한 그릇이 필요한 날엔 이쪽이 맞다.

장승포항 일대는 거제에서도 해산물 상권의 밀도가 높은 동네다. 지심도로 들어가는 배가 뜨는 터미널이 있어, 아침 배로 동백섬을 다녀와 점심에 전골, 오후에 온천, 저녁에 뚝배기로 짜면 장승포에서의 하루가 빈틈없이 찬다.','48',4,'2026-08-04 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='장승포 철판 위 열세 가지 바다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='장승포 철판 위 열세 가지 바다' AND source='MOIS' AND external_id='73' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','운동, 사우나, 그리고 숙성 삼겹살','남강스파 앤 피트니스가 있는 김해 삼계동의 저녁','/img/magazine/218.jpg','헬스장과 사우나가 한 건물에 있는 동네의 저녁 메뉴는 어딘가 당당해요. 남강스파 앤 피트니스가 있는 김해 삼계동이 그래요. 운동하고 탕까지 마친 사람들이 쏟아져 나오는 신도시 상권이라, 저녁 선택지가 골고루 발달했죠.

① 요즘삼겹살 — 최상급 한돈을 15일 숙성해서 내는 고깃집이에요. 운동 후 단백질이라는 명분이 필요하다면 여기서 완성돼요. ② 샤브20 — 육수를 다섯 가지 중에 고르는 샤브 전문점. 탕에서 데운 몸을 국물로 이어가는, 가장 순한 동선이에요. ③ 바다칼국수&해물전골 — 해물을 듬뿍 넣은 시원한 국물이 간판이라 해장 겸 저녁으로 좋아요. ④ 두총각닭갈비&막국수 — 숯불 향의 매콤한 닭갈비. 땀을 뺐는데 또 땀 나는 걸 먹고 싶은 날이 있잖아요. ⑤ 혼다라멘 — 진한 육수의 일본식 라멘집. 혼밥러의 자리예요.

[IMG]삼계동 고깃집, 숙성고 유리 너머로 지방이 하얗게 굳은 삼겹살 덩어리가 걸려 있다. ⓒ 물멍

남강스파의 물은 24도 단순천이라 원수 자체는 순한 편이고, 뜨거운 탕과 사우나 시설이 몸을 데우는 역할을 해요. 김해 전체로 눈을 넓히면 뒷고기와 불암동 장어라는 향토 카드도 있지만, 삼계동에서의 하루라면 위의 다섯 집 안에서 저녁이 해결돼요. 운동은 안 했어도 사우나는 했으니까, 절반의 자격은 충분해요.','48',4,'2026-08-05 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='운동, 사우나, 그리고 숙성 삼겹살');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='운동, 사우나, 그리고 숙성 삼겹살' AND source='MOIS' AND external_id='87' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','워터파크 옆 동네가 갈비를 굽는 이유','김해롯데워터파크와 장유·율하 외식 지도','/img/magazine/219.jpg','하루 종일 물에서 논 가족의 저녁 메뉴가 왜 늘 갈비로 수렴하는지 생각해본 적 있나요. 답은 간단해요. 모두가 배고프고, 아무도 메뉴 회의를 할 기력이 없기 때문이죠. 김해롯데워터파크가 있는 장유·율하 신도시는 그 수렴의 결과가 상권으로 굳은 동네예요.

한우파는 가인화로구이 김해율하점으로 가요. 1+등급 원육을 직접 공수해 합리적인 가격에 내는 화로구이집이라, 갈비살과 부채살을 섞어 시키면 가족 단위 저녁이 깔끔하게 끝나요. 양념파는 낙원갈비집 김해장유점이에요. 숙성 양념 돼지갈비가 주력인 가족외식형 갈비집인데, 밥까지 볶아야 끝나는 유형의 저녁이죠. 초벌구이로 내는 외식명가 화로정은 LA갈비 쪽이라, 굽는 수고를 절반쯤 덜고 싶은 날의 카드예요.

불 앞이 부담스러우면 조림과 튀김이 있어요. 황금코다리 김해장유점은 특제 소스의 코다리조림 전문점이고, 카츠인은 국내산 한돈을 숙성해 튀기는 히레카츠집이에요. 물놀이로 지친 아이가 고를 확률이 가장 높은 건 물론 돈카츠 쪽이고요.

[QUOTE]워터파크의 하루는 슬라이드에서 시작해 불판에서 끝난다.

온천수 자체는 24도의 순한 단순천이라, 여기선 물이 놀이의 재료에 가까워요. 그러니 미련 없이 놀고, 저녁 상권에 몸을 맡기세요. 이 동네는 그 순서를 위해 설계된 것처럼 굴러가요.','48',4,'2026-08-07 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='워터파크 옆 동네가 갈비를 굽는 이유');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='워터파크 옆 동네가 갈비를 굽는 이유' AND source='MOIS' AND external_id='89' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','밀양 국밥은 맑고, 방아잎이 올라간다','호텔아리나에서 시작하는 밀양돼지국밥 계보 여행','/img/magazine/220.jpg','돼지국밥이라고 다 같은 국밥이 아닙니다. 부산식이 뽀얀 돼지 사골 국물이라면, 밀양식은 소머리 육수를 쓰는 맑은 국물 계열입니다. 그 위에 경상도 허브인 방아잎을 얹는 순간, 그릇은 완전히 밀양의 것이 됩니다.

계보의 현재를 보려면 밀양아리랑시장으로 갑니다. 시장 안 노포 단골집은 방아잎을 얹은 맑은 돼지국밥으로 6시내고향과 백종원의 3대천왕까지 다녀간 집입니다. 국물을 한 술 뜨면 ''돼지국밥은 무겁다''는 선입견이 그 자리에서 정정됩니다. 수육 한 접시를 곁들이면 시장 나들이의 격이 달라지고요.

원조 상권을 따지자면 무안면입니다. 밀양 시내에서 떨어진 이 면 소재지에 식육식당형 국밥집들이 골목을 이루는데, 동부식육식당과 무안식육식당이 그 골목의 오래된 이름들입니다. 식육식당이란 고기를 팔던 정육점이 밥상을 차리기 시작한 형태라, 고기의 신선도가 상호에 내장돼 있는 셈입니다.

[IMG]밀양아리랑시장 국밥집, 맑은 국물 위에 방아잎 두 장이 떠 있다. ⓒ 물멍

호텔아리나의 온천은 26도의 황산염천입니다. 진정 효과가 있다고 알려진 물이라, 국밥으로 속을 데우고 탕에서 몸을 가라앉히는 순서가 밀양에서는 자연스럽습니다. 국물의 고장에서 물의 진정까지, 밀양의 하루는 두 가지 액체로 완성됩니다.','48',4,'2026-08-08 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='밀양 국밥은 맑고, 방아잎이 올라간다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='밀양 국밥은 맑고, 방아잎이 올라간다' AND source='MOIS' AND external_id='90' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','아침 여덟 시, 국밥집 문이 먼저 열린다','천성산짐엔스파와 양산 덕계의 이른 한 그릇','/img/magazine/221.jpg','온천의 최적 시간대는 오전이라고 믿는 쪽입니다. 사람이 적고, 물이 하루 중 가장 정돈되어 있는 시간이니까요. 문제는 아침을 어디서 해결하느냐인데, 양산 덕계에서는 이 문제가 이미 풀려 있습니다.

착한돼지국밥은 아침 여덟 시부터 문을 엽니다. 사골 육수의 진한 돼지국밥집이라, 탕에 들어가기 전 빈속을 채우는 용도로도, 탕에서 나와 허기를 갚는 용도로도 시간이 맞습니다. 수육까지 시키는 건 나올 때의 몫으로 남겨두면 됩니다.

[QUOTE]국밥집이 문을 여는 시간이 곧 그 동네 온천의 개장 시간이다.

천성산짐엔스파의 물은 36도의 중탄산천. 체온과 거의 같은 온도라 들어가는 순간의 저항이 없고, 그래서 오전의 몸으로 가장 만만하게 들어갈 수 있는 물입니다. 유황 냄새도 뜨거운 김도 없이, 부드럽게 데워지는 쪽입니다.

덕계 생활권은 부산 접경이라 돼지국밥 문화가 짙게 배어 있는 동네입니다. 동동국밥 양산덕계점은 국밥에 우동까지 하는 집이라, 아침 국밥이 부담스러운 일행과 갈 때 유용합니다. 국밥 한 그릇, 미지근한 탕 두 시간, 다시 국밥 반 그릇. 화려할 것 없는 이 반복이 양산 덕계에서 보내는 반나절의 전부이고, 그것으로 충분합니다.','48',4,'2026-08-10 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='아침 여덟 시, 국밥집 문이 먼저 열린다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='아침 여덟 시, 국밥집 문이 먼저 열린다' AND source='MOIS' AND external_id='93' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','진주에서 온도를 세 번 갈아타는 법: 탕, 육수, 육전','윙스온천에서 하연옥까지, 찬 냉면 위에 따뜻한 육전을 얹는 도시','/img/magazine/222.jpg','얼음 뜬 육수 위에 노란 육전이 부채꼴로 얹혀 나온다. 하연옥 본점의 냉면 그릇이다. 진주냉면의 첫인상은 사치스럽다는 것인데, 해물로 낸 육수 위에 계란옷을 입혀 부친 소고기 육전이 올라가기 때문이다. 차가운 국수에 따뜻한 전을 얹는 조합은 다른 도시의 냉면에서는 볼 수 없는 진주만의 문법이다.

그 문법의 대표 주자가 하연옥이다. 진주냉면을 말할 때 가장 먼저 불리는 노포로, 본점의 냉면 그릇에는 육전이 시그니처처럼 얹혀 나온다. 이 집을 제대로 쓰는 방법은 냉면과 별개로 육전 한 접시를 추가하는 것. 갓 부쳐 나온 육전을 냉면 국물에 살짝 적셔 먹는 순간, 이 도시가 왜 음식으로 기억되는지 알게 된다.

[IMG]하연옥의 냉면 그릇, 얼음 뜬 육수 위에 노란 육전이 부채꼴로 얹혀 있다. ⓒ 물멍

본점 대기가 길면 하대동으로 옮기면 된다. 하연옥 하대동점이 있다. 줄이 아니라 냉면을 먹으러 온 사람에게는 이 분점의 존재가 곧 시간이다.

윙스온천 스파앤피트니스는 진주혁신도시, 충무공동에 있다. 신도시답게 주변에 신흥 외식 상권이 자라는 중이라, 고기가 필요한 저녁이라면 같은 동네의 태영한우 진주혁신도시점에서 한우를 구울 수 있다.

[QUOTE]뜨거운 물 뒤의 차가운 육수, 그 위의 따뜻한 육전 — 진주는 온도로 기억되는 도시다.

동선은 이렇다. 낮에 윙스온천의 탕과 사우나로 몸을 데우고, 점심 아니면 이른 저녁에 냉면집으로 간다. 뜨거운 물, 차가운 육수, 따뜻한 육전. 온도를 세 번 갈아타는 이 코스가 진주에서 반나절을 쓰는 가장 우아한 방법이다. 육전은 꼭 한 접시 더 시켜라.','48',4,'2026-08-11 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='진주에서 온도를 세 번 갈아타는 법: 탕, 육수, 육전');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='진주에서 온도를 세 번 갈아타는 법: 탕, 육수, 육전' AND source='MOIS' AND external_id='95' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','68도의 물, 게장으로 갚는 저녁','상대온천관광호텔과 경산의 밥상들','/img/magazine/223.jpg','68도. 상대온천의 원수 온도예요. 전국 온천을 통틀어도 앞줄에 서는 뜨거운 나트륨-염화물천이라, 탕에 들어갔다 나오면 보온 효과 때문에 한참 동안 몸에서 열이 안 빠져요. 이런 물을 만난 날의 저녁은 든든해야 공평하죠.

상대온천이 있는 남산면은 한적한 농촌권이라 주변엔 백숙과 토종닭을 하는 집들이 먼저 검색돼요. 탕 후 몸보신이라는 고전적인 조합이 필요하면 이 근방에서 해결하는 것도 방법이에요.

본격적인 밥상은 경산 시내로 나가야 해요. 풍천관은 간장게장과 게국지로 이름난 집이에요. 짭조름한 게장에 밥을 비비다 보면 밥도둑이라는 낡은 표현을 다시 꺼내게 되죠. 주차가 편한 것도 온천에서 차로 이동하는 동선에선 무시 못 할 장점이고요.

숯불이 당기면 닭바위예요. 숯불 닭갈비 전문점인데 상추겉절이와 미역국이 곁들이로 인기라는 점이 이 집의 성격을 말해줘요. 구이집인데 상이 정갈한 쪽이라는 뜻이죠. 솥밥이 필요한 날은 더반이에요. 버섯해물전골에 솥밥을 내는 한정식집으로, 마지막에 긁어 먹는 누룽지가 별미예요.

[QUOTE]뜨거운 물에는 짠 밥상이 붙는다. 경산의 저녁이 그 증거다.

68도의 물과 간장게장. 둘 다 진한 것들이라, 경산에서의 하루는 싱겁게 끝날 도리가 없어요.','47',4,'2026-08-13 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='68도의 물, 게장으로 갚는 저녁');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='68도의 물, 게장으로 갚는 저녁' AND source='MOIS' AND external_id='140' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','황리단길에서 저녁을 고르는 세 가지 방법','탕에서 나온 몸이 원하는 건 결국 고기다','/img/magazine/224.jpg','33도. 에스지빌라앤스파의 물은 뜨겁다기보다 미지근하게 몸을 감싸는 쪽이에요. 중탄산천 특유의 부드러운 물에 오래 잠겨 있다 나오면, 이상하게 허기가 천천히 그리고 확실하게 올라옵니다. 그럴 때 경주에서 갈 곳은 정해져 있어요. 황리단길.

① 취향가옥. 한옥을 고쳐 만든 식당인데, 소갈비찜을 압력솥으로 쪄내서 고기가 젓가락에 힘을 주기도 전에 갈라져요. 육전 밀면을 곁들이면 탕에서 빠져나간 염분까지 채워지는 기분. 대릉원과 첨성대가 가까우니 저녁 산책 전 이른 식사로 좋아요.

② 다인매운등갈비찜. 매일 새로 삶은 생고기만 쓴다는 집이에요. 매운 등갈비찜은 온천욕으로 노곤해진 몸을 한 번 더 깨우는 맛이라, 탕을 마친 날의 마지막 식사로 어울려요. 다음 날 또 탕에 들어갈 계획이라면 더더욱.

③ 범외양간. 황리단길에서 돌판 스테이크를 숯불로 구워내는 건 이 집뿐이라고 해요. 민물장어덮밥도 있어서, 온천 여행에 보양이라는 명분을 붙이고 싶은 날 고르기 좋습니다.

[IMG]압력솥에서 막 나온 취향가옥의 소갈비찜. 김이 가라앉기 전에 찍었다. ⓒ 물멍

순서는 이렇게 추천해요. 낮에 탕, 해질 무렵 대릉원 산책, 저녁은 셋 중 하나. 경주의 밤은 생각보다 길어요.','47',4,'2026-08-14 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='황리단길에서 저녁을 고르는 세 가지 방법');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='황리단길에서 저녁을 고르는 세 가지 방법' AND source='MOIS' AND external_id='141' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','파도소리 들으며 끓인 칼국수','양남, 온천과 바다가 한 동네에 있을 때 생기는 일','/img/magazine/225.jpg','양남은 조용한 동네입니다. 주상절리 파도소리길을 걷는 사람들, 방파제의 낚시꾼, 그리고 해수온천에 몸을 담그러 오는 사람들. 양남해수온천랜드의 33도짜리 중탄산천은 뜨겁게 지지는 물이 아니라 오래 머무는 물이라, 나올 때쯤이면 뜨끈한 국물 생각이 간절해집니다.

그 국물을 책임지는 곳이 양남해물칼국수입니다. 이름 그대로 해물칼국수 한 가지에 집중하는 집인데, 동해안 어촌의 칼국수답게 국물에서 바다 냄새가 먼저 올라옵니다. 탕에서 나와 몸이 식기 전에 바로 가는 것을 권합니다. 온천의 온기와 칼국수의 온기가 이어지면 그날 하루는 성공입니다.

[QUOTE]온천물도 바닷물도 다 짭짤한 동네에서, 국물이 맛없기가 더 어렵다.

저녁은 골목횟집입니다. 경북관광공사가 소개한 현지인 횟집으로, 붕장어 요리가 간판입니다. 아나고라고 불러야 더 익숙한 그 생선을, 구이로도 회로도 냅니다. 탕과 파도소리길 산책을 모두 마친 뒤의 저녁 자리로 좋습니다. 붕장어의 기름기는 걸은 만큼만 맛있어지는 법이니까요.

다음 날 아침 일찍 다시 탕에 들어가는 것으로 마무리하면, 1박의 구조가 완성됩니다.','47',4,'2026-08-16 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='파도소리 들으며 끓인 칼국수');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='파도소리 들으며 끓인 칼국수' AND source='MOIS' AND external_id='150' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','탕에서 나온 몸에 채소부터냐 두부부터냐, 보문단지 세 갈래','더케이호텔 경주 33℃ 중탄산천에서 갈라지는 쌈밥·순두부·한우','/img/magazine/226.jpg','숟가락을 넣으면 두부가 저항 없이 갈라집니다. 맷돌순두부 뚝배기 앞에서, 보문단지 온천을 마친 사람의 첫 끼가 정해지는 순간입니다. 하지만 여기까지 오기 전에 세 갈래 길이 있습니다. 쌈밥, 순두부, 한우. 경주 사람들도 이 순서를 두고 의견이 갈립니다.

쌈밥파의 근거지는 별채반 교동쌈밥입니다. 쌈 채소가 켜켜이 쌓인 상에 곤달비비빔밥 같은 나물 요리가 함께 오릅니다. 탕에서 땀을 뺀 몸에 채소부터 채워 넣는 순서가 옳다고 믿는 사람들의 선택이고, 점심에 가면 상이 더 가볍게 느껴집니다.

순두부파는 황남맷돌순두부와 전통맷돌순두부를 놓고 다시 갈립니다. 둘 다 경주시 문화관광 공식 소개에 오른 집이라 어느 쪽을 골라도 논쟁에서 지지 않습니다. 맷돌로 간 콩의 몽글한 순두부는 더케이호텔의 33℃ 중탄산천과 결이 같은 음식이라, 온천 직후의 첫 끼로 가장 자주 선택됩니다.

[IMG]맷돌순두부 뚝배기. 숟가락을 넣으면 두부가 저항 없이 갈라진다. ⓒ 물멍

한우파는 경주천년한우 보문점으로 갑니다. 보문단지 안에 있어 더케이호텔앤리조트에서 이동이 가장 짧다는 실리적 장점이 있습니다. 저녁에 구이로 제대로 먹고, 다음 날 아침 온천으로 해장하는 역순 코스를 짜는 사람들이 주로 여기 속합니다.

[QUOTE]보문단지에 정답은 없다. 있는 건 1박에 두 끼라는 산수뿐이다.

그러니 논쟁에 끼지 마십시오. 1박이면 세 곳 중 두 곳은 갈 수 있습니다. 오늘 저녁 한우, 내일 아침 탕, 그다음 순두부 — 이 순서로 짜면 됩니다.','47',4,'2026-08-17 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='탕에서 나온 몸에 채소부터냐 두부부터냐, 보문단지 세 갈래');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='탕에서 나온 몸에 채소부터냐 두부부터냐, 보문단지 세 갈래' AND source='MOIS' AND external_id='153' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','천북면에서는 고기 굽는 연기가 이정표다','블루밸리콘도온천과 한우단지의 거리','/img/magazine/227.jpg','경주 천북면에 들어서면 안내판보다 먼저 냄새가 방향을 알려줘요. 이 일대는 ''천북 한우단지''로 불릴 만큼 한우 숯불구이 식당이 몰려 있는 동네거든요. 블루밸리콘도온천에서 몸을 데운 다음의 동선이 아주 짧다는 뜻이에요.

물천한우는 방송에도 소개된 한우구이집이에요. 정육 식당 특유의 직관적인 방식, 그러니까 고기를 고르고 바로 구워 먹는 구조라 군더더기가 없어요. 온천욕을 마친 저녁, 오래 기다리지 않고 바로 불판 앞에 앉고 싶을 때 좋은 선택이에요.

옛날경주숯불은 TV생생정보에 나온 뒤로도 지역 평점이 최상위권을 지키는 집이에요. 숯불 향이 진하게 배는 스타일이라, 탕에서 씻어낸 몸에 다시 연기 냄새를 입히고 돌아가게 되지만 그게 이 동네를 다녀왔다는 증거이기도 하죠.

[QUOTE]탕에서 씻고 나와 굳이 숯불 앞에 앉는 것, 그게 천북식 온천 코스다.

고기가 아닌 날엔 착한밥상이 있어요. 한국인의밥상에 소개된 한식당인데, 반찬이 줄지어 나오는 한 상 차림이에요. 구이는 어제 먹었고 오늘은 아침 탕만 하고 돌아가는 날, 마지막 끼니로 부담이 없어요.

온천과 한우단지가 같은 면 안에 있는 조합은 흔치 않아요. 천북은 그 드문 경우예요.','47',4,'2026-08-18 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='천북면에서는 고기 굽는 연기가 이정표다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='천북면에서는 고기 굽는 연기가 이정표다' AND source='MOIS' AND external_id='155' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','45도 열탕 다음엔 북어물찜','구미 로컬만 아는 메뉴로 차리는 하루','/img/magazine/228.jpg','발리스파의 물은 45도. 이번 목록에서 손꼽히게 뜨거운 축입니다. 열탕에서 제대로 땀을 빼고 나온 몸이 원하는 것은 대체로 둘 중 하나입니다. 시원한 국물, 아니면 든든한 고기. 구미는 양쪽 다 준비되어 있습니다.

① 신사랑방부터 말해야 합니다. 북어물찜이라는, 구미 밖에서는 좀처럼 듣기 힘든 메뉴의 원조격 식당입니다. 촉촉하게 쪄낸 북어에 양념이 배어드는 요리로, 땀을 뺀 직후의 첫 끼로 이만한 것이 없습니다. 사태찌개도 함께 놓고 고민하게 됩니다.

② 진주국수는 해장 코스로도 꼽히는 집입니다. 찹쌀수제비와 특미막국수가 대표 메뉴인데, 감칠맛 나는 육수와 쫄깃한 면발 덕에 탕 전에 가볍게 먹는 점심으로도 어울립니다. 배가 너무 부르면 열탕이 힘들어지니, 탕 전이라면 수제비 쪽을 권합니다.

③ 저녁을 든든히 가려면 농우마실입니다. 돼지 본갈비와 목살갈비를 굽는 집으로 점심특선이 유명하지만, 온천 일정이라면 저녁 갈비가 순서상 맞습니다.

④ 구미역 근처 싱글벙글복어는 다음 날 아침용입니다. 밀복지리의 맑고 칼칼한 국물은 전날의 갈비와 열탕을 동시에 정리해 줍니다.

구미시가 ''구미맛집 100선''을 공식 선정해 운영하는 도시라는 점도 적어둡니다. 이 네 곳은 그 상권의 앞줄에 있는 집들입니다.','47',4,'2026-08-20 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='45도 열탕 다음엔 북어물찜');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='45도 열탕 다음엔 북어물찜' AND source='MOIS' AND external_id='157' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','점촌의 1975년생 순대와 61도의 물','문경 온천 여행의 먹는 순서','/img/magazine/229.jpg','문경 에스티엑스리조트의 원수는 61도예요. 몸을 담그면 어깨까지 노곤해지는 진짜 열탕이죠. 이 물에서 나온 다음의 문경을 먹는 순서로 정리해 봤어요.

첫 끼는 약돌돼지여야 해요. 약돌 사료를 먹여 키운 문경 특산 돼지인데, 문경약돌돼지한마리가 그 전문점이에요. 구이로 먹는 게 정석이고, 탕에서 빠진 기운을 채우는 저녁 메뉴로 이보다 문경다운 게 없어요.

다음 날은 점촌 시내로 나가요. 진미순대는 1975년부터 영업 중인 노포예요. 오십 년째 순대를 만드는 집 앞에 서면 메뉴 고민이 사라져요. 순대 한 접시면 아침 탕을 마친 속이 조용해집니다.

면이 당기는 날엔 두 가지 선택지가 있어요. 한성짬뽕은 그릇 위가 화려하기로 유명한 짬뽕집이고, 산북손짜장은 수타면으로 짜장을 내는 집이에요. 짬뽕이냐 짜장이냐 하는 오래된 질문이 문경에서는 두 집 중 어디로 가느냐의 문제가 돼요.

[IMG]진미순대 앞. 간판보다 세월이 먼저 보인다. ⓒ 물멍

마무리는 산양면의 한옥 카페 화수헌. 문경 오미자 제품을 기념품으로 챙기는 것까지 하면, 61도에서 시작한 여행이 차 한 잔으로 식으며 끝나요. 온도가 높은 데서 낮은 데로 흐르는 여행. 문경은 그 순서가 자연스러운 동네예요.','47',4,'2026-08-21 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='점촌의 1975년생 순대와 61도의 물');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='점촌의 1975년생 순대와 61도의 물' AND source='MOIS' AND external_id='161' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','41℃ 탕을 사이에 두고, 닭과 고등어가 싸운다','안동온천 스파랜드에서 찜닭골목과 일직식당까지, 순서의 문제','/img/magazine/230.jpg','안동에서 한 끼만 먹을 수 있다면? 이 질문은 잔인합니다. 찜닭과 간고등어가 각자의 골목에서 백 년 가까운 서사를 쌓아온 도시이기 때문입니다.

찜닭 진영부터 보겠습니다. 안동시골찜닭은 찜닭골목의 대표 주자로, 간장 양념에 조린 닭과 당면의 정석을 냅니다. 종가찜닭은 남은 국물에 밥을 비벼 먹는 맛으로 알려진 집입니다. 찜닭은 양이 많고 짭짤해서, 안동온천 스파랜드에서 41℃ 탕을 마치고 수분과 염분이 동시에 그리운 저녁에 어울립니다.

간고등어 진영은 일직식당이 이끕니다. 여러 방송에 나온 안동 간고등어의 대표 주자로, 구이정식의 껍질 익는 냄새만으로 밥 한 공기가 사라집니다. 다만 소금 간이 깊이 밴 생선이라, 탕에 들어가기 전 점심으로 먹으면 탕 안에서 내내 물을 마시게 됩니다. 순서는 탕 먼저입니다.

[IMG]일직식당의 간고등어 구이, 껍질이 익으며 기름이 배어 나온다. ⓒ 물멍

중재안도 있습니다. 안동김대감은 간고등어와 찜닭을 한 상에 올리는 집입니다. 일행의 의견이 갈렸을 때 여기서 싸움이 끝납니다.

[QUOTE]안동에서는 닭과 고등어가 싸우고, 손님은 이기기만 하면 된다.

다음 날 아침 몫도 있습니다. 헛제사밥까치구멍집은 백년가게 인증을 받은 집으로, 제사 없이 차리는 제삿밥, 헛제사밥을 냅니다. 고춧가루 없이 간장으로 비비는 밥은 탕을 마친 다음 날 아침의 속에 가장 관대한 음식입니다. 그러니 안동은 한 끼로 계획하지 마십시오. 탕, 저녁, 아침 — 세 번의 식탁이 41℃ 물 주위에 이미 차려져 있습니다.','47',4,'2026-08-23 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='41℃ 탕을 사이에 두고, 닭과 고등어가 싸운다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='41℃ 탕을 사이에 두고, 닭과 고등어가 싸운다' AND source='MOIS' AND external_id='177' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','대게 찌는 김, 온천에서 나는 김','겨울 강구항과 79도 염류천의 상관관계','/img/magazine/231.jpg','겨울 강구항에는 두 종류의 김이 오릅니다. 하나는 대게 찜통에서, 하나는 온천탕에서. 영덕 메르센트리조트의 원수는 79도, 소금기를 품은 염류천이라 몸에 온기가 오래 남습니다. 대게 철에 이 조합을 맞추러 오는 사람들이 있습니다.

영덕대게는 겨울부터 봄까지가 제철이고, 그중 살이 꽉 찬 것을 박달대게라 부릅니다. 강구항의 대게천국은 바닷가 자리에서 박달대게 풀코스를 내는 집입니다. 찜에서 시작해 볶음밥으로 끝나는 코스의 구조는 어디나 비슷하지만, 게살의 밀도가 다릅니다. 여름이라면 물회로 방향을 틀면 됩니다.

영덕대게궁은 30년 넘게 대게를 쪄온, TV에도 나온 집입니다. 두 집 다 예산이 필요한 식사이니, 온천욕으로 하루를 열고 대게를 저녁의 정점에 두는 배치를 권합니다. 몸이 따뜻할 때 먹는 대게는 손이 덜 곱아 살도 더 잘 발립니다.

[IMG]강구항 대게 찜통에서 오르는 김. 겨울 항구의 난방이다. ⓒ 물멍

대게가 부담스러운 날의 대안도 적어둡니다. 강구항 풍물어시장 안 대구횟집은 바다를 보며 대게 코스를 먹는 또 다른 선택지고, 나비산 기사식당은 물곰탕과 물가자미찌개로 20년을 버틴 현지인 식당입니다. 주말엔 줄이 섭니다. 바다 생선이 아예 당기지 않으면 아성식당의 한우불고기가 있습니다. 송이불고기라는 호사도 가능합니다.','47',4,'2026-08-24 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='대게 찌는 김, 온천에서 나는 김');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='대게 찌는 김, 온천에서 나는 김' AND source='MOIS' AND external_id='182' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','물가자미라는 생선을 아세요?','칠보산 온천 아랫동네, 축산항의 밥상','/img/magazine/232.jpg','영덕 사람들이 대게만 먹고 사는 건 아니에요. 칠보산온천리조트가 있는 병곡·영해 쪽 생활권에서 진짜 일상의 생선은 물가자미예요. 뼈째 썰어 회로, 찌개로, 조림으로. 이 동네 밥상의 주연이죠.

그 물가자미를 제대로 하는 집이 영덕물가자미전문점이에요. 식객 허영만의 백반기행에 소개된 곳으로, 물가자미정식을 시키면 회와 조림이 한 상에 올라요. 79도 염류천에 몸을 데우고 나온 점심으로, 기름진 것 없이 개운하게 정리되는 상이에요. 김가네식당도 물가자미찌개와 물회를 전문으로 하는 방송 촬영지였던 집이라, 두 집을 놓고 고르면 돼요.

국물 쪽으로 가면 송천강재첩국이 있어요. 재첩국이 깊고 시원하기로 소문난 현지인 맛집인데, 재첩수제비와 재첩전까지 있어서 술 없이도 해장하는 기분이 나요. 아침 일찍 탕에 들어가기 전, 속을 데우는 첫 끼로 제일 좋아요.

대게가 그리운 날은 축산항의 정일호선주집으로 가요. TV에 나온 대게 횟집으로, 박달대게와 모둠회를 함께 내요. 강구항까지 가지 않고도 대게 코스가 되는 셈이죠.

[QUOTE]대게는 손님 상에 오르고, 물가자미는 주인 상에 오른다는 말이 있는 동네다.

온천은 몸을 데우고, 물가자미는 속을 데워요. 영덕의 북쪽은 그렇게 먹는 동네예요.','47',4,'2026-08-26 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='물가자미라는 생선을 아세요?');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='물가자미라는 생선을 아세요?' AND source='MOIS' AND external_id='183' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','묵을 72시간 쑤는 동네의 점심','영주온천랜드 앞뒤로 배치하는 다섯 끼','/img/magazine/233.jpg','영주에는 묵을 72시간에 걸쳐 쑤는 집이 있어요. 영주전통묵집식당. 메밀묵밥이 대표 메뉴인데, 오래 쑨 묵 특유의 탄력이 숟가락에서부터 느껴져요. 순흥 묵밥은 영주의 오랜 향토식이고, 이 집은 그 전통을 웰빙이라는 말이 생기기 전부터 지켜온 곳이에요. 51도 온천에서 땀을 빼고 나온 속에 차게 말아낸 묵밥을 넣는 순간이, 영주 온천 여행의 핵심 장면이에요.

영주온천랜드 일정에 끼워 넣을 나머지 네 끼는 이래요.

쫄면이 궁금하면 두 집이 경쟁해요. 나드리쫄면은 40년 전통에 백년가게로 선정된 집이고, 중앙분식은 33년째 원조 쫄면을 내는 집이에요. 영주가 쫄면에 진심인 도시라는 건 이 두 집의 존속 연수만 봐도 알 수 있죠. 매콤새콤한 쫄면은 탕 전 가벼운 점심에 어울려요.

든든한 상이 필요하면 두부마을 택지2호점. 영주 부석태 재래콩으로 만드는 청국장과 두부돈까스로 백년가게에 선정됐어요. 청국장 냄새가 부담스럽지 않은 편이라 입문용으로도 좋아요.

저녁은 너른마당의 궁중백숙이에요. 7가지 약초를 쓰는 약선 음식점이라, 온천욕과 보양식이라는 오래된 짝을 완성해 줘요.

묵과 쫄면과 청국장과 백숙. 영주는 화려하지 않은 대신 오래 검증된 것들로 상을 차리는 도시예요.','47',4,'2026-08-27 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='묵을 72시간 쑤는 동네의 점심');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='묵을 72시간 쑤는 동네의 점심' AND source='MOIS' AND external_id='184' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','51℃ 탕에서 나와 인삼 도너츠 봉지를 든다, 풍기의 오후','소백산풍기온천에서 정도너츠·영주칠향계·순흥기지떡까지, 조리법 세 개','/img/magazine/234.jpg','봉지 안에서 갓 튀긴 도너츠의 온기가 손바닥으로 올라옵니다. 소백산풍기온천에서 51℃ 탕을 마치고 나온 오후, 풍기읍을 걷는 손에 들린 것은 인삼 도너츠입니다. 풍기는 인삼의 동네고, 인삼의 동네답게 간식마저 인삼으로 만듭니다.

그 도너츠를 튀기는 곳이 정도너츠입니다. 풍기읍에서 40년째 도너츠를 튀기는 집으로, 인삼 도너츠가 간판이고 사과와 생강 도너츠도 있습니다. 몸에 좋은 것을 튀겨 먹는다는 모순이 즐거운 집이라, 온천의 노곤함과 도너츠의 온기는 생각보다 잘 어울립니다.

[IMG]정도너츠의 인삼 도너츠. 쌉싸름함은 설탕이 해결한다. ⓒ 물멍

끼니는 영주칠향계입니다. 7가지 약초를 우린 육수로 끓이는 칠향계 삼계탕 전문점으로, 인삼의 고장에서 먹는 삼계탕이니 재료의 출처를 의심할 필요가 없습니다. 온천욕으로 열어둔 땀구멍에 뜨거운 탕약 같은 국물을 부어 넣는 순서가 보양의 정석이라, 탕 후 저녁 자리에 두는 것을 권합니다.

마지막 조각은 순흥면에 있습니다. 순흥기지떡은 50년 전통의 발효떡 명가입니다. 기지떡은 막걸리로 반죽을 발효시켜 찌는 떡이라 폭신하고 은은하게 시큼한데, 상하기 쉬운 여름이 아니라면 다음 날 아침까지도 맛이 유지됩니다. 숙소에서 아침 탕 전에 한 조각 먹는 용도로 사 가면 정확합니다.

[QUOTE]풍기의 하루는 튀긴 것, 끓인 것, 찐 것 — 조리법 세 개로 요약된다.

오후엔 튀긴 것, 저녁엔 끓인 것, 다음 날 아침엔 찐 것. 이 순서대로 봉지 세 개를 채우고, 사이사이 51℃ 탕에 들어가면 됩니다.','47',4,'2026-08-29 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='51℃ 탕에서 나와 인삼 도너츠 봉지를 든다, 풍기의 오후');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='51℃ 탕에서 나와 인삼 도너츠 봉지를 든다, 풍기의 오후' AND source='MOIS' AND external_id='186' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','58℃ 열탕에서 나와 3대째 곰탕 솥 앞으로, 영천 장터의 순서','광천온천랜드와 영천공설시장 — 곰탕, 육회비빔밥, 꾼만두, 새우칼국수','/img/magazine/235.jpg','국솥에서 오르는 김이 탕의 연장처럼 느껴져요. 광천온천랜드에서 58℃ 열탕을 마친 몸으로 영천공설시장 곰탕골목에 들어서면 그래요. 영천은 장의 도시예요. 한우와 돔배기라 불리는 상어고기가 이 장터의 오랜 주인공이죠.

곰탕 쪽의 대표 선수는 포항할매집이에요. 이름은 포항인데 영천에서 3대째 소머리곰탕과 도가니탕을 끓이는 집으로, 여러 TV 프로그램에 소개됐어요. 뽀얀 국물에 밥을 말면 열탕에서 빠져나간 기운이 그릇 단위로 복구돼요. 탕 직후 첫 끼로 이만한 게 없어요.

[IMG]영천공설시장 곰탕골목, 포항할매집 솥에서 김이 오른다. ⓒ 물멍

한우의 도시라는 정체성은 화평대군 식당에서 확인해요. 1975년부터 50년을 이어온 한우 식육식당인데, 간판은 육회비빔밥이에요. 육회를 비빔밥으로 먹는 건 구이보다 빠르고 가벼워서, 오후 탕을 남겨둔 점심에 알맞아요.

온천 가는 길엔 삼송꾼만두 영천본점이에요. 45년 전통의 백년가게로, 속이 꽉 찬 꾼만두를 튀겨내요. 포장해서 차에서 먹는 사람이 많은 이유는 한 입이면 알게 돼요.

푸짐한 걸로 마무리하고 싶은 저녁엔 영천새우칼국수. 새우칼국수와 닭불고기를 함께 하는 집인데, 양으로 현지인 입소문이 난 곳이에요.

[QUOTE]장이 서는 도시에서 온천 여행은 밥 걱정이 없다. 영천이 그 증거다.

그러니 영천에선 식당 검색에 시간을 쓰지 마세요. 가는 길에 꾼만두, 점심에 육회비빔밥, 탕 직후 곰탕, 저녁에 새우칼국수 — 순서만 정하고 출발하면 돼요.','47',4,'2026-08-30 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='58℃ 열탕에서 나와 3대째 곰탕 솥 앞으로, 영천 장터의 순서');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='58℃ 열탕에서 나와 3대째 곰탕 솥 앞으로, 영천 장터의 순서' AND source='MOIS' AND external_id='188' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','덕구온천 1박, 옹심이로 열고 대게로 닫는 순서','41℃ 중탄산천에서 나온 몸이 울진에서 먹는 네 끼','/img/magazine/236.jpg','국물에 들어간 지 몇 초, 옹심이는 자기가 어떻게 만들어졌는지 들킵니다. 덕구솔밭옹심이칼국수는 감자를 직접 갈아 옹심이를 빚고 칼국수 위에 얹어 냅니다. 그래서 덕구온천에서 나온 손님들이 이 집 앞에 줄을 섭니다.

순서가 중요합니다. 덕구의 물은 41℃ 중탄산천. 오래 담그고 나오면 속이 헐거워지는 느낌이 드는데, 쫄깃한 옹심이와 뜨끈한 국물이 그 빈자리를 정확히 채웁니다. 탕 전에 먹으면 배가 불러 탕이 짧아지고, 탕 뒤에 먹으면 하루가 완성됩니다. 울진까지 와서 순서를 틀릴 이유가 없습니다.

[IMG]칼국수 위에 얹힌 감자 옹심이. 김이 걷히기 전에 한 개 먼저. ⓒ 물멍

아침은 다른 집입니다. 할머니순두부는 순두부 백반과 곤드레비빔밥을 냅니다. 이른 시간에 탕에 들어갈 계획이라면, 부드러운 두부로 속을 달래는 첫 끼로 이 집을 권합니다. 온천 동네의 아침에 맞는 온도입니다.

저녁에는 격식을 맞춥니다. 청아가든은 한방 재료를 쓴 한방오리와 해물전골을 내는 집입니다. ''국민보양온천''이라는 이름을 단 온천 곁에서 보양식으로 하루를 닫는 것, 덕구에서는 그게 예의입니다.

[QUOTE]감자를 가는 수고를 아끼는 옹심이는 국물에 들어가는 순간 들킨다.

겨울이라면 마지막 칸이 하나 더 열립니다. 죽변항과 후포항의 울진대게. 대게찜과 온천은 울진 겨울 여행의 오래된 공식입니다. 옹심이로 열고 대게로 닫는 1박 — 이 동네의 표준을 그대로 따르면 됩니다. 탕에 먼저 들어가고, 그다음에 옹심이입니다.','47',4,'2026-09-01 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='덕구온천 1박, 옹심이로 열고 대게로 닫는 순서');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='덕구온천 1박, 옹심이로 열고 대게로 닫는 순서' AND source='MOIS' AND external_id='191' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','청도역 앞에는 추어탕 골목이 있다','29도 냉온천과 뜨거운 국물의 균형','/img/magazine/237.jpg','청도굿스파의 물은 29도예요. 뜨겁다기보다 미지근한, 오래 담그는 염류천이죠. 그래서 청도에서는 뜨거움을 밥상에서 찾게 돼요. 마침 이 동네엔 그 역할을 백 년 가까이 해온 골목이 있어요. 청도역 앞 추어탕 골목.

골목의 현역 중 하나가 역전추어탕이에요. 전통추어탕에 미꾸라지튀김까지, 가격도 부담 없는 현지인 집이죠. 청도 추어탕은 미꾸라지를 갈아 맑게 끓이는 경상도식이라 걸쭉한 남원식과는 결이 달라요. 29도 탕에서 나와 몸이 아쉬워하는 온도를 이 뚝배기가 채워줘요. 탕 후 첫 끼로 배치하세요.

고기 쪽 대표는 청도가마솥국밥이에요. 이름은 국밥집인데 정작 오픈 시간부터 줄을 세우는 건 육회와 육회비빔밥이에요. 신선도가 생명인 메뉴로 승부하는 집이라 이른 점심에 가는 게 유리해요.

면 요리 두 집도 적어둘게요. 이지비짬뽕은 차돌박이짬뽕을 칼칼하고 깔끔하게 내는 집이고, 국수사랑은 해물칼국수와 콩국수를 하는데 주차장이 넓어서 온천 가는 길에 들르기 좋아요.

[IMG]추어탕 뚝배기와 산초 가루. 청도식은 국물이 맑다. ⓒ 물멍

돌아가는 길엔 청도 반시를 한 상자 사요. 씨 없는 감이라는 별명의 그 감이에요. 미지근한 탕, 뜨거운 추어탕, 달콤한 감. 청도의 온도는 그렇게 세 단계로 정리돼요.','47',4,'2026-09-02 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='청도역 앞에는 추어탕 골목이 있다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='청도역 앞에는 추어탕 골목이 있다' AND source='MOIS' AND external_id='202' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','옹치기, 청도 사람들의 닭 조리법','용암온천 곁에서 만나는 향토 닭요리와 미나리','/img/magazine/238.jpg','청도에는 다른 지역에서 통 들어본 적 없는 닭요리가 있습니다. 옹치기. 닭을 특유의 소스에 조려내는 향토 음식으로, 단짠의 균형이 찜닭과도 닭볶음탕과도 다릅니다.

이 요리를 하는 두 집이 나란히 방송을 탔습니다. 시골집은 생생정보통에 나온 집으로, 특유의 소스가 배어든 조림닭을 냅니다. 오경통닭 옹치기는 생활의 달인에 방영된 청도시장의 집입니다. 시장 안에서 먹는 단짠 닭요리는 장 구경과 묶으면 그 자체로 반나절 일정이 됩니다. 용암온천관광호텔의 29도 염류천은 서두르지 않고 오래 담그는 물이라, 탕을 마친 뒤의 늦은 점심으로 옹치기를 배치하면 시간이 맞습니다.

구이가 필요한 저녁에는 선택지가 둘입니다. 백운숯불갈비는 최고 등급 한우만 쓰는 숯불갈비집이고, 정우숯불가든은 30년 넘게 수제 양념을 지켜 백년가게 인증을 받은 집입니다. 육회비빔밥부터 생삼겹살까지 폭이 넓어 일행의 취향이 갈릴 때 유리합니다.

계절이 맞다면 하나 더. 청도는 한재 미나리의 산지라, 초봄이면 미나리에 삼겹살을 싸 먹는 조합이 온 동네의 행사가 됩니다. 온천욕 후 미나리 향으로 마무리하는 초봄의 청도는, 옹치기의 계절과는 또 다른 얼굴입니다.

낯선 이름의 음식이 있는 동네는 믿어도 됩니다. 그 이름이 살아남았다는 것 자체가 검증이니까요.','47',4,'2026-09-04 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='옹치기, 청도 사람들의 닭 조리법');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='옹치기, 청도 사람들의 닭 조리법' AND source='MOIS' AND external_id='203' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','약수로 끓인 백숙이라는 발명','청송 달기약수터 백숙촌에서의 한나절','/img/magazine/239.jpg','청송 사람들은 오래전에 알아냈어요. 톡 쏘는 탄산 약수로 닭을 삶으면 잡내가 사라지고 육질이 부드러워진다는 걸. 그렇게 달기약수터 주변에 백숙촌이 생겼고, 지금도 그 발명은 유효해요.

달기약수닭백숙 해성은 그 백숙촌에서 현지인 입소문으로 꼽히는 집이에요. 달기약수로 끓인 토종닭백숙이 기본이고, 닭떡갈비라는 변주도 있어요. 백숙은 주문 후 시간이 걸리는 음식이니, 소노호텔앤리조트 청송의 74도 온천에서 몸을 데우고 나오는 시간에 맞춰 미리 전화해 두면 동선이 매끄러워요. 온천으로 데운 몸에 약수 백숙을 더하는 것, 청송식 이중 보양이죠.

[QUOTE]물 좋은 동네는 결국 물로 요리를 한다.

한 상 제대로 받고 싶은 날엔 삼보식당이에요. 60년 전통의 한정식당인데, 더덕구이정식과 흑미약물닭백숙이 대표 메뉴예요. 주왕산에서 나는 산나물 밑반찬이 상을 채우는 집이라, 주왕산 산행과 온천을 묶은 날의 저녁으로 맞아요.

생선 쪽 선택지는 청송송어장횟집이에요. 직영 양식장에서 갓 잡은 송어만 써서 비린내가 없다는 게 이 집의 자부심이에요. 송어회로 시작해 송어매운탕으로 끝내는 구성이 가능해요.

후식은 정해져 있어요. 청송 사과. 가을이면 도로변 판매대마다 쌓이는 그 사과를 트렁크에 싣는 것으로 청송 일정은 끝나요.','47',4,'2026-09-05 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='약수로 끓인 백숙이라는 발명');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='약수로 끓인 백숙이라는 발명' AND source='MOIS' AND external_id='204' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','31℃ 탕에서 나온 몸이 고르는 왜관의 국물 한 그릇','칠곡 그린랜드와 싸리골 식당 — 메뉴 셋이 계절을 나눠 맡는 집','/img/magazine/240.jpg','메뉴 셋이 계절을 나눠 맡습니다. 간판은 해물칼국수, 여름엔 콩국수, 구수한 쪽이 당기는 날엔 청국장. 칠곡 왜관 싸리골 식당의 주문표는 그래서 언제 가도 어렵지 않습니다.

왜관은 맛집 리스트가 긴 동네가 아닙니다. 대신 오래된 밥집들이 조용히 제 몫을 합니다. 국밥과 칼국수 — 소도시 노포가 지키는 두 개의 국물이 이 동네 외식의 뼈대입니다.

물도 같은 성격입니다. 그린랜드의 온천수는 31℃ 단순천. 뜨겁게 지지는 탕이 아니라 오래 머무는 탕이라, 나와서도 화려한 음식보다 순한 국물이 당깁니다. 왜관의 밥상과 물이 닮은 셈입니다.

싸리골 식당은 시골집 분위기의 칼국수집입니다. 해산물이 듬뿍 들어간 해물칼국수 국물이 간판. 탕에서 나른해진 오후에 이 한 그릇이면 왜관의 반나절이 정리됩니다.

[IMG]해물이 잠긴 칼국수 국물. 왜관의 오후는 이 온도로 흐른다. ⓒ 물멍

돌아가는 길엔 꿀입니다. 칠곡은 아카시아 벌꿀 산지로, 봄이면 지천의 아카시아가 이 동네 양봉의 밑천이 됩니다. 병 하나면 기념품 고민이 끝납니다.

[QUOTE]요란한 미식의 동네가 아니라는 것. 그건 단점이 아니라 성격이다.

31℃에 오래 담갔다 나온 몸이라면 이미 알고 있을 겁니다. 칼국수 한 그릇 시키고, 꿀 한 병 들고 돌아가면 됩니다.','47',4,'2026-09-07 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='31℃ 탕에서 나온 몸이 고르는 왜관의 국물 한 그릇');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='31℃ 탕에서 나온 몸이 고르는 왜관의 국물 한 그릇' AND source='MOIS' AND external_id='207' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','해 뜨자마자 탕, 그다음 물회 — 호미곶에서 구룡포까지','한반도 동쪽 끝의 반나절, 다섯 칸으로 채우기','/img/magazine/241.jpg','해가 제일 먼저 뜨는 동네에서는 밥도 제일 먼저 먹게 돼요. 호미곶온천랜드에서 아침 탕을 마치고 나오면, 여기서 구룡포까지 이어지는 반나절짜리 먹거리 동선이 시작돼요.

첫 정거장은 해맞이광장 근처 등대지기 식당. 시원한 육수의 물회가 간판이고 홍게 같은 해산물도 내요. 탕에서 데운 몸에 찬 물회를 붓는 순서 — 포항식 온냉교대욕이라고 불러도 돼요. 아침 겸 점심으로 여기서 속을 깨우세요.

판을 키우고 싶으면 바다랑대게예요. 호미곶 인근에서 대게 코스를 하는데, 구룡포식 모리국수를 같이 내요. 모리국수는 생선과 해물을 잔뜩 넣고 끓이는 구룡포 뱃사람들의 국수. 대게로 시작해 국물로 닫는 순서가 이 집에서는 자연스러워요.

오후는 구룡포 일본인 가옥거리. 여든여덟밤과 구룡가옥, 두 곳 다 옛 일본 가옥의 골격을 살린 카페예요. 적산가옥 창틀 사이로 들어오는 오후 빛 아래서 커피를 마시면, 아침의 온천이 꽤 먼 일처럼 느껴져요.

[IMG]구룡포 일본인 가옥거리의 목조 이층집들. 카페 간판이 없으면 시대를 헷갈릴 골목. ⓒ 물멍

겨울이면 한 칸이 더 붙어요. 구룡포는 과메기의 본진이니까요. 온천, 물회, 대게, 적산가옥 카페, 과메기. 다섯 칸을 반나절에 채우는 동네예요.

[QUOTE]탕에서 데운 몸에 찬 물회를 붓는 것, 포항식 온냉교대욕이다.

조건은 하나, 아침 탕을 놓치지 않는 것. 해가 먼저 뜨는 만큼 하루도 먼저 시작하세요. 나머지 다섯 칸은 동선이 알아서 채워요.','47',4,'2026-09-08 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='해 뜨자마자 탕, 그다음 물회 — 호미곶에서 구룡포까지');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='해 뜨자마자 탕, 그다음 물회 — 호미곶에서 구룡포까지' AND source='MOIS' AND external_id='209' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','죽도시장 곰탕골목에는 65년 된 솥이 있다','포항건강랜드에서 시장까지, 국물의 동선','/img/magazine/242.jpg','죽도시장은 포항의 위장입니다. 수산시장으로 유명하지만, 이 시장의 진짜 저력은 곰탕골목에 있습니다.

골목의 터줏대감은 장기식당입니다. 3대째 65년, 수요미식회에 나온 곰탕과 수육의 집입니다. 몇 걸음 옆 평남식당은 40년 넘은 노포로 백종원의 3대천왕에 나왔고, 소머리곰탕과 한우수육을 냅니다. 두 집의 솥이 나란히 끓는 골목을 걷다 보면, 어느 집 앞에서 걸음이 멈추느냐가 그날의 점심을 정합니다. 포항건강랜드에서 몸을 데우고 나온 뒤라면 어느 솥이든 정답입니다.

[QUOTE]시장 곰탕집의 역사는 간판이 아니라 솥 밑바닥에 쌓인다.

물회를 빼고 포항을 말할 수는 없습니다. 환여횟집 본점은 매콤달콤한 육수를 부어 먹는 포항물회의 원조급으로 TV에 여러 번 나왔고, 마라도회식당은 38년 전통에 생활의 달인 최강달인으로 선정된 집입니다. 참가자미물회가 이 집의 자랑입니다. 탕에서 나온 여름 오후라면 곰탕 대신 물회로 방향을 트는 것도 맞는 선택입니다.

아침형 여행자를 위한 집도 있습니다. 조방돼지국밥은 포항터미널 인근에서 아침 7시부터 문을 여는 노포입니다. 이른 국밥 한 그릇으로 하루를 열고, 오전 탕에 들어가는 순서가 가능하다는 뜻입니다.

겨울이 오면 이 모든 목록 위에 과메기가 얹힙니다. 국물의 도시는 계절마다 두꺼워집니다.','47',4,'2026-09-10 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='죽도시장 곰탕골목에는 65년 된 솥이 있다');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='죽도시장 곰탕골목에는 65년 된 솥이 있다' AND source='MOIS' AND external_id='216' ON CONFLICT (magazine_id,place_id) DO NOTHING;
INSERT INTO magazines (category,title,subtitle,thumbnail_url,body,sido_code,read_minutes,published_at) SELECT 'FOOD','나물 열세 가지를 세고 비빈다 — 무등산 보리밥거리와 24℃ 탕','광주 지산동, 산·온천·보리밥이 걸어서 닿는 동네','/img/magazine/243.jpg','비비기 전에 세어 보면 열세 가지예요. 팔도강산의 무등산 보리밥정식을 시키면 나물 반찬이 그렇게 깔리고 시래기 된장국이 따라와요. 갓 지은 보리밥에 나물을 얹고 고추장과 참기름을 두르는 게 이 거리의 표준 동작이에요.

거리의 이름은 무등산 보리밥거리. 등산객들이 하산 후 막걸리와 함께 비벼 먹던 밥이 거리 하나를 이뤘어요. 광주 지산동, 무등산 자락이에요.

호텔무등파크의 온천이 바로 이 동네예요. 물은 24℃ 중탄산천 — 지지는 물이 아니라 느긋하게 몸을 담그는 물이에요. 그렇게 나온 점심으로, 기름진 것 하나 없이 배가 부른 보리밥상이 정확히 맞아요. 산, 온천, 보리밥이 도보 생활권 안에 있는 배치는 드물어요.

할머니집 온천 보리밥은 상호에 아예 ''온천''이 들어간 집이에요. 지산동 온천 곁에서 보리밥을 차려 온 세월이 이름에 남은 거죠. 탕과 밥 사이가 이보다 가까운 조합은 흔치 않아요.

[IMG]보리밥상 위의 나물 반찬들. 비비기 전에 세어 보면 열세 가지다. ⓒ 물멍

[QUOTE]고추장 한 숟갈 넣기 전에, 나물 열세 가지를 먼저 센다.

순서는 이래요. 오전에 무등산 자락을 가볍게 걷고, 보리밥에 막걸리 한 잔, 오후에 탕. 저녁이 남으면 광주의 떡갈비나 오리탕으로 채우면 돼요. 산 아랫동네의 하루는 이렇게 짜는 거예요 — 오늘은 열세 가지부터 세어 보세요.','29',4,'2026-09-11 00:00:00+09'::timestamptz WHERE NOT EXISTS (SELECT 1 FROM magazines WHERE title='나물 열세 가지를 세고 비빈다 — 무등산 보리밥거리와 24℃ 탕');
INSERT INTO magazine_places (magazine_id,place_id,sort_order) SELECT m.id,p.id,0 FROM magazines m, places p WHERE m.title='나물 열세 가지를 세고 비빈다 — 무등산 보리밥거리와 24℃ 탕' AND source='MOIS' AND external_id='223' ON CONFLICT (magazine_id,place_id) DO NOTHING;
COMMIT;