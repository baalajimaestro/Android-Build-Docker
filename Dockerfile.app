FROM fedora:latest

RUN dnf -y groupinstall "Development Tools"; dnf clean all

# Install java (OpenJDK)
RUN dnf -y install java-1.8.0-openjdk maven; dnf clean all

# Install 32bit Libraries
RUN dnf -y upgrade libstdc++; dnf clean all
RUN dnf -y install glibc.i686 libstdc++.i686 glibc-devel.i686 zlib-devel.i686 ncurses-devel.i686 libX11-devel.i686 libXrender.i686; dnf clean all

# Download Android SDK
ENV LD_LIBRARY_PATH=${ANDROID_HOME}/tools/lib64:${ANDROID_HOME}/emulator/lib64:${ANDROID_HOME}/emulator/lib64/qt/lib
ENV ANDROID_HOME /opt/android-sdk-linux

RUN cd /opt \
    && curl -sL https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -o android-sdk-tools.zip \
    && unzip -q android-sdk-tools.zip -d ${ANDROID_HOME} \
    && rm android-sdk-tools.zip
ENV PATH=${ANDROID_HOME}/emulator:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:/opt/maven/bin:/opt/gradle/bin:${PATH}

# Install Android SDK
RUN mkdir ~/.android && echo "### User Sources for Android SDK Manager" > ~/.android/repositories.cfg
RUN yes | sdkmanager --licenses &> /dev/null && yes | sdkmanager --update &> /dev/null
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
