-- номенклатура и объем товаров в указанной торговой точке
SELECT p.*, ca.coming_amount - sa.selling_amount AS amount
FROM (SELECT product_barcode, SUM(amount) AS coming_amount
      FROM coming
      WHERE outlet_id = ?
      GROUP BY product_barcode
     ) AS ca
         LEFT JOIN (SELECT product_barcode, SUM(amount) AS selling_amount
                    FROM selling
                    WHERE outlet_id = ?
                    GROUP BY product_barcode
) AS sa
                   ON ca.product_barcode = sa.product_barcode
         INNER JOIN product AS p
                    ON ca.product_barcode = p.barcode;
