use projects;
select * from swiggy limit 5;

# 01 HOW MANY RESTAURANTS HAVE A RATING GREATER THAN 4.5?
select count(restaurant_name) as total_restaurants
from swiggy
where rating > 4.5;

# 02 WHICH IS THE TOP 1 CITY WITH THE HIGHEST NUMBER OF RESTAURANTS?
select city, count(*) as total_restaurants
from swiggy
group by 1
order by 2 desc limit 1;

# HOW MANY RESTAURANTS SELL( HAVE WORD "PIZZA" IN THEIR NAME)?
select restaurant_name, count(*) as total_restaurants
from swiggy
where restaurant_name like '%Pizza%'
group by 1;

-- WHAT IS THE MOST COMMON CUISINE AMONG THE RESTAURANTS IN THE DATASET?
select cuisine, count(*) as total_numbers
from swiggy
group by 1
order by 2 desc;

-- WHAT IS THE AVERAGE RATING OF RESTAURANTS IN EACH CITY?
select city, avg(rating) as average_rating
from swiggy 
group by city;

-- WHAT IS THE HIGHEST PRICE OF ITEM UNDER THE 'RECOMMENDED' MENU CATEGORY FOR EACH RESTAURANT?
select restaurant_name, cuisine, menu_category , max(price) as costliest_item
from swiggy
where menu_category = 'Recommended'
group by restaurant_name, cuisine,menu_category
order by costliest_item desc;

-- FIND THE TOP 5 MOST EXPENSIVE RESTAURANTS THAT OFFER CUISINE OTHER THAN INDIAN CUISINE. 
select restaurant_name, max(cost_per_person)
from swiggy
where cuisine <> 'Indian'
group by restaurant_name
order by 2 desc limit 5;

-- FIND THE RESTAURANTS THAT HAVE AN AVERAGE COST WHICH IS HIGHER THAN THE TOTAL AVERAGE COST OF ALL    
--    RESTAURANTS TOGETHER.
select distinct(restaurant_name) as restaurants, cost_per_person
from swiggy
where price > (
select avg(cost_per_person) from swiggy
);

-- RETRIEVE THE DETAILS OF RESTAURANTS THAT HAVE THE SAME NAME BUT ARE LOCATED IN DIFFERENT CITIES.
select distinct(t1.restaurant_name), t1.city as city_1,t2.city as city_2
from swiggy t1
join swiggy t2 on
t1.restaurant_name = t2.restaurant_name 
and 
t2.city <> t1.city;

-- WHICH RESTAURANT OFFERS THE MOST NUMBER OF ITEMS IN THE 'MAIN COURSE' CATEGORY?
select distinct restaurant_name, count(item) as Total_items
from swiggy
where menu_category = 'Main Course'
group by 1
order by 2 desc limit 1;

-- LIST THE NAMES OF RESTAURANTS THAT ARE 100% VEGEATARIAN IN ALPHABETICAL ORDER OF RESTAURANT NAME
select distinct restaurant_name,
(count(case when veg_or_nonveg = 'Veg' then 1 end)*100/
count(*)) as vegeterian_percentage
from swiggy
group by restaurant_name
having vegeterian_percentage = 100.00
order by restaurant_name;

-- WHICH IS THE RESTAURANT PROVIDING THE LOWEST AVERAGE PRICE FOR ALL ITEMS?
select restaurant_name, avg(price) as average_price
from swiggy
group by restaurant_name
order by 2 limit 1;

-- WHICH TOP 5 RESTAURANT OFFERS HIGHEST NUMBER OF CATEGORIES?

select distinct restaurant_name, count(distinct menu_category) as total_category
from swiggy
group by restaurant_name
order by 2 desc limit 5;

-- WHICH RESTAURANT PROVIDES THE HIGHEST PERCENTAGE OF NON-VEGEATARIAN FOOD?
select * from swiggy;
select restaurant_name,
(count(case when veg_or_nonveg = 'Non-veg' then 1 end)*100/
count(*)) as non_veg_percentage
from swiggy
group by restaurant_name
having non_veg_percentage = 100.00
order by restaurant_name;

-- Determine the Most Expensive and Least Expensive Cities for Dining:
select city, max(cost_per_person) as max_cost, min(cost_per_person) as min_cost
from swiggy
group by city
order by 2 desc;

with expensive_city as(
select
	city, max(cost_per_person) as max_cost,
    min(cost_per_person) as min_cost
    from swiggy
    group by city
	) 
select city, max_cost,min_cost
from expensive_city
order by max_cost desc;


-- Calculate the Rating Rank for Each Restaurant Within Its City
select restaurant_name,city,rating,
dense_rank() over(partition by city order by rating desc) as rating_rank
from swiggy
group by 1,2,3;

with rankbycity as(
select distinct restaurant_name,city,rating,
dense_rank() over(partition by city order by rating desc) as rating_rank
from swiggy
)
select
	restaurant_name,
    city,
    rating,
    rating_rank
from rankbycity;













