create table author (
                        author_id	serial PRIMARY KEY,
                        name_author	VARCHAR(50)
);

insert into author(name_author)
values
       ('Булгаков М.А.'),
       ('Достоевский Ф.М.'),
       ('Есенин С.А.'),
       ('Пастернак Б.Л.');

create table genre (
    genre_id serial PRIMARY KEY,
    name_genre	VARCHAR(30)
);

CREATE TABLE book (
                      book_id INT PRIMARY KEY AUTO_INCREMENT,
                      title VARCHAR(50),
                      author_id INT NOT NULL,
                      price DECIMAL(8,2),
                      amount INT,
                      FOREIGN KEY (author_id)  REFERENCES author (author_id)
);