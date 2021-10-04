#!/bin/bash

# Print script commands and exit on errors.
set -xe



#Get the number of cores to speed up the compilation process
NUM_CORES=`grep -c ^processor /proc/cpuinfo`

# --- Mininet --- #


# --- Protobuf --- #
cd protobuf
./configure --prefix=/usr
make -j${NUM_CORES}
sudo make install
sudo ldconfig
unset CFLAGS CXXFLAGS LDFLAGS
# Force install python module
cd python
sudo python setup.py install
cd ../..

# --- gRPC --- #
cd grpc
make -j${NUM_CORES}
sudo make install
sudo ldconfig
unset LDFLAGS
cd ..


# --- BMv2 deps (needed by PI) --- #
cd behavioral-model
cd install
bash ../travis/install-thrift.sh
bash ../travis/install-nanomsg.sh
sudo ldconfig
cd ../../..

# --- PI/P4Runtime --- #
cd  /home/cxy/PI
./configure --with-proto
make -j${NUM_CORES}
sudo make install
sudo ldconfig
cd ..

# --- Bmv2 --- #
cd behavioral-model
./autogen.sh
./configure --enable-debugger --with-pi
make -j${NUM_CORES}
sudo make install
sudo ldconfig
# Simple_switch_grpc target
cd targets/simple_switch_grpc
./autogen.sh
./configure --with-thrift
make -j${NUM_CORES}
sudo make install
sudo ldconfig
cd ../../..


# --- P4C --- #
cd p4c
mkdir -p build
cd build
cmake ..
# The command 'make -j${NUM_CORES}' works fine for the others, but
# with 2 GB of RAM for the VM, there are parts of the p4c build where
# running 2 simultaneous C++ compiler runs requires more than that
# much memory.  Things work better by running at most one C++ compilation
# process at a time.
make -j1
sudo make install
sudo ldconfig
cd ../..

# --- Tutorials --- #
