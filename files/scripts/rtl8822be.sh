# thanks to https://ubuntuforums.org/showthread.php?t=2364383
sudo apt update
sudo apt install git
git clone https://github.com/rtlwifi-linux/rtlwifi-next
cd rtlwifi-next
make
sudo make install
sudo modprobe rtl8822be
