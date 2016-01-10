#!/usr/bin/env bash

sudo apt-add-repository ppa:brightbox/ruby-ng &&
    sudo apt-get update &&
    sudo apt-get install -y ruby2.2 ruby2.2-dev git build-essential zlib1g-dev libssl-dev &&
    gem install bundler &&
    cd /vagrant &&
    bundle install
