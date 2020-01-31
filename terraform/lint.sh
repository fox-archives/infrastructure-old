#/bin/sh -xu

docker run --rm -v $(pwd):/data -t wata727/tflint:0.14.0
