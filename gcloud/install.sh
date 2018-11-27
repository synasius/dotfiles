#!/usr/bin/env zsh

if (( ! $+commands[gcloud] )); then
    # Create environment variable for correct distribution
    #export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
    export CLOUD_SDK_REPO="cloud-sdk-bionic"

    # Add the Cloud SDK distribution URI as a package source
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

    # Import the Google Cloud Platform public key
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

    # Update the package list and install the Cloud SDK
    sudo apt update && sudo apt install google-cloud-sdk
fi