-- перечень покупателей указанного вида товара за некоторый период
SELECT DISTINCT client_id
FROM selling
WHERE sale_datetime >= ?
  AND sale_datetime <= ?
  AND product_barcode IN (SELECT barcode
                          FROM product
                          WHERE product_type_id = ?
);

-- общее число покупателей указанного вида товара за некоторый период
SELECT COUNT(DISTINCT client_id)
FROM selling
WHERE sale_datetime >= ?
  AND sale_datetime <= ?
  AND product_barcode IN (SELECT barcode
                          FROM product
                          WHERE product_type_id = ?
);

-- перечень покупателей указанного вида товара,
-- сделавших покупку товара в объеме не менее заданного
SELECT DISTINCT client_id
FROM selling
WHERE amount >= ?
  AND product_barcode IN (SELECT barcode
                          FROM product
                          WHERE product_type_id = ?
);

-- общее число покупателей указанного вида товара,
-- сделавших покупку товара в объеме не менее заданного
SELECT COUNT(DISTINCT client_id)
FROM selling
WHERE amount >= ?
  AND product_barcode IN (SELECT barcode
                          FROM product
                          WHERE product_type_id = ?
);
