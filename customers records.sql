create table customer_records (
customer_id int auto_increment primary key,
name varchar (30),
age int,
email varchar(200)
);

-- insert 10 customer records --

insert into customer_records (name,age,email)
values ('john doe' , 23 , 'johndoe@123.com'),
('mark doe' , 19 , 'markdoe@123.com'),
('vimal' , 25 , 'vimal@127.com'),
('mani' , 27 , 'mani@123.com'),
('pradeep',30,'pradeepkumar@156.com'),
('sundeep',21,'sundeepkishan@158.com'),
('kiran',45,'kiranraj@344.com'),
('victor',35,'victor@0001.com'),
('sathya',41,'sathya@156.com'),
('ashok',50,'ashokselvan@156.com');

select *from customer_records;


create table customer_address(
address_id int auto_increment primary key ,
customer_id int,
home_address varchar (100),
work_address varchar (100),
stay_address varchar(100),
address_type varchar (100),
status varchar (50),
status_time time,
foreign key(customer_id)references customer_records(customer_id)
);


-- Insert 10 records into customer_address with Tamil Nadu (Thanjavur) addresses

insert into customer_address (customer_id, home_address, work_address, stay_address, address_type, status, status_time)
values
(1, '123 East Street, Thanjavur', null,'pallavaram road, chrompet', 'Home', 'Active','09:39:00'), -- 9.39 AM
(2, null, '456 Work Avenue, Thanjavur', null, 'Work', 'Active','06:30:00'), -- 6.30 AM
(3, '789 South Street, Thanjavur', null, null, 'Home', 'Active', '21:30:00 '), -- 21.30 PM
(4, null, '321 Industrial Road, Thanjavur', null, 'Work', 'Active','11:30:00 '), -- 11.30 AM
(5, '22 North Street, Thanjavur', null, null, 'Home', 'Active','14:30:00 '), -- 14.30 PM
(6, '666 Orathandau', '555 Stay Blvd, Thanjavur', '231 padukkottai hostel','Stay', 'Deactive', '20:30:00 '), -- 20.30 PM
(7, '99 River Road, Thanjavur', null, null, 'Home', 'Active','10:00:00 '), -- 10.00 AM
(8, 'trichy road,vallam', '11 Tech Park, Thanjavur', 'new bustand near thanjavur', 'Work', 'Deactive', '21:45:00 '), -- 21.45 PM
(9, '55 Market Street, Thanjavur', null, null, 'Home', 'Active', '08:20:00 '), -- 8.20 AM
(10, 'near central bustand of madurai', '88 Industrial Area, Thanjavur', null, 'Work', 'Deactive', '15:21:00 '); -- 15.21 PM

select *from customer_address;
drop table customer_address ;

--------------------------------------------------------------------------------------

-- 1. let's consider customer is creating orders. Each order must have one or more items. Basically write insert statements with proper order items. Create orders only for half of the customer --

create table orders_details(
order_id int auto_increment primary key,
order_item varchar(50),
order_date datetime,
delivery_date datetime default current_timestamp,
address_id int,
customer_id int,
foreign key (address_id) references customer_address (address_id),
foreign key (customer_id) references customer_records (customer_id)
);

INSERT INTO orders_details (order_item, order_date, delivery_date, address_id, customer_id)
VALUES
('Laptop', '2025-06-01 10:00:00', '2025-06-05 10:00:00', 1, 1),
('Smartphone', '2025-06-02 11:00:00', '2025-06-06 11:00:00', 1, 1),
('Tablet', '2025-06-03 09:30:00', '2025-06-07 09:30:00', 2, 2),
('Monitor', '2025-06-04 12:15:00', '2025-06-08 12:15:00', 3, 3),
('Headphones', '2025-06-05 13:20:00', '2025-06-09 13:20:00', 4, 4),
('Keyboard', '2025-06-06 14:45:00', '2025-06-10 14:45:00', 5, 5),
('Mouse', '2025-06-07 15:30:00', '2025-06-11 15:30:00', 5, 5),
('Charger', '2025-06-08 16:30:00', '2025-06-12 16:30:00', 4, 4),
('Webcam', '2025-06-09 17:30:00', '2025-06-13 17:30:00', 3, 3),
('Speaker', '2025-06-10 18:30:00', '2025-06-14 18:30:00', 2, 2);

select *from orders_details;

-- 2.Write select query to pull only an active status customer --

SELECT cr.customer_id, cr.name, cr.age, cr.email
FROM customer_records cr
JOIN customer_address ca ON cr.customer_id = ca.customer_id
WHERE ca.status = 'Active';

-- 3.Update top 5 customer status as Deleted from Active & also update modified time as well --

update customer_address set status='Delete', status_time= '10:00:45'
where customer_id<=5;

-- 4.Write query to pull all active customers with only the home address type address record -- 

select cr.name,cr.age,cr.email
from customer_records cr
join customer_address ca on cr.customer_id=ca.customer_id 
where status='Active' and ca.address_type='home';