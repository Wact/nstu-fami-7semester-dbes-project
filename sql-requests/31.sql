-- данные об объеме продаж указанного товара за некоторый период
-- по всем торговым точкам
SELECT outlet_id, SUM(amount)
FROM selling
WHERE product_barcode = ?
  AND sale_datetime > ?
  AND sale_datetime < ?
GROUP BY outlet_id;

-- данные об объеме продаж указанного товара за некоторый период
-- по торговым точкам заданного типа
SELECT outlet_id, SUM(amount)
FROM selling
WHERE product_barcode = ?
  AND sale_datetime > ?
  AND sale_datetime < ?
  AND outlet_id IN (SELECT id
                    FROM outlet
                    WHERE outlet_type_id = ?
)
GROUP BY outlet_id;

-- данные об объеме продаж указанного товара за некоторый период
-- по конкретной торговой точке
SELECT SUM(amount)
FROM selling
WHERE product_barcode = ?
  AND sale_datetime > ?
  AND sale_datetime < ?
  AND outlet_id = ?;
