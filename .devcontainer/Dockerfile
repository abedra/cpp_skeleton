FROM ubuntu:24.04

RUN apt-get update -yy
RUN apt-get install -yy \
    curl \
    software-properties-common \
    ca-certificates \
    perl \
    git \
    ninja-build
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
RUN add-apt-repository ppa:ubuntu-toolchain-r/test -yy
RUN apt-get update -yy
RUN apt-get install cmake gcc-13 g++-13 -yy
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-13 13 --slave /usr/bin/g++ g++ /usr/bin/g++-13

WORKDIR /skeleton
ENV PATH=~/.local/bin:$PATH
COPY . .
RUN BUILD_TYPE=debug make setup
# RUN make test
