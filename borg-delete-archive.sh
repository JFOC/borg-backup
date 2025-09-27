#!/usr/bin/env bash

# get current directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# load values from .env
set -o allexport
eval $(cat ${DIR}'/.env' | sed -e '/^#/d;/^\s*$/d' -e 's/\(\w*\)[ \t]*=[ \t]*\(.*\)/\1=\2/' -e "s/=['\"]\(.*\)['\"]/=\1/g" -e "s/'/'\\\''/g" -e "s/=\(.*\)/='\1'/g")
set +o allexport

# Setting this, so the repo does not need to be given on the commandline:
export BORG_RSH=${ENV_BORG_RSH}
export BORG_REPO=${ENV_BORG_REPO}
# See the section "Passphrase notes" for more infos.
export BORG_PASSPHRASE=${ENV_BORG_PASSPHRASE}
export BORG_RESTORE_MOUNT=${ENV_BORG_RESTORE_MOUNT}
LOG=${ENV_BORG_LOG_DIRECTORY}${ENV_BORG_LOG_FILE}

/usr/local/bin/borg delete --list ${BORG_REPO} -a $@
