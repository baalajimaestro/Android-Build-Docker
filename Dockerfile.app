FROM fedora:latest

RUN dnf -y groupinstall "Development Tools" > /dev/null ; dnf clean all

# Install java (OpenJDK)
RUN dnf -y install java-11-openjdk maven > /dev/null ; dnf clean all

# Install 32bit Libraries
RUN dnf -y upgrade libstdc++ > /dev/null ; dnf clean all
RUN dnf -y install glibc.i686 libstdc++.i686 glibc-devel.i686 zlib-devel.i686 ncurses-devel.i686 libX11-devel.i686 libXrender.i686 > /dev/null ; dnf clean all

# Download Android SDK
ENV LD_LIBRARY_PATH=${ANDROID_HOME}/tools/lib64:${ANDROID_HOME}/emulator/lib64:${ANDROID_HOME}/emulator/lib64/qt/lib
ENV ANDROID_HOME=/opt/android-sdk-linux

RUN cd /opt \
    && curl -sL https://dl.google.com/android/repository/commandlinetools-linux-6200805_latest.zip -o android-sdk-tools.zip \
    && unzip -q android-sdk-tools.zip -d ${ANDROID_HOME} \
    && rm android-sdk-tools.zip

ENV PATH=${ANDROID_HOME}/emulator:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}

# Install Android SDK
RUN mkdir ~/.android && echo "### User Sources for Android SDK Manager" > ~/.android/repositories.cfg
RUN yes | sdkmanager --sdk_root=${ANDROID_HOME} --licenses > /dev/null
RUN yes | sdkmanager --sdk_root=${ANDROID_HOME} --update > /dev/null
RUN sdkmanager --sdk_root=${ANDROID_HOME} "emulator" "tools" "platform-tools" > /dev/null
RUN yes | sdkmanager --sdk_root=${ANDROID_HOME} \
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
    "build-tools;25.0.3" > /dev/null
    
RUN sdkmanager --sdk_root=${ANDROID_HOME} "platforms;android-29" > /dev/null

CMD ["/bin/bash"]
