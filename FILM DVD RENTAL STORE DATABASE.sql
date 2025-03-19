CREATE DATABASE film_dvd_rental_store;
USE film_dvd_rental_store;

CREATE TABLE category
(
	category_id TINYINT PRIMARY KEY,
    name VARCHAR(25) NOT NULL,
    last_update TIMESTAMP
);

CREATE TABLE film_category
(
    film_id SMALLINT(5),
    category_id TINYINT(3),
    last_update TIMESTAMP,
    PRIMARY KEY(film_id, category_id),
    FOREIGN KEY (category_id) REFERENCES category(category_id),
    FOREIGN KEY (film_id) REFERENCES film(film_id)
);

CREATE TABLE language
(
	language_id TINYINT(3) PRIMARY KEY,
    name CHAR(20) NOT NULL,
    last_update TIMESTAMP
);

CREATE TABLE actor
(
	actor_id SMALLINT(5) PRIMARY KEY,
    first_name VARCHAR(45) NOT NULL,
	last_name VARCHAR(45),
    last_update TIMESTAMP
);

CREATE TABLE film_actor (
    actor_id SMALLINT(5),
    film_id SMALLINT(5),
    last_update TIMESTAMP,
    PRIMARY KEY (actor_id, film_id),
    FOREIGN KEY (actor_id) REFERENCES actor(actor_id),
    FOREIGN KEY (film_id) REFERENCES film(film_id)
);

CREATE TABLE inventory
(
	inventory_id MEDIUMINT(8) PRIMARY KEY,
    film_id SMALLINT(5) NOT NULL,
    store_id TINYINT(3) NOT NULL,
    last_update TIMESTAMP
);

CREATE TABLE film
(
	film_id SMALLINT(5) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    discription TEXT(100) NOT NULL,
    release_year YEAR NOT NULL,
    language_id TINYINT(3) NOT NULL,
    FOREIGN KEY (language_id) REFERENCES language(language_id),
    original_language_id TINYINT(3) NOT NULL,
    FOREIGN KEY (original_language_id) REFERENCES language(language_id),
    actor_id SMALLINT(5) NOT NULL,
    FOREIGN KEY (actor_id) REFERENCES film_actor(actor_id),
    rental_duration TINYINT(3) NOT NULL,
    rental_rate DECIMAL(4,2),
    length SMALLINT(5) NOT NULL,
    replacement_cost DECIMAL(5,2),
    rating ENUM('G','PG','PG-13','R','NC-17') NOT NULL,
	special_features SET('Deleted Scenes', 'Commentary', 'Behind the Scenes', 'Trailers'),
    last_update TIMESTAMP
);

CREATE TABLE country (
    country_id SMALLINT(5) PRIMARY KEY,
    country VARCHAR(50) NOT NULL,
    last_update TIMESTAMP 
);

CREATE TABLE city (
    city_id SMALLINT(5) PRIMARY KEY,
    country_id SMALLINT(5),
    city VARCHAR(50) NOT NULL,
    last_update TIMESTAMP,
    FOREIGN KEY (country_id) REFERENCES country(country_id)
);

CREATE TABLE address
(
	address_id SMALLINT(5) PRIMARY KEY,
    address1 VARCHAR(50) NOT NULL,
    address2 VARCHAR(50) NOT NULL,
    district VARCHAR(20) NOT NULL,
    city_id SMALLINT(5),
    postal_code VARCHAR(10),
    phone INT(10) NOT NULL,
    location GEOMETRY,
    last_update TIMESTAMP,
    FOREIGN KEY (city_id) REFERENCES city(city_id)
);

CREATE TABLE staff
(
	staff_id TINYINT(3) PRIMARY KEY,
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45),
    address_id SMALLINT(5),
    picture BLOB,
    email VARCHAR(50) NOT NULL,
    store_id TINYINT(3),
    active TINYINT(1),
    username VARCHAR(16),
    password VARCHAR(40) NOT NULL,
    last_update TIMESTAMP,
    FOREIGN KEY (address_id) REFERENCES address(address_id),
    FOREIGN KEY (store_id) REFERENCES store(store_id)
);

CREATE TABLE customer
(
	customer_id SMALLINT(5) PRIMARY KEY,
    store_id TINYINT(3),
    first_name VARCHAR(45) NOT NULL,
    last_name VARCHAR(45) NOT NULL,
    email VARCHAR(50) NOT NULL,
    active TINYINT(1),
    create_date DATETIME,
    last_update TIMESTAMP,
    address_id SMALLINT(5),
	FOREIGN KEY (address_id) REFERENCES address(address_id)
);

CREATE TABLE rental
(
	rental_id INT(11) PRIMARY KEY,
    rental_date DATETIME,
    inventory_id MEDIUMINT(8),
    customer_id SMALLINT(5),
    staff_id TINYINT(3),
    return_date DATETIME,
    last_update TIMESTAMP,
    FOREIGN KEY (inventory_id) REFERENCES inventory(inventory_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

CREATE TABLE payment
(
	payment_id SMALLINT(5) PRIMARY KEY,
    customer_id SMALLINT(5),
    staff_id TINYINT(3),
    rental_id INT(11),
    amount DECIMAL(5,2),
    payment_date DATETIME,
    last_update TIMESTAMP,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id),
    FOREIGN KEY (rental_id) REFERENCES rental(rental_id)
);
