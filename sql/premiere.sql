DROP TABLE IF EXISTS order_line;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS part;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS sales_rep;

CREATE TABLE IF NOT EXISTS customer (
    customer_number CHAR(3) NOT NULL,
    last VARCHAR(10) NOT NULL,
    first VARCHAR(8) NOT NULL,
    street VARCHAR(15),
    city VARCHAR(15),
    state CHAR(2),
    zip_code CHAR(5),
    balance DECIMAL(7,2),
    credit_limit DECIMAL(6,2),
    slsrep_number CHAR(2),
    PRIMARY KEY (customer_number)
);

INSERT INTO customer VALUES 
('124','Adams','Sally','481 Oak','Lansing','MI','49224',818.75,1000,'03'),
('256','Samuels','Ann','215 Pete','Grant','MI','49219',21.50,1500,'06'),
('311','Charles','Don','48 College','Ira','MI','49034',825.75,1000,'12'),
('315','Daniels','Tom','914 Cherry','Kent','MI','48391',770.75,750,'06'),
('405','Williams','Al','519 Watson','Grant','MI','49219',402.75,1500,'12'),
('412','Adams','Sally','16 Elm','Lansing','MI','49224',1817.50,2000,'03'),
('522','Nelson','Mary','108 Pine','Ada','MI','49441',98.75,1500,'12'),
('567','Dinh','Tran','808 Ridge','Harper','MI','48421',402.40,750,'06'),
('587','Galvez','Mara','512 Pine','Ada','MI','49441',114.60,1000,'06'),
('622','Martin','Dan','419 Chip','Grant','MI','49219',1045.75,1000,'03');

CREATE TABLE IF NOT EXISTS sales_rep (
    slsrep_number CHAR(2) NOT NULL,
    last VARCHAR(20) NOT NULL,
    first VARCHAR(15) NOT NULL,
    street VARCHAR(25),
    city VARCHAR(15),
    state CHAR(2),
    zip_code CHAR(5),
    total_commission DECIMAL(7,2),
    commission_rate DECIMAL(3,2),
    PRIMARY KEY (slsrep_number)
);

INSERT INTO sales_rep VALUES
('03','Jones','Mary','123 Main','Grant','MI','49219',2150.00,0.05),
('06','Smith','William','102 Raymond','Ada','MI','49441',4912.50,0.07),
('12','Diaz','Miguel','419 Harper','Lansing','MI','49224',2150.00,0.05);

CREATE TABLE IF NOT EXISTS part (
    part_number CHAR(4) NOT NULL,
    part_description VARCHAR(12),
    units_on_hand INT,
    item_class CHAR(2),
    warehouse_number CHAR(1),
    unit_price DECIMAL(6,2),
    PRIMARY KEY (part_number)
);

INSERT INTO part VALUES
('AX12','Iron',104,'HW','3',24.95),
('AZ52','Dartboard',20,'SG','2',12.95),
('BA74','Basketball',40,'SG','1',29.95),
('BH22','Cornpopper',95,'HW','3',24.95),
('BT04','Gas Grill',11,'AP','2',149.99),
('BZ66','Washer',52,'AP','3',399.99),
('CA14','Griddle',78,'HW','3',39.99),
('CB03','Bike',44,'SG','1',299.99),
('CX11','Blender',112,'HW','3',22.95),
('CZ81','Treadmill',68,'SG','2',349.95);

CREATE TABLE IF NOT EXISTS orders (
    order_number CHAR(5) NOT NULL,
    order_date DATE,
    customer_number CHAR(3) NOT NULL,
    PRIMARY KEY (order_number),
    FOREIGN KEY (customer_number) REFERENCES customer(customer_number)
);

INSERT INTO orders VALUES
('12489','2002-09-02','124'),
('12491','2002-09-02','311'),
('12494','2002-09-04','315'),
('12495','2002-09-04','256'),
('12498','2002-09-05','522'),
('12500','2002-09-05','124'),
('12504','2002-09-05','522');

CREATE TABLE IF NOT EXISTS order_line (
    order_number CHAR(5) NOT NULL,
    part_number CHAR(4) NOT NULL,
    number_ordered INT DEFAULT 0,
    quoted_price DECIMAL(6,2),
    PRIMARY KEY (order_number, part_number),
    FOREIGN KEY (order_number) REFERENCES orders(order_number),
    FOREIGN KEY (part_number) REFERENCES part(part_number)
);

INSERT INTO order_line VALUES
('12489','AX12',11,21.95),
('12491','BT04',1,149.99),
('12491','BZ66',1,399.99),
('12494','CB03',4,279.99),
('12495','CX11',2,22.95),
('12498','AZ52',2,12.95),
('12498','BA74',4,24.95),
('12500','BT04',1,149.99),
('12504','CZ81',2,325.99);