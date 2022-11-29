rm -f scapp.yml
docker swarm leave -f
docker rm -f $(docker ps -aq)
wget https://raw.githubusercontent.com/NicolasHuberty/linfo2145group5/main/scapp.yml
temp=$(docker swarm init --advertise-addr `curl ifconfig.me` | grep -n "docker swarm join --token" | cut -b 7-)
echo ""
echo "You have to copy this in worker and then go back here"
echo "-------------------------------------------------------------------------"
echo "docker swarm leave & "${temp} "--advertise-addr \`curl ifconfig.me\`"
echo "-------------------------------------------------------------------------"
echo ""
echo "PRESS q when the command above is done"
while : ; do
read -n 1 k <&1
if [[ $k = q ]] ; then
printf "\nContinue the program\n"
break
echo "Press 'q' to exit"
fi
done
docker network create --driver overlay --attachable scapp-net
docker stack deploy -c scapp.yml scapp
docker run -d -e REACT_APP_AUTH_SERVICE_URL=http://`curl ifconfig.me`:3001 -e REACT_APP_CATALOG_SERVICE_URL=http://`curl ifconfig.me`:3004 -e REACT_APP_BASKET_SERVICE_URL=http://`curl ifconfig.me`:3008 -p 3002:80 --name scapp-front nicolashuberty/scapp-frontend
