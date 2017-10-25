#!/bin/sh

while getopts 'v:' flag; do
  case "${flag}" in
	  v) version=${OPTARG} ;;
	  *) echo "Unexpected parameter ${flag}" ; exit ;;
  esac
done

if [ -z ${version} ] ; then
   echo 'not specify version number'
   exit
fi

echo 'starting to build image'
nohup sudo docker build -t johnshine/crossover-vnc:${version} . > ../build.${version}.log &
