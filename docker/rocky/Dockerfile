FROM rockylinux:9 AS build

RUN dnf update -y
RUN dnf install -y 'dnf-command(config-manager)'
RUN dnf config-manager --enable crb
RUN dnf install -y gcc-toolset-13 ninja-build cmake
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
RUN ln -sf /opt/rh/gcc-toolset-13/root/usr/bin/gcc /usr/bin/gcc
RUN ln -sf /opt/rh/gcc-toolset-13/root/usr/bin/g++ /usr/bin/g++

WORKDIR /skeleton
ENV PATH=~/.local/bin:$PATH
COPY . .
RUN BUILD_TYPE=release make setup
RUN make test

FROM rockylinux:9

ARG APP_DIR=/release
ENV APP_USER=appuser
RUN groupadd $APP_USER && useradd -g $APP_USER $APP_USER && mkdir -p ${APP_DIR} && chown -R $APP_USER:$APP_USER ${APP_DIR}
USER $APP_USER

WORKDIR ${APP_DIR}
COPY --from=build --chown=$APP_USER:$APP_USER /skeleton/build/example .

CMD ["./example"]
