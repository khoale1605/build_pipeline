#!/bin/bash

set -e

CAS_VER=@CAS_VER@

function inputInstallDir()
{
    DEFAULT_INST_DIR=/usr/local/integral/csc-integral-cas-server-$CAS_VER

    echo -e "Installation directory [$DEFAULT_INST_DIR]: \c"
    read INST_DIR

    # Use default location if installation dir is not provided
    if [ -z $INST_DIR ]; then
        INST_DIR=$DEFAULT_INST_DIR
    fi

    # Installation dir must not exist
    if [ -e $INST_DIR ]; then
        echo ERROR: \"$INST_DIR\" already exists, remove it first
        exit 1
    fi
}

function inputOldInstallDir()
{
    echo -e "Old installation directory: \c"
    read OLD_INST_DIR

    if [ ! -d $OLD_INST_DIR ]; then
        echo ERROR: \"$OLD_INST_DIR\" does not exist or is not a directory
        exit 1
    fi
}

function extract()
{
    # Create installation dir
    echo Create \"$INST_DIR\" ...
    mkdir -p $INST_DIR
    if [ $? -gt 0 ]; then
        echo ERROR: cannot create $INST_DIR
    exit 1
    fi

    echo "Extract Tomcat Native Library ..."
    cd ./csc-integral-cas-server/bin
    mkdir libtcnative-1.1.20-el5-x86_64
    mv ./libtcnative-1.1.20-el5-x86_64.tar.gz ./libtcnative-1.1.20-el5-x86_64/
    cd ./libtcnative-1.1.20-el5-x86_64
    gzip -dc ./libtcnative-1.1.20-el5-x86_64.tar.gz | tar xf -
    rm -rf ./libtcnative-1.1.20-el5-x86_64.tar.gz
    cd ..

    mkdir libtcnative-1.1.20-solaris-sparc
    mv ./libtcnative-1.1.20-solaris-sparc.tar.gz ./libtcnative-1.1.20-solaris-sparc
    cd ./libtcnative-1.1.20-solaris-sparc
    gzip -dc ./libtcnative-1.1.20-solaris-sparc.tar.gz | tar xf -
    rm -rf ./libtcnative-1.1.20-solaris-sparc.tar.gz
    cd ..

    cd ../..

    cp -R ./csc-integral-cas-server/* $INST_DIR/
    chmod 775 $INST_DIR/bin/*.sh
}

clear
echo "---------------------------------------------"
echo "Integral CAS $CAS_VER Installation"
echo "---------------------------------------------"
echo
echo "Choose installation mode:"
echo
echo "[1] New"
echo "[2] Upgrade"
echo
echo -e "Enter choice: \c"
read CHOICE
echo

case "$CHOICE" in

    1)
        inputInstallDir
        extract
        ;;

    2)
        inputInstallDir
        inputOldInstallDir
        extract

        $JAVA_HOME/bin/java -jar ./csc-integral-installer.jar $OLD_INST_DIR $INST_DIR CAS
        ;;

    *)
        echo "ERROR: wrong input"
        exit 1
        ;;

esac

echo "Installation is successfully completed!"

exit 0
