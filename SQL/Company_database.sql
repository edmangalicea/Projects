drop table Agent;
drop table Purchaser;
drop table Managers;
drop table Products;
drop table Sales;
/* question 2.1.1 */

create table Agent
    (Agent_id varchar(3),
    a_name varchar(5),
    dob char(10),
    salary varchar(6),
    Office varchar(2),
    primary key (Agent_id)
    );
    
create table Purchaser
    (pch_id varchar(3),
    Company varchar(10),
    pch_name varchar(8),
    city varchar(10),
    state char(2),
    primary key (pch_id)
    );

create table Managers
    (Agent_id1 varchar(3),
    Agent_id2 varchar(3),
    primary key (Agent_id1, Agent_id2)
    );
create table Products
    (pid varchar(5),
    pname varchar(7),
    unit_price numeric(5,0),
    conditions varchar(4) check (conditions = 'New' or conditions = 'Used'),
    primary key(pid)
    );
    
create table Sales
    (Agent_id varchar(3),
    pch_id varchar(3),
    pid varchar(5),
    quantity numeric(5,0),
    primary key (Agent_id, pch_id)
    );
    
/* Question 2.1.2 */

create table Agent
    (Agent_id varchar(3),
    a_name varchar(5),
    dob char(10),
    salary varchar(6) default(90000) not null check (salary> 60000 and salary < 300000) ,
    Office varchar(2),
    primary key (Agent_id)
    );    
    
/* Question 2.2.1 */

select pid, pname
from products, managers, sales
where unit_price > 250 and pid.products = pid.sales and Agent_id2 = 02;
    
/* 2.2.2 */
select pch_id, pid
from purchaser natural join products natural join sales
where purchaser.city = 'Boston'
and Sales.pid = Products.pid 
and sales.quantity > some (select quantity
from purchaser natural join products natural join sales
where purchaser.city = 'Orlando' and Sales.pid = Products.pid);

/* 2.2.3 */
select pname, unit_price
from purchaser natural join products natural join sales
where Sales.pid = Products.pid and Sales.pch_id = Purchaser.pch_id 
and not Purchaser.Company = 'Toyota';

/* 2.2.4 */
/*
select Agent_id, pid, avg_sales
from (select Agent_id, pid, avg(quantity) as avg_sales from Sales group by Agent_id,Pid)
where Sales.pid = Products.pid ;
*/
select Agent_id, pid, avg(quantity)/count(pch_id) as avg_sales
from Sales
group by Agent_id, pid;
/*2.2.5*/

select Agent_id1, count (Agent_id2) as Agent_Count
from managers
group by Agent_id1;

/*2.2.6 */
/* when it says number of products is it talking about the count of products? or do you want the list of all of them? */
select pid, quantity
from sales
where sales.quantity < 400;

/* 2.2.7 */
select pname, pch_name, company
from Products natural join Sales natural join Purchaser
where Products.pid = Sales.pid and Sales.pch_id = Purchaser.pch_id
and quantity < all(select quantity from sales);

/* 2.2.8 */
/* agent_id1 manages agent_id2 */
select Agent_id1, Agent_id2
from managers;

/* 2.3.1 */
/*Delete all the puurchases without placing any order */
delete from purchaser
where pch_id not in  (select pch_id from sales);


/* 2.3.2 */
insert into Product(pname, unit_price, condition) values('TV', 300, 'New');

/* 2.3.3 */  
update Product
set unit_price = case
    when unit_price < 0 then unit_price * 0
    when unit_price > 8000 then 3200
    when unit_price = NULL then 5000
    else unit_price
    end;


/* 2.3.4 */
update Agent
set Salary = (select salary + 0.03 * Sales.quantity from Sales natural join Agent
where Agent.Agent_id = Sales.Agent_id);


