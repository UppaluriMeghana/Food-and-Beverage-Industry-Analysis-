use ig_clone;
select * from dim_cities;
select * from dim_repondents;
select * from fact_survey_responses;
-- 1. Demographic Insights (examples)
-- a. Who prefers energy drink more? (male/female/non-binary?)
select gender,count(gender) preferred from dim_repondents r 
INNER JOIN fact_survey_responses f 
ON r.Respondent_ID = f.Respondent_ID
where consume_frequency = "Daily"
group by gender
order by count(gender) desc;

-- b. Which age group prefers energy drinks more?
select age,count(age) preferred_group from dim_repondents r 
INNER JOIN fact_survey_responses f 
ON r.Respondent_ID = f.Respondent_ID
where consume_frequency = "Daily"
group by age
order by count(age) desc;

-- c. Which type of marketing reaches the most Youth (15-30)?
select marketing_channels, count(marketing_channels) marketing_type from dim_repondents r 
INNER JOIN fact_survey_responses f 
ON r.Respondent_ID = f.Respondent_ID
where age BETWEEN 15 and 30
group by marketing_channels
order by count(marketing_channels) desc;


-- 2. Consumer Preferences:
-- a. What are the preferred ingredients of energy drinks among respondents?
select Ingredients_expected, count(Ingredients_expected) preferred_ingredients from fact_survey_responses
group by Ingredients_expected
order by count(Ingredients_expected) desc;

-- b. What packaging preferences do respondents have for energy drinks?
select packaging_preference, count(packaging_preference) preferred_packaging from fact_survey_responses
group by packaging_preference
order by count(packaging_preference) desc;

-- 3. Competition Analysis:
-- a. Who are the current market leaders?
select current_brands, count(current_brands) preferred_brands from fact_survey_responses
group by current_brands
order by count(current_brands) desc;

-- b. What are the primary reasons consumers prefer those brands over ours?
select reasons_for_choosing_brands, count(reasons_for_choosing_brands) preferred_brands from fact_survey_responses
where current_brands != "CodeX"
group by reasons_for_choosing_brands
order by count(reasons_for_choosing_brands) desc;

-- 4. Marketing Channels and Brand Awareness:
-- a. Which marketing channel can be used to reach more customers?
select marketing_channels, count(marketing_channels) preferred_brands from fact_survey_responses
group by marketing_channels
order by count(marketing_channels) desc;

-- b. How effective are different marketing strategies and channels in reaching our customers?
select marketing_channels, count(marketing_channels) effective_channels from fact_survey_responses
where current_brands = "CodeX"
group by marketing_channels
order by count(marketing_channels) desc;

-- 5. Brand Penetration:
-- a. What do people think about our brand? (overall rating)
select brand_perception, count(brand_perception) preferred_brands from fact_survey_responses
where current_brands = "CodeX"
group by brand_perception
order by count(brand_perception) desc;

select taste_experience, count(taste_experience) preferred_brands from fact_survey_responses
where current_brands = "CodeX"
group by taste_experience
order by count(taste_experience) desc;

-- b. Which cities do we need to focus more on?
select city, count(city), current_brands from fact_survey_responses f
INNER JOIN
dim_repondents r
ON r.Respondent_ID = f.Respondent_ID
INNER JOIN dim_cities c
ON c.city_ID = r.city_ID
where current_brands = "CodeX"
group by city
order by count(city) desc limit 5;

-- 6. Purchase Behavior:
-- a. Where do respondents prefer to purchase energy drinks?
select purchase_location, count(purchase_location) preferred_location from fact_survey_responses
group by purchase_location
order by count(purchase_location) desc;


-- b. What are the typical consumption situations for energy drinks among respondents?
select consume_reason, count(consume_reason) preferred_reason from fact_survey_responses
group by consume_reason
order by count(consume_reason) desc;

-- c. What factors influence respondents purchase decisions, such as price range and limited edition packaging?
select price_range, count(price_range) preferred_price from fact_survey_responses
group by price_range
order by count(price_range) desc;

select limited_Edition_packaging, count(limited_Edition_packaging) preferred_edition from fact_survey_responses
group by limited_Edition_packaging
order by count(limited_Edition_packaging) desc;

-- 7. Product Development
-- a. Which area of business should we focus more on our product development? (Branding/taste/availability)
select * from fact_survey_responses;
select reasons_preventing_trying, count(reasons_preventing_trying) focus_on from fact_survey_responses
where current_brands = "CodeX"
group by reasons_preventing_trying
order by count(reasons_preventing_trying) desc;