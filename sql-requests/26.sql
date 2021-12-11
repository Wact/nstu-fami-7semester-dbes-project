-- перечень покупателей указанного вида товара за некоторый период
SELECT DISTINCT client_id
FROM realization
WHERE datetime >= ?
  AND datetime <= ?
  AND product_id IN (SELECT barcode
                     FROM product
                     WHERE product_type_id = ?
                    );

-- общее число покупателей указанного вида товара за некоторый период
SELECT COUNT(DISTINCT client_id)
FROM realization
WHERE datetime >= ?
  AND datetime <= ?
  AND product_id IN (SELECT barcode
                     FROM product
                     WHERE product_type_id = ?
                    );

-- перечень покупателей указанного вида товара,
-- сделавших покупку товара в объеме не менее заданного
SELECT DISTINCT client_id
FROM realization
WHERE amount >= ?
  AND product_id IN (SELECT barcode
                     FROM product
                     WHERE product_type_id = ?
                    );

-- общее число покупателей указанного вида товара,
-- сделавших покупку товара в объеме не менее заданного
SELECT COUNT(DISTINCT client_id)
FROM realization
WHERE amount >= ?
  AND product_id IN (SELECT barcode
                     FROM product
                     WHERE product_type_id = ?
                    );
