FROM quay.io/feedyard/circleci-remote-docker:4.1.2

LABEL maintainer=<nic.cheneweth@thoughtworks.com>

ENV CIRCLECI_VERSION=0.1.4180
ENV CIRCLECI_SHA256SUM=03ea89ce5c6060baa27f216a94a35b785355cdbdc072631c7d9fbc7eb4cb3814
ENV CIRCLECI_DESTDIR=/usr/local/bin

ENV INVOKE_VERSION=1.2.0
ENV PYTEST_VERSION=4.0.1

# packages for test and publish of orbs
RUN apk add --no-cache \
    curl \
    python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    rm -r /root/.cache && \
    curl -L https://github.com/CircleCI-Public/circleci-cli/releases/download/v${CIRCLECI_VERSION}/circleci-cli_${CIRCLECI_VERSION}_linux_amd64.tar.gz --output circleci-cli_${CIRCLECI_VERSION}_linux_amd64.tar.gz && \
    echo "${CIRCLECI_SHA256SUM}  circleci-cli_${CIRCLECI_VERSION}_linux_amd64.tar.gz" > circleci-cli_${CIRCLECI_SHA256SUM}_SHA256SUMS && \
    sha256sum -cs circleci-cli_${CIRCLECI_SHA256SUM}_SHA256SUMS && \
    tar vzxf circleci-cli_${CIRCLECI_VERSION}_linux_amd64.tar.gz --strip 1 --directory ${CIRCLECI_DESTDIR} && \
    rm -f circleci-cli_${CIRCLECI_VERSION}_linux_amd64.tar.gz && rm -f circleci-cli_${CIRCLECI_SHA256SUM}_SHA256SUMS

RUN pip install pytest==${PYTEST_VERSION} invoke==${INVOKE_VERSION}

HEALTHCHECK NONE
