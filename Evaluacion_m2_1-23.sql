
-- EVALUACIÓN FINAL MÓDULO 2



USE sakila;

-- Ejercicio 1. Seleccionar todos los nombres de las películas sin que aparezcan duplicados: 

SELECT DISTINCT 
	title
FROM 
	film;



-- Ejercicio 2. Mostrar los nombres de todas las películas que tengan una clasificación de "PG-13":

SELECT 
	title,
	rating
FROM 
	film
WHERE 
	rating = 'PG-13';



-- Ejercicio 3. Encontrar el título y la descripción de todas las películas que contengan la palabra "amazing" en su descripción:

SELECT 
	title, 
	description
FROM 
	film
WHERE 
	description LIKE '%amazing%';



-- Ejercicio 4. Encontrar el título de todas las películas que tengan una duración mayor a 120 minutos:

SELECT 
	title, 
	length
FROM 
	film
WHERE 
	length > 120;



-- Ejercicio 5. Recuperar los nombres de todos los actores:

SELECT 
	first_name, 
	last_name
FROM 
	actor
ORDER BY 
	last_name, 
	first_name;  -- Plus para ordenar alfabéticamente (apellido)



-- Ejercicio 6. Encontrar el nombre y apellido de los actores que tengan "Gibson" en su apellido:

SELECT 
	first_name, 
	last_name
FROM 
	actor 
WHERE 
	last_name LIKE '%Gibson%';

	-- Comprobación solo 1 Gibson
	SELECT *
	FROM actor
	ORDER BY last_name; 



-- Ejercicio 7. Encontrar los nombres de los actores que tengan un actor_id entre 10 y 20:

SELECT 
	actor_id, 
	first_name, 
	last_name
FROM 
	actor
WHERE 
	actor_id BETWEEN 10 AND 20
ORDER BY 
	actor_id;



-- Ejercicio 8. Encontrar el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su clasificación:

SELECT 
	title, 
	rating 
FROM 
	film 
WHERE 
	rating NOT IN ('R', 'PG-13');



-- Ejercicio 9. Encontrar la cantidad total de películas en cada clasificación de la tabla film y mostrar la clasificación junto con el recuento:

SELECT 
	rating, COUNT(*) AS count
FROM 
	film
GROUP BY 
	rating
ORDER BY 
	count DESC; -- Plus para ordenar la clasificación de mayor a menor cantidad de películas.



-- Ejercicio 10. Encontrar la cantidad total de películas alquiladas por cada cliente. Mostrar el ID del cliente, su nombre y apellido junto con la cantidad de películas alquiladas:

SELECT 
	c. customer_id,
	c. first_name,
	c. last_name,
	COUNT(r.rental_id) AS total_rentals
FROM
	customer c	
-- Asegurar que se mantienen todos los clientes aunque no hayan alquilado películas. Como no hay ningún cliente sin alquiler, también podríamos utilizar el INNER JOIN.  
LEFT JOIN 
	rental r ON c.customer_id = r.customer_id	
GROUP BY 
	c.customer_id
ORDER BY 
	c.customer_id;



-- Ejercicio 11. Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría junto con el recuento de alquileres:

SELECT 
	c.name AS category_name,
	COUNT(r.rental_id) AS total_rentals
FROM
	rental r
INNER JOIN
	inventory i ON r.inventory_id = i.inventory_id 
INNER JOIN 
	film_category fc ON i.film_id = fc.film_id
INNER JOIN 
	category c ON fc.category_id = c.category_id 
GROUP BY 
	c.name 
ORDER BY 
	total_rentals DESC; -- Plus para ordenar las categorías de mayor a menor cantidad de alquileres. 
	
	

-- Ejercicio 12. Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y muestra la clasificación junto con el promedio de duración:
	
SELECT
	rating,
	AVG(length) AS average_duration
FROM	
	film
GROUP BY
	rating; 


 	--Plus para mostrar la duración redondeada: 
 		
 		SELECT
			rating,
			ROUND(AVG(length), 2) AS average_duration
		FROM	
			film
		GROUP BY
			rating;
		
		
		
		
-- Ejercicio 13. Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love":
		
SELECT 
	a.first_name,
	a.last_name
FROM
	actor a
INNER JOIN
	film_actor fa ON a.actor_id = fa.actor_id 
INNER JOIN 
	film f ON fa.film_id = f.film_id 
WHERE 
	f.title = 'Indian Love'
ORDER BY
	last_name, 
	first_name; -- Plus para ordenar alfabéticamente (apellido).
	


		
-- Ejercicio 14. Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción:
	
SELECT 
	title
FROM 
	film
WHERE 
	description LIKE '%dog%' OR description LIKE '%cat%';




-- Ejercicio 15. Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor? NO.

SELECT 	
	a.actor_id,
	a.first_name,
	a.last_name
FROM
	actor a
LEFT JOIN
	film_actor fa ON a.actor_id = fa.actor_id
