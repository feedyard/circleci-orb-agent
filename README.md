# feedyard/circleci-orb-agent [![CircleCI](https://circleci.com/gh/feedyard/circleci-orb-agent.svg?style=svg)](https://circleci.com/gh/feedyard/circleci-orb-agent) [![Docker Repository on Quay](https://quay.io/repository/feedyard/circleci-orb-agent/status "Docker Repository on Quay")](https://quay.io/repository/feedyard/circleci-orb-agent) [![GitHub license](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/feedyard/circleci-orb-agent/master/LICENSE) [![Base Image](https://img.shields.io/badge/FROM-alpine-blue.svg)](https://alpinelinux.org)

Based on [feedyard/circleci-remote-docker](https://github.com/feedyard/circleci-remote-docker). Includes the circleci cli
and common tools for building circleci orbs.

_additions_

apk/bin      | pip
-------------|----------
python3      | invoke
curl         | yamllint
circleci-cli |

See CHANGELOG for list of installed packages/versions.
