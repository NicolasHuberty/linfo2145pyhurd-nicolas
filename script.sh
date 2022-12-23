echo "Configuring your VM..."
rm -f scapp.yml &> /dev/null
docker swarm leave -f &> /dev/null
docker rm -f $(docker ps -aq) &> /dev/null
echo "This may take some time..."
wget -O - https://raw.githubusercontent.com/NicolasHuberty/linfo2145pyhurd-nicolas/main/scappToRun.sh | bash &> /dev/null
temp=$(docker swarm init --advertise-addr `curl ifconfig.me` | grep -n "docker swarm join --token" | cut -b 7-) &> /dev/null
echo ""
echo "You have to copy this in worker and then go back here"
echo "-------------------------------------------------------------------------"
echo "docker swarm leave | "${temp} "--advertise-addr \`curl ifconfig.me\`"
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
docker network create --driver overlay --attachable scapp-net &> /dev/null
docker stack deploy -c scapp.yml scapp
