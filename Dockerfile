FROM quay.io/feedyard/circleci-remote-docker:5.0.3

LABEL maintainer=<nic.cheneweth@thoughtworks.com>

ENV CIRCLECI_VERSION=0.1.5607
ENV CIRCLECI_SHA256SUM=125e711d4e834254fca04a381530ce2f2d7e337e4f4710cd8a4a3283c19a7b9b

ENV INVOKE_VERSION=1.2.0
ENV YAMLLINT_VERSION=1.15.0

RUN apk add --no-cache \
    curl=7.64.0-r1 && \
    curl -L https://github.com/CircleCI-Public/circleci-cli/releases/download/v${CIRCLECI_VERSION}/circleci-cli_${CIRCLECI_VERSION}_linux_amd64.tar.gz --output circleci-cli_${CIRCLECI_VERSION}_linux_amd64.tar.gz && \
    echo "${CIRCLECI_SHA256SUM}  circleci-cli_${CIRCLECI_VERSION}_linux_amd64.tar.gz" > circleci-cli_${CIRCLECI_SHA256SUM}_SHA256SUMS && \
    sha256sum -cs circleci-cli_${CIRCLECI_SHA256SUM}_SHA256SUMS && \
    tar vzxf circleci-cli_${CIRCLECI_VERSION}_linux_amd64.tar.gz --strip 1 --directory /usr/local/bin && \
    rm -f circleci-cli_${CIRCLECI_VERSION}_linux_amd64.tar.gz && rm -f circleci-cli_${CIRCLECI_SHA256SUM}_SHA256SUMS

RUN apk add --no-cache \
    python3=3.6.8-r2 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip==19.1.1 setuptools==41.0.1 && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    rm -r /root/.cache

RUN pip install \
    invoke==${INVOKE_VERSION} \
    yamllint==${YAMLLINT_VERSION}

HEALTHCHECK NONE
