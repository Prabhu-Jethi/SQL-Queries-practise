CREATE TYPE start_end_enum AS ENUM ('start', 'end');
Create table If Not Exists Activity (machine_id int, process_id int, activity_type start_end_enum, timestamp float);
Truncate table Activity
insert into Activity (machine_id, process_id, activity_type, timestamp) values 
('0', '0', 'start', '0.712'),
('0', '0', 'end', '1.52'),
('0', '1', 'start', '3.14'),
('0', '1', 'end', '4.12'),
('1', '0', 'start', '0.55'),
('1', '0', 'end', '1.55'),
('1', '1', 'start', '0.43'),
('1', '1', 'end', '1.42'),
('2', '0', 'start', '4.1'),
('2', '0', 'end', '4.512'),
('2', '1', 'start', '2.5'),
('2', '1', 'end', '5');


/*
The table shows the user activities for a factory website.
(machine_id, process_id, activity_type) is the primary key (combination of columns with unique values) of this table.
machine_id is the ID of a machine.
process_id is the ID of a process running on the machine with ID machine_id.
activity_type is an ENUM (category) of type ('start', 'end').
timestamp is a float representing the current time in seconds.
'start' means the machine starts the process at the given timestamp and 'end' means the machine ends the process at the given timestamp.
The `start` timestamp will always be less than or equal to the `end` timestamp for every `(machine_id, process_id)` pair.
It is guaranteed that each (machine_id, process_id) pair has a 'start' and 'end' timestamp.

 

There is a factory website that has several machines each running the same number of processes. Write a solution to find the average 
time each machine takes to complete a process.

The time to complete a process is the 'end' timestamp minus the 'start' timestamp. The average time is calculated by the total time to 
complete every process on the machine divided by the number of processes that were run.

The resulting table should have the machine_id along with the average time as processing_time, which should be rounded to 3 decimal places.
*/


SELECT a.machine_id,
    ROUND(
        (SELECT AVG(a1.TIMESTAMP)
        from Activity a1
        WHERE a1.activity_type = 'end' and a1.machine_id = a.machine_id)::numeric
        - 
        (SELECT avg(a1.TIMESTAMP)
        FROM Activity a1
        WHERE a1.activity_type = 'start' and a1.machine_id = a.machine_id)::numeric, 3) as processing_time
FROM Activity a
GROUP BY a.machine_id;


--- Postgres --> ROUND(Double precision, integer) doesn't exist ❌

--- Instead, Use ROUND(<your_column>::numeric, <integer>) ✅