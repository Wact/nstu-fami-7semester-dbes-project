-- данные о выработке отдельно взятого продавца
-- определенной торговой точки за указанный период
SELECT COUNT(*) AS output
FROM selling
WHERE datetime > ?
  AND datetime < ?
  AND outlet_id = ?
  AND outlet_employee_id = ?;
