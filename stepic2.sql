create table author (
                        author_id	serial PRIMARY KEY,
                        name_author	VARCHAR(50)
);

insert into author(name_author)
values
    ('�������� �.�.'),
    ('����������� �.�.'),
    ('������ �.�.'),
    ('��������� �.�.'),
    ('��������� �.�.');

create table genre (
                       genre_id serial PRIMARY KEY,
                       name_genre	VARCHAR(30)
);

insert into genre(name_genre) values ('�����'),
                                  ('������'),
                                  ('�����������');

CREATE TABLE book (
                      book_id serial PRIMARY KEY,
                      title VARCHAR(50),
                      author_id INT NOT NULL,
                      genre_id int,
                      price DECIMAL(8,2),
                      amount INT,
                      FOREIGN KEY (author_id)  REFERENCES author on DELETE cascade,
                      FOREIGN KEY (genre_id)  REFERENCES genre on DELETE set null
);

INSERT INTO book (title, author_id, genre_id, price, amount)
VALUES ('������ � ���������', 1, 1, 670.99, 3),
       ('����� ������� ', 1, 1, 540.50, 5),
       ('������ ����������', 2, 1, 799.01, 3),
       ('�����', 2, 1, 480.50, 10),
       ('������������� � �����', 3, 2, 650.00, 15),
       ('������ �������', 3, 2, 570.20, 6),
       ('������', 4, 2, 518.99, 10),
       ('�����', 2, 1, 460.00, 10),
       ('����� ������ �������', 5, 3, 570.59, 2),
       ('������ ������', 4, 3, 740.50, 5);

select title, name_author
from book b inner join author a on a.author_id = b.author_id;

select title, name_genre, price
from genre g join book b on g.genre_id = b.genre_id
where b.amount > 8
order by price desc;

select name_author, title
from author a left join book b on a.author_id = b.author_id;

select name_genre
from genre g left join book b on g.genre_id = b.genre_id
where b.title is null;

SELECT g.name_genre
FROM genre g
WHERE not EXISTS(SELECT * from book b WHERE b.genre_id = g.genre_id);

select * from book, genre;

create table city (
    city_id serial primary key,
    name_city text
);

insert into city(name_city)
values ('������'),
       ('�����-���������'),
       ('�����������');

select name_city, name_author, '2020-01-01'::date + floor(random() * 365)::int as ����
from author, city
order by name_city, ���� desc;

select title, name_author, name_genre, price, amount
from book b
    join author a on a.author_id = b.author_id
    join genre g on g.genre_id = b.genre_id
where price between 500 and 700;

select name_genre, title, name_author
from book b join genre g on g.genre_id = b.genre_id
            join author a on a.author_id = b.author_id
where name_genre like '�����'
order by title;

select name_author, case when sum(amount) is null then 0 else sum(amount) end as ����������
from book b right join author a on a.author_id = b.author_id
group by name_author
having sum(amount) < 10 or sum(amount) is null
order by ����������;

select name_author, sum(amount) as ����������
from book b right join author a on a.author_id = b.author_id
group by name_author
having sum(amount) < 10 or sum(amount) is null
order by ����������;

SELECT author_id, SUM(amount) AS sum_amount FROM book GROUP BY author_id;

update book set genre_id = 1
where book_id = 7;

update book set genre_id = 3
where book_id = 2;

select name_author
from book b inner join author a on a.author_id = b.author_id
group by name_author
having count(distinct b.genre_id) = 1
order by name_author;

select title, name_author, name_genre, price, amount
from book b inner join genre g on g.genre_id = b.genre_id
            inner join author a on a.author_id = b.author_id
where b.genre_id in (select genre_id
                    from book
                    group by genre_id
                    having sum(amount) = (select sum(amount) as max_amount
                                          from book
                                          group by genre_id
                                          order by max_amount desc
                                          limit 1))
order by b.title;


