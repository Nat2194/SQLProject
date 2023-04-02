select count(distinct project.student_name), project.year
from    (
        select distinct student_name, year from project
        ) as temp1,
        (
        select distinct student_name, house from project
        ) as temp2, project
where temp2.house = project.house and temp1.year = project.year;