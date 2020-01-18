#!/bin/bash

if [ -z $JAVA_HOME ]; then
    echo "ERROR: JAVA_HOME is not set! Installer needs Java 1.6 to run"
    exit 1
fi

export TMPDIR=`mktemp -d /tmp/selfextract.XXXXXX`

ARCHIVE=`awk '/^__ARCHIVE_BELOW__/ {print NR + 1; exit 0; }' $0`

echo Extract temp files into $TMPDIR ...
UNAME=`uname`
if [ "$UNAME" == "SunOS" ]; then
    SCRIPT_DIR=`dirname $0`
    SCRIPT_DIR=`cd $SCRIPT_DIR; pwd`
    SCRIPT_ABS_PATH=$SCRIPT_DIR/`basename $0`
    CDIR=`pwd`

    cd $TMPDIR

    tail +$ARCHIVE $SCRIPT_ABS_PATH | gzip -dc | tar xf -
    mkdir ./csc-integral-cas-server
    # Use GNU tar to handle long paths
    chmod +x ./tar
    ./tar xf ./csc-integral-cas-server.tar -C ./csc-integral-cas-server

    cd $CDIR
else
    tail -n+$ARCHIVE $0 | tar xz -C $TMPDIR
    mkdir $TMPDIR/csc-integral-cas-server
    tar xf $TMPDIR/csc-integral-cas-server.tar -C $TMPDIR/csc-integral-cas-server
fi

echo Start installation ...
CDIR=`pwd`
cd $TMPDIR
chmod +x ./install.sh
./install.sh

cd $CDIR
rm -rf $TMPDIR

exit 0

__ARCHIVE_BELOW__
