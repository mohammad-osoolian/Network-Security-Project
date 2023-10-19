docker network create simnet

echo "Creating target servers..."
docker run -dit --rm --name ser1 --network simnet --user root target-server:1.0.0
docker run -dit --rm --name ser2 --network simnet --user root target-server:1.0.0
docker run -dit --rm --name ser3 --network simnet --user root target-server:1.0.0

echo "Starting ssh and ftp services on target servers..."
temp=$(docker exec -it ser1 rc-service sshd start)
temp=$(docker exec -it ser1 rc-service vsftpd start)
temp=$(docker exec -it ser2 rc-service sshd start)
temp=$(docker exec -it ser3 rc-service vsftpd start)
temp=$(docker exec -it ser1 rc-service crond start)
temp=$(docker exec -it ser2 rc-service crond start)
temp=$(docker exec -it ser3 rc-service crond start)

echo "Creating web server..."
docker run -dit --rm --name web --network simnet --user root -p 8000:8000 web-server:1.0.0

echo "Creating attack machine..."
docker run -it --rm --name attacker --network simnet --user root attack-machine:1.0.0
