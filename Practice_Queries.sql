select * from `country-data`;

ALTER TABLE `country-data` RENAME TO country_data;
alter table global_youtube_statistics change column video_views video_views double;

select * from country_data
limit 20;

select country, child_mort, gdpp
from country_data
limit 30;

select * from country_data
where inflation < 10;

select * from country_data
where income > 10000 and income <25000
order by income;

select * from country_data 
order by child_mort limit 5;

-- select countries whose life expectancy is greater than 70

select country_data.country, country_data.life_expec
from country_data
where life_expec > 70;

# select countries whose life expectancy is greater than or equal to 70

select country_data.country, country_data.life_expec
from country_data
where life_expec >= 70;

# select countries whose inflation is less than or equal to 25

select country_data.country, country_data.inflation
from country_data
where inflation <= 25
order by 2;

# select countries whose inflation is greater than or equal to 8 but less than 20

select country_data.country, country_data.inflation
from country_data
where inflation >= 8 and inflation < 20;

# print out all the data points for albania

select * from country_data
where country = 'albania';

# print out all the data points for countries except Algeria, Albania and Angola

select * from country_data
where country != 'algeria'and country != 'albania'and country != 'angola';

select * from country_data
where country not in ('algeria','albania','angola');

# print out all the data points for countries except Algeria, Albania and Angola
# Australia, Austria, Armenia, Bahamas , Belgium

with country_1 as(
select * from country_data 
where country in ('Algeria', 'Albania', 'Angola' ,'Australia', 'Austria', 'Armenia','Bahamas' , 'Belgium')
)
select * from country_1 
where country not in ('Algeria', 'Albania', 'Angola');

# select all countries that start with letter k

select * from country_data
where country like "k%";

# select 10 countries that end with letter y

select * from country_data
where country like "%y";

# select the data points for the following country only Australia, Armenia , Bahamas , Belgium

select * from country_data
where country in ('Australia','Armenia','Bahamas','Belgium');

# select the countries whose inflation is in the range of 5 to 15

select country, inflation from country_data
where inflation between 5 and 15
order by 2;

# select the data points for the following countries only Austria, armenia

select * from country_data
where country in ('Austria','armenia');

# select countries where child_mort is less than 10 and inflation is above 15

select * from country_data
where child_mort < 10 and inflation >15;

# select countries where child_mort is less than 10 or inflation is above 15

select country, child_mort, inflation from country_data
where child_mort < 10 or inflation >15
order by 2;

# print out all the datapoints of countries except angola (CTE)
# Australia, Austria, Armenia, Bahamas , Belgium

with dp_1 as (
select * from country_data
where country in ('angola','Australia','Austria','Armenia','Bahamas','Belgium')
)
select * from dp_1
where country not in ('angola');

# show countries that didnot share export data

select * from country_data
where exports is null;

# distinct list of countries
select distinct country from country_data;
select count(distinct(country)) from country_data;

# distinct count, count countries 
select count(*) as total_count, count(distinct country) as country_count
from country_data;

# count, count youtuber
alter table `global youtube statistics` rename to global_youtube_statistics ;
select * from global_youtube_statistics;
select count(*)as count, count(youtuber) as count_y,count(channel_type), count(distinct channel_type) as no_of_channeltype 
from	global_youtube_statistics;

# use uploads to create consistency status
select global_youtube_statistics.Youtuber,video_views_rank,uploads/(year(current_date())-created_year) as consistency
from global_youtube_statistics
order by consistency desc
limit 5;

select 
case when
	uploads < 75000 then 'level_1'
   when uploads between 75000 and 150000 then 'level_2'
    when uploads between 150000 and 225000 then 'level_3'
    when uploads > 225000 then 'level_4'
    end as const_status,
    youtuber, uploads
    from global_youtube_statistics
    order by 1;

# Use country to create continent column
select * from global_youtube_statistics;
select Country from global_youtube_statistics
order by 1;
select count(distinct Country)from global_youtube_statistics;
select  distinct country from global_youtube_statistics
order by 1;

