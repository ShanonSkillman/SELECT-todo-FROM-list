DROP DATABASE IF EXISTS todo_app;
DROP USER IF EXISTS michael;
DROP TABLE IF EXISTS tasks;
CREATE USER michael WITH PASSWORD 'stonebreaker';
CREATE DATABASE todo_app;
\c todo_app;

CREATE TABLE tasks (
    ID serial NOT NULL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT now(),
    updated_at TIMESTAMP NULL,
    completed BOOLEAN NOT NULL DEFAULT false
);

ALTER TABLE tasks
    DROP COLUMN completed;

ALTER TABLE tasks ADD completed_at TIMESTAMP NULL;
ALTER TABLE tasks ALTER COLUMN updated_at SET NOT NULL;
ALTER TABLE tasks ALTER COLUMN updated_at SET DEFAULT now();

-- create a new task
INSERT INTO tasks (id, title, description, created_at, updated_at, completed_at) VALUES (default, 'Study SQL', 'Complete this exercise', now(), now(), NULL);

-- creating a new task simple
INSERT INTO tasks (title, description) VALUES ('Study PostgreSQL', 'Read all the documentation');

SELECT title FROM tasks WHERE completed_at IS NULL;
UPDATE tasks SET completed_at = now() WHERE title = 'Study SQL';
SELECT * FROM tasks WHERE completed_at IS NULL;
SELECT created_at FROM tasks ORDER BY created_at DESC;

INSERT INTO tasks (title, description) VALUES ('mistake 1', 'a test entry');
INSERT INTO tasks (title, description) VALUES ('mistake 2', 'another test entry');
INSERT INTO tasks (title, description) VALUES ('third mistake', 'another test entry');

SELECT * FROM tasks WHERE title ~ 'mistake';
DELETE FROM tasks WHERE title ~ 'mistake 1';
SELECT title, description FROM tasks WHERE title ~ 'mistake';
DELETE FROM tasks WHERE title ~ 'mistake';
SELECT * FROM tasks ORDER BY title ASC;