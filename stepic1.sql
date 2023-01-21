SELECT * FROM information_schema.table_constraints WHERE table_name = 'book';

select title, author, amount,
       case when amount < 4 then price * 0.5 else price * 0.7 end as sale
from book;

select title, author, amount,
       case amount when 10 then price * 0.5
                   when 15 then price * 0.7
           else price * 0.9 end as sale
from book;

select title, author, amount,
       case when amount < 4 then price * 0.5
            when amount > 3 then price * 0.6
           else price * 0.7 end as sale
from book;

select title, author, amount,
       round((case when amount < 4 then price * 0.5 else price * 0.7 end), 2) as sale
from book;

select title, author, amount, price,
       case when amount < 4 then round(price * 0.5, 2)
            when amount < 11 then round(price * 0.7, 2)
            else price * 0.9 end as sale,
       case when amount < 4 then 'Скидка 50%'
            when amount < 11 then 'Скидка 30%'
            else 'Скидка 10%' end as Скидка
from book;

select title, price from book
where price < 600;

select title, price * amount as стоимость from book
where price * amount > 4000;

SELECT title, price
FROM book
WHERE author IN ('Булгаков М.А.', 'Достоевский Ф.М.');

select title, author from book
where (price between 540.5 and 800) and (amount in (2, 3, 5, 7));

select author, title, amount from book
where price < 750
order by author, amount desc;

select author, title from book
where amount between 2 and 14
order by author desc, title;

select title from book
where title like 'Б%';

select title from book
where title like '% и %'
or title like 'и %'
or title like '% и'
or title like 'и';

select title from book
where title not like '%_ _%';

select name from stepic
where name not like '%_ _%';

select title, author from book
where title like '%_ _%'
   and author like '%С.%'
order by title;

select title, author, price from book
where author like '%.М.%'
  and price < 600;

select 'Донцова Дарья' as author,
       concat('Евлампия Романова и ', title) as title,
       round((price * 1.42), 2) as price
       from book
order by price desc;

insert into book(title, author, price, amount) values ('Игрок', 'Достоевский Ф.М.', 480.50, 10);

select distinct author from book;

select author from book
group by author;

update book set amount = 3 where amount = 2;

select author, sum(amount), count(title), sum(price * amount) as sum_price from book
group by author;

INSERT INTO book (title, author, price, amount) VALUES ('Черный человек','Есенин С.А.', Null, Null);

select author, count(price) from book
group by author;

delete from book
where book_id = 7;

select author as Автор, count(DISTINCT title) as Различных_книг, sum(amount) as Количество_экземпляров from book
group by author;

select author, min(price) as Минимальная_цена,
       max(price) as Максимальная_цена,
       round(avg(price), 2) as Средняя_цена
           from book
group by author;

select author,
       round(sum(price * amount), 2) as Стоимость,
       round(sum(price * amount - price * amount / 1.18), 2) as НДС,
       round(sum(price * amount / 1.18), 2) as Стоимость_без_НДС
from book
group by author;

select min(price) as Минимальная_цена,
       max(price) as Максимальная_цена,
       round(avg(price), 2) as Средняя_цена
       from book;

select author,
       sum(price * amount),
       min(price) as Минимальная_цена,
       max(price) as Максимальная_цена
from book
group by author
having sum(price * amount) > 5000
order by Минимальная_цена desc;

select round(avg(price), 2) as Средняя_цена,
       sum(price * amount) as Стоимость
from book
where amount between 5 and 14;

select author, max(price), min(price)
from book
where author != 'Есенин С.А.'
group by author
having sum(amount) > 10;

select author, sum(price * amount) as Стоимость
from book
where title != 'Идиот' and title != 'Белая гвардия'
group by author
having sum(price * amount) > 5000
order by Стоимость desc;

select author, sum(price)
from book
where title != 'Стихотворения и поэмы'
group by author
having sum(price) > 1500;

select * from book
order by price desc
limit 1;

select * from book
where price = (select min(price) from book);

select author, title, price from book
where price <= (select avg(price) from book)
order by price desc;

select avg(price) from book;

select author, title, amount from book
where amount not between ((select avg(amount) from book) - 3) and ((select avg(amount) from book) + 3);

select title, author, amount from book
where abs(amount - (select avg(amount) from book)) > 3;

