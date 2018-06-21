#!/bin/bash


export DRIVERLESS_AI_AUTHENTICATION_METHOD="local"
export DRIVERLESS_AI_LOCAL_HTPASSWD_FILE="/etc/JARVICE/htpasswd"

sudo nvidia-smi -pm 1
sudo /opt/h2oai/dai/run-dai.sh
sudo tail -f /opt/h2oai/dai/log/dai.out
