-- данные о рентабельности торговой точки:
-- соотношение объема продаж к накладным расходам
-- (суммарная заработная плата продавцов + платежи за аренду,
-- коммунальные услуги) за указанный период
SELECT income / expenses
FROM (SELECT row_number() OVER (), SUM(item_price * amount) AS income
      FROM selling
      WHERE outlet_id = ?
        AND datetime >= ?
        AND datetime <= ?
     ) AS i
JOIN (SELECT row_number() OVER (), SUM(amount) AS expenses
      FROM payment
      WHERE outlet_id = ?
        AND datetime >= ?
        AND datetime <= ?
     ) AS e
     ON i.row_number = e.row_number;