select avg(amount) from book;

select author, title, price from book
where (price - (select min(price) from book)) between 1 and 150
order by price;

select author, title, amount from book
where amount in (select amount
                 from book
                 group by amount
                 having count(amount) = 1);

select amount
from book
group by amount
having count(amount) = 1;

select title, author, price, amount
from book
where amount < all (select avg(amount)
                    from book
                    group by author);

select author, title, price
from book
where price < any (select min(price)
                    from book
                    group by author);

select title, author, amount, floor((select round(avg(amount), 2)
                               from book)) as Среднее_кол_во
from book
where abs(amount - (select avg(amount) from book)) > 3;

select title, author, amount,
       ((select max(amount) from book) - amount) as Заказ
from book
where amount != (select max(amount) from book);

select author, title
from (select *
      from book
      order by price desc
      limit 3) as sub
order by price
limit 1;

select author, title
from book
where price = (select min(price) from
               (select price
               from book
               order by price desc
               limit 3) as sub);

select author, title
from (select ROW_NUMBER () OVER (ORDER BY price desc) AS RowNum, *
      from book) as sub
where RowNum = 3;

delete from book
where book_id = 6;

update book set amount = 3 where book_id = 1;

create table supply (
    supply_id	serial PRIMARY KEY,
        title	VARCHAR(50),
        author	VARCHAR(30),
        price	DECIMAL(8, 2),
        amount	INT
);

insert into supply(title, author, price, amount)
values ('Лирика', 'Пастернак Б.Л.', 518.99, 2),
       ('Черный человек', 'Есенин С.А.', 570.20, 6),
       ('Белая гвардия', 'Булгаков М.А.', 540.50, 7),
       ('Идиот', 'Достоевский Ф.М.', 360.80, 3);

insert into book(title, author, price, amount)
select title, author, price, amount
from supply
where author not in (select author from book);

update book set price = price * 0.9 where amount between 5 and 10;

alter table book
add buy int;

update book set buy = 3 where book_id = 2;

update book set amount = amount - buy,
                buy = 0;

create table book
(book_id serial primary key,
 title varchar(50),
 author varchar(30),
 price decimal(8,2),
 amount int,
 buy int);
insert into book
(title, author, price, amount, buy)
values
    ('Мастер и Маргарита', 'Булгаков М.А.', 670.99, 3, 0),
    ('Белая гвардия', 'Булгаков М.А.', 540.50, 5, 3),
    ('Идиот', 'Достоевский Ф.М.', 460.00, 10, 8),
    ('Братья Карамазовы', 'Достоевский Ф.М.', 799.01, 2, 0),
    ('Стихотворения и поэмы', 'Есенин С.А.', 650.00, 15, 18);

update book set buy = case when amount < buy then amount else buy end,
                price = case when buy = 0 then price * 0.9 else price end;

UPDATE book
SET amount = book.amount + supply.amount,
    price = (book.price + supply.price) / 2
from supply
WHERE book.title = supply.title AND book.author = supply.author;

delete from supply
where author in (select author
                 from book
                 group by author
                 having sum(amount) > 10);

create table ordering as
select author, title, (select round(avg(amount))
                       from book) as amount
from book
where amount < (select round(avg(amount))
                from book);

update book set price = price * 0.9;

CREATE TABLE trip
(
    trip_id BIGSERIAL,
    name VARCHAR(30),
    city VARCHAR(25),
    per_diem DECIMAL(8,2),
    date_first DATE,
    date_last DATE
);

