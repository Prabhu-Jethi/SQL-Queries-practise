SELECT h.hacker_id, h.name
from hackers h 
JOIN submissions s on h.hacker_id = s.hacker_id
JOIN challenges c on c.challenge_id = s.challenge_id
join difficulty d on d.difficulty_level = c.difficulty_level
where s.score = d.score
GROUP BY h.hacker_id, h.name
HAVING COUNT(DISTINCT s.challenge_id) > 1
ORDER BY COUNT(DISTINCT s.challenge_id) desc, h.hacker_id asc;

SELECT * from difficulty;
SELECT * from hackers;
SELECT * FROM submissions;
SELECT * from challenges;