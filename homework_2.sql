select count(*) "Количество всех заказов"
from orders o;

select o.order_id, sum(o.unit_price * o.quantity * (1 - o.discount)) as "Итоговый чек"
from order_details o 
group by o.order_id ;

select e.city "Наименование города", count(city) "Количество сотрудников"
from employees e 
group by e.city ;

select concat(e.first_name, ' ',e.last_name) as "ФИО сотрудника", sum(od.unit_price * od.quantity * (1 - od.discount)) as "Сумма заказа"
from orders o
inner join order_details od on o.order_id = od.order_id 
inner join employees e on o.employee_id = e.employee_id 
group by "ФИО сотрудника";

select p.product_name as "Наименование продукта", sum(od.quantity) as "Продано в шт."
from order_details od 
inner join products p on od.product_id = p.product_id 
group by p.product_name 
order by "Продано в шт." asc;

select *
from products;

select *
from employees e ;

select *
from orders o;

select *
from order_details o ;