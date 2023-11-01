echo ---------------------------------------
echo "Removing containers..."
echo ---------------------------------------
docker stop attacker web ser1 ser2 ser3

echo ---------------------------------------
echo "Removing docker network"
echo ---------------------------------------

docker network rm simnet
