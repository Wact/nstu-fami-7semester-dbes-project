-- данные о выработке на одного продавца за указанный период
-- по всем торговым точкам
SELECT outlet_id, AVG(count) AS output
FROM (SELECT outlet_id, COUNT(*) AS count
      FROM selling
      WHERE sale_datetime > ?
        AND sale_datetime < ?
      GROUP BY employee_id, outlet_id
     ) AS a
GROUP BY outlet_id;

-- данные о выработке на одного продавца за указанный период
-- по торговым точкам заданного типа
SELECT outlet_id, AVG(count) AS output
FROM (SELECT outlet_id, COUNT(*) AS count
      FROM selling
      WHERE sale_datetime > ?
        AND sale_datetime < ?
        AND outlet_id IN (SELECT id
                          FROM outlet
                          WHERE outlet_type_id = ?
      )
      GROUP BY employee_id, outlet_id
     ) AS a
GROUP BY outlet_id;

-- данные о выработке на одного продавца за указанный период
-- по конкретной торговой точке
SELECT outlet_id, AVG(count) AS output
FROM (SELECT outlet_id, COUNT(*) AS count
      FROM selling
      WHERE sale_datetime > ?
        AND sale_datetime < ?
        AND outlet_id = ?
      GROUP BY employee_id, outlet_id
     ) AS a
GROUP BY outlet_id;
