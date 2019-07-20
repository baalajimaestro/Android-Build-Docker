apt update
apt upgrade -y
apt install sudo git lsb-release apt-utils p7zip-full wget curl brotli rsync -y
git config --global user.email "baalajimaestro@raphielgang.org"
git config --global user.name "baalajimaestro"
git clone https://github.com/akhilnarang/scripts
cd scripts
bash setup/android_build_env.sh
unlink /usr/bin/python
ln -s /lib/x86_64-linux-gnu/libncurses.so.6 /usr/lib/x86_64-linux-gnu/libncurses.so.5
ln -s /usr/bin/python2.7 /usr/bin/python
cd ..
rm -rf scripts
