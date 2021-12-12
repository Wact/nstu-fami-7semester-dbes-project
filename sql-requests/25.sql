-- перечень поставщиков указанного вида товара
-- в объеме не менее заданного за весь период
SELECT DISTINCT supplier_id
FROM supply
WHERE max_size > ?
  AND product_barcode IN (SELECT barcode
                          FROM product
                          WHERE product_type_id = ?
);

-- перечень поставщиков указанного вида товара
-- в объеме не менее заданного за указанный период
SELECT DISTINCT supplier_id
FROM supply
WHERE max_size > ?
  AND production_date >= ?
  AND production_date <= ?
  AND product_barcode IN (SELECT barcode
                          FROM product
                          WHERE product_type_id = ?
);

-- перечень поставщиков некоторого товара
-- в объеме не менее заданного за весь период
SELECT DISTINCT supplier_id
FROM supply
WHERE max_size > ?
  AND product_barcode = ?;

-- перечень поставщиков некоторого товара
-- в объеме не менее заданного за указанный период
SELECT DISTINCT supplier_id
FROM supply
WHERE max_size > ?
  AND production_date >= ?
  AND production_date <= ?
  AND product_barcode = ?;

-- общее число поставщиков указанного вида товара
-- в объеме не менее заданного за весь период
SELECT COUNT(DISTINCT supplier_id)
FROM supply
WHERE max_size > ?
  AND product_barcode IN (SELECT barcode
                          FROM product
                          WHERE product_type_id = ?
);

-- общее число поставщиков указанного вида товара
-- в объеме не менее заданного за указанный период
SELECT COUNT(DISTINCT supplier_id)
FROM supply
WHERE max_size > ?
  AND production_date >= ?
  AND production_date <= ?
  AND product_barcode IN (SELECT barcode
                          FROM product
                          WHERE product_type_id = ?
);

-- общее число поставщиков некоторого товара
-- в объеме не менее заданного за весь период
SELECT COUNT(DISTINCT supplier_id)
FROM supply
WHERE max_size > ?
  AND product_barcode = ?;

-- общее число поставщиков некоторого товара
-- в объеме не менее заданного за указанный период
SELECT COUNT(DISTINCT supplier_id)
FROM supply
WHERE max_size > ?
  AND production_date >= ?
  AND production_date <= ?
  AND product_barcode = ?;
