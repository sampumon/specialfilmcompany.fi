#!/bin/bash

# syncs _site to specialfilmcompany.fi
# usage: ./sync.sh [lftp mirror extra commands]

# 1. requires lftp, which you can find from homebrew: http://brew.sh/
#
# 2. for non-interactiveness, add login info into ~/.netrc:
# machine ftp.specialfilmcompany.fi
# 	login USER
# 	password SECRETPASSWORD
#
# 3. for making it work, add into ~/.lftprc:
# set ssl:verify-certificate no

SITE=ftp.specialfilmcompany.fi

[ -d "_site" ] || {
	echo "can't find _site; are you at jekyll source directory?"
	exit 1
}

# BEGIN SERIOUS ACTION
set -x

# NOTE: no --delete in order to keep extra apache redirects etc.
lftp -e "mirror --reverse --only-newer --verbose=2 $* _site .; exit" $SITE
