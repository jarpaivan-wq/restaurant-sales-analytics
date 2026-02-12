-- =====================================================
-- RESTAURANT DATABASE SCHEMA
-- =====================================================
-- This schema represents an Italian restaurant with
-- products, orders, categories, and service types.
-- =====================================================

-- Drop existing database if exists
DROP DATABASE IF EXISTS restaurante_italiano;

-- Create database
CREATE DATABASE restaurante_italiano;
USE restaurante_italiano;

-- =====================================================
-- Table: categorias
-- Purpose: Product categories (Entradas, Platos Principales, etc.)
-- =====================================================
CREATE TABLE categorias (
    categoria_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_categoria VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT
);

-- =====================================================
-- Table: productos
-- Purpose: Menu items with pricing
-- =====================================================
CREATE TABLE productos (
    producto_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_producto VARCHAR(100) NOT NULL,
    categoria_id INT NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    disponible BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (categoria_id) REFERENCES categorias(categoria_id)
);

-- =====================================================
-- Table: tipos_servicio
-- Purpose: Service channel types (Mesa, Delivery, Para Llevar)
-- =====================================================
CREATE TABLE tipos_servicio (
    tipo_servicio_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_servicio VARCHAR(50) NOT NULL UNIQUE,
    descripcion TEXT
);

-- =====================================================
-- Table: pedidos
-- Purpose: Order header with date and service type
-- =====================================================
CREATE TABLE pedidos (
    pedido_id INT PRIMARY KEY AUTO_INCREMENT,
    fecha_pedido DATETIME NOT NULL,
    tipo_servicio_id INT NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (tipo_servicio_id) REFERENCES tipos_servicio(tipo_servicio_id)
);

-- =====================================================
-- Table: detalle_pedido
-- Purpose: Line items for each order
-- =====================================================
CREATE TABLE detalle_pedido (
    detalle_id INT PRIMARY KEY AUTO_INCREMENT,
    pedido_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10, 2) NOT NULL,
    subtotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (pedido_id) REFERENCES pedidos(pedido_id),
    FOREIGN KEY (producto_id) REFERENCES productos(producto_id)
);

-- =====================================================
-- Indexes for performance optimization
-- =====================================================
CREATE INDEX idx_productos_categoria ON productos(categoria_id);
CREATE INDEX idx_pedidos_fecha ON pedidos(fecha_pedido);
CREATE INDEX idx_pedidos_servicio ON pedidos(tipo_servicio_id);
CREATE INDEX idx_detalle_pedido ON detalle_pedido(pedido_id);
CREATE INDEX idx_detalle_producto ON detalle_pedido(producto_id);

-- =====================================================
-- End of schema definition
-- =====================================================
