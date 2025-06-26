
select * from stores; -- 3
select * from staffs; -- 10
select * from products; -- 321
select * from brands; -- 9
select * from categories; -- 7
select * from stocks; -- 939 
select * from orders; -- 1615
select * from order_items; -- 4722
select * from customers; -- 1445
select * from status; -- 4


1) Identify product which are not sold to any customer yet. Rejected orders can also be considered as not sold yet.
    select *
    from products 
    where product_id not in (select product_id 
                            from order_items oi
                            join orders o on o.order_id=oi.order_id
                            join status s on s.code=o.order_status
                            where s.description<>'Rejected');


2) Display the store name and their employee names. Output should have 1 record for each store with staff names can be comma seperated.
    select store_name ,concat(emp.first_name,' ',emp.last_name) as staff
    from stores s
    join staffs emp on emp.store_id=s.store_id ;

    select store_name, listagg(concat(emp.first_name,' ',emp.last_name), ', ') as staff
    from stores s
    join staffs emp on emp.store_id=s.store_id 
    group by store_name;


3) Display the most in stock product in each store.
    with cte as 
        (select st.store_name, p.product_name, sum(s.quantity) as remaining_quantity
        , rank() over(partition by st.store_name order by remaining_quantity desc) as rnk
        from stocks s 
        join products p on p.product_id=s.product_id
        join stores st on st.store_id=s.store_id
        group by st.store_name, p.product_name)
    select store_name, product_name, remaining_quantity
    from cte 
    where rnk=1;

    
4) For all the orders which are neither completed nor rejected and display the order id, order status description, product name, quantity ordered, total cost, store name, staff name, customer name
    select o.order_id, s.description as status, p.product_name, oi.quantity, oi.list_price
    , concat(oi.discount*100,'%') as discount
    , (oi.quantity*oi.list_price) * (1-oi.discount) as total_cost 
    , st.store_name, concat(emp.first_name,emp.last_name) as emp_name
    , concat(c.first_name,c.last_name) as cust_name
    from orders o 
    join order_items oi on oi.order_id=o.order_id 
    join status s on s.code = o.order_status
    join products p on p.product_id = oi.product_id
    join stores st on st.store_id=o.store_id
    join staffs emp on emp.staff_id=o.staff_id
    join customers c on c.customer_id=o.customer_id
    where s.description not in ('Completed', 'Rejected');


5) Find the most sold product. Display the product name, brand  name, category name. Only completed orders should be considered.
    select product_name 
    from (
        select product_name, sum(oi.quantity) as total_sold
        , rank() over(order by total_sold desc) as rnk 
        from orders o
        join order_items oi on oi.order_id=o.order_id
        join status s on s.code=o.order_status
        join products p on p.product_id=oi.product_id
        where s.description = 'Completed'
        group by product_name) sq 
    where sq.rnk=1;


6) Identify staff who have sold more than 1000 products.
    select concat(s.first_name,' ',s.last_name) as staff, sum(oi.quantity) as total_products
    from order_items oi 
    join orders o on o.order_id = oi.order_id
    join staffs s on s.staff_id=o.staff_id
    group by staff
    having total_products >= 1000;
    

7) Identify the 3 most selling bike categories.
    select category_name
    from (
        select c.category_name,sum(quantity) as total_sold
        , rank() over(order by sum(quantity) desc) as rnk 
        from order_items oi
        join products p on oi.product_id=p.product_id
        join categories c on c.category_id=p.category_id
        group by c.category_name) x
    where x.rnk=1;


8) Which city hosts most frequent customers? If multiple customers have same frequency then consider then as 1.
    with cte as 
        (select customer_id, count(1) as total_orders
        , rank() over(order by count(1) desc) as rnk 
        from orders
        group by customer_id)
    select distinct c.city
    from cte 
    join customers c on c.customer_id=cte.customer_id
    where rnk = 1
    order by city;

    
9) Display the brand with the least no of in stock products
    select brand_name 
    from (
        select b.brand_name, sum(s.quantity) as total_stock
        , rank() over(order by sum(s.quantity)) as rnk 
        from stocks s
        join products p on p.product_id=s.product_id
        join brands b on b.brand_id=p.brand_id
        group by b.brand_name) x 
    where x.rnk=1;
    

10) Which store has the most and least no of customers? Display 2 columns for highest customer and lowest customer. Mention also customer count suffixed to customer name.
    select distinct 
      concat(first_value(store_name) over(order by count(1) desc)
            , ' - '
            , first_value(count(1)) over(order by count(1) desc)) as highest_customers
    , concat(first_value(store_name) over(order by count(1))
            , ' - '
            , first_value(count(1)) over(order by count(1)))  as lowest_customers
    from (select distinct store_name, customer_id
        from orders o 
        join stores s on s.store_id=o.store_id) o 
    group by store_name;

