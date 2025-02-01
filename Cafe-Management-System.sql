SQL>Create table MenuItems (item_id number(10)primary key, name
varchar(100),description varchar(20),price float(10),category varchar(50));

SQL>Create table Customer (cust_id number(10)primary key, name
varchar(100),contact_info number(10));

SQL>create table Order_details (order_id number(10) primary key, order_date date
,total_amount number(10),cust_id number(10),foreign key (cust_id) references
Customer(cust_id));

SQL>create table Suppliers (supplier_id number(4) primary key,name
varchar(10),contact_info number(10));

SQL>insert all into MenuItems values (1, 'Burger', 'A cheeseburger', 150, 'Main
Course')into MenuItems values
(2, 'Fries', ' French fries', 50, 'Side')into MenuItems values
(3, 'Pizza', ' Margherita pizza', 250, 'Main Course')into MenuItems values
(4, 'Soda', ' cola drink', 30, 'Beverage')
select * from dual;

SQL>insert all into Customer values (1, 'Swamiraj', 8308306784)
into Customer values(2, 'Shivam', 8788360118)
into Customer values(3, 'Vedant', 8600180515)
into Customer values(4, 'Arya', 8888878128)
select * from dual;

SQL>insert all into Order_details values (101, '14-nov-2023', 230, 1)
into Order_details values(102, '14-nov-2023', 280, 2)
into Order_details values(103, '13-nov-2023', 150, 3)
into Order_details values(104, '10-nov-2023', 250, 4)
select * from dual;

SQL>insert all into Suppliers values (201, 'Food Inc.', 8700345571)
into Suppliers values(202,'Quality ', 9960302141)
into Suppliers values(203, 'Masters', 9011586059)
into Suppliers values(204, 'Drinks Co.', 9622385092 )
select * from dual

SQL>select * from suppliers;
SQL>select * from menuitems;
SQL>select * from customer;

SQL> select * from order_details where cust_id = 1;

SQL> select c.name as customer_name, sum(o.total_amount) as total_spent from customer c join order_details o on c.cust_id = o.cust_id group by c.name;

SQL> select count(*) as total_orders from order_details where order_date = to_date('14-nov-2023', 'dd-mon-yyyy');

SQL> set serveroutput on
SQL> declare
 2 v_name menuitems.name%type;
 3 v_price menuitems.price%type;
 4 begin
 5 select name, price into v_name, v_price
 6 from menuitems
 7 where item_id = 1;
 8
 9 dbms_output.put_line('Item: ' || v_name || ' Price: ' || v_price);
10 end;
11 /

SQL> set serveroutput on;
SQL> declare
 2 v_price menuitems.price%type;
 3 begin
 4 select price into v_price
 5 from menuitems
 6 where item_id = 2;
 7
 8 if v_price > 100 then
 9 dbms_output.put_line('The price is above 100');
10 else
11 dbms_output.put_line('The price is 100 or below');
12 end if;
13 end;
14 /

SQL> set serveroutput on;
SQL> declare
 2 v_discounted_price number;
 3 begin
 4 v_discounted_price := get_discounted_price(1);
 5 dbms_output.put_line('Discounted price: ' || v_discounted_price);
 6 end;
 7 /

SQL> set serveroutput on;
SQL> create or replace trigger log_price_update
 2 after update of price on menuitems
 3 for each row
 4 begin
 5 insert into price_log (item_id, old_price, new_price, update_time)
 6 values (:old.item_id, :old.price, :new.price, sysdate);
 7 end;
 8 /