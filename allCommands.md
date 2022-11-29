
# Basket Microservice
```console

curl -H "Content-Type: application/json" --request POST localhost:3008/basket/newproduct --data '{"username":"admin","productQty":10,"productId":"carotte"}'

curl -X GET localhost:3008/basket/getbasket/admin

curl -H "Content-Type: application/json" --request POST localhost:3008/basket/removeproduct --data '{"username":"admin","productQty":10,"productId":"carotte"}'

curl --request POST localhost:3008/basket/deletebasket/admin
```
