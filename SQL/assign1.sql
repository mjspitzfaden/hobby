CREATE TABLE restaurant (
  id SERIAL NOT NULL PRIMARY KEY,
  name VARCHAR,
  distance INTEGER,
  stars INTEGER,
  category VARCHAR,
  favorite_dish VARCHAR,
  takout BOOLEAN,
  last_time DATE
);

--
INSERT INTO restaurant Values (1, 'pizzaplace', 10, 5, 'Italian', 'pizza', TRUE, '2017-04-17');
--
INSERT INTO restaurant Values (2, 'place', 5, 1, 'Italian', 'pizza', FALSE, '2017-04-18');
--
SELECT * FROM restaurant WHERE favorite_dish LIKE '%izza%';
--
INSERT INTO restaurant Values (3, 'Michael', 4, 4, 'Polish', 'pizza', FALSE, '2017-04-22');
--
select * FROM restaurant;
INSERT INTO restaurant Values (3, 'Michael', 4, 4, 'Polish', 'pizza', FALSE, '2017-04-22');
--
INSERT INTO restaurant Values (4, 'Michael', 4, 4, 'Polish', 'pizza', FALSE, '2017-04-22');
--
select * FROM restaurant;
--
INSERT INTO restaurant Values (3, 'Michael', 4, 4, 'Polish', 'pizza', FALSE, '2017-04-22');
--
select * FROM restaurant;

CREATE TABLE restaurant (
  id SERIAL NOT NULL PRIMARY KEY,
  name VARCHAR,
  distance INTEGER,
  stars INTEGER,
  category VARCHAR,
  favorite_dish VARCHAR,
  takout BOOLEAN,
  last_time DATE
);
--
INSERT INTO restaurant Values (1, 'pizzaplace', 10, 5, 'Italian', 'pizza', TRUE, '2017-04-17');
--
INSERT INTO restaurant Values (2, 'place', 5, 1, 'Italian', 'pizza', FALSE, '2017-04-18');
--
SELECT * FROM restaurant WHERE favorite_dish LIKE '%izza%';
--
INSERT INTO restaurant Values (3, 'Michael', 4, 4, 'Polish', 'pizza', FALSE, '2017-04-22');
--
select * FROM restaurant;
INSERT INTO restaurant Values (3, 'Michael', 4, 4, 'Polish', 'pizza', FALSE, '2017-04-22');
--
INSERT INTO restaurant Values (4, 'Michael', 4, 4, 'Polish', 'pizza', FALSE, '2017-04-22');
--
select * FROM restaurant;
--
INSERT INTO restaurant Values (3, 'Michael', 4, 4, 'Polish', 'pizza', FALSE, '2017-04-22');
--
select * FROM restaurant;
---  The names of the restaurants that you gave a 5 stars to:
select name FROM restaurant WHERE stars = 5;
---- The favorite dishes of all 5-star restaurants
select favorite_dish FROM restaurant WHERE stars = 5;
--The the id of a restaurant by a specific restaurant name, say 'Moon Tower'
select id FROM restaurant WHERE name = 'Michael';
-- restaurants in the category of 'BBQ'
select name FROM restaurant WHERE category = 'Polish';
--restaurants that do take out
select name FROM restaurant WHERE takout = TRUE;
--restaurants that do take out and is in the category of 'BBQ'
select name FROM restaurant WHERE takout = TRUE AND category = 'BBQ';
--restaurants within 2 miles
select name FROM restaurant WHERE distance < 2;
--restaurants you haven't ate at in the last week
select name FROM restaurant WHERE date < 2017-10-3 or date = NULL;
--restaurants you haven't ate at in the last week and has 5 stars
select name FROM restaurant WHERE stars = 5 and last_time < 2017-10-3 or last_time = NULL;
--list restaurants by the closest distance.
select * FROM restaurant ORDER BY distance;
--list the top 2 restaurants by distance.
select * FROM restaurant ORDER BY distance limit 2;
--list the top 2 restaurants by stars.
select * FROM restaurant ORDER BY stars limit 2;
--list the top 2 restaurants by stars where the distance is less than 2 miles.
select * FROM restaurant WHERE distance < 2 ORDER BY stars limit 2;
--count the number of restaurants in the db.
select count(*) FROM restaurant;
--count the number of restaurants by category.
select category, count(*) from restaurant group by category;
--get the average stars per restaurant by category.
select category, avg(stars) from restaurant group by category;
--get the max stars of a restaurant by category.
select category, max(stars) from restaurant group by category;
