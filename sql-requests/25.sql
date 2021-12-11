-- перечень поставщиков указанного вида товара
-- в объеме не менее заданного за весь период
SELECT DISTINCT provider_id
FROM supply
WHERE max_size > ?
  AND product_id IN (SELECT barcode
                     FROM product
                     WHERE product_type_id = ?
                    );

-- перечень поставщиков указанного вида товара
-- в объеме не менее заданного за указанный период
SELECT DISTINCT provider_id
FROM supply
WHERE max_size > ?
  AND datetime >= ?
  AND datetime <= ?
  AND product_id IN (SELECT barcode
                     FROM product
                     WHERE product_type_id = ?
                    );

-- перечень поставщиков некоторого товара
-- в объеме не менее заданного за весь период
SELECT DISTINCT provider_id
FROM supply
WHERE max_size > ?
  AND product_id = ?;

-- перечень поставщиков некоторого товара
-- в объеме не менее заданного за указанный период
SELECT DISTINCT provider_id
FROM supply
WHERE max_size > ?
  AND datetime >= ?
  AND datetime <= ?
  AND product_id = ?;

-- общее число поставщиков указанного вида товара
-- в объеме не менее заданного за весь период
SELECT COUNT(DISTINCT provider_id)
FROM supply
WHERE max_size > ?
  AND product_id IN (SELECT barcode
                     FROM product
                     WHERE product_type_id = ?
                    );

-- общее число поставщиков указанного вида товара
-- в объеме не менее заданного за указанный период
SELECT COUNT(DISTINCT provider_id)
FROM supply
WHERE max_size > ?
  AND datetime >= ?
  AND datetime <= ?
  AND product_id IN (SELECT barcode
                     FROM product
                     WHERE product_type_id = ?
                    );

-- общее число поставщиков некоторого товара
-- в объеме не менее заданного за весь период
SELECT COUNT(DISTINCT provider_id)
FROM supply
WHERE max_size > ?
  AND product_id = ?;

-- общее число поставщиков некоторого товара
-- в объеме не менее заданного за указанный период
SELECT COUNT(DISTINCT provider_id)
FROM supply
WHERE max_size > ?
  AND datetime >= ?
  AND datetime <= ?
  AND product_id = ?;
