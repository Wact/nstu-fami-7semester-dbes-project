-- сведения о поставках определенного товара указанным поставщиком за все время
SELECT s.*, d.warehouse_id, d.delivery_date, d.amount
FROM supply AS s
RIGHT JOIN (SELECT *
            FROM distribution
            WHERE supply_id IN (SELECT id
                                FROM supply
                                WHERE product_id = ?
                                  AND provider_id = ?
                               )
           ) AS d
           ON s.id = d.supply_id;

-- сведения о поставках определенного товара указанным поставщиком за некоторый период
SELECT s.*, d.warehouse_id, d.delivery_date, d.amount
FROM supply AS s
RIGHT JOIN (SELECT *
            FROM distribution
            WHERE supply_id IN (SELECT id
                                FROM supply
                                WHERE product_id = ?
                                  AND provider_id = ?
                               )
              AND delivery_date >= ?
              AND delivery_date <= ?
           ) AS d
           ON s.id = d.supply_id;
