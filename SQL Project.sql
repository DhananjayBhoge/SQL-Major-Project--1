use social_media;

select * from bookmarks;
select * from comment_likes;
select * from comments;
select * from follows;
select * from hashtag_follow;
select * from hashtags;
select * from login;
select * from photos;
select * from post;
select * from post_likes;
select * from post_tags;
select * from users;
select * from videos;


---------------------------------

-- 1) Identify Users by Location ( Write a query to find all posts made by users in specific locations such as 'Agra', 'Maharashtra', and 'West Bengal' 
-- Hint: Focus on filtering users by location.)

select p.post_id, u.user_id, u.username, p.location
from POST p
join USERS u on p.user_id = u.user_id
where p.location in ('Agra', 'Maharashtra', 'West Bengal');

---------------------------------
-- 2) Determine the Most Followed Hashtags
 -- Write a query to list the top 5 most-followed hashtags on the platform.
 -- Hint: Join relevant tables to calculate the total follows for each hashtag.

select h.hashtag_name, COUNT(f.hashtag_id) as Total_Follows
from hashtags h
join hashtag_follow f on h.hashtag_id = f.hashtag_id
group by h.hashtag_name
order by total_follows desc
limit 5;

  ---------------------------------------
-- 3) Find the Most Used Hashtags
-- Identify the top 10 most-used hashtags in posts
-- Hint: Count how many times each hashtag appears in posts.
  
select h.hashtag_name, COUNT(ht.hashtag_id) as Total_Hashtags
from hashtags h
join post_tags ht on h.hashtag_id = ht.hashtag_id
group by h.hashtag_name
order by Total_Hashtags desc
limit 10;

-------------------------------------
 -- 4) Identify the Most Inactive User
 -- Write a query to find users who have never made any posts on the platform.
 -- Hint: Use a subquery to identify these users
  
  select u.user_id, u.username
  from users u
  where u.user_id not in(
  select p.user_id
  from post p);
  
  -------------------------------------
-- 5) Identify the Posts with the Most Likes
-- Write a query to find the posts that have received the highest number of likes.
-- Hint: Count the number of likes for each post.

select p.post_id, p.caption, COUNT(pl.user_id) as Total_Likes
from post p
join POST_LIKES pl on p.post_id = pl.post_id
group by p.post_id, p.caption
order by Total_Likes desc;

------------------------------------
-- 6) Calculate Average Posts per User
-- Write a query to determine the average number of posts made by users.
-- Hint: Consider dividing the total number of posts by the number of unique users.

select COUNT(p.post_id) / COUNT(distinct u.user_id) as Average_posts
from users u
left join post p on u.user_id = p.user_id;

------------------------------------------
-- 7) Track the Number of Logins per User
-- Write a query to track the total number of logins made by each user.
-- Hint: Join user and login tables.

select u.user_id, u.username, COUNT(l.login_id) as Total_logins
from users u
join login l on u.user_id = l.user_id
group by u.user_id, u.username
order by Total_logins desc;

-----------------------------
-- 8) Identify a User Who Liked Every Single Post
-- Write a query to find any user who has liked every post on the platform.
-- Hint: Compare the number of posts with the number of likes by this user.

select u.user_id, u.username
from users u
join post_likes pl on u.user_id = pl.user_id
group by u.user_id, u.username
having COUNT(distinct pl.post_id) = (select count(p.post_id) from post p);

-- user who ilkes on maximum post
select u.user_id, u.username, count(*)
from users u
join post p on u.user_id = p.user_id
join post_likes pl on p.post_id = pl.post_id
group by p.post_id
order by count(*) desc
limit 1;

---------------------------------------
-- 9) Find Users Who Never Commented
-- Write a query to find users who have never commented on any post.
-- Hint: Use a subquery to exclude users who have commented.

select u.user_id, u.username
from users u
where u.user_id not in (
select c.user_id
from comments c );

----------------------------------
-- 10) Identify a User Who Commented on Every Post
--  Write a query to find any user who has commented on every post on the platform.
--  Hint: Compare the number of posts with the number of comments by this user.

select u.user_id, u.username
from users u
join comments c on u.user_id = c.user_id
group by u.user_id, u.username
having COUNT(DISTINCT c.post_id) = (select COUNT(post_id) from POST);

-------------------------------------
-- 11) Identify Users Not Followed by Anyone
--  Write a query to find users who are not followed by any other users.
-- Hint: Use the follows table to find users who have no followers

select u.user_id, u.username
from USERS u
where u.user_id NOT IN (
select f.followee_id
from follows f);

------------------------
-- 12) Identify Users Who Are Not Following Anyone
-- Write a query to find users who are not following anyone.
-- Hint: Use the follows table to identify users who are not following others.

select u.user_id, u.username
from USERS u
where u.user_id NOT IN (
select f.follower_id
from follows f);

--------------------------------------
-- 13) Find Users Who Have Posted More than 5 Times
 -- Write a query to find users who have made more than five posts.
 -- Hint: Group the posts by user and filter the results based on the number of posts.

select u.user_id, u.username, COUNT(p.post_id) as post_count
from users u
join post p ON u.user_id = p.user_id
group by u.user_id, u.username
having post_count > 5;

-----------------------------
-- 14) Identify Users with More than 40 Followers
-- Write a query to find users who have more than 40 followers.
-- Hint: Group the followers and filter the result for those with a high follower count.

select u.user_id, u.username, COUNT(f.follower_id) AS follower_count
from USERS u
join follows f ON u.user_id = f.followee_id
group by u.user_id, u.username
having COUNT(f.follower_id) > 40;

-----------------------------
-- 15) Search for Specific Words in Comments
-- Write a query to find comments containing specific words like "good" or "beautiful."
-- Hint: Use regular expressions to search for these words.

select comment_id, comment_text, user_id
from comments
where comment_text REGEXP 'good|beautiful';

-- OR by using like operator

select comment_id, comment_text, user_id
from comments
where comment_text LIKE '%good%'
or comment_text LIKE '%beautiful%';

--------------------------------------
-- 16) Identify the Longest Captions in Posts
-- Write a query to find the posts with the longest captions.
-- Hint: Calculate the length of each caption and sort them to find the top 5 longest ones

select post_id, caption, LENGTH(caption) AS caption_length
from POST
order by LENGTH(caption) desc
limit 5;

----------------------------------------

















  
  
  
  
  
  