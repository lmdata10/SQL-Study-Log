

--- Student Learning Dataset ---


select * from student_learning_dataset;


1) Identify all the undergraduate students and display their id, gender and course name.
    select student_id, gender, course_name
    from student_learning_dataset
    where education_level='Undergraduate';


2) Fetch details of female students who spent over 300 mins on videos and have high possibility of dropping out.
    select *
    from student_learning_dataset
    where gender='Female'
    and time_spent_on_videos >300
    and dropout_likelihood = True;

    
3) Identify students who have either taken Machine Learning or Data Science course and have atleast attempted couple of quiz or have scored over 60 in quiz. Sort data based on least forum participation
    select *
    from student_learning_dataset
    where course_name in ('Machine Learning', 'Data Science')
    and (quiz_attempts >= 2 or quiz_scores > 60)
    order by forum_participation;

    
4) How many students prefer learning through visuals
    select count(*)
    from student_learning_dataset
    where learning_style = 'Visual';

    
5) What is the minimum and maximum exam score by students with the highest assignment completion rate?
    select max(assignment_completion_rate)
    from student_learning_dataset;

    select max(final_exam_score) as highest_score, min(final_exam_score) as lowest_score
    from student_learning_dataset
    where assignment_completion_rate = (select max(assignment_completion_rate) 
                                        from student_learning_dataset);


6) What is the average age of all Postgraduate or Undergraduate female students who took Cybersecurity course and either had High engagement level or preferred learning through writing or actively participated in atleast 20 forums. return whole number.
    select avg(age),round(avg(age),0), split_part(avg(age),'.',1)
    from student_learning_dataset
    where gender = 'Female'
    and education_level in ('Undergraduate','Postgraduate')
    and course_name = 'Cybersecurity'
    or (engagement_level = 'High'
        or learning_style = 'Reading/Writing'
        or forum_participation >= 20);

        
7) Idently all the male postgraduate student or female undergraduate student with final score over 90. Output should contains 2 columns, 1 with the student id and second column should indicate male postgraduate student as "Master degree" and female undergraduate student as "Bachelor degree"
    select student_id, case when gender = 'Male' then 'Master degree' else 'Bachelor degree' end as degree
    from student_learning_dataset
    where (gender = 'Male' and education_level = 'Postgraduate' and final_exam_score > 90)
        or (gender = 'Female' and education_level = 'Undergraduate' and final_exam_score > 90)
    order by student_id;


8) What is the average time spent on watching videos based on education level? Consider only those students whose age is a even number. Round the value to a single decimal point.
    select education_level, round(avg(time_spent_on_videos),1)
    from student_learning_dataset
    where age%2 = 0
    group by education_level

    
9) Identify the most popular male and female student among teachers. Popularity is based on students scoring the hight exam score and highest assignment_completion_rate.
    select *
    from student_learning_dataset
    where (gender = 'Male'
        and final_exam_score = (select max(final_exam_score) from student_learning_dataset where gender='Male')
        and assignment_completion_rate = (select max(assignment_completion_rate) from student_learning_dataset where                gender='Male'))
    or (gender = 'Female'
        and final_exam_score = (select max(final_exam_score) from student_learning_dataset where gender='Female')
        and assignment_completion_rate = (select max(assignment_completion_rate) from student_learning_dataset where                gender='Female')) ;


10) How many male, female and other students have never participated in a forum with bare minimun quiz attempts and have low engagement level. Result should be 3 columns, 1 each for each gender.
    select sum(case when gender='Male' then 1 else 0 end) as male_students
    , sum(case when gender='Female' then 1 else 0 end) as female_students
    , sum(case when gender='Other' then 1 else 0 end) as other_students
    from student_learning_dataset
    where forum_participation=0
    and engagement_level = 'Low'
    and quiz_attempts in (select min(quiz_attempts) from student_learning_dataset);

    -- Solve the above problem but now display result in 3 seperate rows for each gender
    select gender, count(1)
    from student_learning_dataset
    where forum_participation=0
    and engagement_level = 'Low'
    and quiz_attempts in (select min(quiz_attempts) from student_learning_dataset)
    group by gender 
    
        
11) How many students have taken python, machine learning and data science course?
    select course_name, count(student_id)
    from student_learning_dataset
    where course_name in ('Python Basics','Machine Learning','Data Science')
    group by course_name;

    
12) Identify the courses that are taken by more than 2000 students.
    select course_name,count(1) 
    from student_learning_dataset
    group by course_name
    having count(1) > 2000;   


13) What is the preferred course and learning style of students over 40 yrs of age.
    select course_name
    from student_learning_dataset
    where age > 40
    group by course_name
    order by count(1) desc
    limit 1;

    
14) Provide a summary of all the courses. How many students have taken each of them but segregate them based on gender.
    select course_name, gender, count(student_id)
    from student_learning_dataset
    where course_name in ('Python Basics','Machine Learning','Data Science')
    group by course_name, gender
    order by course_name, gender;

    select course_name
    , sum(case when gender='Male' then 1 else 0 end) as male_students
    , sum(case when gender='Female' then 1 else 0 end) as female_students
    , sum(case when gender='Other' then 1 else 0 end) as other_students
    from student_learning_dataset
    where course_name in ('Python Basics','Machine Learning','Data Science')
    group by course_name
    order by course_name;
    

15) Identify the most popular courses, between the age group of 15-25, 26-40 and >40. Course popularity is based on how many students have taken it. Output should be 3 columns specific to each age group.
    with cte as 
            (select course_name
            , sum(case when age between 15 and 25 then 1 else 0 end) as "15-25"
            , sum(case when age between 26 and 40 then 1 else 0 end) as "26-40"
            , sum(case when age > 40 then 1 else 0 end) as ">40"
            from student_learning_dataset
            group by course_name),
        cte_agg as 
            (select max("15-25") as "15-25", max("26-40") as "26-40", max(">40") as ">40"
            from cte )
    select max(case when c."15-25" = ca."15-25" then c.course_name end) as "15-25"
    , max(case when c."26-40" = ca."26-40" then c.course_name end) as "26-40"
    , max(case when c.">40" = ca.">40" then c.course_name end) as ">40"
    from cte c
    cross join cte_agg ca ;
    
