FROM debian:buster-slim

RUN apt update && apt upgrade -y && apt install sudo git lsb-release apt-utils p7zip-full wget curl brotli rsync -y

RUN git config --global user.email "baalajimaestro@raphielgang.org" && \ 
    git config --global user.name "baalajimaestro" && \ 
    git clone https://github.com/akhilnarang/scripts /root/scripts
    
RUN cd /root/scripts && sed -i 's/DEBIAN_10_PACKAGES=\"curl rsync\"/# DEBIAN_10_PACKAGES=\"curl rsync\"/g' setup/android_build_env.sh && \ 
bash setup/android_build_env.sh

RUN unlink /usr/bin/python && \ 
ln -s /lib/x86_64-linux-gnu/libncurses.so.6 /usr/lib/x86_64-linux-gnu/libncurses.so.5 && \ 
ln -s /usr/bin/python2.7 /usr/bin/python

RUN rm -rf /root/scripts

CMD ["bash"]
