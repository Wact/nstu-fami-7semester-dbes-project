-- данные о заработной плате продавцов
-- по всем торговым точкам
SELECT outlet_id, fullname, salary
FROM outlet_employee
-- указать должность "продавец"
WHERE position_id = ?;

-- данные о заработной плате продавцов
-- по торговым точкам заданного типа
SELECT outlet_id, fullname, salary
FROM outlet_employee
-- указать должность "продавец"
WHERE position_id = ?
  AND outlet_id IN (SELECT id
                    FROM outlet
                    WHERE outlet_type_id = ?
                   );

-- данные о заработной плате продавцов
-- по конкретной торговой точке
SELECT outlet_id, fullname, salary
FROM outlet_employee
-- указать должность "продавец"
WHERE position_id = ?
  AND outlet_id = ?;
