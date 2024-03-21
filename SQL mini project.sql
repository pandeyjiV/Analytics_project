use online_food;
show tables;

describe food;
alter table food add primary key (ID);

/* finding total number of rows in a table */
select count(ID) from food;

select * from food 
limit 5;
/* Find total city from each area */
select count(distinct(city)) from food;

/* Find total restaurant from each city*/
select count(distinct(Restaurant)) from food;
select city, count(distinct(restaurant)) as tot_hotels
from food
group by city
order by tot_hotels desc;
/* Find total order made from each restaurant from Bangalore*/
select Restaurant ,count(ID) as tot_orders
from food
where city = 'Bangalore'
group by restaurant 
order by count(ID) desc;
select * from food 
limit 5;
# find restotent with maxmum orders
select Restaurant,city,total_orders
from (
select Restaurant,city,count(ID) as total_orders, 
dense_rank() over (order by count(ID)desc) as rankk
from food
group by Restaurant,city) as ranking
where rankk = 1;

# Find top two restaurant with maximum order
select Restaurant,city,total_orders
from (
select Restaurant,city,count(ID) as total_orders, 
dense_rank() over (order by count(ID)desc) as rankk
from food
group by Restaurant,city) as ranking
where rankk between 1 and 2;

/* Find retaurants from kormangala area from bangakore
which serve chinese food */

select * from food
where city = 'Bangalore' and Area = 'Koramangala' 
and Food_type like '% Chinese%';

select avg(delivery_time)
from food;
/* Find average delivery time in each city*/
select city, avg(Delivery_time)
from food 
group by city
order by avg(Delivery_time) desc;

/* Find avg price of food from powai area in mumbai*/
select city, area, avg(price) from food 
group by city, area
having area='powai' and city='mumbai';
#or 
select city,area,avg(price)
from food
where area = 'powai' and city = 'mumbai';

/* Find top three cities with least average delivery time*/

select city, avg(Delivery_time)
from food
group by city
order by avg(Delivery_time) asc
limit 3;
/* Find all restaurant from mumbai ,kolkata and surat who serve 
north india or Mughalai or south india or fast food */ 
select * from food 
where city in ('Mumbai','Kolkata','Surat') and
food_type in ('North indian','Munghalai','south indian','Fast food');