INSERT INTO trip(name, city, per_diem, date_first, date_last)
VALUES
    ('Баранов П.Е.', 'Москва', '700', '2020-01-12', '2020-01-17'),
    ('Абрамова К.А.', 'Владивосток', '450', '2020-01-14', '2020-01-27'),
    ('Семенов И.В.', 'Москва', '700', '2020-01-23', '2020-01-31'),
    ('Ильиных Г.Р.', 'Владивосток', '450', '2020-01-12', '2020-02-02'),
    ('Колесов С.П.', 'Москва', '700', '2020-02-01', '2020-02-06'),
    ('Баранов П.Е.', 'Москва', '700', '2020-02-14', '2020-02-22'),
    ('Абрамова К.А.', 'Москва', '700', '2020-02-23', '2020-03-01'),
    ('Лебедев Т.К.', 'Москва', '700', '2020-03-03', '2020-03-06'),
    ('Колесов С.П.', 'Новосибирск', '450', '2020-02-27', '2020-03-12'),
    ('Семенов И.В.', 'Санкт-Петербург', '700', '2020-03-29', '2020-04-05'),
    ('Абрамова К.А.', 'Москва', '700', '2020-04-06', '2020-04-14'),
    ('Баранов П.Е.', 'Новосибирск', '450', '2020-04-18', '2020-05-04'),
    ('Лебедев Т.К.', 'Томск', '450', '2020-05-20', '2020-05-31'),
    ('Семенов И.В.', 'Санкт-Петербург', '700', '2020-06-01', '2020-06-03'),
    ('Абрамова К.А.', 'Санкт-Петербург', '700', '2020-05-28', '2020-06-04'),
    ('Федорова А.Ю.', 'Новосибирск', '450', '2020-05-25', '2020-06-04'),
    ('Колесов С.П.', 'Новосибирск', '450', '2020-06-03', '2020-06-12'),
    ('Федорова А.Ю.', 'Томск', '450', '2020-06-20', '2020-06-26'),
    ('Абрамова К.А.', 'Владивосток', '450', '2020-07-02', '2020-07-13'),
    ('Баранов П.Е.', 'Воронеж', '450', '2020-07-19', '2020-07-25');

select name, city, per_diem, date_first, date_last
from trip
where name like '%_а _%'
order by date_last desc;

select distinct name
from trip
where city = 'Москва'
order by name;

select city, count(name) as Количество
from trip
group by city
order by city;

select *
from trip
order by date_first
limit 1;

select city, count(name) as Количество
from trip
group by city
order by Количество desc
limit 2;

select name, city, date_last - date_first + 1 as Длительность
from trip
where city not in ('Москва', 'Санкт-Петербург')
order by Длительность desc, city desc;

select name, city, date_first, date_last
from trip
where (date_last - date_first) = (select date_last - date_first as Длительность
                                  from trip
                                  order by Длительность
                                  limit 1);

select name, city, date_first, date_last
from trip
where (date_last - date_first) = (select min(date_last - date_first)
                                  from trip);

select name, city, date_first, date_last
from trip
where date_part('month', date_first) = date_part('month', date_last)
order by city, name;

select to_char(date_first, 'month') as Месяц, count(date_first) as Количество
from trip
group by to_char(date_first, 'month')
order by Количество desc, Месяц;

select name, city, date_first, (date_last - date_first + 1) * per_diem as Сумма
from trip
where date_part('month', date_first) in (2, 3)
order by name, Сумма desc;

update trip
set date_last = '2020-03-02'
where trip_id = 4;

select name, sum((date_last - date_first + 1) * per_diem) as Сумма
from trip
group by name
having count(city) > 3
order by Сумма desc;

CREATE TABLE fine
(
    fine_id        INT PRIMARY KEY GENERATED ALWAYS AS identity,
    name           TEXT,
    number_plate   TEXT,
    violation      TEXT,
    sum_fine       DECIMAL(8, 2),
    date_violation DATE,
    date_payment   DATE
);

INSERT INTO fine (name, number_plate, violation, sum_fine, date_violation, date_payment)
VALUES ('Баранов П.Е.', 'P523BT', 'Превышение скорости(от 40 до 60)', NULL, '2020-02-14 ', NULL),
       ('Абрамова К.А.', 'О111AB', 'Проезд на запрещающий сигнал', NULL, '2020-02-23', NULL),
       ('Яковлев Г.Р.', 'T330TT', 'Проезд на запрещающий сигнал', NULL, '2020-03-03', NULL),
       ('Баранов П.Е.', 'P523BT', 'Превышение скорости(от 40 до 60)', 500.00, '2020-01-12', '2020-01-17'),
       ('Абрамова К.А.', 'О111AB', 'Проезд на запрещающий сигнал', 1000.00, '2020-01-14', '2020-02-27'),
       ('Яковлев Г.Р.', 'T330TT', 'Превышение скорости(от 20 до 40)', 500.00, '2020-01-23', '2020-02-23'),
       ('Яковлев Г.Р.', 'M701AA', 'Превышение скорости(от 20 до 40)', NULL, '2020-01-12', NULL),
       ('Колесов С.П.', 'K892AX', 'Превышение скорости(от 20 до 40)', NULL, '2020-02-01', NULL);

