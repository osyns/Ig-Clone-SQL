-- 1. Finding the 5 oldest users

SELECT *
FROM users
ORDER BY created_at;

-- 2. Most popular Registration Date

SELECT
       DAYNAME(created_at) AS day,
       COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total desc
limit 2;

-- 3. Find the users who have never posted a photo

SELECT username
FROM users
LEFT JOIN photos
  ON users.id = photos.user_id
 WHERE photos.id IS NULL;


-- 4. Who got the most likes on a single photo
SELECT
    username,
    photos.id, 
    photos.image_url,
    COUNT(*) AS total
FROM photos
INNER JOIN likes
    ON photos.id = likes.photo_id
INNER JOIN users
    ON photos.user_id = users.id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;

-- 5. how many times does the avg user post
-- calculate avg number of photo per user
-- total number of photos / total number of users

SELECT 
    (SELECT COUNT(*) 
     FROM photos) /  (SELECT COUNT(*) 
                      FROM users) AS avg;

-- 6. what are the top 5 most commonly used hashtags?
select tags.tag_name, COUNT(*) AS total
FROM tags
JOIN photo_tags
ON  tags.id = photo_tags.tag_id
GROUP BY tags.id
order by total desc limit 5;


-- 7. Finding bots. Users who have liked every single photo

select username, COUNT(*) AS num_likes from users
INNER JOIN likes
ON users.id = likes.user_id
group by users.id
HAVING num_likes = (SELECT COUNT(*) FROM photos);   # HAVING works instead of WHERE