--SIMPLE QUERIES
SELECT * from cd.bookings;
SELECT * from cd.facilities;
SELECT * from cd.members;

--QUESTION 1
SELECT COUNT(*) FROM CD.bookings;
SELECT COUNT(*) FROM CD.facilities; 
SELECT COUNT(*) FROM CD.members;  

--QUESTION 2
SELECT * FROM cd.bookings 
ORDER BY bookid DESC;

--QUESTION 3
SELECT DISTINCT name 
FROM cd.facilities;  

--QUESTION 4
SELECT * from cd.facilities 
ORDER BY membercost DESC LIMIT(3); 

--QUESTION 5
SELECT * from cd.facilities 
ORDER BY monthlymaintenance LIMIT(1) 

--QUESTION 6
SELECT m1.* FROM cd.members as m1 
INNER JOIN cd.members as m2 
ON m1.surname = m2.surname AND m1.memid != m2.memid;  

--QUESTION 7
SELECT m1.*, m2.* FROM cd.members as m1 
INNER JOIN cd.members as  m2 
ON m1.memid != m2.memid AND SUBSTRING_INDEX(m1.address, ',', -2) = SUBSTRING_INDEX(m2.address, ',', -2);  

--QUESTION 8
SELECT * from cd.members 
WHERE surname LIKE 'Sm%' OR surname LIKE 'Tr%' or surname LIKE '%ll' OR surname LIKE '%ew' ;

--JOIN QUERIES
--QUESTION 1
SELECT * FROM cd.bookings as b 
INNER JOIN cd.members as m 
ON b.memid=m.memid; 

--QUESTION 2
SELECT * FROM cd.bookings as b 
INNER JOIN cd.facilities as f 
ON b.facid=f.facid 
where b.facid is not null; 

--QUESTION 3
SELECT * FROM cd.bookings as b 
INNER JOIN cd.members as m 
ON b.memid=m.memid; 

--QUESTION 4
SELECT * FROM cd.facilities as f 
LEFT JOIN cd.bookings as b 
ON b.facid=f.facid 
where b.facid is NULL; 

--QUESTION 5
SELECT * FROM cd.facilities as f 
LEFT JOIN cd.bookings as b 
ON b.facid=f.facid 
LEFT JOIN cd.members as m 
ON b.memid=m.memid 
where b.facid is NULL AND b.memid is NULL; 

--AGGREGATE QUERIES
--QUESTION 1 
SELECT f.facid, 
COUNT(*) AS total_facilities 
FROM cd.bookings as b 
INNER JOIN cd.facilities as f 
ON b.facid=f.facid 
GROUP BY f.facid; 

--QUESTION 2
SELECT f.facid, 
COUNT(DISTINCT b.facid) AS total_facilities, 
m.memid, 
SUM(b.slots) AS total_slots_booked 
FROM cd.bookings as b 
INNER JOIN cd.facilities as f 
ON b.facid = f.facid 
INNER JOIN cd.members as m 
ON b.memid = m.memid 
GROUP BY f.facid, m.memid; 

--QUESTION 3
SELECT f.name, 
COUNT(DISTINCT b.facid) AS total_facilities, 
m.memid, 
SUM(b.slots) AS total_slots_booked 
FROM cd.bookings as b 
INNER JOIN cd.facilities as f 
ON b.facid = f.facid 
INNER JOIN cd.members as m 
ON b.memid = m.memid 
GROUP BY f.facid, m.memid 
ORDER BY total_slots_booked DESC LIMIT 3; 

--QUESTION 4
SELECT f.facid, 
COUNT(DISTINCT b.facid) AS total_facilities, 
b.facid, 
f.name, 
SUM(b.slots) AS total_slots_booked 
FROM cd.bookings as b 
INNER JOIN cd.facilities as f 
ON b.facid = f.facid 
GROUP BY f.facid, b.facid 
ORDER BY total_slots_booked DESC; 

--QUESTION 5
SELECT f.facid, 
COUNT(DISTINCT b.facid) AS total_facilities, 
b.facid, 
f.name, 
SUM(b.slots) AS total_slots_booked, 
CASE WHEN m.firstname = 'GUEST' 
THEN SUM(b.slots) * f.guestcost 
ELSE SUM(b.slots) * f.membercost 
END AS total_earnings 
FROM cd.bookings as b 
INNER JOIN cd.facilities as f 
ON b.facid = f.facid 
INNER JOIN cd.members as m 
ON b.memid = m.memid 
GROUP BY f.facid, b.facid, m.firstname 
ORDER BY total_slots_booked DESC, 
total_earnings DESC LIMIT 3; 

--QUESTION 6
SELECT m.memid, 
m.recommendedby, 
SUM(b.slots) as total_slots, 
COUNT(r.recommendedby) as referred_by_count 
FROM cd.members m 
INNER JOIN cd.bookings as b 
ON b.memid = m.memid 
LEFT JOIN cd.members as r 
ON r.recommendedby = m.memid 
GROUP BY m.memid 
ORDER BY total_slots DESC, 
referred_by_count DESC LIMIT 3;  

--QUESTION 7
SELECT m.* FROM cd.members as m 
INNER JOIN cd.bookings as b 
ON b.memid = m.memid 
INNER JOIN cd.facilities as f 
ON f.facid = b.facid AND f.name LIKE '%Tennis%' 
GROUP BY m.memid ORDER BY COUNT(*) DESC; 