select
case when country in ("Nigeria", "Egypt", "South Africa") then "Africa"
     when country in ("China", "India", "Japan") then "Asia"
	 when country in ("France", "Germany", "United Kingdom") then "Europe"
	 when country in ("United States", "Canada", "Mexico") then "North America"
     when country in ("Brazil", "Argentina", "Chile") then "South America"
     when country in ("Australia", "New Zealand") then "Australia"
     end as continents,
    youtuber , uploads, Country
    from global_youtube_statistics
    limit 20;
    
# count no. of youtubers on the list
select count(distinct Youtuber) as total_youtubers from global_youtube_statistics;

# No. of countries on the list
select count(distinct country) as total_countries from global_youtube_statistics;

# Total highest year earning for these youtubers
select * from global_youtube_statistics;
select sum(highest_yearly_earnings) as total_highest_year_earnings
from global_youtube_statistics;

# Total views for these youtubers
select sum(video_views) as total_views
from global_youtube_statistics;

# Total lowest earnings for these youtubers
select sum(`lowest_yearly_earnings`) as total_lowest_earnings
from global_youtube_statistics;

# what did the highest earning youtuber make in a year
select * from global_youtube_statistics;
select max(highest_yearly_earnings) as highest_earner
from global_youtube_statistics;
select * from global_youtube_statistics
where highest_yearly_earnings = 
(select max(highest_yearly_earnings) as highest_earner
from global_youtube_statistics);

# what did the lowest earning youtuber make in a year
select min(highest_yearly_earnings) from global_youtube_statistics;

# what is average yearly earning on the higher side
select avg(highest_yearly_earnings) as average_earnings from global_youtube_statistics;

# what is the average yearly earnings on the lower side
select avg(lowest_yearly_earnings) as average_earnings_low from global_youtube_statistics;

# what is the number of views gained and by who
select Youtuber, video_views from global_youtube_statistics
where video_views = ( select max(video_views) from global_youtube_statistics);

# Views by continent
with conti_views as(
select 
	video_views,
    Country,
    case
     when Country in ("Algeria","Angola","Benin","Botswana","Burkina Faso","Burundi","Cabo Verde","Cameroon","Central African Republic",
          "Chad","Comoros","Congo, Dem. Rep", "Congo, Rep.","Cote d'Ivoire","Djibouti","Egypt","Equatorial Guinea","Eritrea",
          "Eswatini (formerly Swaziland)","Ethiopia","Gabon","Gambia","Ghana","Guinea","Guinea-Bissau","Kenya", "Lesotho",
          "Liberia",'Libya',"Madagascar","Malawi","Mali","Mauritania","Mauritius","Morocco","Mozambique","Namibia",
          "Niger","Nigeria","Rwanda","Sao Tome and Principe","Senegal","Seychelles","Sierra Leone","Somalia","South Africa",
          "South Sudan","Sudan","Tanzania""Togo","Tunisia","Uganda","Zambia","Zimbabwe") then 'Africa'

     when Country in ("Albania","Andorra", "Armenia","Austria","Azerbaijan","Belarus","Belgium","Bosnia and Herzegovina",
          "Bulgaria","Croatia","Cyprus","Czechia","Denmark","Estonia","Finland","France","Georgia","Germany",
          "Greece","Hungary","Iceland","Ireland","Italy","Kazakhstan","Kosovo","Latvia","Liechtenstein","Lithuania",
          "Luxembourg","Malta","Moldova","Monaco","Montenegro","Netherlands","Macedonia, FYR","Norway","Poland","Portugal",
          "Romania","Russia","San Marino","Serbia","Slovakia","Slovenia","Spain","Sweden","Switzerland","Turkey",
          "Ukraine","United Kingdom","Vatican City") then 'Europe'

     when Country in ("Afghanistan","Armenia","Azerbaijan","Bahrain","Bangladesh", "Bhutan","Brunei","Cambodia","China","Cyprus",
        "Georgia","India","Indonesia","Iran","Iraq","Israel","Japan","Jordan","Kazakhstan","Kuwait","Kyrgyzstan","Laos",
        "Lebanon","Malaysia","Maldives","Mongolia","Myanmar","Nepal","North Korea","Oman","Pakistan","Palestine","Philippines",
        "Qatar","Russia","Saudi Arabia","Singapore","South Korea","Sri Lanka","Syria","Taiwan","Tajikistan","Thailand",
        "Timor-Leste","Turkey","Turkmenistan","United Arab Emirates","Uzbekistan","Vietnam","Yemen") then 'Asia'

     when Country in ("Antigua and Barbuda","Bahamas","Barbados","Belize","Canada","Costa Rica","Cuba","Dominica",
                 "Dominican Republic","El Salvador","Grenada","Guatemala","Haiti","Honduras","Jamaica","Mexico",
                 "Nicaragua","Panama","Saint Vincent and the Grenadines","United States") then 'North_America'

     when Country in ("Argentina","Bolivia","Brazil","Chile","Colombia","Ecuador","Guyana","Paraguay","Peru","Suriname",
                 "Uruguay","Venezuela") then 'South_America'

     when Country in ("Australia","Fiji","Kiribati","Marshall Islands","Micronesia","Nauru","New Zealand","Palau",
                       "Papua New Guinea","Samoa","Solomon Islands","Tonga","Tuvalu","Vanuatu") then 'Australia_and_Oceania '
	end as continents
from global_youtube_statistics)

