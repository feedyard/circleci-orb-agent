#!/usr/bin/env bash

echo "We're going to try to install the dependencies for you!"
set -e
[[ $(uname) == "Darwin" ]] || ( echo "installation only works on Mac" && exit 1 )
hash brew &>/dev/null || ( echo "you need to install homebrew manually" && exit 1 )
hash python3 &>/dev/null || brew install python3
[[ -e .env/bin/activate ]] || python3 -m venv .env
( . .env/bin/activate && pip install -r requirements.txt )
echo "python dependencies installed in a virtualenv. run \`. .env/bin/activate\` to use"
hash bundle &>/dev/null || ( echo -e "you somehow have no Ruby, so we're installing latest\n" && brew install ruby )
bundle install || ( echo "your bundle install failed, which means you're running base install Ruby or a pre 2.1 version. You'll need to resolve it yourself if you want to run the tests, but the rest will work fine." && exit 1)