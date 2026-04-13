#!/bin/bash

echo "Install Azure Devops Agent as service"

ORG_URL="$1"
PAT="$2"
POOL="$3"
AGENT="$4"
BASE_DIR="/opt/vsts-agent-linux"

apt update
apt install -y curl wget apt-transport-https

mkdir -p $BASE_DIR && cd $BASE_DIR
echo "Downloading vsts agent"
wget https://download.agent.dev.azure.com/agent/4.271.0/vsts-agent-linux-x64-4.271.0.tar.gz -P $BASE_DIR
tar -zxvf $BASE_DIR/vsts-agent-linux-x64-4.271.0.tar.gz

echo "Running unattended configuration"
$BASE_DIR/config.sh --unattended \
  --url $ORG_URL \
  --auth pat \
  --token $PAT \
  --pool $POOL \
  --agent $AGENT \
  --acceptTeeEula

echo "Configuring vsts service"
$BASE_DIR/svc.sh install
$BASE_DIR/svc.sh start

rm vsts-agent-linux-x64-4.271.0.tar.gz

echo "Install Azure CLI"
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
