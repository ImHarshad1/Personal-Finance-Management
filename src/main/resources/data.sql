/*for mysql
INSERT IGNORE INTO category (id, name, type) VALUES
(1,'Shopping','EXPENSE'),
(2,'Movie','EXPENSE'),
(3,'Salary','INCOME'),
(4,'Travel','EXPENSE'),
(5,'EMI','EXPENSE'),
(6,'Groceries','EXPENSE'),
(7,'Mobile Recharge','EXPENSE'),
(8,'Rent','EXPENSE'),
(9,'Food','EXPENSE'),
(10,'Bills','EXPENSE'),
(11,'Other Expense','EXPENSE'),
(12,'Other Income','INCOME');
*/

/*
For postgresql
*/
INSERT INTO category (id, name, type) VALUES
(1,'Shopping','EXPENSE'),
(2,'Movie','EXPENSE'),
(3,'Salary','INCOME'),
(4,'Travel','EXPENSE'),
(5,'EMI','EXPENSE'),
(6,'Groceries','EXPENSE'),
(7,'Mobile Recharge','EXPENSE'),
(8,'Rent','EXPENSE'),
(9,'Food','EXPENSE'),
(10,'Bills','EXPENSE'),
(11,'Other Expense','EXPENSE'),
(12,'Other Income','INCOME')
ON CONFLICT (id) DO NOTHING;
