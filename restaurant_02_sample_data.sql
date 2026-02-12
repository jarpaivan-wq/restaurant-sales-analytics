-- =====================================================
-- RESTAURANT SAMPLE DATA
-- =====================================================
-- This file contains simulated data for demonstration
-- purposes. All orders and sales data are fictional
-- and created specifically for this portfolio.
-- =====================================================

USE restaurante_italiano;

-- =====================================================
-- Insert Categories
-- =====================================================
INSERT INTO categorias (nombre_categoria, descripcion) VALUES
('Entradas', 'Aperitivos y entradas'),
('Pasta', 'Platos de pasta italiana'),
('Pizza', 'Pizzas artesanales'),
('Carnes', 'Platos de carne'),
('Postres', 'Postres caseros'),
('Bebidas', 'Bebidas y refrescos');

-- =====================================================
-- Insert Products
-- =====================================================
INSERT INTO productos (nombre_producto, categoria_id, precio, disponible) VALUES
-- Entradas
('Bruschetta', 1, 8.50, TRUE),
('Carpaccio', 1, 12.00, TRUE),
('Antipasto Misto', 1, 14.50, TRUE),
-- Pasta
('Spaghetti Carbonara', 2, 15.00, TRUE),
('Fettuccine Alfredo', 2, 14.50, TRUE),
('Lasagna Bolognese', 2, 16.00, TRUE),
('Penne Arrabiata', 2, 13.50, TRUE),
('Ravioli Ricotta', 2, 15.50, TRUE),
-- Pizza
('Pizza Margherita', 3, 12.00, TRUE),
('Pizza Pepperoni', 3, 14.00, TRUE),
('Pizza Quattro Formaggi', 3, 15.50, TRUE),
('Pizza Vegetariana', 3, 13.50, TRUE),
-- Carnes
('Pollo al Limón', 4, 18.00, TRUE),
('Ossobuco', 4, 22.00, TRUE),
('Saltimbocca', 4, 20.00, TRUE),
-- Postres
('Tiramisu', 5, 7.50, TRUE),
('Panna Cotta', 5, 6.50, TRUE),
('Cannoli', 5, 6.00, TRUE),
('Gelato', 5, 5.50, TRUE),
-- Bebidas
('Agua Mineral', 6, 2.50, TRUE),
('Coca-Cola', 6, 3.00, TRUE),
('Vino Tinto Copa', 6, 5.50, TRUE),
('Café Espresso', 6, 2.00, TRUE);

-- =====================================================
-- Insert Service Types
-- =====================================================
INSERT INTO tipos_servicio (nombre_servicio, descripcion) VALUES
('Mesa', 'Servicio en el restaurante'),
('Delivery', 'Entrega a domicilio'),
('Para Llevar', 'Recogida en local');

-- =====================================================
-- Insert Orders (Sample orders across different months and hours)
-- =====================================================

-- Enero 2024 orders
INSERT INTO pedidos (fecha_pedido, tipo_servicio_id, total) VALUES
('2024-01-05 12:30:00', 1, 42.50),
('2024-01-05 13:15:00', 2, 28.00),
('2024-01-05 19:45:00', 1, 65.00),
('2024-01-10 12:00:00', 1, 38.50),
('2024-01-10 20:30:00', 3, 31.00),
('2024-01-15 13:30:00', 2, 45.00),
('2024-01-15 19:00:00', 1, 72.50),
('2024-01-20 12:45:00', 1, 55.00),
('2024-01-20 14:00:00', 3, 27.50),
('2024-01-25 20:15:00', 1, 88.00);

-- Febrero 2024 orders
INSERT INTO pedidos (fecha_pedido, tipo_servicio_id, total) VALUES
('2024-02-02 12:15:00', 1, 48.00),
('2024-02-02 19:30:00', 2, 35.50),
('2024-02-07 13:00:00', 1, 61.00),
('2024-02-07 20:00:00', 1, 75.50),
('2024-02-12 12:30:00', 3, 29.00),
('2024-02-12 19:15:00', 1, 52.00),
('2024-02-17 13:45:00', 2, 42.00),
('2024-02-17 20:30:00', 1, 95.00),
('2024-02-22 12:00:00', 1, 44.50),
('2024-02-22 19:45:00', 3, 38.00);

-- Marzo 2024 orders
INSERT INTO pedidos (fecha_pedido, tipo_servicio_id, total) VALUES
('2024-03-01 12:30:00', 1, 56.00),
('2024-03-01 19:00:00', 2, 41.50),
('2024-03-05 13:15:00', 1, 68.00),
('2024-03-05 20:15:00', 1, 82.50),
('2024-03-10 12:45:00', 3, 33.00),
('2024-03-10 19:30:00', 1, 59.00),
('2024-03-15 13:00:00', 2, 47.50),
('2024-03-15 20:00:00', 1, 91.00),
('2024-03-20 12:15:00', 1, 51.00),
('2024-03-20 19:45:00', 3, 36.50),
('2024-03-25 13:30:00', 1, 73.00),
('2024-03-25 20:30:00', 2, 44.00);

