# Dockerfile Repo for Android and Kernel Builders

- The AOSP Image contains all the dependencies prebuilt for building AOSP ROM.
- The Kernel Image is an exclusive kernel builder with cross-compile toolchains and Clang 11 inbuilt. Its a bit big on size due to the toolchains being prebuilt
- The AOSP BuildBot, maybe regarded as a sample dockerfile on how to use the AOSP Image.
- The provided sample, needs a bind mount to access actual source.
- That image can be run with this command: 
    `docker run -it --name android-builder --hostname maestrobox -v /home/baalajimaestro/buildsystem/pa:/android -v /home/baalajimaestro/.ccache:/tmp/ccache --rm baalajimaestro/aosp_buildbot`


All these images are updated weekly under a cron on [Travis-CI](https://travis-ci.com/baalajimaestro/Android-Build-Docker) to maintain the latest dependencies.


If you happen to encounter any missing dependencies, please open an issue, or ping me on [telegram](https://t.me/baalajimaestro)

You may use these images stored at the docker hub.

- [AOSP Image](https://hub.docker.com/r/baalajimaestro/android_build)
- [Kernel Image](https://hub.docker.com/r/baalajimaestro/kernel_build)
- [AOSP BuildBot](https://hub.docker.com/r/baalajimaestro/aosp_buildbot)