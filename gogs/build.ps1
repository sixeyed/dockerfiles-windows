
# build the builder image
docker build -t sixeyed/gogs-builder -f Dockerfile.builder .

# run the builder
rm -r -Force gogs
mkdir gogs
docker run --rm -v $pwd\gogs:c:\out sixeyed/gogs-builder

# build the image
docker build -t sixeyed/gogs .
