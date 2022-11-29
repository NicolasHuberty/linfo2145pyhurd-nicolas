# Run network project
```console
wget -O - https://raw.githubusercontent.com/NicolasHuberty/linfo2145pyhurd-nicolas/main/script.sh | bash
```
# Basket Microservice
```console

curl -H "Content-Type: application/json" --request POST localhost:3008/basket/newproduct --data '{"username":"admin","productQty":10,"productId":"carotte"}'

curl -X GET localhost:3008/basket/getbasket/admin

curl -H "Content-Type: application/json" --request POST localhost:3008/basket/removeproduct --data '{"username":"admin","productQty":10,"productId":"carotte"}'

curl --request POST localhost:3008/basket/deletebasket/admin
```
# Catalog microservice
```console
curl -X POST localhost:3004/catalog/addproduct -H "Content-Type: application/json" -d '{"productName": "salad", "productCat":"vegetable","productImage":"url","productPrice":2, "userRole": "admin"}'

curl -X GET localhost:3004/catalog/salad

curl -X GET localhost:3004/catalog

curl -X PUT localhost:3004/catalog/modifyProduct -H "Content-Type: application/json" -d '{"userRole":"admin","productName": "salad", "productCat": "vegetables","productImage":"url", "productPrice":20}'

curl -X DELETE localhost:3004/catalog/removeProduct/salad -H "Content-Type: application/json" -d '{"userRole": "admin"}'

curl -X DELETE localhost:3004/catalog/removeCategory/vegetable -H "Content-Type: application/json" -d '{"userRole": "admin"}'
```
# Purchase microservice
```console
curl -X POST localhost:3010/purchase/newPurchase -H "Content-Type: application/json" -d '{"username":"admin", "products":[{"productId":"apple","productQty":3, "productPrice":1}], "totalAmount": 3}'

curl -X GET localhost:3010/purchase/admin
```
# Logs microservice
```console
 curl -X POST localhost:3006/logs/login/admin
 
 curl -X POST localhost:3006/logs/register/admin
 
 curl -X POST localhost:3006/logs/itemview/carotte/admin
 
 curl -X POST localhost:3006/logs/itemadd -H "Content-Type: application/json" -d '{"username": "admin", "productQty":10,"productId":"carotte"}'
 
 curl -X POST localhost:3006/logs/itembuy -H "Content-Type: application/json" -d '{"username": "admin", "productQty":10,"productId":"carotte"}'
 
 curl -X POST localhost:3006/logs/performance -H "Content-Type:application/json" -d '{"role":"admin","microservice":"","call":"newproduct","time":4}'
 
 curl -X GET localhost:3006/logs/added/carotte

 curl -X GET localhost:3006/logs/getview/carotte

 curl -X GET localhost:3006/logs/getbuy/carotte

 curl -X GET localhost:3006/logs/getlogin/admin

 curl -X GET localhost:3006/logs/getregister/admin

 curl -X GET localhost:3006/logs/getperformance/basket
 
```
