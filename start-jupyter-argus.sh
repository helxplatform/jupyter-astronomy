#!/bin/bash

HOME_PATH="/home/jovyan"
USER_PATH="/home/${USER_NAME}"

# Create the S3 credentials
echo "Create credentials file"
cd ${HOME_PATH}
mkdir .aws
echo "[default]" > .aws/credentials
echo "aws_access_key_id = $S3_ACCESS_KEY_ID" >> .aws/credentials
echo "aws_secret_access_key = $S3_SECRET_ACCESS_KEY" >> .aws/credentials
S3_ACCESS_KEY_ID=
S3_SECRET_ACCESS_KEY=

# Start the notebook
cd ${HOME_PATH}
#start-notebook.sh --NotebookApp.token= --ip="*" --NotebookApp.base_url=${NB_PREFIX} --NotebookApp.allow_origin="*"
start.sh jupyter lab --LabApp.token= --ip="*" --NotebookApp.base_url=${NB_PREFIX} --NotebookApp.allow_origin="*"
