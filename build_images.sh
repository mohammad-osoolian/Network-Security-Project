echo ------------------------------------------
echo building attacker image
echo ------------------------------------------
cd attacker-image
docker build . -t attacker-machine:1.0.0
cd ..

echo ------------------------------------------
echo building target image
echo ------------------------------------------
cd target-server-image
docker build . -t target-server:1.0.0
cd ..

echo ------------------------------------------
echo building web image
echo ------------------------------------------
cd web-server-image/SecBack
docker build . -t web-server:1.0.0
cd ../..
