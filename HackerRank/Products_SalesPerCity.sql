---- Products Sales Per City

SELECT invoice.city_name,
product.product_name,
invoice_item.line_total_price
FROM invoice_item as invoice_item
JOIN product as product
ON invoice_item.product_id = product.id
JOIN (
    SELECT invoice.id,
    customer.city_name
    FROM invoice as invoice
    JOIN (
    SELECT customer.id,city.city_name
        FROM customer as customer
        LEFT JOIN city as city
        ON customer.city_id = city.id
    )as customer
    ON invoice.customer_id = customer.id
) as invoice
ON invoice_item.invoice_id = invoice.id
ORDER BY invoice_item.line_total_price DESC;


---- Products Sales Per City

SELECT 
    CI.city_name, 
    PR.product_name, 
    ROUND(SUM(INV_I.line_total_price), 2) AS tot
FROM 
    city as CI, 
    customer as CU, 
    invoice as INV, 
    invoice_item as INV_I, 
    product as PR 
WHERE 
    CI.id = CU.city_id
    AND CU.id = INV.customer_id 
    AND INV.id = INV_I.invoice_id 
    AND INV_I.product_id = PR.id 
GROUP BY 
    CI.city_name, 
    PR.product_name 
ORDER BY 
    tot DESC, 
    CI.city_name, 
    PR.product_name ;