-- Abril 2024 orders
INSERT INTO pedidos (fecha_pedido, tipo_servicio_id, total) VALUES
('2024-04-03 12:00:00', 1, 49.50),
('2024-04-03 19:15:00', 2, 38.00),
('2024-04-08 13:30:00', 1, 64.00),
('2024-04-08 20:00:00', 1, 78.50),
('2024-04-13 12:45:00', 3, 31.50),
('2024-04-13 19:45:00', 1, 55.50),
('2024-04-18 13:00:00', 2, 43.00),
('2024-04-18 20:15:00', 1, 87.00),
('2024-04-23 12:30:00', 1, 46.00),
('2024-04-23 19:30:00', 3, 39.50),
('2024-04-28 13:15:00', 1, 70.00),
('2024-04-28 20:30:00', 2, 52.50);

-- Mayo 2024 orders
INSERT INTO pedidos (fecha_pedido, tipo_servicio_id, total) VALUES
('2024-05-02 12:15:00', 1, 53.00),
('2024-05-02 19:00:00', 2, 40.50),
('2024-05-07 13:45:00', 1, 66.50),
('2024-05-07 20:15:00', 1, 84.00),
('2024-05-12 12:30:00', 3, 34.00),
('2024-05-12 19:30:00', 1, 58.00),
('2024-05-17 13:00:00', 2, 45.50),
('2024-05-17 20:00:00', 1, 92.50),
('2024-05-22 12:45:00', 1, 48.50),
('2024-05-22 19:45:00', 3, 37.00),
('2024-05-27 13:30:00', 1, 75.50),
('2024-05-27 20:30:00', 2, 49.00);

-- =====================================================
-- Insert Order Details (linking orders to products)
-- =====================================================

-- Pedido 1 details
INSERT INTO detalle_pedido (pedido_id, producto_id, cantidad, precio_unitario, subtotal) VALUES
(1, 1, 1, 8.50, 8.50),
(1, 4, 2, 15.00, 30.00),
(1, 23, 2, 2.00, 4.00);

-- Pedido 2 details
INSERT INTO detalle_pedido (pedido_id, producto_id, cantidad, precio_unitario, subtotal) VALUES
(2, 9, 2, 12.00, 24.00),
(2, 23, 2, 2.00, 4.00);

-- Pedido 3 details
INSERT INTO detalle_pedido (pedido_id, producto_id, cantidad, precio_unitario, subtotal) VALUES
(3, 2, 1, 12.00, 12.00),
(3, 14, 2, 22.00, 44.00),
(3, 16, 1, 7.50, 7.50),
(3, 20, 1, 2.00, 2.00);

-- Pedido 4 details
INSERT INTO detalle_pedido (pedido_id, producto_id, cantidad, precio_unitario, subtotal) VALUES
(4, 5, 2, 14.50, 29.00),
(4, 17, 1, 6.50, 6.50),
(4, 21, 1, 3.00, 3.00);

-- Pedido 5 details
INSERT INTO detalle_pedido (pedido_id, producto_id, cantidad, precio_unitario, subtotal) VALUES
(5, 10, 2, 14.00, 28.00),
(5, 21, 1, 3.00, 3.00);

-- Pedido 6 details
INSERT INTO detalle_pedido (pedido_id, producto_id, cantidad, precio_unitario, subtotal) VALUES
(6, 3, 1, 14.50, 14.50),
(6, 6, 2, 16.00, 32.00),
(6, 18, 2, 6.00, 12.00);

-- Pedido 7 details
INSERT INTO detalle_pedido (pedido_id, producto_id, cantidad, precio_unitario, subtotal) VALUES
(7, 11, 2, 15.50, 31.00),
(7, 13, 2, 18.00, 36.00),
(7, 16, 1, 7.50, 7.50);

-- Pedido 8 details
INSERT INTO detalle_pedido (pedido_id, producto_id, cantidad, precio_unitario, subtotal) VALUES
(8, 7, 2, 13.50, 27.00),
(8, 15, 1, 20.00, 20.00),
(8, 19, 1, 5.50, 5.50),
(8, 20, 1, 2.50, 2.50);

-- Continue with similar pattern for remaining orders...
-- (Adding representative samples to keep file manageable)

-- Pedido 20 details (High-value Mesa order)
INSERT INTO detalle_pedido (pedido_id, producto_id, cantidad, precio_unitario, subtotal) VALUES
(20, 3, 2, 14.50, 29.00),
(20, 14, 3, 22.00, 66.00),
(20, 16, 2, 7.50, 15.00),
(20, 22, 3, 5.50, 16.50);

-- Pedido 30 details (Delivery order)
INSERT INTO detalle_pedido (pedido_id, producto_id, cantidad, precio_unitario, subtotal) VALUES
(30, 9, 3, 12.00, 36.00),
(30, 18, 2, 6.00, 12.00),
(30, 21, 2, 3.00, 6.00);

-- Pedido 40 details (Para Llevar order)
INSERT INTO detalle_pedido (pedido_id, producto_id, cantidad, precio_unitario, subtotal) VALUES
(40, 10, 2, 14.00, 28.00),
(40, 19, 2, 5.50, 11.00);

-- =====================================================
-- End of sample data
-- =====================================================
