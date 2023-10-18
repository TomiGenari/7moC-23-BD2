-- INSERT INTO employees
INSERT INTO employees (employeeNumber, lastName, firstName, extension, email, officeCode, jobTitle) VALUES (1037, 'Smith', 'John', 'x7357', 'j.smith@example.com', '1', 'CFO'); /* El campo de email no admite valores nulos, por lo que se produce un error */

-- UPDATE employees SET employeeNumber = employeeNumber - 20;
UPDATE employees SET employeeNumber = employeeNumber - 20; /* A todos los IDs se les resta 20 unidades */

-- UPDATE employees SET employeeNumber = employeeNumber + 20;
UPDATE employees SET employeeNumber = employeeNumber + 20; /* Se intenta sumar 20 unidades a todos los ids, pero se produce una violación de la clave primaria al coincidir dos ids con el mismo valor (la clave primaria debe ser única) */

-- ALTER TABLE employees ADD age INT CHECK ( age BETWEEN 16 AND 70);
ALTER TABLE employees ADD age INT CHECK (age BETWEEN 18 AND 65);

-- INSERT INTO employees
INSERT INTO employees (employeeNumber, lastName, firstName, extension, email, officeCode, jobTitle) VALUES (1073, 'Genari', 'Tomas', 'x7357', 't.genari@example.com', '1', 'CTO');

-- CREATE TRIGGER employees_before_update
CREATE TRIGGER employees_before_update BEFORE UPDATE ON employees FOR EACH ROW BEGIN SET NEW.lastUpdate = NOW(), NEW.lastUpdateUser = 'Tomas Genari'; END;

-- CREATE TRIGGER employees_before_insert
CREATE TRIGGER employees_before_insert BEFORE INSERT ON employees FOR EACH ROW BEGIN SET NEW.lastUpdate = NOW(), NEW.lastUpdateUser = 'Tomas Genari'; END;

-- INSERT INTO employees
INSERT INTO employees (employeeNumber, lastName, firstName, extension, email, officeCode, jobTitle) VALUES (1103, 'Brown', 'Alice', 'x7357', 'a.brown@example.com', '1', 'COO');

-- create trigger customer_create_date before insert on customer for each row SET NEW.create_date = NOW(); /* Este trigger asigna el valor NOW() al campo create_date. Se ejecuta al insertar un nuevo customer */

-- create trigger del_film after delete on film for each row BEGIN DELETE FROM film_text WHERE film_id = old.film_id; /* Este trigger se activa después de borrar una película. Elimina de la tabla film_text las filas que tengan el id de la película borrada. */

-- create trigger ins_film after insert on film for each row BEGIN INSERT INTO film_text (film_id, title, description) VALUES (new.film_id, new.title, new.description); /* Este trigger se dispara después de insertar una película en la tabla film. Inserta en la tabla fil_text el nuevo valor del id, título y descripción de la película insertada. */

-- create trigger upd_film after update on film for each row BEGIN IF (old.title != new.title) OR (old.description != new.description) OR (old.film_id != new.film_id) THEN UPDATE film_text SET title=new.title, description=new.description, film_id=new.film_id WHERE film_id=old.film_id; END IF; /* Este trigger se lanza después de actualizar una película en la tabla film. Verifica si el título anterior o la descripción o el id son diferentes a los valores anteriores. Si alguna de estas condiciones se cumple se actualizan los campos con los valores nuevos. */

-- create trigger payment_date before insert on payment for each row SET NEW.payment_date = NOW(); /* Este trigger se realiza antes de insertar una fila en la tabla payment. Establece el valor que devuelve la función NOW() al campo payment_date */

