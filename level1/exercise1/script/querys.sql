/*querys, Exercise 1, Level 1 "Store Glasses"*/

/*List a customer's total invoices for a given period.*/
SELECT 
	sale.id_sale, 
    CONCAT(glass.brand, " ", glass.crystal_color) as glass_description,
    client.name
FROM sale
INNER JOIN
	glass ON glass.id_glass = sale.id_glass
INNER JOIN
    client ON client.id_client = sale.id_client
WHERE
	sale.id_client = 1 
    AND
    sale.sales_date BETWEEN "2025-01-01" AND "2025-06-13";

/*List the different models of glasses an employee has sold over the course of a year.*/
SELECT DISTINCT
    sale.id_sale,
    glass.mount_type
FROM
	sale
INNER JOIN
	glass ON glass.id_glass = sale.id_glass
WHERE
	id_client = 1
    AND
    YEAR(sales_date) = 2024;

/*--List the different suppliers who have successfully supplied glasses sold by the optician.*/
SELECT DISTINCT
	provider.name
FROM
	sale
INNER JOIN
	glass ON glass.id_glass = sale.id_glass
INNER JOIN
	provider ON provider.id_provider = glass.id_provider;