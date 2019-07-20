FROM debian:buster-slim

RUN apt update
RUN apt upgrade -y
RUN apt install sudo git lsb-release apt-utils p7zip-full wget curl brotli rsync -y
RUN git config --global user.email "baalajimaestro@raphielgang.org"
RUN git config --global user.name "baalajimaestro"
RUN git clone https://github.com/akhilnarang/scripts
RUN scripts
RUN bash setup/android_build_env.sh
RUN unlink /usr/bin/python
RUN ln -s /lib/x86_64-linux-gnu/libncurses.so.6 /usr/lib/x86_64-linux-gnu/libncurses.so.5
RUN ln -s /usr/bin/python2.7 /usr/bin/python
RUN cd ..
RUN rm -rf scripts

CMD ["bash"]
