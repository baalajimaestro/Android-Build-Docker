FROM debian:bullseye-slim

RUN apt update && \
    apt install -y \  
    git \
    sudo \
    apt-transport-https \
    ca-certificates \
    software-properties-common \
    build-essential \
    tar \
    lsb-release \
    gzip \
    unzip \
    zip \
    bzip2 \
    gnupg \
    curl \
    wget \
    openjdk-11-jdk \
    libqt5webkit5

ENV LD_LIBRARY_PATH=${ANDROID_HOME}/tools/lib64:${ANDROID_HOME}/emulator/lib64:${ANDROID_HOME}/emulator/lib64/qt/lib

ENV ANDROID_HOME /opt/android-sdk-linux
RUN dpkg --add-architecture i386

RUN apt-get install -y \
    libc6:i386 libstdc++6:i386 libgcc1:i386 libncurses5:i386 libz1:i386 \
    xvfb lib32z1 lib32stdc++6 build-essential \
    libcurl4-openssl-dev libglu1-mesa libxi-dev libxmu-dev \
    libglu1-mesa-dev

RUN apt-get purge maven maven2 \
    && apt-get update \
    && apt-get -y install maven gradle \
    && mvn --version \
    && gradle -v

# Download Android SDK

RUN cd /opt \
    && wget -q https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -O android-sdk-tools.zip \
    && unzip -q android-sdk-tools.zip -d ${ANDROID_HOME} \
    && rm android-sdk-tools.zip
ENV PATH=${ANDROID_HOME}/emulator:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}

# Install Android SDK
RUN mkdir ~/.android && echo "### User Sources for Android SDK Manager" > ~/.android/repositories.cfg
RUN yes | sdkmanager --licenses && yes | sdkmanager --update
RUN sdkmanager "emulator" "tools" "platform-tools"
RUN yes | sdkmanager \
    "platforms;android-29" \
    "platforms;android-28" \
    "platforms;android-27" \
    "platforms;android-26" \
    "platforms;android-25" \
    "build-tools;29.0.2" \
    "build-tools;29.0.1" \
    "build-tools;28.0.3" \
    "build-tools;28.0.2" \
    "build-tools;28.0.1" \
    "build-tools;28.0.0" \
    "build-tools;27.0.3" \
    "build-tools;27.0.2" \
    "build-tools;27.0.1" \
    "build-tools;27.0.0" \
    "build-tools;26.0.2" \
    "build-tools;26.0.1" \
    "build-tools;25.0.3"

# CleanUp
RUN apt clean
RUN sdkmanager "platforms;android-29"

CMD ["/bin/bash"]