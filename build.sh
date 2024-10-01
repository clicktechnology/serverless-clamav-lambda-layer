#!/bin/bash

if [ -z "$1" ]; then
    echo "Usage: Please specify either 'build' or 'update'"
    exit 1
fi

rm -rf ./layer
mkdir layer

case "$1" in
    build)
        echo "Building fresh layer.."
        IMAGE_NAME=clamav-build
        docker build --build-arg IMAGE_NAME=${IMAGE_NAME} --platform=linux/x86_64 -t ${IMAGE_NAME} -f Dockerfile.build .
        ;;
    update)
        echo "Updating the virus scan definitions layer.."
        IMAGE_NAME=clamav-update
        docker build --build-arg IMAGE_NAME=${IMAGE_NAME} --platform=linux/x86_64 -t ${IMAGE_NAME} -f Dockerfile.update .
        ;;
    *)
        echo "Invalid parameter: Please specify either 'build' or 'update'"
        exit 1
        ;;
esac

docker run --name ${IMAGE_NAME} ${IMAGE_NAME}
docker cp ${IMAGE_NAME}:/home/build/${IMAGE_NAME}_lambda_layer.zip .
docker rm ${IMAGE_NAME}
mkdir -p ./${IMAGE_NAME}-layer
mv ${IMAGE_NAME}_lambda_layer.zip ./${IMAGE_NAME}-layer

pushd ${IMAGE_NAME}-layer
unzip -n ${IMAGE_NAME}_lambda_layer.zip
rm ${IMAGE_NAME}_lambda_layer.zip
popd
