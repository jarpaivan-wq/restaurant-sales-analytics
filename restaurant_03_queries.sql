-- ================================================
-- RESTAURANT ANALYTICS - BUSINESS QUERIES
-- ================================================
-- Author: SQL Portfolio Project
-- Business: La Bella Italia - Italian Restaurant
-- Description: Analytical queries for restaurant operations insights
-- ================================================

USE restaurant_analytics;

-- ================================================
-- QUERY #1: Top Selling Products by Category
-- ================================================
-- Business Question: Which products sell most within each category?
-- Purpose: Guide inventory management and menu promotion strategy
-- ================================================

SELECT
    cat.nombre_categoria,
    pro.nombre_producto,
    SUM(dep.cantidad) AS total_unidades_vendidas,
    SUM(dep.precio_unitario * dep.cantidad) AS revenue_por_producto
FROM categorias cat
INNER JOIN productos pro
    ON cat.categoria_id = pro.categoria_id
INNER JOIN detalle_pedidos dep
    ON pro.producto_id = dep.producto_id
GROUP BY cat.nombre_categoria, pro.nombre_producto
ORDER BY cat.nombre_categoria ASC, total_unidades_vendidas DESC;

-- ================================================
-- QUERY #2: Monthly Revenue by Service Type
-- ================================================
-- Business Question: How does dine-in revenue compare to delivery monthly?
-- Purpose: Track revenue trends and optimize service channel investment
-- ================================================

SELECT
    DATE_FORMAT(ped.fecha_pedido, '%Y-%m') AS `mes/año`,
    ped.tipo_servicio,
    COUNT(ped.pedido_id) AS total_pedidos_mes,
    SUM(dep.precio_unitario * dep.cantidad) AS revenue_total_mes
FROM pedidos ped
INNER JOIN detalle_pedidos dep
    ON ped.pedido_id = dep.pedido_id
WHERE ped.estado = 'completado'
GROUP BY DATE_FORMAT(ped.fecha_pedido, '%Y-%m'), ped.tipo_servicio
ORDER BY `mes/año` ASC, ped.tipo_servicio DESC;

-- ================================================
-- QUERY #3: Peak Hours Analysis
-- ================================================
-- Business Question: At what times does the restaurant experience highest demand?
-- Purpose: Optimize staff scheduling and kitchen capacity planning
-- ================================================

SELECT
    HOUR(ped.fecha_pedido) AS hora_del_dia,
    COUNT(ped.pedido_id) AS total_pedidos,
    SUM(dep.precio_unitario * dep.cantidad) AS revenue_total
FROM pedidos ped
INNER JOIN detalle_pedidos dep
    ON ped.pedido_id = dep.pedido_id
WHERE ped.estado = 'completado'
GROUP BY HOUR(ped.fecha_pedido)
ORDER BY total_pedidos DESC;

-- ================================================
-- QUERY #4: Average Ticket by Service Type
-- ================================================
-- Business Question: How much does a customer spend on average per service type?
-- Purpose: Compare profitability between dine-in and delivery channels
-- Note: NULLIF prevents division by zero; COALESCE handles NULL results
-- ================================================

WITH tabla_revenue AS (
    SELECT
        pedido_id,
        SUM(precio_unitario * cantidad) AS revenue
    FROM detalle_pedidos
    GROUP BY pedido_id
)
SELECT
    ped.tipo_servicio,
    COUNT(ped.pedido_id) AS total_pedidos,
    SUM(tr.revenue) AS revenue_total,
    COALESCE(ROUND(SUM(tr.revenue) / NULLIF(COUNT(ped.pedido_id), 0), 2), 0) AS ticket_promedio
FROM pedidos ped
INNER JOIN tabla_revenue tr
    ON ped.pedido_id = tr.pedido_id
WHERE ped.estado = 'completado'
GROUP BY ped.tipo_servicio
ORDER BY ticket_promedio DESC;

-- ================================================
-- QUERY #5: Underperforming Menu Items
-- ================================================
-- Business Question: Which products are candidates for menu removal?
-- Purpose: Optimize menu by identifying low-demand items
-- Criteria: Products with fewer than 5 units sold total
-- ================================================

SELECT
    cat.nombre_categoria,
    pro.nombre_producto,
    pro.precio AS precio_producto,
    SUM(dep.cantidad) AS unidades_vendidas,
    SUM(dep.precio_unitario * dep.cantidad) AS revenue_total
FROM categorias cat
INNER JOIN productos pro
    ON cat.categoria_id = pro.categoria_id
INNER JOIN detalle_pedidos dep
    ON pro.producto_id = dep.producto_id
GROUP BY cat.nombre_categoria, pro.nombre_producto, pro.precio
HAVING COUNT(dep.producto_id) < 5
ORDER BY unidades_vendidas ASC;

-- ================================================
-- END OF QUERIES
-- ================================================
