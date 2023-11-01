echo -----------------------------------
echo "Creating docker network..."
echo -----------------------------------
docker network create simnet

echo -----------------------------------
echo "Creating target servers..."
echo -----------------------------------
docker run -dit --rm --name ser1 --network simnet --user root target-server:1.0.0
docker run -dit --rm --name ser2 --network simnet --user root target-server:1.0.0
docker run -dit --rm --name ser3 --network simnet --user root target-server:1.0.0

echo ----------------------------------------------------------
echo "Starting ssh and ftp services on target servers..."
echo ----------------------------------------------------------
temp=$(docker exec -it ser1 rc-service sshd start)
temp=$(docker exec -it ser1 rc-service vsftpd start)
temp=$(docker exec -it ser2 rc-service sshd start)
temp=$(docker exec -it ser3 rc-service vsftpd start)
temp=$(docker exec -it ser1 rc-service crond start)
temp=$(docker exec -it ser2 rc-service crond start)
temp=$(docker exec -it ser3 rc-service crond start)

echo ----------------------------------
echo "Creating web server..."
echo ----------------------------------
docker run -dit --rm --name web --network simnet --user root -p 8000:8000 web-server:1.0.0

echo ----------------------------------
echo "Creating attack machine..."
echo ----------------------------------
docker run -it --rm --name attacker --network simnet --user root attacker-machine:1.0.0
