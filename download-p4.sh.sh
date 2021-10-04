#!/bin/bash

# Print script commands and exit on errors.
set -xe


#Get the number of cores to speed up the compilation process
NUM_CORES=`grep -c ^processor /proc/cpuinfo`

# --- Mininet --- #
git clone git://github.com/miyachu/mininet mininet


# --- Protobuf --- #
git clone https://github.com/miyachu/protobuf.git

# --- gRPC --- #
git clone https://github.com/miyachu/grpc.git

# Install gRPC Python Package
sudo pip install grpcio

# --- BMv2 deps (needed by PI) --- #
git clone https://github.com/miyachu/behavioral-model.git



# --- PI/P4Runtime --- #
git clone https://github.com/miyachu/PI.git


# --- Bmv2 --- #



# --- P4C --- #
git clone https://github.com/miyachu/p4c


# --- Tutorials --- #
sudo pip install crcmod
git clone https://github.com/p4lang/tutorials
sudo mv tutorials /home/p4