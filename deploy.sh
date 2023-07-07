#!/bin/bash

# ex: bash deploy.sh PPD erable

case $1 in
  PRD)
    printf "Deploying to $2 PROD\n"
    read -p "Are you sure? " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
      gsutil -m cp -r ./projects/app.$2.com gs://bloom-project-front-config-prd/projects/ && gsutil -m setmeta -r -h "Cache-Control:no-store" gs://bloom-project-front-config-prd
    fi
    ;;

  PPD)
    printf "Deploying to $2 PREPROD\n"
    gsutil -m cp -r ./projects/app.ppd.mainnet.$2.smart-chain.fr/ gs://bloom-project-front-config-ppd-mainnet/projects/ && gsutil -m setmeta -r -h "Cache-Control:no-store" gs://bloom-project-front-config-ppd-mainnet
    ;;

  STG)
    printf "Deploying to STG\n"
    gsutil -m cp -r ./projects/ gs://bloom-project-front-config-stg/ && gsutil -m setmeta -r -h "Cache-Control:no-store" gs://bloom-project-front-config-stg
    ;;

  *)
    printf "Bad environment name\n"
    ;;
esac
