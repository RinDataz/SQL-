REM   Script: DW_LAB_2210463_TALAQATTAN
REM   Data Warehouse lab10

CREATE TABLE T_DATE(  
    ID_DATE NUMBER(5),  
    ORDER_DATE DATE,  
    Day_No NUMBER(1),  
    Day_Name CHAR(10),  
    Month_No NUMBER(2),  
    Month_Name CHAR(10),  
    Qaurter NUMBER(1),  
    YYear NUMBER(4)  
);

CREATE TABLE CUSTOMER_COPY AS  
SELECT CUSTOMER_ID, CUST_FIRST_NAME, CUST_LAST_NAME, NLS_LANGUAGE, NLS_TERRITORY,  
CREDIT_LIMIT, CUST_EMAIL, ACCOUNT_MGR_ID, CUST_GEO_LOCATION, DATE_OF_BIRTH,  
MARITAL_STATUS, GENDER, INCOME_LEVEL  
FROM OE.CUSTOMERS;

CREATE TABLE ORDERS_COPY AS SELECT * FROM OE.ORDERS;

CREATE TABLE T_SALESMAN AS   
SELECT DISTINCT COALESCE(SALES_REP_ID, 999) AS SALES_REP_ID,  
'NAME-' || TO_CHAR(COALESCE(SALES_REP_ID, 999)) AS SNAME  
FROM ORDERS_COPY;

CREATE TABLE D_TIME AS   
SELECT DISTINCT ID_DATE, ORDER_DATE, Month_No, Qaurter, YYear  
FROM T_DATE;

ALTER TABLE D_TIME ADD CONSTRAINT PK_D_TIME PRIMARY KEY(ID_DATE);

CREATE TABLE D_CUSTOMERS AS   
SELECT DISTINCT CUSTOMER_ID, CUST_FIRST_NAME, CUST_LAST_NAME, GENDER  
FROM CUSTOMER_COPY;

ALTER TABLE D_CUSTOMERS ADD CONSTRAINT PK_D_CUSTOMERS PRIMARY KEY(CUSTOMER_ID);

CREATE TABLE D_ORDERS AS  
SELECT DISTINCT ORDER_ID, ORDER_MODE AS OMode, ORDER_STATUS AS STATUS  
FROM ORDERS_COPY;

ALTER TABLE D_ORDERS ADD CONSTRAINT PK_D_ORDERS PRIMARY KEY(ORDER_ID);

CREATE TABLE D_SALESMAN AS  
SELECT DISTINCT SALES_REP_ID, SNAME  
FROM T_SALESMAN;

ALTER TABLE D_SALESMAN ADD CONSTRAINT PK_D_SALESMAN PRIMARY KEY(SALES_REP_ID);

CREATE TABLE F_ORDERS(  
    F_ORDERS_ID NUMBER,   
    ORDER_AMOUNT NUMBER,  
    D_TIME_ID NUMBER,  
    D_CUSTOMER_ID NUMBER,   
    D_ORDERS_ID NUMBER,  
    D_SALESMAN_ID NUMBER  
);

CREATE TABLE T_DATE(  
    ID_DATE NUMBER(5),  
    ORDER_DATE DATE,  
    Day_No Number(1),  
    Day_Name char(10),  
    Month_No NUMBER(2),  
    Month_Name CHAR(10),  
    Quarter NUMBER(1),  
    YYear NUMBER(4)  
);

ALTER TABLE F_ORDERS ADD CONSTRAINT FK_ORDERS_TO_D_ORDERS FOREIGN KEY(D_ORDERS_ID) REFERENCES D_ORDERS(ORDER_ID);

ALTER TABLE F_ORDERS ADD CONSTRAINT PD_F_ORDERS_ID PRIMARY KEY(F_ORDERS_ID);

ALTER TABLE F_ORDERS ADD CONSTRAINT FK_ORDERS_TO_D_TIME FOREIGN KEY(D_TIME_ID) REFERENCES D_TIME(ID_DATE);

ALTER TABLE F_ORDERS ADD CONSTRAINT FK_ORDERS_TO_D_CUSTOMERS FOREIGN KEY(D_CUSTOMER_ID) REFERENCES D_CUSTOMERS(CUSTOMER_ID);

ALTER TABLE F_ORDERS ADD CONSTRAINT FK_ORDERS_TO_D_SALESMAN FOREIGN KEY(D_SALESMAN_ID) REFERENCES D_SALESMAN(SALES_REP_ID);

