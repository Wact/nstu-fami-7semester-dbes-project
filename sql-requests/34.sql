-- данные об арендованных помещениях
SELECT *
FROM outlet
WHERE id IN (SELECT DISTINCT outlet_id
             FROM payment
             WHERE payment_type_id = ? -- указать тип "аренда"
            );

-- перечень сотрудников, работающих в помещениях указанного типа
SELECT DISTINCT fullname
FROM outlet_employee
WHERE outlet_id IN (SELECT id
                    FROM outlet
                    WHERE outlet_type_id = ?
                   );

-- общее число сотрудников, работающих в помещениях указанного типа
SELECT COUNT(DISTINCT fullname)
FROM outlet_employee
WHERE outlet_id IN (SELECT id
                    FROM outlet
                    WHERE outlet_type_id = ?
                   );

-- перечень сотрудников, работающих в конкретном помещении
SELECT DISTINCT fullname
FROM outlet_employee
WHERE outlet_id = ?;

-- общее число сотрудников, работающих в конкретном помещении
SELECT COUNT(DISTINCT fullname)
FROM outlet_employee
WHERE outlet_id = ?;

-- перечень сотрудников по всем арендованным помещениям
SELECT DISTINCT fullname
FROM outlet_employee
WHERE outlet_id IN (SELECT id
                    FROM outlet
                    WHERE id IN (SELECT DISTINCT outlet_id
                                 FROM payment
                                 WHERE payment_type_id = ? -- указать тип "аренда"
                                )
                   );

-- общее число сотрудников по всем арендованным помещениям
SELECT COUNT(DISTINCT fullname)
FROM outlet_employee
WHERE outlet_id IN (SELECT id
                    FROM outlet
                    WHERE id IN (SELECT DISTINCT outlet_id
                                 FROM payment
                                 WHERE payment_type_id = ? -- указать тип "аренда"
                                )
                   );
