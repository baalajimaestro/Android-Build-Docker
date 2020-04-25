#
# Copyright © 2019 Maestro Creativescape
#
# SPDX-License-Identifier: GPL-3.0
#
# My Personal AOSP BuildBot
# 
FROM baalajimaestro/android_build

RUN zypper -n install libQt5WebKit5 maven gradle &> /dev/null

ENV ANDROID_HOME /opt/android-sdk-linux    
ENV PATH=${ANDROID_HOME}/emulator:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}

RUN cd /opt \
    && curl https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip -o android-sdk-tools.zip \
    && unzip -q android-sdk-tools.zip -d ${ANDROID_HOME} \
    && rm android-sdk-tools.zip

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
    "build-tools;25.0.3" &> /dev/null

RUN sdkmanager "platforms;android-29"

CMD ["/bin/bash"]
