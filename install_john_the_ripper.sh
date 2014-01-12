#script to install the latest version of John The Ripper
#in Backtrack 5 R1
wget http://www.openwall.com/john/g/john-1.7.9-jumbo-7.tar.gz
tar xvf john-1.7.9-jumbo-7.tar.gz
cd john-1.7.9-jumbo-7
cd src
make clean generic
cd ..
cd run
echo "John the Ripper has been installed"
read success!