ALTER TABLE F_ORDERS ADD CONSTRAINT FK_ORDERS_TO_D_ORDERS FOREIGN KEY(D_ORDERS_ID) REFERENCES D_ORDERS(ORDER_ID);

CREATE SEQUENCE SEQ_F_ORDERS START WITH 1;

INSERT INTO F_ORDERS (F_ORDERS_ID,ORDER_AMOUNT, D_ORDERS_ID,D_CUSTOMER_ID) SELECT SEQ_F_ORDERS.nextval , ORDER_TOTAL, ORDER_ID,  
    CUSTOMER_ID FROM ORDERS_COPY;

UPDATE F_ORDERS o SET D_SALESMAN_ID = (SELECT (D_SALESMAN.SALES_REP_ID)  
    FROM D_SALESMAN  
    JOIN orders_copy oc ON D_SALESMAN.SALES_REP_ID = oc.SALES_REP_ID AND oc.order_id=o.F_ORDERS_ID);

ALTER TABLE F_ORDERS ADD OMODE VARCHAR(8);

UPDATE F_ORDERS  
SET OMODE = (SELECT ORDER_MODE FROM D_ORDERS WHERE D_ORDERS.ORDER_ID = F_ORDERS.D_ORDERS_ID);

UPDATE F_ORDERS  
SET OMODE = (SELECT OMODE FROM D_ORDERS WHERE D_ORDERS.ORDER_ID = F_ORDERS.D_ORDERS_ID);

UPDATE F_ORDERS  
SET ONLINE_ORDER = (CASE WHEN OMODE = 'online' THEN 1 ELSE 0 END);

ALTER TABLE F_ORDERS ADD ONLINE_ORDER CHAR(1);

UPDATE F_ORDERS  
SET ONLINE_ORDER = (CASE WHEN OMODE = 'online' THEN 1 ELSE 0 END);

ALTER TABLE F_ORDERS ADD DIRECT_ORDER CHAR(1);

UPDATE F_ORDERS  
SET DIRECT_ORDER = (CASE WHEN OMODE = 'direct' THEN 1 ELSE 0 END);

SELECT* FROM F_ORDERS;

SELECT * FROM D_TIME;

SELECT * FROM T_DATE;

SELECT * FROM F_ORDERS;

SELECT * FROM D_DATE;

SELECT * FROM D_TIME;

SELECT COUNT(*) AS NumberofOrders 
FROM F_ORDERS;

SELECT COUNT(*) AS NumberofOrders 
FROM D_ORDERS;

SELECT COUNT(*) AS NumberofOrders 
FROM F_ORDERS;

SELECT MIN(ORDER_AMOUNT) AS MinAmount, 
       MAX(ORDER_AMOUNT) AS MaxAmount, 
       AVG(ORDER_AMOUNT) AS Average 
FROM F_ORDERS;

SELECT D_CUSTOMERS.CUSTOMER_ID, D_CUSTOMERS.CUST_FIRST_NAME, D_CUSTOMERS.CUST_LAST_NAME, 
       MIN(F_ORDERS.ORDER_AMOUNT) AS MinAmount, MAX(F_ORDERS.ORDER_AMOUNT) AS MaxAmount, AVG(F_ORDERS.ORDER_AMOUNT) AS Average 
FROM D_CUSTOMERS 
JOIN F_ORDERS ON D_CUSTOMERS.CUSTOMER_ID = F_ORDERS.D_CUSTOMER_ID 
GROUP BY D_CUSTOMERS.CUSTOMER_ID, D_CUSTOMERS.CUST_FIRST_NAME, D_CUSTOMERS.CUST_LAST_NAME;

SELECT D_CUSTOMERS.CUSTOMER_ID, D_CUSTOMERS.CUST_FIRST_NAME, D_CUSTOMERS.CUST_LAST_NAME 
FROM D_CUSTOMERS 
JOIN F_ORDERS ON D_CUSTOMERS.CUSTOMER_ID = F_ORDERS.D_CUSTOMER_ID 
GROUP BY D_CUSTOMERS.CUSTOMER_ID, D_CUSTOMERS.CUST_FIRST_NAME, D_CUSTOMERS.CUST_LAST_NAME 
HAVING AVG(F_ORDERS.ORDER_AMOUNT) > 2 * (SELECT AVG(ORDER_AMOUNT) FROM F_ORDERS);

