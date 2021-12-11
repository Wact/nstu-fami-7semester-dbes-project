-- актуальные сведения об объеме и ценах на указанный товар
-- по всем торговым точкам
SELECT ca.product_id, ca.coming_amount - sa.selling_amount AS amount, pr.item_price
FROM (SELECT outlet_id, product_id, SUM(amount) AS coming_amount
      FROM coming
      WHERE product_id = ?
      GROUP BY outlet_id
     ) AS ca
LEFT JOIN (SELECT outlet_id, product_id, SUM(amount) AS selling_amount
           FROM selling
           WHERE product_id = ?
           GROUP BY outlet_id
          ) AS sa
          ON ca.product_id = sa.product_id
            AND ca.outlet_id = sa.outlet_id
INNER JOIN (
  SELECT p.outlet_id, p.product_id, r.item_price
  FROM (SELECT id, item_price
        FROM price
        WHERE relevance = TRUE
       ) AS r
  INNER JOIN (SELECT outlet_id, price_id, product_id
              FROM coming
              WHERE product_id = ?
             ) AS p
             ON r.id = p.price_id
           ) AS pr
           ON ca.product_id = pr.product_id
             AND ca.outlet_id = pr.outlet_id;


-- актуальные сведения об объеме и ценах на указанный товар
-- по торговым точкам указанного типа
SELECT ca.product_id, ca.coming_amount - sa.selling_amount AS amount, pr.item_price
FROM (SELECT product_id, SUM(amount) AS coming_amount
      FROM coming
      WHERE outlet_id IN (SELECT id
                          FROM outlet
                          WHERE outlet_type_id = ?
                         )
        AND product_id = ?
     ) AS ca
LEFT JOIN (SELECT product_id, SUM(amount) AS selling_amount
           FROM selling
           WHERE outlet_id IN (SELECT id
                               FROM outlet
                               WHERE outlet_type_id = ?
                              )
             AND product_id = ?
          ) AS sa
          ON ca.product_id = sa.product_id
INNER JOIN (
  SELECT p.product_id, r.item_price
  FROM (SELECT id, item_price
        FROM price
        WHERE relevance = TRUE
       ) AS r
  INNER JOIN (SELECT price_id, product_id
              FROM coming
              WHERE outlet_id IN (SELECT id
                                  FROM outlet
                                  WHERE outlet_type_id = ?
                                 )
                AND product_id = ?
             ) AS p
             ON r.id = p.price_id
           ) AS pr
           ON ca.product_id = pr.product_id;

-- актуальные сведения об объеме и ценах на указанный товар
-- по конкретной торговой точке
SELECT ca.product_id, ca.coming_amount - sa.selling_amount AS amount, pr.item_price
FROM (SELECT product_id, SUM(amount) AS coming_amount
      FROM coming
      WHERE outlet_id = ?
        AND product_id = ?
     ) AS ca
LEFT JOIN (SELECT product_id, SUM(amount) AS selling_amount
           FROM selling
           WHERE outlet_id = ?
             AND product_id = ?
          ) AS sa
          ON ca.product_id = sa.product_id
INNER JOIN (
  SELECT p.product_id, r.item_price
  FROM (SELECT id, item_price
        FROM price
        WHERE relevance = TRUE
       ) AS r
  INNER JOIN (SELECT price_id, product_id
              FROM coming
              WHERE outlet_id = ?
                AND product_id = ?
             ) AS p
             ON r.id = p.price_id
           ) AS pr
           ON ca.product_id = pr.product_id;
