drop database moviecatalogue_db;
create database moviecatalogue_db;
use moviecatalogue_db;
                   
create table genre(genre_id int auto_increment primary key,
                   genre_name varchar(30) character set utf8mb4 not null);

create table director(director_id int auto_increment primary key,
                     first_name varchar(30) character set utf8mb4 not null, 
					last_name varchar(30) character set utf8mb4 not null,
                    birth_date date);

create table rating(rating_id int auto_increment primary key,
                    rating_name varchar(5) not null);

create table movie(movie_id int auto_increment primary key,
                   genre_id int not null,
                   director_id int,
                   rating_id int,
                   title varchar(128) character set utf8mb4,
                   release_date date,
                   foreign key (genre_id) references genre(genre_id),
                   foreign key (director_id) references director(director_id),
                   foreign key (rating_id) references rating(rating_id));

create table actor(actor_id int auto_increment primary key,
                    first_name varchar(30) character set utf8mb4 not null,
				   last_name varchar(30) character set utf8mb4 not null,
				   birth_date date);

create table castmembers(cast_member_id int auto_increment primary key,
                      actor_id int not null,
                      movie_id int not null,
                      role varchar(50) character set utf8mb4 not null,
                      foreign key (actor_id) references actor(actor_id),
                      foreign key (movie_id) references movie(movie_id));
                      
show actor;

show DATABASES;
