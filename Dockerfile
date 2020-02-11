#
# Copyright © 2019 Maestro Creativescape
#
# SPDX-License-Identifier: GPL-3.0
#
# Docker Image Builder for Android BuildSystem on Alpine Linux Edge
# Deps picked primarily from https://github.com/akhilnarang/scripts
# 
FROM alpine:edge

### Uncomment the community repository
RUN  sed -e 's;^#http\(.*\)/edge/community;http\1/edge/community;g' \
            -i /etc/apk/repositories

RUN apk update

### I have split the deps to several run steps to split the deps
### across a lot of layers. This ensures your image is pulled a
### lot faster. 

RUN apk add git \
            patchelf \
            brotli \
            unzip \
            p7zip --no-cache || echo "Done!"

RUN apk add zip \
            curl \
            wget \
            gnupg \
            python3 \
            python3-dev --no-cache

RUN apk add bash \
            moreutils \
            openssh \
            openssl \
            brotli --no-cache

RUN apk add rsync \
            build-base \
            automake \
            autoconf \
            gawk \
            gperf --no-cache

RUN apk add htop \
            libc6-compat \
            libcap-ng-dev \
            expat-dev \
            gmp-dev \
            lz4-dev --no-cache

RUN apk add xz-dev \
            mpc1-dev \
            mpfr-dev \
            ncurses5-libs \
            unzip \
            openssl-dev \
            axel --no-cache

RUN apk add bc \
            bison \
            libtool \
            squashfs-tools \
            texinfo \
            re2c \
            clang-dev \
            pngcrush --no-cache

RUN apk add libpng-dev \
            subversion \
            maven \
            w3m \
            ncftp \
            libxslt --no-cache

RUN apk add zlib-dev \
            lzip \
            unzip \
            ccache \
            sudo \
            ca-certificates --no-cache

### schedtool is needed by a few roms, but is not on newest edge repos
### A quick google revealed it lying on v3.0, pull it from there.
RUN apk add schedtool --update-cache --repository http://dl-8.alpinelinux.org/alpine/v3.0/testing/ --allow-untrusted

### Set up adb udev rules
RUN curl --create-dirs -L -o /etc/udev/rules.d/51-android.rules -O -L https://raw.githubusercontent.com/M0Rf30/android-udev-rules/master/51-android.rules
RUN chmod 644 /etc/udev/rules.d/51-android.rules
RUN chown root /etc/udev/rules.d/51-android.rules

### Install android repo command
RUN curl --create-dirs -L -o /usr/local/bin/repo -O -L https://storage.googleapis.com/git-repo-downloads/repo
RUN chmod a+x /usr/local/bin/repo

RUN git config --global user.name "baalajimaestro"
RUN git config --global user.email "baalajimaestro@pixelexperience.org"

CMD ["bash"]