CREATE TABLE traffic_violation
(
    violation_id INT PRIMARY KEY GENERATED ALWAYS AS identity,
    violation    TEXT,
    sum_fine     DECIMAL(8, 2)
);

INSERT INTO traffic_violation (violation, sum_fine)
VALUES ('Превышение скорости(от 20 до 40)', 500),
       ('Превышение скорости(от 40 до 60)', 1000),
       ('Проезд на запрещающий сигнал', 1000);

select f.name, f.number_plate, f.violation,
       case when f.sum_fine = tv.sum_fine then 'Стандартная сумма штрафа'
            when f.sum_fine < tv.sum_fine then 'Уменьшенная сумма штрафа'
            when f.sum_fine > tv.sum_fine then 'Увеличенная сумма штрафа' end as description
from fine f, traffic_violation tv
where f.violation = tv.violation and f.sum_fine is not null;

update fine f
set sum_fine = tv.sum_fine
from traffic_violation tv
where f.violation = tv.violation and f.sum_fine is null;

select f.name, f.number_plate, f.violation
from fine f
group by f.name, f.number_plate, f.violation
having count(name) > 1
order by name, number_plate, violation;

update fine f2
set sum_fine = f2.sum_fine * 2
from (select f.name, f.number_plate, f.violation
      from fine f
      group by f.name, f.number_plate, f.violation
      having count(f.name) > 1
      order by f.name, f.number_plate, f.violation) as n
where f2.date_payment is null
and f2.name = n.name
and f2.number_plate = n.number_plate
and f2.violation = n.violation;

update fine f2
set sum_fine = f2.sum_fine * 2
from (select f.name, f.number_plate, f.violation
      from fine f
      group by f.name, f.number_plate, f.violation
      having count(f.name) > 1
      order by f.name, f.number_plate, f.violation) as n
where f2.date_payment is null
  and f2.name in (n.name)
  and f2.number_plate in (n.number_plate)
  and f2.violation in (n.violation);

update fine f2
set sum_fine = f2.sum_fine * 2
from (select f.name, f.number_plate, f.violation
      from fine f
      group by f.name, f.number_plate, f.violation
      having count(f.name) > 1
      order by f.name, f.number_plate, f.violation) as n
where f2.date_payment is null
  and (f2.name, f2.number_plate, f2.violation) = (n.name, n.number_plate, n.violation);

with n as (select f.name, f.number_plate, f.violation
           from fine f
           group by f.name, f.number_plate, f.violation
           having count(f.name) > 1
           order by f.name, f.number_plate, f.violation)
update fine f2
set sum_fine = f2.sum_fine * 2
from n
where f2.date_payment is null
  and (f2.name, f2.number_plate, f2.violation) = (n.name, n.number_plate, n.violation);

update fine
set sum_fine = 2000
where fine_id in (1, 2);

CREATE TABLE payment
(
    payment_id INT PRIMARY KEY GENERATED ALWAYS AS identity,
    name           TEXT,
    number_plate   TEXT,
    violation      TEXT,
    date_violation DATE,
    date_payment DATE
);

INSERT INTO payment (name, number_plate, violation, date_violation, date_payment)
VALUES
    ('Яковлев Г.Р.', 'M701AA', 'Превышение скорости(от 20 до 40)', '2020-01-12', '2020-01-22'),
    ('Баранов П.Е.', 'P523BT', 'Превышение скорости(от 40 до 60)', '2020-02-14', '2020-03-06'),
    ('Яковлев Г.Р.', 'T330TT', 'Проезд на запрещающий сигнал', '2020-03-03', '2020-03-23');

update fine f
set date_payment = p.date_payment,
    sum_fine = case when (p.date_payment - f.date_violation) <= 20 then f.sum_fine / 2 else f.sum_fine end
from payment p
where f.date_payment is null
and (f.name, f.number_plate, f.violation, f.date_violation)
        = (p.name, p.number_plate, p.violation, p.date_violation);

create table back_payment as
      select name, number_plate, violation, sum_fine, date_violation
      from fine
      where date_payment is null;

delete from fine
where date_violation < '2020-02-01';