WHERE 	
	fa.actor_id IS NULL; 
	

	

-- Ejercicio 16. Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010:
	
SELECT 
	title,
	release_year
FROM
	film 
WHERE 
	release_year BETWEEN 2005 and 2010;

		-- Como únicamente hay películas de 2006, lo verifico (cambiándo el año de realización en cada comprobación):
		SELECT 
		    COUNT(*) AS count_2005
		FROM 
		    film
		WHERE 
		    release_year = 2005;


	
		   
-- Ejercicio 17. Encuentra el título de todas las películas que son la misma categoría "Family":

SELECT
	f.title, c.name AS category 
FROM
	film f
INNER JOIN
	film_category fc ON f.film_id = fc.film_id 
INNER JOIN 	
	category c ON fc.category_id = c.category_id 
WHERE 	
	c.name = 'Family';




-- Ejercicio 18. Muestra el nombre y apellido de los actores que aparecen en más de 10 películas:

SELECT 
	a.first_name,
	a.last_name,
	COUNT(fa.film_id) AS Total_films
FROM
	actor a
INNER JOIN
	film_actor fa ON a.actor_id = fa.actor_id 
GROUP BY 
	a.actor_id
HAVING 
	COUNT(fa.film_id) > 10
ORDER BY
	a.last_name, 
	a.first_name;




-- Ejercicio 19. Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la tabla:

SELECT 
	title,
	rating,
	length
FROM
	film 
WHERE 
	rating = 'R' AND length > 120;




-- Ejercicio 20. Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y muestra el nombre de la categoría junto con el promedio de duración:

SELECT 
	c.name AS category,
	AVG(f.length) AS average_duration
FROM
	category c
INNER JOIN 
	film_category fc ON c.category_id = fc.category_id 
INNER JOIN
	film f ON fc.film_id = f.film_id 
GROUP BY 
	c.name 
HAVING 
	AVG(f.length) > 120
ORDER BY
	average_duration DESC; -- plus ordenar de mayor a menor media-duración. 
	
			-- plus redondear media-duración:
	
		SELECT 
    		c.name AS category,
    		ROUND(AVG(f.length), 2) AS average_duration
		FROM
    		category c
		INNER JOIN 
   			film_category fc ON c.category_id = fc.category_id 
		INNER JOIN
    		film f ON fc.film_id = f.film_id 
		GROUP BY 
    		c.name 
		HAVING 
    		AVG(f.length) > 120
		ORDER BY 
    		average_duration DESC;
    	
    	
    	
-- Ejercicio 21. Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto con la cantidad de películas en las que han actuado:

SELECT 
	a.first_name,
	a.last_name,
	COUNT(*) AS total_films
FROM
	actor a
INNER JOIN
	film_actor fa ON a.actor_id = fa.actor_id
GROUP BY 	
	a.actor_id
HAVING 
	COUNT(*) >= 5
ORDER BY 
	total_films DESC; -- plus orden de mayor a menor cantidad de películas. 

	-- Comprobar que no hay ningún actor que haya hecho entre 5-14 películas
		SELECT 
			a.first_name,
			a.last_name,
			COUNT(*) AS total_films
		FROM
			actor a
		INNER JOIN
			film_actor fa ON a.actor_id = fa.actor_id
		GROUP BY 	
			a.actor_id
		HAVING 
			COUNT(*) BETWEEN 5 AND 13
		ORDER BY 
			total_films DESC;

		
		
-- Ejercicio 22. Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las películas correspondientes:

SELECT
	f.title	
FROM	
	film f
WHERE 	
	f.film_id IN (
		SELECT 	
			r.inventory_id
		FROM
			rental r
		WHERE 
			DATEDIFF(return_date, rental_date)> 5
	);


	

-- Ejercicio 23. Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la categoría "Horror" y luego exclúyelos de la lista de actores:


SELECT
    a.first_name,
    a.last_name
FROM
    actor a
WHERE
    a.actor_id NOT IN (
        SELECT DISTINCT
            fa.actor_id
        FROM
            film_actor fa
        INNER JOIN 
        	film_category fc ON fa.film_id = fc.film_id
        INNER JOIN 
        	category c ON fc.category_id = c.category_id
        WHERE
            c.name = 'Horror'
         )
 ORDER BY 
	a.last_name, 
	a.first_name; -- Plus para ordenar alfabéticamente (apellido).
	
	
-- Usando otro operador: 
	
	
SELECT
    a.first_name,
    a.last_name
FROM
    actor a
WHERE
    NOT EXISTS (
        SELECT 1
        FROM
            film_actor fa
        INNER JOIN 
        	film_category fc ON fa.film_id = fc.film_id
        INNER JOIN 
        	category c ON fc.category_id = c.category_id
        WHERE
            fa.actor_id = a.actor_id AND c.name = 'Horror'
        )
ORDER BY
   a.last_name, 
   a.first_name;