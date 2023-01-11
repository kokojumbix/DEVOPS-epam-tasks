USE UPASS;

\! echo 'Count of instances with one name from Passport table, except names that starts from letter "O":'
SELECT First_name as 'Name', count(id) as 'Count of instances with that name' FROM Passport
where First_name not like 'O%'
group by First_name;









