-- CREATE DATABASE evaluation_donnees1;

-- 1) Création des tables
CREATE TABLE team (
    id   SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

CREATE TABLE employee (
    id            SERIAL PRIMARY KEY,
    first_name    VARCHAR(100) NOT NULL,
    last_name     VARCHAR(100) NOT NULL,
    contract_type VARCHAR(50),
    salary        INT,
    team_id       INT REFERENCES team(id)
);

CREATE TABLE leave(
    id          SERIAL PRIMARY KEY,
    start_date  DATE NOT NULL,
    end_date    DATE NOT NULL,
    employee_id INT  NOT NULL REFERENCES employee(id)
);

-- 2) Inserts
INSERT INTO team(name) VALUES 
('Developpement'),
('Marketing'),
(' RH'),
('Support');

INSERT INTO employee (first_name, last_name, contract_type, salary, team_id) VALUES
('Alice',   'Sanchez',   'CDI', 2500, 1),  
('Bob',     'Durand',   'CDD', 1800, 1),  
('Carla',   'Dubois',   'CDI', 2700, 2),   
('Iavo',   'Rasolo',   'Stage', 800,  2), 
('Onja',    'Rakoto',   'CDI', 2300, 3),  
('Fabrice', 'Randri',   'CDI', 2600, NULL),
('Gina',    'Ravel',    'CDD', 1900, NULL);

INSERT INTO leave (start_date, end_date, employee_id) VALUES
('2025-01-10', '2025-01-15', 1),
('2025-11-10', '2025-11-20', 2), 
('2025-11-15', '2025-11-16', 3), 
('2025-12-01', '2025-12-10', 4), 
('2025-11-14', '2025-11-18', 5); 

-- 3) Requêtes des questions
    --1)
SELECT id, first_name, last_name
FROM Employee
WHERE team_id IS NULL;

    --2)
SELECT e.id, e.first_name, e.last_name
FROM Employee e
LEFT JOIN Leave l ON l.employee_id = e.id
WHERE l.id IS NULL;

    --3)
SELECT
    l.id           AS leave_id,
    l.start_date,
    l.end_date,
    e.first_name,
    e.last_name,
    t.name         AS team_name
FROM Leave l
JOIN Employee e ON e.id = l.employee_id
LEFT JOIN Team t ON t.id = e.team_id;

    --4)
SELECT
    contract_type,
    COUNT(*) AS nb_employees
FROM Employee
GROUP BY contract_type;

    --5)
SELECT COUNT(DISTINCT employee_id) AS nb_employees_on_leave
FROM Leave
WHERE start_date <= CURRENT_DATE
  AND end_date   >= CURRENT_DATE;

    --6)
SELECT
    e.id,
    e.last_name,
    e.first_name,
    t.name AS team_name
FROM Employee e
JOIN Leave l  ON l.employee_id = e.id
LEFT JOIN Team t ON t.id = e.team_id
WHERE l.start_date <= CURRENT_DATE
  AND l.end_date   >= CURRENT_DATE;
