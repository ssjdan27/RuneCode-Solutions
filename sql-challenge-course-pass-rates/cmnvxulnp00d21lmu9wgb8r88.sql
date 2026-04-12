SELECT 
    c.course_name AS course,
    ROUND(
        COUNT(CASE WHEN es.score >= 60 THEN 1 END) * 1.0 / COUNT(e.student_id), 
        2
    ) AS pass_rate
FROM courses c
JOIN enrollments e ON c.id = e.course_id
LEFT JOIN exam_scores es ON e.student_id = es.student_id AND e.course_id = es.course_id
GROUP BY c.id, c.course_name
ORDER BY course ASC;