FROM quay.io/feedyard/circleci-remote-docker:5.3.1

LABEL maintainer=<nic.cheneweth@thoughtworks.com>

ENV CIRCLECI_VERSION=0.1.5830
ENV CIRCLECI_SHA256SUM=40f0d5f4ee725d83864dc253c4fd17a34295e077e80d622a7e5253bfaf94612c

ENV INVOKE_VERSION=1.3.0
ENV YAMLLINT_VERSION=1.17.0

RUN apk add --no-cache \
        python3=3.7.3-r0 \
        curl=7.65.1-r0 && \
    curl -L https://github.com/CircleCI-Public/circleci-cli/releases/download/v${CIRCLECI_VERSION}/circleci-cli_${CIRCLECI_VERSION}_linux_amd64.tar.gz --output circleci-cli_${CIRCLECI_VERSION}_linux_amd64.tar.gz && \
    echo "${CIRCLECI_SHA256SUM}  circleci-cli_${CIRCLECI_VERSION}_linux_amd64.tar.gz" > circleci-cli_${CIRCLECI_SHA256SUM}_SHA256SUMS && \
    sha256sum -cs circleci-cli_${CIRCLECI_SHA256SUM}_SHA256SUMS && \
    tar vzxf circleci-cli_${CIRCLECI_VERSION}_linux_amd64.tar.gz --strip 1 --directory /usr/local/bin && \
    rm -f circleci-cli_${CIRCLECI_VERSION}_linux_amd64.tar.gz && rm -f circleci-cli_${CIRCLECI_SHA256SUM}_SHA256SUMS && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip==19.2.3 && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    rm -r /root/.cache && \
    pip install \
        setuptools==41.2.0 \
        invoke==${INVOKE_VERSION} \
        yamllint==${YAMLLINT_VERSION}

HEALTHCHECK NONE