SELECT D_SALESMAN.SALES_REP_ID, D_SALESMAN.SNAME, COUNT(*) AS NumberofOrders 
FROM F_ORDERS 
JOIN D_SALESMAN ON F_ORDERS.F_SALESMAN_ID = D_SALESMAN.SALES_REP_ID 
GROUP BY D_SALESMAN.SALES_REP_ID, D_SALESMAN.SNAME;

SELECT D_SALESMAN.SALES_REP_ID, D_SALESMAN.SNAME, COUNT(*) AS NumberofOrders 
FROM F_ORDERS 
JOIN D_SALESMAN ON F_ORDERS.D_SALESMAN_ID = D_SALESMAN.SALES_REP_ID 
GROUP BY D_SALESMAN.SALES_REP_ID, D_SALESMAN.SNAME;

SELECT D_SALESMAN.SALES_REP_ID, D_SALESMAN.SNAME, COUNT(*) AS NumberofOrders 
FROM F_ORDERS 
JOIN D_SALESMAN ON F_ORDERS.D_SALESMAN_ID = D_SALESMAN.SALES_REP_ID 
GROUP BY D_SALESMAN.SALES_REP_ID, D_SALESMAN.SNAME;

SELECT * FROM D_SALESMAN;

SELECT D_CUSTOMERS.CUSTOMER_ID, D_CUSTOMERS.CUST_FIRST_NAME, D_CUSTOMERS.CUST_LAST_NAME 
FROM D_CUSTOMERS 
JOIN F_ORDERS ON D_CUSTOMERS.CUSTOMER_ID = F_ORDERS.D_CUSTOMER_ID 
GROUP BY D_CUSTOMERS.CUSTOMER_ID, D_CUSTOMERS.CUST_FIRST_NAME, D_CUSTOMERS.CUST_LAST_NAME 
HAVING AVG(F_ORDERS.ORDER_AMOUNT) > 2 * (SELECT AVG(ORDER_AMOUNT) FROM F_ORDERS WHERE D_CUSTOMERS.CUSTOMER_ID = F_ORDERS.D_CUSTOMER_ID);

SELECT D_SALESMAN.SALES_REP_ID, D_SALESMAN.SNAME, COUNT(*) AS NumberofOrders 
FROM F_ORDERS 
JOIN D_SALESMAN ON F_ORDERS.D_SALESMAN_ID = D_SALESMAN.SALES_REP_ID 
GROUP BY D_SALESMAN.SALES_REP_ID, D_SALESMAN.SNAME;

SELECT D_CUSTOMERS.CUSTOMER_ID, D_CUSTOMERS.CUST_FIRST_NAME, D_CUSTOMERS.CUST_LAST_NAME, COUNT(*) AS NumberofOrders 
FROM F_ORDERS 
JOIN D_CUSTOMERS ON D_CUSTOMERS.CUSTOMER_ID = F_ORDERS.D_CUSTOMER_ID 
GROUP BY D_CUSTOMERS.CUSTOMER_ID, D_CUSTOMERS.CUST_FIRST_NAME, D_CUSTOMERS.CUST_LAST_NAME;

SELECT D_CUSTOMERS.CUSTOMER_ID, D_CUSTOMERS.CUST_FIRST_NAME, D_CUSTOMERS.CUST_LAST_NAME,  
    COUNT(*) AS NumberofOrders, SUM(F_ORDERS.ORDER_AMOUNT) AS TOTAL 
FROM F_ORDERS 
JOIN D_CUSTOMERS ON D_CUSTOMERS.CUSTOMER_ID = F_ORDERS.D_CUSTOMER_ID 
GROUP BY D_CUSTOMERS.CUSTOMER_ID, D_CUSTOMERS.CUST_FIRST_NAME, D_CUSTOMERS.CUST_LAST_NAME 
ORDER BY DESC;

SELECT D_CUSTOMERS.CUSTOMER_ID, D_CUSTOMERS.CUST_FIRST_NAME, D_CUSTOMERS.CUST_LAST_NAME,  
    COUNT(*) AS NumberofOrders, SUM(F_ORDERS.ORDER_AMOUNT) AS TOTAL 
FROM F_ORDERS 
JOIN D_CUSTOMERS ON D_CUSTOMERS.CUSTOMER_ID = F_ORDERS.D_CUSTOMER_ID 
GROUP BY D_CUSTOMERS.CUSTOMER_ID, D_CUSTOMERS.CUST_FIRST_NAME, D_CUSTOMERS.CUST_LAST_NAME 
ORDER BY NumberofOrders DESC;

