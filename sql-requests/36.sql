-- сведения о поставках товаров по указанному номеру заказа
SELECT *
FROM supply
WHERE id IN (SELECT DISTINCT supply_id
             FROM order_item
             WHERE order_id IN (SELECT id
                                FROM order
                                WHERE id = ?
                               )
            );
