-- номенклатура и объем товаров в указанной торговой точке
SELECT p.*, ca.coming_amount - sa.selling_amount AS amount
FROM (SELECT product_id, SUM(amount) AS coming_amount
      FROM coming
      WHERE outlet_id = ?
      GROUP BY product_id
     ) AS ca
LEFT JOIN (SELECT product_id, SUM(amount) AS selling_amount
           FROM selling
           WHERE outlet_id = ?
           GROUP BY product_id
          ) AS sa
          ON ca.product_id = sa.product_id
INNER JOIN product AS p
           ON ca.product_id = p.id;
