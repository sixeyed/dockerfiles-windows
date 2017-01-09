
# build the builder image
docker build -t registry-builder -f Dockerfile.builder .

# run the builder to compile registry
rm -r -Force registry
mkdir registry
docker run --rm -v $pwd\registry:c:\out registry-builder

# build the registry image
docker build -t registry  .