SELECT D_CUSTOMERS.CUSTOMER_ID, D_CUSTOMERS.CUST_FIRST_NAME, D_CUSTOMERS.CUST_LAST_NAME, 
    D_SALESMAN.SALES_REP_ID, D_SALESMAN.SNAME, COUNT(*) AS DirectOrderCount 
FROM F_ORDERS 
JOIN D_CUSTOMERS ON D_CUSTOMERS.CUSTOMER_ID = F_ORDERS.D_CUSTOMER_ID 
JOIN D_SALESMAN ON F_ORDERS.F_SALESMAN_ID = D_SALESMAN.SALES_REP_ID 
GROUP BY D_CUSTOMERS.CUSTOMER_ID, D_CUSTOMERS.CUST_FIRST_NAME, D_CUSTOMERS.CUST_LAST_NAME, 
    D_SALESMAN.SALES_REP_ID, D_SALESMAN.SNAME;

SELECT D_CUSTOMERS.CUSTOMER_ID, D_CUSTOMERS.CUST_FIRST_NAME, D_CUSTOMERS.CUST_LAST_NAME 
FROM D_CUSTOMERS 
JOIN F_ORDERS ON D_CUSTOMERS.CUSTOMER_ID = F_ORDERS.D_CUSTOMER_ID 
GROUP BY D_CUSTOMERS.CUSTOMER_ID, D_CUSTOMERS.CUST_FIRST_NAME, D_CUSTOMERS.CUST_LAST_NAME 
HAVING SUM(F_ORDERS.ORDER_AMOUNT) > 0.8 * (SELECT AVG(ORDER_AMOUNT) FROM F_ORDERS);

SELECT D_CUSTOMERS.CUSTOMER_ID, D_CUSTOMERS.CUST_FIRST_NAME, D_CUSTOMERS.CUST_LAST_NAME, 
    D_SALESMAN.SALES_REP_ID, D_SALESMAN.SNAME, COUNT(*) AS DirectOrderCount 
FROM F_ORDERS 
JOIN D_CUSTOMERS ON D_CUSTOMERS.CUSTOMER_ID = F_ORDERS.D_CUSTOMER_ID 
JOIN D_SALESMAN ON F_ORDERS.F_SALESMAN_ID = D_SALESMAN.SALES_REP_ID 
GROUP BY D_CUSTOMERS.CUSTOMER_ID, D_CUSTOMERS.CUST_FIRST_NAME, D_CUSTOMERS.CUST_LAST_NAME, 
    D_SALESMAN.SALES_REP_ID, D_SALESMAN.SNAME;

SELECT D_CUSTOMERS.CUSTOMER_ID, D_CUSTOMERS.CUST_FIRST_NAME, D_CUSTOMERS.CUST_LAST_NAME, 
    D_SALESMAN.SALES_REP_ID, D_SALESMAN.SNAME, COUNT(*) AS DirectOrderCount 
FROM F_ORDERS 
JOIN D_CUSTOMERS ON D_CUSTOMERS.CUSTOMER_ID = F_ORDERS.D_CUSTOMER_ID 
JOIN D_SALESMAN ON F_ORDERS.D_SALESMAN_ID = D_SALESMAN.SALES_REP_ID 
GROUP BY D_CUSTOMERS.CUSTOMER_ID, D_CUSTOMERS.CUST_FIRST_NAME, D_CUSTOMERS.CUST_LAST_NAME, 
    D_SALESMAN.SALES_REP_ID, D_SALESMAN.SNAME;

SELECT D_TIME.YYEAR, F_ORDERS.D_CUSTOMER_ID, SUM(F_ORDERS.ORDER_AMOUNT) AS TOTAL 
FROM F_ORDERS 
JOIN D_TIME ON F_ORDERS.D_TIME_ID = D_TIME.ID_DATE 
GROUP BY D_TIME.YYEAR, F_ORDERS.D_CUSTOMER_ID 
ORDER BY D_TIME.YYEAR, F_ORDERS.D_CUSTOMER_ID;

SELECT D_TIME.YYEAR, F_ORDERS.D_CUSTOMER_ID, SUM(F_ORDERS.ORDER_AMOUNT) AS TOTAL 
FROM F_ORDERS 
JOIN D_TIME ON F_ORDERS.D_TIME_ID = D_TIME.ID_DATE 
GROUP BY D_TIME.YYEAR, F_ORDERS.D_CUSTOMER_ID 
ORDER BY D_TIME.YYEAR, F_ORDERS.D_CUSTOMER_ID;

