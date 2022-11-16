SELECT courses.id, title, SUM(student)
FROM courses INNER JOIN courses_participants
             ON courses_participants.course = courses.id
WHERE courses.price > 50
GROUP BY courses.id
ORDER BY title;
