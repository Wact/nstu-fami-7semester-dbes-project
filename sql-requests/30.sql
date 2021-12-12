-- данные о выработке отдельно взятого продавца
-- определенной торговой точки за указанный период
SELECT COUNT(*) AS output
FROM selling
WHERE sale_datetime
    > ?
  AND sale_datetime
    < ?
  AND outlet_id = ?
  AND employee_id = ?;
