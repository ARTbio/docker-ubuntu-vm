LOGIN="docker login -e=$DOCKER_EMAIL -u=$DOCKER_USERNAME -p=$DOCKER_PASSWORD"
$LOGIN || (sleep 5s && $LOGIN || echo "login failed twice, quitting" && exit 1)
docker push artbio/ubuntu-vm || (sleep 5s && docker push artbio/ubuntu-vm || echo "push failed twice, quitting" && exit 1)

