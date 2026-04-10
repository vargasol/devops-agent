#!/bin/bash

echo "Install Azure Devops Agent as service"

ORG_URL=$1
PAT="$2"
POOL="$3"
AGENT="$4"

export BASE_DIR=/opt/vsts-agent-linux
sudo apt update
sudo apt install -y curl wget apt-transport-https

mkdir -p ~/myagent && cd ~/myagent
mkdir $BASE_DIR
cd $BASE_DIR
wget https://download.agent.dev.azure.com/agent/4.271.0/vsts-agent-linux-x64-4.271.0.tar.gz -P $BASE_DIR
tar -zxvf $BASE_DIR/vsts-agent-linux-x64-4.271.0.tar.gz
./config.sh --unattended \
  --url $ORG_URL \
  --auth pat \
  --token $PAT \
  --pool $POOL \
  --agent $AGENT \
  --acceptTeeEula
sudo ./svc.sh install
sudo ./svc.sh start

rm vsts-agent-linux-x64-4.271.0.tar.gz

echo "Install Azure CLI"
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
