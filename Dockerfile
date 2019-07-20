FROM debian:buster-slim

COPY ./build.sh .
RUN bash build.sh

CMD ["bash"]
