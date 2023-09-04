FROM ubuntu:22.04 as build

RUN apt-get update -yy
RUN DEBIAN_FRONTEND=noninteractive apt-get install -yy \
    python3-pip \
    wget \
    software-properties-common \
    ca-certificates \
    gpg
RUN add-apt-repository ppa:ubuntu-toolchain-r/test -yy
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | tee /usr/share/keyrings/kitware-archive-keyring.gpg >/dev/null
RUN echo 'deb [signed-by=/usr/share/keyrings/kitware-archive-keyring.gpg] https://apt.kitware.com/ubuntu/ jammy main' | tee /etc/apt/sources.list.d/kitware.list >/dev/null
RUN apt-get update -yy
RUN apt-get install cmake gcc-13 g++-13 -yy
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-13 13 --slave /usr/bin/g++ g++ /usr/bin/g++-13
RUN pip install "conan<2.0" pytest && conan --version
RUN conan profile new default --detect

WORKDIR /build
COPY . .

WORKDIR /build/build
RUN conan install .. --build=missing

WORKDIR /build
RUN cmake -B build -H.
RUN cmake --build build
RUN build/bin/tests

FROM ubuntu:22.04 as production

RUN apt-get update -yy
RUN apt-get install software-properties-common -yy
RUN add-apt-repository ppa:ubuntu-toolchain-r/test -yy
RUN apt-get update -yy
RUN apt-get install libstdc++6 -yy

ARG APP_DIR=/release
ENV APP_USER=appuser
RUN groupadd $APP_USER && useradd -g $APP_USER $APP_USER && mkdir -p ${APP_DIR} && chown -R $APP_USER:$APP_USER ${APP_DIR}
USER $APP_USER

WORKDIR ${APP_DIR}
COPY --from=build --chown=$APP_USER:$APP_USER /build/build/bin/cpp_skeleton .

CMD ["./cpp_skeleton"]