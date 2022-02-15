create database E_Commerce;

use E_Commerce;

create table if not exists `supplier`
(
`SUPP_ID` INT primary Key auto_increment ,
`SUPP_NAME` varchar(30),
`SUPP_CITY` varchar(40),
`SUPP_PHONE` varchar(10)
);

create table if not exists `customer`
(
`CUS_ID` int not null,
`CUS_NAME` varchar(20) null default null,
`CUS_PHONE` varchar(10),
`CUS_CITY` varchar(30),
`CUS_GENDER` char,
primary key(`CUS_ID`));

create table if not exists `category` 
(
`CAT_ID` int not null,
`CAT_NAME` varchar(20) null default null,
primary key(`CAT_ID`)

);

create table IF not exists `product`(
`PRO_ID` int not null,
`PRO_NAME` varchar(20) null default null,
`PRO_DESC` varchar(60) null default null,
`CAT_ID` int not null,
primary key(`PRO_ID`),
foreign key(`CAT_ID`) references category(`CAT_ID`)
);

create table if not exists `product_details`(
`PROD_ID` int not null,
`PRO_ID` int not null,
`SUPP_ID` int not null,
`PROD_PRICE` int not null,
primary key(`PROD_ID`),
foreign key(`PRO_ID`)references product(`PRO_ID`),
foreign key(`SUPP_ID`) references supplier(`SUPP_ID`)
);

create table if not exists `Orders`(
`ORD_ID` int not null,
`ORD_AMOUNT` int not null,
`ORD_DATE` date,
`CUS_ID` int not null,
`PROD_ID` int not null,
primary key(`ORD_ID`),
foreign key(`CUS_ID`)references customer(`CUS_ID`),
foreign key(`PROD_ID`) references product_details(`PROD_ID`)
);


create table if not exists `rating`
(
`RAT_ID` int not null,
`CUS_ID` int not null,
`SUPP_ID` int not null,
`RAT_RATSTARS` int not null,
primary key(`RAT_ID`),
foreign key(`SUPP_ID`) references supplier(`SUPP_ID`),
foreign key(`CUS_ID`) references customer(`CUS_ID`)
);

insert into `supplier` values(1,'Rajesh Retails','Delhi','1234567890');
insert into `supplier` values(2,'Appario Ltd','Mumbai','2589631470');
insert into `supplier` values(3,'Knome products','Banglore','9785462315');
insert into `supplier` values(4,'Bansal Retails','Kochi','8975463285');
insert into `supplier` values(5,'Mittal Ltd','Lucknow','7898456532');

insert into `customer` values(1,'AAKASH','9999999999','DELHI','M');
insert into `customer` values(2,'AMAN','9785463215','NOIDA','M');
insert into `customer` values(3,'NEHA','9999999999','MUMBAI','F');
insert into `customer` values(4,'MEGHA','9994562399','KOLKATA','F');
insert into `customer` values(5,'PULKIT','7895999999','LUCKNOW','M');

insert into `category` values(1,'BOOKS');
insert into `category` values(2,'GAMES');
insert into `category` values(3,'GROCERIES');
insert into `category` values(4,'ELECTRONICS');
insert into `category `values(5,'CLOTHES');

insert into `product` values(1,'GTA V','DFJDJFDJFDJFDJFJF',2);
insert into `product` values(2,'TSHIRT','DFDFJDFJDKFD',5);
insert into `product` values(3,'ROG LAPTOP','DFNTTNTNTERND',4);
insert into `product` values(4,'OATS','REURENTBTOTH',3);
insert into `product` values(5,'HARRY POTTER','NBEMCTHTJTH',1);

insert into `product_details` values(1,1,2,1500);
insert into `product_details` values(1,3,5,30000);
insert into `product_details` values(3,5,1,3000);
insert into `product_details` value(4,2,3,2500);
insert into `product_details` values(5,4,1,1000);

insert into `Orders` values(20,1500,"2021-10-12",2,1);
insert into `Orders` values(25,30500,"2021-09-16",3,5);
insert into `Orders` values(26,2000,"2021-10-05",5,2);
insert into `Orders` values(30,3500,"2021-08-16",1,1);
insert into `Orders` values(50,2500,"2021-10-06",4,3);

insert into `rating` values(1,2,2,4);
insert into `rating` values(2,3,4,3);
insert into `rating` values(3,5,1,5);
insert into `rating` values(5,4,5,4);

select `customer`.cus_gender,count(customer.cus_gender) as count from `customer` 
inner join `Orders` on `customer`.cus_id = `Orders`.cus-id
where `Orders`.ord_amount >= 3000 group by
`customer`.cus_gender;


select `orders`.*,product.pro_name from `orders`, product_details, product
where `orders` .cus_id =2 and `orders`. prod_id = product_details.prod_id and 
product_details.prod_id = product.pro_id;

select supplier.* from supplier , product_details where supplier.supp_id in 
(select product_details.supp_id from product_details group by product_details.supp_id having 
count(product_details.supp_id) > 1) group by supplier.supp_id;

select category.* from `orders` inner join product_details on
`orders`.prod_id = product_details.prod_id inner join product on 
product.pro_id = product_details.pro_id inner join category on 
category.cat_id = product.cat_id
having min(`orders`.ord_amount);


#QUERY 7
select product.pro_id,product.pro_name from orders inner join product_details on 
product_details.pro_id = orders.prod_id inner join product on 
product.pro_id = product_details.pro_id where orders.ord_date > 2021-10-05;

# QUERY 8
select customer.cus_name,customer.cus_gender from customer where customer.cus_name like 'A%' or
customer.cus-name like 'A%'; 

# QUERY 9
select supplier.supp_id,supplier.supp_name, rating.rat_ratstars,
case
when rating.rat_ratstars > 4 then 'genuine suppllier`
when rating.rat_ratstars > 2 then `average supplier`
else `supplier should not be considered`
end
 as verdict from rating inner join supplier on supplier.supp_id = rating.supp_id;
 
 delimiter $$
 creat procedure proc1()
 begin
 select supplier.supp_id,supplier.supp_name, rating.rat_ratstars,
  case
     when rating.rat_ratstars > 4 then'genuine supplier'
     when rating.rat_ratstars > 2 then'average supplier'
     else 'supplier should not be considered'
     end
as verdict from rating inner join supplier on supplier.supp_id = rating.supp_id;
 end $$
 
 call proc1;
 











