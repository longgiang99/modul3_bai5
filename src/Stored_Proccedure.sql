use classicmodels;
delimiter //
create procedure findAllCustumer()
begin
    select *from customers;

end //
delimiter ;
call findAllCustumer();
delimiter //
drop procedure if exists findAllCustumer;
call findAllCustumer();
delimiter ;

delimiter //
create procedure getCusById(in cusNum int(5))
begin
    select * from customers where customernumber = cusNum;
end //
delimiter ;

call getCusById(242);

delimiter //
create procedure getCusCountById(
    in in_city varchar(50),
    out total int
)
begin
    select count(customerNumber)
    into total
    from customers
    where city = in_city;
end //

delimiter ;
call getCusCountById('lyon', @total);
select @total;

DELIMITER //

CREATE PROCEDURE SetCounter(
    INOUT counter INT,
    IN inc INT
)

BEGIN

    SET counter = counter + inc;

END//

DELIMITER ;
SET @counter = 1;

CALL SetCounter(@counter, 1);

CALL SetCounter(@counter, 1);

CALL SetCounter(@counter, 5);

SELECT @counter;

create view cusViews as select customerNumber,customerName,phone from  customers;
select *from cusViews;
create or replace view cusViews as select customerName,phone,contactFirstName,contactLastName from customers;
select *from cusViews;
drop view cusViews;

use demo;
create unique index abc on products(productCode);
create index cba on products(productName,productPrice);
explain select *from products where productCode= '@24';
drop index abc on products;
create view produ as select productCode,productName,productPrice,productstartus from products;
select *from produ;
create  or replace view produ as select productName,productPrice from products;
drop view  produ;
delimiter //
create procedure info_product()
begin
    select *from products;
end //

delimiter ;
call info_product();


delimiter //
create procedure add_product(
in code varchar(20),
in name varchar(50),
in price int,
in amount int,
in description varchar(100),
in startus tinyint(1)
) begin
    insert into products( productCode, productName, productPrice, productAmount, productDescription, productstartus)
        values(code,name,price,amount,description,startus) ;
end //
delimiter ;
call add_product('@30','abc',10,30,'ngon',2);
delimiter //
create procedure update_product(
in id_input int,
in code varchar(20),
in name varchar(50),
in price int,
in amount int,
in description varchar(100),
in startus tinyint(1)
)
begin
update products
    set productCode =code,
        productName = name,
        productPrice =price,
        productAmount=amount,
        productDescription =description,
        productstartus = startus
    where id= id_input;

end //
delimiter ;
call update_product(1,'23','giang',10,10,'ngon',5);
delimiter //
create procedure delete_product(
in id_in int
)begin
    delete from products where id=id_in;
end //

delimiter ;
call delete_product(1);