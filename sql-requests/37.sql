-- сведения о покупателях указанного товара за обозначенный
-- (или за весь) период по всем торговым точкам
SELECT *
FROM client
WHERE id IN (SELECT DISTINCT client_id
             FROM realization
             WHERE product_id = ?
            );

-- сведения о покупателях указанного товара за обозначенный
-- (или за весь) период по торговым точкам указанного типа
SELECT *
FROM client
WHERE id IN (SELECT DISTINCT client_id
             FROM realization
             WHERE product_id = ?
               AND outlet_id IN (SELECT id
                                 FROM outlet
                                 WHERE outlet_type_id = ?
                                )
            );

-- сведения о покупателях указанного товара за обозначенный
-- (или за весь) период по данной торговой точке
SELECT *
FROM client
WHERE id IN (SELECT DISTINCT client_id
             FROM realization
             WHERE product_id = ?
               AND outlet_id = ?
            );
