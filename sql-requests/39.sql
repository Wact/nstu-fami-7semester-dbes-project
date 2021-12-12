-- данные о товарообороте торговой точки за указанный период
SELECT *
FROM selling
WHERE sale_datetime > ?
  AND sale_datetime < ?
  AND outlet_id = ?;

-- данные о товарообороте всех торговых точек определенной группы за указанный период
SELECT *
FROM selling
WHERE sale_datetime > ?
  AND sale_datetime < ?
  AND outlet_id IN (SELECT id
                    FROM outlet
                    WHERE outlet_type_id = ?
);
