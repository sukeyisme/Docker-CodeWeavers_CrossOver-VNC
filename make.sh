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
nohup docker build --cpuset-cpus=0-3 -t crossover-vnc:${version} . > build.${version}.log &
