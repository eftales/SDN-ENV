sudo apt install git make redis-server libpthread-stubs0-dev libhiredis-dev ethtool -y

sudo apt remove openjdk-11-jre-headless -y

sudo apt install openjdk-8-jdk maven g++ -y

sudo echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64" >> ~/.bashrc

# DHCP Server
sudo apt install isc-dhcp-server -y
sudo rm -f /etc/dhcp/dhcpd.conf /etc/default/isc-dhcp-server
sudo cp dhcpd.conf /etc/dhcp/dhcpd.conf
sudo cp isc-dhcp-server /etc/default/isc-dhcp-server

# SDN Source
git clone git@github.com:eftales/sdn-soft.git
cd sdn-soft
git checkout phy-env
cd lib/
mvn install:install-file -DgroupId=com.javastruct -DartifactId=javastruct -Dversion=0.1 -Dpackaging=jar -Dfile=javastruct-0.1.jar
cd ..
