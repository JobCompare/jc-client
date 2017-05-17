#!/bin/bash

ROOT=$PWD
ARGUMENTS=( "$@" )

if [ -z "${NODE_ENV}" ]
then
  NODE_ENV="development"
fi

if [ "${NODE_ENV}" == "development" ]
then
  ${ROOT}/node_modules/.bin/jest --coverage
  return_code=$?
  if [ ${return_code} != 0 ]
  then
    exit ${return_code}
  fi
fi

for argument in "${ARGUMENTS[@]}"
do
  if [ "$argument" == "install" ]
  then
    npm install
  elif [ "$argument" != "test" ]; then
    npm run "$argument"
  fi

  return_code=$?
  if [ ${return_code} != 0 ]
  then
    exit ${return_code}
  fi
done
