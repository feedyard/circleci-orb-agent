FROM quay.io/feedyard/circleci-remote-docker:5.2.0

LABEL maintainer=<nic.cheneweth@thoughtworks.com>

ENV CIRCLECI_VERSION=0.1.5652
ENV CIRCLECI_SHA256SUM=a313b8eb0624d96c09492c3505f741c223b0b068a69dc7a15344ff5eeeb18677

ENV INVOKE_VERSION=1.2.0
ENV YAMLLINT_VERSION=1.16.0

RUN apk add --no-cache \
    python3=3.6.8-r2 \
    curl=7.64.0-r2 && \
    curl -L https://github.com/CircleCI-Public/circleci-cli/releases/download/v${CIRCLECI_VERSION}/circleci-cli_${CIRCLECI_VERSION}_linux_amd64.tar.gz --output circleci-cli_${CIRCLECI_VERSION}_linux_amd64.tar.gz && \
    echo "${CIRCLECI_SHA256SUM}  circleci-cli_${CIRCLECI_VERSION}_linux_amd64.tar.gz" > circleci-cli_${CIRCLECI_SHA256SUM}_SHA256SUMS && \
    sha256sum -cs circleci-cli_${CIRCLECI_SHA256SUM}_SHA256SUMS && \
    tar vzxf circleci-cli_${CIRCLECI_VERSION}_linux_amd64.tar.gz --strip 1 --directory /usr/local/bin && \
    rm -f circleci-cli_${CIRCLECI_VERSION}_linux_amd64.tar.gz && rm -f circleci-cli_${CIRCLECI_SHA256SUM}_SHA256SUMS && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip==19.1.1 setuptools==41.0.1 && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    rm -r /root/.cache && \
    pip install \
    invoke==${INVOKE_VERSION} \
    yamllint==${YAMLLINT_VERSION}

HEALTHCHECK NONE
