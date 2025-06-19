FROM ubuntu:24.04 AS build

RUN apt-get update -yy
RUN apt-get install -yy \
    curl \
    software-properties-common \
    ca-certificates \
    ninja-build
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
RUN add-apt-repository ppa:ubuntu-toolchain-r/test -yy
RUN apt-get update -yy
RUN apt-get install cmake gcc-13 g++-13 -yy
RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-13 13 --slave /usr/bin/g++ g++ /usr/bin/g++-13

WORKDIR /skeleton
ENV PATH=~/.local/bin:$PATH
COPY . .
RUN BUILD_TYPE=release make setup
RUN make test

FROM ubuntu:24.04

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
COPY --from=build --chown=$APP_USER:$APP_USER /skeleton/build/example .

CMD ["./example"]
