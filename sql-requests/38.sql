-- сведения о наиболее активных покупателях
-- по всем торговым точкам
SELECT *
FROM client
WHERE id IN (SELECT client_id
             FROM selling
             GROUP BY client_id
             ORDER BY SUM(amount) DESC
             LIMIT 10
);

-- сведения о наиболее активных покупателях
-- по торговым точкам указанного типа
SELECT *
FROM client
WHERE id IN (SELECT client_id
             FROM selling
             WHERE outlet_id IN (SELECT id
                                 FROM outlet
                                 WHERE outlet_type_id = ?
             )
             GROUP BY client_id
             ORDER BY SUM(amount) DESC
             LIMIT 10
);

-- сведения о наиболее активных покупателях
-- по данной торговой точке
SELECT *
FROM client
WHERE id IN (SELECT client_id
             FROM selling
             WHERE outlet_id = ?
             GROUP BY client_id
             ORDER BY SUM(amount) DESC
             LIMIT 10
);
