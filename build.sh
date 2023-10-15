version=$(./versioning.sh)
docker build -t helloworld-node:$version .
