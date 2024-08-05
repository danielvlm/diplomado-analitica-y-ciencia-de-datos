-- Explorar la tabla "menu_items"
SELECT * FROM menu_items;

/* 1. Realizar consultas para contestar las siguientes preguntas:
Encontrar el número de artículos en el menú. R= 32 */
SELECT COUNT(menu_item_id)
FROM menu_items;

-- ¿Cuál es el artículo menos caro? R= Edamame
SELECT *
FROM menu_items
ORDER BY price ASC
LIMIT 1;

-- ¿Cuál es el artículo más caro? R= Shrimp Scampi
SELECT *
FROM menu_items
ORDER BY price DESC
LIMIT 1;

-- ¿Cuántos platos americanos hay en el menú? R= 6
SELECT COUNT (category)
FROM menu_items
WHERE category = 'American';

-- ¿Cuál es el precio promedio de los platos? R= 13.2859375
SELECT AVG (price)
FROM menu_items;

-- Explorar la tabla order_details
SELECT * FROM order_details;

/* Realizar consultas para contestar las siguientes preguntas:
¿Cuantos pedidos únicos se realizaron en total? R= 32*/
SELECT COUNT (DISTINCT (item_id))
FROM order_details;

-- ¿Cuáles son los 5 pedidos que tuvieron el mayor número de artículos? R= 440, 2675, 3473, 4305 y 443
SELECT order_id, COUNT (order_id)
FROM order_details
GROUP BY order_id
ORDER BY 2 DESC
LIMIT 5;

-- ¿Cuándo se realizó el primer pedido? R= El '2023-01-01' a las 11:38:36
SELECT order_date, order_time
FROM order_details
ORDER BY order_date ASC
LIMIT 1;

-- ¿Cuándo se realizó el último pedido? R= El '2023-03-31' a las 11:22:20
SELECT order_date, order_time
FROM order_details
ORDER BY order_date DESC
LIMIT 1;

-- ¿Cuántos pedidos se hicieron entre el '2023-01-01' y el '2023-01-05'? R= 308
SELECT COUNT (DISTINCT (order_id))
FROM order_details
WHERE order_date BETWEEN '2023-01-01' AND '2023-01-05';

/* Usar ambas tablas para conocer la reacción de los clientes respecto al menú
Realizar un left join entre order_details y menu_items con el identificador
item_id(tabla order_details) y menu_item_id(tabla menu_items).*/
SELECT *
FROM order_details AS t1
LEFT JOIN menu_items AS t2
ON t1.item_id = t2.menu_item_id;

/* Una vez que hayas explorado los datos en las tablas correspondientes y respondido
las preguntas planteadas, realiza un análisis adicional usando este join entre las
tablas. El objetivo es identificar 5 puntos clave que puedan ser de utilidad para los 
dueños del restaurante en el lanzamiento de su nuevo menú. Para eso crea tus propias
consultas y utiliza los resultados obtenidos para llegar a estas conclusiones. */

-- ¿Qué tipo de comida fue la que más se vendió? R= Asian
SELECT t2.category, COUNT (t2.category)
FROM order_details AS t1
LEFT JOIN menu_items AS t2
ON t1.item_id = t2.menu_item_id
GROUP BY t2.category
ORDER BY 2 DESC
LIMIT 1;

-- ¿Qué tipo de comida fue la que generó más ingresos? R= Italian
SELECT t2.category, SUM (t2.price)
FROM order_details AS t1
LEFT JOIN menu_items AS t2
ON t1.item_id = t2.menu_item_id
GROUP BY 1
ORDER BY SUM (t2.price) DESC;

-- ¿Qué tipo de comida generó menos ingresos? R= American
SELECT t2.category, SUM (t2.price)
FROM order_details AS t1
LEFT JOIN menu_items AS t2
ON t1.item_id = t2.menu_item_id
GROUP BY 1
ORDER BY SUM (t2.price) ASC;

-- ¿Qué producto fue el que generó más ingresos? R= Korean Beef Bow
SELECT t2.item_name, SUM (t2.price)
FROM order_details AS t1
LEFT JOIN menu_items AS t2
ON t1.item_id = t2.menu_item_id
GROUP BY t2.item_name
ORDER BY SUM (t2.price) DESC;

-- ¿Qué producto fue el que generó menos ingresos? R= Chicken Tacos
SELECT t2.item_name, SUM (t2.price)
FROM order_details AS t1
LEFT JOIN menu_items AS t2
ON t1.item_id = t2.menu_item_id
GROUP BY t2.item_name
ORDER BY SUM (t2.price) ASC;