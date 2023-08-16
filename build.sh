#!/bin/bash

VERSION=
VARIANT=
PUSH=0

while [ $# -ge 1 ]; do
  echo $*
  case "$1" in
    -h|--help)
      echo "Usage: $0 [options] [version [variant]]"
      echo "with version matching X.X.X an upstream version of promtail"
      exit 1
      ;;
    -p|--push)
      PUSH=1
      shift
      ;;
    ?.?.?)
      VERSION=$1
      shift
      VARIANT=${1:-1}
      if [ $# -ge 1 ]; then
        shift
      fi
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done


TAG=manastech/promtail-rancher

if [ ! -z "$VERSION" ]; then
  echo Building with upstream version $VERSION
  TAG=$TAG:$VERSION-$VARIANT
fi

docker build . -t $TAG --build-arg VERSION=$VERSION
if [ $PUSH -eq 1 ]; then
  docker push $TAG
fi

