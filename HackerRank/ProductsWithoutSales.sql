---- Products Without Sales(solution_1)


SELECT product.sku, product.product_name
FROM  product
WHERE product.id NOT IN (SELECT product_id FROM invoice_item);



----- Products Without Sales(solution_2)

SELECT  product.sku, product.product_name
FROM  product
WHERE product.id NOT IN (SELECT product_id FROM invoice_item)
GROUP BY 1,2
ORDER BY product.sku ASC;