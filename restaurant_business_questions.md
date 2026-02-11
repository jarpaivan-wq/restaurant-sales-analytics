# 📊 Business Questions Documentation

## Overview
This document provides detailed explanations of each business query developed for La Bella Italia restaurant analytics, including business context, SQL logic, and actionable insights.

---

## Query #1: Top Selling Products by Category

### Business Context
Understanding which products drive the most sales within each category helps La Bella Italia make informed decisions about inventory, menu promotions, and kitchen resource allocation.

### Business Question
**"Which products sell the most units within each menu category, and how much revenue do they generate?"**

### SQL Approach
```sql
SELECT
    cat.nombre_categoria,
    pro.nombre_producto,
    SUM(dep.cantidad) AS total_unidades_vendidas,
    SUM(dep.precio_unitario * dep.cantidad) AS revenue_por_producto
FROM categorias cat
INNER JOIN productos pro ON cat.categoria_id = pro.categoria_id
INNER JOIN detalle_pedidos dep ON pro.producto_id = dep.producto_id
GROUP BY cat.nombre_categoria, pro.nombre_producto
ORDER BY cat.nombre_categoria ASC, total_unidades_vendidas DESC;
```

### Key SQL Concepts
- **3 INNER JOINs**: Chains categories → products → order details
- **SUM(cantidad)**: Counts total units sold per product
- **SUM(precio_unitario * cantidad)**: Calculates actual revenue (price × quantity)
- **Multi-column GROUP BY**: Groups by both category and product name
- **Multi-column ORDER BY**: Sorts by category first, then by sales volume

### Business Insights
- Identifies star products within each category
- Reveals which categories drive the most revenue
- Shows pricing effectiveness (high units vs high revenue)

### Actionable Outcomes
- Feature top-selling items prominently on menu
- Ensure adequate ingredient stock for bestsellers
- Use high-performers as upsell anchors for waitstaff
- Consider bundling popular items for promotions

---

## Query #2: Monthly Revenue by Service Type

### Business Context
Comparing dine-in vs delivery performance helps La Bella Italia allocate resources effectively and evaluate the ROI of delivery platform partnerships.

### Business Question
**"How does monthly revenue and order volume compare between dine-in and delivery services?"**

### SQL Approach
```sql
SELECT
    DATE_FORMAT(ped.fecha_pedido, '%Y-%m') AS `mes/año`,
    ped.tipo_servicio,
    COUNT(ped.pedido_id) AS total_pedidos_mes,
    SUM(dep.precio_unitario * dep.cantidad) AS revenue_total_mes
FROM pedidos ped
INNER JOIN detalle_pedidos dep ON ped.pedido_id = dep.pedido_id
WHERE ped.estado = 'completado'
GROUP BY DATE_FORMAT(ped.fecha_pedido, '%Y-%m'), ped.tipo_servicio
ORDER BY `mes/año` ASC, ped.tipo_servicio DESC;
```

### Key SQL Concepts
- **DATE_FORMAT()**: Groups orders by month/year for trend analysis
- **COUNT(pedido_id)**: Counts total orders per service type per month
- **SUM(precio_unitario * cantidad)**: Calculates monthly revenue by channel
- **WHERE estado = 'completado'**: Excludes cancelled or pending orders
- **Dual GROUP BY**: Groups by both time period and service type

### Business Insights
- Tracks month-over-month growth by service channel
- Identifies seasonal patterns in each service type
- Compares order volume vs revenue contribution per channel

### Actionable Outcomes
- Evaluate whether delivery platform fees are justified by revenue
- Plan promotional campaigns by channel based on slow months
- Optimize delivery menu pricing to improve channel margins
- Staff planning based on monthly service type distribution

---

## Query #3: Peak Hours Analysis

### Business Context
Knowing when demand peaks allows La Bella Italia to optimize kitchen staffing, reduce wait times, and improve customer satisfaction during busy periods.

### Business Question
**"At what hours of the day does the restaurant receive the most orders and generate the most revenue?"**

### SQL Approach
```sql
SELECT
    HOUR(ped.fecha_pedido) AS hora_del_dia,
    COUNT(ped.pedido_id) AS total_pedidos,
    SUM(dep.precio_unitario * dep.cantidad) AS revenue_total
FROM pedidos ped
INNER JOIN detalle_pedidos dep ON ped.pedido_id = dep.pedido_id
WHERE ped.estado = 'completado'
GROUP BY HOUR(ped.fecha_pedido)
ORDER BY total_pedidos DESC;
```

### Key SQL Concepts
- **HOUR()**: Extracts hour component (0-23) from datetime column
- **COUNT()**: Counts orders per hour slot
- **SUM()**: Calculates revenue generated per hour
- **GROUP BY HOUR()**: Aggregates all orders sharing the same hour