SELECT D_TIME.YYEAR, D_TIME.QUARTER, F_ORDERS.D_CUSTOMER_ID, SUM(F_ORDERS.ORDER_AMOUNT) AS TOTAL 
FROM F_ORDERS 
JOIN D_TIME ON F_ORDERS.D_TIME_ID = D_TIME.ID_DATE 
GROUP BY D_TIME.YYEAR, D_TIME.QUARTER,F_ORDERS.D_CUSTOMER_ID 
ORDER BY D_TIME.YYEAR, D_TIME.QUARTER,F_ORDERS.D_CUSTOMER_ID;

SELECT D_TIME.YYEAR, D_TIME.QUARTER, F_ORDERS.D_CUSTOMER_ID, SUM(F_ORDERS.ORDER_AMOUNT) AS TOTAL 
FROM F_ORDERS 
JOIN D_TIME ON F_ORDERS.D_TIME_ID = D_TIME.ID_DATE 
GROUP BY D_TIME.YYEAR, D_TIME.QUARTER,F_ORDERS.D_CUSTOMER_ID 
ORDER BY D_TIME.YYEAR, D_TIME.QUARTER,F_ORDERS.D_CUSTOMER_ID;

SELECT D_TIME.YYEAR, D_TIME.QUARTER, D_TIME.MONTH_NO, F_ORDERS.D_CUSTOMER_ID, SUM(F_ORDERS.ORDER_AMOUNT) AS TOTAL 
FROM F_ORDERS 
JOIN D_TIME ON F_ORDERS.D_TIME_ID = D_TIME.ID_DATE 
GROUP BY D_TIME.YYEAR, D_TIME.QUARTER, D_TIME.MONTH_NO, F_ORDERS.D_CUSTOMER_ID 
ORDER BY D_TIME.YYEAR, D_TIME.QUARTER, D_TIME.MONTH_NO, F_ORDERS.D_CUSTOMER_ID;

SELECT D_ORDERS.OMODE, D_TIME.YYEAR, D_TIME.QUARTER, D_TIME.MONTH_NO, SUM(F_ORDERS.ORDER_AMOUNT) AS AMOUNT 
FROM F_ORDERS 
JOIN D_TIME ON F_ORDERS.D_TIME_ID = D_TIME.ID_DATE 
JOIN D_ORDERS ON F_ORDERS.D_ORDERS_ID = D_ORDERS.ORDER_ID 
GROUP BY D_ORDERS.OMODE, D_TIME.YYEAR, D_TIME.QUARTER, D_TIME.MONTH_NO;

SELECT D_TIME.YYEAR, D_TIME.QAURTER, F_ORDERS.D_CUSTOMER_ID, SUM(F_ORDERS.ORDER_AMOUNT) AS TOTAL 
FROM F_ORDERS 
JOIN D_TIME ON F_ORDERS.D_TIME_ID = D_TIME.ID_DATE 
GROUP BY D_TIME.YYEAR, D_TIME.QAURTER,F_ORDERS.D_CUSTOMER_ID 
ORDER BY D_TIME.YYEAR, D_TIME.QAURTER,F_ORDERS.D_CUSTOMER_ID;

SELECT D_TIME.YYEAR, D_TIME.QAURTER, D_TIME.MONTH_NO, F_ORDERS.D_CUSTOMER_ID, SUM(F_ORDERS.ORDER_AMOUNT) AS TOTAL 
FROM F_ORDERS 
JOIN D_TIME ON F_ORDERS.D_TIME_ID = D_TIME.ID_DATE 
GROUP BY D_TIME.YYEAR, D_TIME.QAURTER, D_TIME.MONTH_NO, F_ORDERS.D_CUSTOMER_ID 
ORDER BY D_TIME.YYEAR, D_TIME.QAURTER, D_TIME.MONTH_NO, F_ORDERS.D_CUSTOMER_ID;

SELECT D_ORDERS.OMODE, D_TIME.YYEAR, D_TIME.QAURTER, D_TIME.MONTH_NO, SUM(F_ORDERS.ORDER_AMOUNT) AS AMOUNT 
FROM F_ORDERS 
JOIN D_TIME ON F_ORDERS.D_TIME_ID = D_TIME.ID_DATE 
JOIN D_ORDERS ON F_ORDERS.D_ORDERS_ID = D_ORDERS.ORDER_ID 
GROUP BY D_ORDERS.OMODE, D_TIME.YYEAR, D_TIME.QAURTER, D_TIME.MONTH_NO;

