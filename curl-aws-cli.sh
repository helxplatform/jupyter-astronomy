#!/bin/sh
# get aws cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64-2.4.16.zip" -o "awscliv2.zip"
echo "----- file size should be 45,657,644 bytes -----"
echo "Need: rename awscliv2.zip to match the file name used in Dockerfile"