select continents, sum(video_views)as total_views
from conti_views
group by 1
order by 2 desc;

# create a popularity scale using uploads, and find the pay using popularity scale
select max(uploads), min(uploads) from global_youtube_statistics;

select 
case
	when uploads < 100000 then 'level 1'
    when uploads between 100000 and 200000 then 'level 2'
    when uploads > 200000 then 'level 3'
    end as uploads_consistency,
    sum(highest_yearly_earnings)
from global_youtube_statistics
group by 1;

# Total highest yearly earnings for these youtubers by country
select country, sum(highest_yearly_earnings) as total_earnings_by_country,count(Youtuber) as total_youtubers
from global_youtube_statistics
group by 1 order by 2 desc limit 3;

# total views by these youtubers by channel type
select Country,channel_type,sum(video_views) as total_views, sum(highest_yearly_earnings)total_earnings, count(Youtuber)total_youtubers
from global_youtube_statistics
where Country = 'india'
group by channel_type,Country
order by 1;

# total number of subs by country
select Country, sum(subscribers)total_subscribers
from global_youtube_statistics
group by Country
order by total_subscribers desc;

# total highest yearly earnings for these youtubers by country where earnings are above 10000000
select Country, sum(highest_yearly_earnings)total_earnings
from global_youtube_statistics
group by 1
having total_earnings >= 10000000
order by 2 desc;

# total views for the youtubers by channel type where views as above 10000000 and Country US 
select Country, channel_type ,sum(video_views)total_vid_views 
from global_youtube_statistics
group by 1,2
having Country = 'United States' and total_vid_views > 10000000;

# total no. of subs by country where subs are above 1000000
select Country, sum(subscribers)total_subs
from global_youtube_statistics
group by 1
having total_subs > 1000000
order by 2 desc;

alter table `bank-full` rename to bank_full;

# balance based on education
select age, education, balance,
sum(balance) over(partition by education) as sum_ed_bal
from bank_full
order by 1,2;

select age, education, balance,
sum(balance) over(partition by age) as sum_ed_bal
from bank_full
where age = 18
order by 1,2,3 desc;

select age, education, balance,
sum(balance) over(order by age) as sum_ed_bal
from bank_full
order by 1,2,3 desc;

select Youtuber,Country, channel_type, highest_yearly_earnings,
sum(highest_yearly_earnings) over(partition by Country, channel_type order by highest_yearly_earnings)tot_ytb from
global_youtube_statistics;

select count(Youtuber) over(partition by Country,channel_type order by Youtuber) as no_of_ytbrs,
Youtuber,Country, channel_type
from global_youtube_statistics
where Country = 'india'
;























