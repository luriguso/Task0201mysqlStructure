/*Lista cuántos productos de categoría 'Bebidas' se han vendido en una determinada localidad.*/
SELECT  
	location.name AS locality,
    SUM(order_detail.quantity) AS total_beverages_sold
FROM `order`
INNER JOIN
    order_detail ON order_detail.id_order = `order`.`id_order`
INNER JOIN
    product ON product.id_product = order_detail.id_product
INNER JOIN
    category ON category.id_category = product.id_category
INNER JOIN
    client ON client.id_client = `order`.`id_client`
INNER JOIN
    location ON location.id_location = client.id_location
WHERE
    location.id_location = 1
    AND
    category.id_category = 2;

/*Lista cuántos pedidos ha efectuado un determinado empleado/a.*/
SELECT
	employee.name AS delivery_men,
    COUNT(delivery.id_employee) AS quantity
FROM delivery
INNER JOIN
	employee ON employee.id_employee = delivery.id_employee
WHERE
	employee.id_employee = 2;