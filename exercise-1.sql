-- Crear la base de datos 'plumbing' si esta no existe
CREATE DATABASE IF NOT EXISTS plumbing;



-- Usar la base de datos 'plumbing'
USE plumbing;



-- tabla 'clientes'
CREATE TABLE clients (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    phone VARCHAR(15) NOT NULL
);


-- tabla 'servicios'
CREATE TABLE services (
    id INT AUTO_INCREMENT PRIMARY KEY,
    service_name VARCHAR(50) NOT NULL,
    service_description VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL
);


-- tabla 'plomeros'
CREATE TABLE plumbers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    plumber_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL,
    phone VARCHAR(15) NOT NULL
);



-- tabla 'facturas'
CREATE TABLE bills (
    id INT AUTO_INCREMENT PRIMARY KEY,
    client_id INT NOT NULL,
    service_id INT NOT NULL,
    plumber_id INT NOT NULL,
    bill_date DATE NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (client_id) REFERENCES clients(id),
    FOREIGN KEY (service_id) REFERENCES services(id),
    FOREIGN KEY (plumber_id) REFERENCES plumbers(id)
);

-- tabla 'descuentos'
CREATE TABLE discounts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    bill_id INT NOT NULL,
    monto DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (bill_id) REFERENCES bills(id)
);



-- tabla 'pagos'
CREATE TABLE pays (
    id INT AUTO_INCREMENT PRIMARY KEY,
    bill_id INT,
    amount DECIMAL(10, 2) NOT NULL,
    pay_date DATE NOT NULL,
    FOREIGN KEY (bill_id) REFERENCES bills(id)
);


-- tabla 'auditoria'
CREATE TABLE audit (
    id INT AUTO_INCREMENT PRIMARY KEY,
    audit_table VARCHAR(50) NOT NULL,
    audit_action VARCHAR(50) NOT NULL,
    audit_date DATETIME NOT NULL
);


-- relaciones
-- Añadir campo cliente_id a la tabla servicios
ALTER TABLE services ADD client_id INT, ADD FOREIGN KEY (client_id) REFERENCES clients(id);

-- tabla intermedia plumber_services
CREATE TABLE plumbers_services (
    plumber_id INT NOT NULL,
    service_id INT NOT NULL,
    PRIMARY KEY (plumber_id, service_id),
    FOREIGN KEY (plumber_id) REFERENCES plumbers(id),
    FOREIGN KEY (service_id) REFERENCES services(id)
);


 -- Arreglando vainas del DBA
 
 -- campo faltate de clientes
ALTER TABLE clients ADD address VARCHAR(255);

-- olvido agregar campos servicios bueno, no pasa nada
ALTER TABLE services ADD service_date DATE;

-- olvido agregar campos a plumbers, bien...
ALTER TABLE plumbers ADD address VARCHAR(255);

-- olvido agregar campos a bills ya lo agregue
ALTER TABLE bills ADD address VARCHAR(255);

-- olvido definir como NO NULO el campo bill_id en la tabla pays
ALTER TABLE pays MODIFY bill_id INT NOT NULL;


-- se percato de otro error que en la tabla descuentos no tiene relacion con auditoria, esta persona me quiere echar
ALTER TABLE audit ADD discount_id INT, ADD FOREIGN KEY (discount_id) REFERENCES discounts(id);

