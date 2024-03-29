IP=localhost
#IP=`curl ifconfig.me`
rm -f scapp.yml
echo "Generating the scapp.yml file..."
SCAPP='version: "3"
services:     # list all services for your application
  # database of users
  users-db:
    # image name
    image: nicolashuberty/kv-storage-system:latest
    ports: ["3000:5984"]
    deploy:
      # deploy only one instance of this service
      replicas: 1
      restart_policy:
        # restart if something went wrong
        condition: on-failure
    networks: [ "scapp-net" ]
  # database of catalog
  catalog-db:
    #image name
    image: nicolashuberty/kv-storage-system:latest
    ports: ["3003:5984"]
    deploy:
      replicas: 1
      restart_policy:
        condition: on-failure
    networks: [ "scapp-net" ]
  # database of catalog
  logs-db:
    #image name
    image: nicolashuberty/kv-storage-system:latest
    ports: ["3005:5984"]
    deploy:
      replicas: 1
      restart_policy:
        condition: on-failure
    networks: [ "scapp-net" ]
  # database of catalog
  basket-db:
    #image name
    image: nicolashuberty/kv-storage-system:latest
    ports: ["3007:5984"]
    deploy:
      replicas: 1
      restart_policy:
        condition: on-failure
    networks: [ "scapp-net" ]
  purchase-db:
    #image name
    image: nicolashuberty/kv-storage-system:latest
    ports: ["3009:5984"]
    deploy:
      replicas: 1
      restart_policy:
        condition: on-failure
    networks: [ "scapp-net" ] 
  # server that listens HTTP requests
  auth-service:
    image: nicolashuberty/scapp-auth:latest
    # link both services (same effect of option --link in docker run)
    depends_on: [ "users-db" ]
    # expose port number 3000 of host running this service
    ports: [ "3001:80" ]
    deploy:
      replicas: 1
      restart_policy:
        condition: on-failure
    networks: [ "scapp-net" ]
  # Catalog service
  catalog-service:
    image: nicolashuberty/scapp-catalog:latest
    # link both services (same effect of option --link in docker run)
    depends_on: [ "catalog-db" ]
    # expose port number 3000 of host running this service
    ports: [ "3004:80" ]
    deploy:
      replicas: 1
      restart_policy:
        condition: on-failure
    networks: [ "scapp-net" ]
  basket-service:
    image: nicolashuberty/scapp-basket:latest
    # link both services (same effect of option --link in docker run)
    depends_on: [ "basket-db" ]
    # expose port number 3000 of host running this service
    ports: [ "3008:80" ]
    deploy:
      replicas: 1
      restart_policy:
        condition: on-failure
    networks: [ "scapp-net" ]
  logs-service:
    image: nicolashuberty/scapp-logs:latest
    # link both services (same effect of option --link in docker run)
    depends_on: [ "logs-db" ]
    # expose port number 3000 of host running this service
    ports: [ "3006:80" ]
    deploy:
      replicas: 1
      restart_policy:
        condition: on-failure
    networks: [ "scapp-net" ]
  purchase-service:
    image: nicolashuberty/scapp-purchase:latest
    # link both services (same effect of option --link in docker run)
    depends_on: [ "purchase-db" ]
    # expose port number 3000 of host running this service
    ports: [ "3010:80" ]
    deploy:
      replicas: 1
      restart_policy:
        condition: on-failure
    networks: [ "scapp-net" ]
  # Docker GUI for swarms
  scapp-front:
    image: nicolashuberty/scapp-front:latest
    ports: [ "3002:80" ]
    deploy:
      replicas: 1
      restart_policy:
        condition: on-failure
    networks: [ "scapp-net" ]
    environment:
      - REACT_APP_AUTH_SERVICE_URL=http://'${IP}':3001 
      - REACT_APP_CATALOG_SERVICE_URL=http://'${IP}':3004
      - REACT_APP_LOG_SERVICE_URL=http://'${IP}':3006
      - REACT_APP_BASKET_SERVICE_URL=http://'${IP}':3008
      - REACT_APP_PURCHASE_SERVICE_URL=http://'${IP}':3010
      - REACT_APP_RECOMMENDATION_SERVICE_URL=http://'${IP}':3011
  recommandation-service:
    image: nicolashuberty/scapp-recommandation:latest
    ports: [ "3011:80" ]
    deploy:
      replicas: 1
      restart_policy:
        condition: on-failure
    networks: [ "scapp-net" ]
    environment:
      - DB_CATALOG=http://admin:admin@'${IP}':3003/catalog
  visualizer:
    image: dockersamples/visualizer:stable
    ports: [ "80:8080" ]
    volumes:
      - "/var/run/docker.sock:/var/run/docker.sock"
    deploy:
      # locate this service in the swarm manager
      placement:
        constraints:
          - node.role == manager
    networks: [ "scapp-net" ]
networks:
  scapp-net:
    external: true'
echo "$SCAPP" > scapp.yml
