create database pizza_sales_data;
use pizza_sales_data;

describe orders;
describe order_details;
describe pizza_types;
describe pizzas;

alter table pizza_types
modify pizza_type_id varchar(60) not null;

alter table pizza_types
add constraint pk_pizza_type_id 
primary key (pizza_type_id);

alter table pizzas
modify pizza_type varchar(100) not null;

alter table pizzas
add constraint fk_pizza_type_id 
foreign key(pizza_type_id) 
references pizza_type (pizza_type_id);

alter table pizzas
modify pizza_id varchar(60) not null ;

alter table orders
add constraint pk_order_id 
primary key (order_id);

alter table order_details
add constraint fk_order_id
foreign key(order_id)
references orders(order_id);

alter table order_details
modify order_details_id int not null;


/* Retrieve the total number of orders placed. */
select count(order_id) as total_orders from orders;

-- Calculate the total revenue generated from pizza sales.

SELECT 
    od.order_id,
    SUM(od.quantity) AS total_quantity,
    SUM(od.quantity * p.price) AS total_sales
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id
GROUP BY od.order_id
ORDER BY total_quantity DESC , total_sales DESC;


SELECT 
    ROUND(SUM(od.quantity * p.price), 2) AS Total_sales
FROM
    order_details od
        JOIN
    pizzas p ON od.pizza_id = p.pizza_id;


-- Identify the highest-priced pizza.

select * from order_details;
select pt.`name`,p.price as highest_Price
from pizzas p
join pizza_types pt
on p.pizza_type_id = pt.pizza_type_id
order by highest_price desc limit 1;

-- Identify the most common pizza size ordered.

-- pizza size is present in pizzas 
-- select * from order_details;
SELECT 
    p.size, COUNT(od.order_details_id) total_orders
FROM
    pizzas p
        JOIN
    order_details od ON p.pizza_id = od.pizza_id
GROUP BY 1
ORDER BY 2 DESC;

-- List the top 5 most ordered pizza types along with their quantities.

select * from order_details;
select * from pizza_types;

select pt.`name`, count(od.quantity) as total_quantity
from pizza_types pt
join order_details od
on pt.pizza_type_id = od.pizza_type_id
order by 2 desc limit 5 ;






