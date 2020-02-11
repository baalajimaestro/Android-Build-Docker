FROM alpine:edge

### Uncomment the community repository
RUN  sed -e 's;^#http\(.*\)/edge/community;http\1/edge/community;g' \
            -i /etc/apk/repositories
RUN apk update
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
            python3-dev --no-cache || echo "Done!"
RUN apk add bash \
            moreutils \
            openssh \
            openssl \
            brotli --no-cache || echo "Done!"
RUN apk add rsync \
            build-base \
            automake \
            autoconf \
            gawk \
            gperf --no-cache || echo "Done!"
RUN apk add htop \
            libc6-compat \
            libcap-ng-dev \
            expat-dev \
            gmp-dev \
            lz4-dev --no-cache || echo "Done!"
RUN apk add xz-dev \
            mpc1-dev \
            mpfr-dev \
            ncurses5-libs \
            unzip \
            openssl-dev \
            axel --no-cache || echo "Done!"
RUN apk add bc \
            bison \
            libtool \
            squashfs-tools \
            texinfo \
            re2c \
            pngcrush --no-cache || echo "Done!"
RUN apk add libpng-dev \
            subversion \
            maven \
            w3m \
            ncftp \
            libxslt --no-cache || echo "Done!"
RUN apk add zlib-dev \
            lzip \
            unzip \
            ccache \
            sudo \
            ca-certificates --no-cache || echo "Done!"


RUN apk add schedtool --update-cache --repository http://dl-8.alpinelinux.org/alpine/v3.0/testing/ --allow-untrusted

RUN curl --create-dirs -L -o /etc/udev/rules.d/51-android.rules -O -L https://raw.githubusercontent.com/M0Rf30/android-udev-rules/master/51-android.rules
RUN chmod 644 /etc/udev/rules.d/51-android.rules
RUN chown root /etc/udev/rules.d/51-android.rules

RUN curl --create-dirs -L -o /usr/local/bin/repo -O -L https://storage.googleapis.com/git-repo-downloads/repo
RUN chmod a+x /usr/local/bin/repo

RUN git config --global user.name "baalajimaestro"
RUN git config --global user.email "baalajimaestro@pixelexperience.org"

CMD ["bash"]
