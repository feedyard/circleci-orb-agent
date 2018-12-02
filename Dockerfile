FROM quay.io/feedyard/circleci-remote-docker:4.1.2

LABEL maintainer=<nic.cheneweth@thoughtworks.com>

ENV CIRCLECI_VERSION=0.1.4296
ENV CIRCLECI_SHA256SUM=06eaa66ac6b90124fc2fd9d8c9c440cf3e3296bab936cc299bf8df295777193b
ENV CIRCLECI_DESTDIR=/usr/local/bin

ENV INVOKE_VERSION=1.2.0
ENV PYTEST_VERSION=4.0.1
ENV YAMLLINT_VERSION=1.13.0

RUN apk add --no-cache \
    curl && \
    curl -L https://github.com/CircleCI-Public/circleci-cli/releases/download/v${CIRCLECI_VERSION}/circleci-cli_${CIRCLECI_VERSION}_linux_amd64.tar.gz --output circleci-cli_${CIRCLECI_VERSION}_linux_amd64.tar.gz && \
    echo "${CIRCLECI_SHA256SUM}  circleci-cli_${CIRCLECI_VERSION}_linux_amd64.tar.gz" > circleci-cli_${CIRCLECI_SHA256SUM}_SHA256SUMS && \
    sha256sum -cs circleci-cli_${CIRCLECI_SHA256SUM}_SHA256SUMS && \
    tar vzxf circleci-cli_${CIRCLECI_VERSION}_linux_amd64.tar.gz --strip 1 --directory ${CIRCLECI_DESTDIR} && \
    rm -f circleci-cli_${CIRCLECI_VERSION}_linux_amd64.tar.gz && rm -f circleci-cli_${CIRCLECI_SHA256SUM}_SHA256SUMS

RUN apk add --no-cache \
    python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    rm -r /root/.cache

RUN pip3 install invoke==${INVOKE_VERSION} pytest==${PYTEST_VERSION} yamllint==${YAMLLINT_VERSION}

HEALTHCHECK NONE