### Business Insights
- Identifies lunch (12-13h) and dinner (19-20h) peak windows
- Reveals low-demand hours for potential promotions
- Compares order volume vs revenue per hour (average ticket by hour)

### Actionable Outcomes
- Schedule maximum kitchen staff during peak hours
- Create happy hour promotions during slow periods
- Plan delivery driver availability around demand peaks
- Adjust prep schedules to reduce wait times at peak times

---

## Query #4: Average Ticket by Service Type

### Business Context
Understanding average spend per order by service type helps La Bella Italia evaluate channel profitability and design targeted promotions to increase ticket size.

### Business Question
**"What is the average amount spent per order for dine-in customers vs delivery customers?"**

### SQL Approach
```sql
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
INNER JOIN tabla_revenue tr ON ped.pedido_id = tr.pedido_id
WHERE ped.estado = 'completado'
GROUP BY ped.tipo_servicio
ORDER BY ticket_promedio DESC;
```

### Key SQL Concepts
- **CTE**: Pre-aggregates revenue per order to avoid row multiplication
- **NULLIF(COUNT, 0)**: Prevents division by zero errors
- **COALESCE(..., 0)**: Handles NULL results from failed divisions
- **ROUND()**: Formats result to 2 decimal places
- **Defensive coding pattern**: Ensures query works safely in production

### Business Insights
- Compares average spend between dine-in and delivery customers
- Identifies which channel has higher value orders
- Reveals opportunity gaps for upselling in lower-ticket channel

### Actionable Outcomes
- Train waitstaff to upsell desserts and drinks in dine-in
- Add combo suggestions in delivery app to increase order value
- Design promotions targeting the lower average ticket channel
- Set revenue targets per order for each service type

---

## Query #5: Underperforming Menu Items

### Business Context
Menu optimization is critical for kitchen efficiency and profitability. Identifying low-demand items helps La Bella Italia reduce ingredient waste and simplify operations.

### Business Question
**"Which menu items have sold fewer than 5 units and are candidates for removal or redesign?"**

### SQL Approach
```sql
SELECT
    cat.nombre_categoria,
    pro.nombre_producto,
    pro.precio AS precio_producto,
    SUM(dep.cantidad) AS unidades_vendidas,
    SUM(dep.precio_unitario * dep.cantidad) AS revenue_total
FROM categorias cat
INNER JOIN productos pro ON cat.categoria_id = pro.categoria_id
INNER JOIN detalle_pedidos dep ON pro.producto_id = dep.producto_id
GROUP BY cat.nombre_categoria, pro.nombre_producto, pro.precio
HAVING COUNT(dep.producto_id) < 5
ORDER BY unidades_vendidas ASC;
```

### Key SQL Concepts
- **HAVING clause**: Filters aggregated results (cannot use WHERE for this)
- **GROUP BY with price**: Includes precio in GROUP BY to avoid MySQL strict mode errors
- **SUM vs COUNT**: SUM(cantidad) for real units sold, COUNT for row filtering in HAVING
- **ORDER BY ASC**: Shows worst performers first

### Business Insights
- Identifies menu items that customers rarely order
- Shows revenue contribution of underperforming items
- Highlights categories with most low-performers

### Actionable Outcomes
- Remove consistently underperforming items to simplify menu
- Redesign or reprice low-sellers before full removal
- Investigate WHY items underperform (visibility, price, taste)
- Replace removed items with variations of bestsellers
- Reduce ingredient purchasing for flagged items

---

## Summary of Business Impact

### Revenue Optimization
- **Product Analysis**: Focus promotions on proven bestsellers
- **Channel Comparison**: Allocate resources to highest-ROI service type
- **Ticket Growth**: Data-driven upselling strategy per channel

### Operational Efficiency
- **Peak Hours**: Right-size staffing to match actual demand
- **Menu Simplification**: Remove deadweight items to reduce complexity
- **Inventory Control**: Stock ingredients based on actual sales velocity

### Strategic Planning
- **Monthly Trends**: Identify seasonal patterns for campaign planning
- **Service Mix**: Balance investment between dine-in and delivery
- **Menu Evolution**: Continuous improvement based on performance data

---

## Technical Notes

### Performance Considerations
- Index on fecha_pedido for date-based filtering
- Index on estado for WHERE clause filtering
- CTE in Query #4 prevents row multiplication from JOIN

### Data Assumptions
- Sample data covers July 2024
- All 50 orders have estado = 'completado'
- detalle_pedidos stores historical precio_unitario for accurate revenue calculation

---

*Documentation prepared for La Bella Italia Restaurant Analytics SQL Portfolio Project*
