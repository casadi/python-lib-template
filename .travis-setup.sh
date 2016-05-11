#!/bin/bash
sudo add-apt-repository -y ppa:pipelight/daily
sudo apt-get -qy update
sudo apt-get install -y wine-staging winbind

case "$WINEENV" in
    py26)
        VERSION=2.6.6
        INSTALLER_URL="https://www.python.org/ftp/python/$VERSION/python-$VERSION.msi"
        INSTALL_COMMAND="wine msiexec /i python-$VERSION.msi"
        CLEAN_COMMAND="del /f python-$VERSION.msi"
        EXECDIR="$HOME/.wine/drive_c/Python26"
        MORE_COMMANDS= # Crash: https://travis-ci.org/WineAsCI/python-lib-template/jobs/49725679#L1789
        ;;
    py27)
        VERSION=2.7.9
        INSTALLER_URL="https://www.python.org/ftp/python/$VERSION/python-$VERSION.msi"
        INSTALL_COMMAND="wine msiexec /i python-$VERSION.msi"
        CLEAN_COMMAND="del /f python-$VERSION.msi"
        EXECDIR="$HOME/.wine/drive_c/Python27"
        MORE_COMMANDS='wget http://download.microsoft.com/download/7/9/6/796EF2E4-801B-4FC4-AB28-B59FBF6D907B/VCForPython27.msi; wine msiexec /i VCForPython27.msi'
        ;;
    py27_64)
        VERSION=2.7.10
        INSTALLER_URL="https://www.python.org/ftp/python/$VERSION/python-$VERSION.amd64.msi"
        INSTALL_COMMAND="wine msiexec /i python-$VERSION.amd64.msi"
        CLEAN_COMMAND="del /f python-$VERSION.amd64.msi"
        EXECDIR="$HOME/.wine/drive_c/Python27"
        MORE_COMMANDS='wget http://download.microsoft.com/download/7/9/6/796EF2E4-801B-4FC4-AB28-B59FBF6D907B/VCForPython27.msi; wine msiexec /i VCForPython27.msi'
        ;;
    py33)
        VERSION=3.3.5
        INSTALLER_URL="https://www.python.org/ftp/python/$VERSION/python-$VERSION.msi"
        INSTALL_COMMAND="wine msiexec /i python-$VERSION.msi"
        CLEAN_COMMAND="del /f python-$VERSION.msi"
        EXECDIR="$HOME/.wine/drive_c/Python33"
        MORE_COMMANDS= # Needs VC++ 10.0
        ;;
    py34_64)
        VERSION=3.4.4
        INSTALLER_URL="https://www.python.org/ftp/python/$VERSION/python-$VERSION.amd64.msi"
        INSTALL_COMMAND="wine msiexec /i python-$VERSION.amd64.msi"
        CLEAN_COMMAND="del /f python-$VERSION.amd64.msi"
        EXECDIR="$HOME/.wine/drive_c/Python34"
        MORE_COMMANDS= # Needs VC++ 10.0
        ;;
    py34)
        VERSION=3.4.4
        INSTALLER_URL="https://www.python.org/ftp/python/$VERSION/python-$VERSION.msi"
        INSTALL_COMMAND="wine msiexec /i python-$VERSION.msi"
        CLEAN_COMMAND="del /f python-$VERSION.msi"
        EXECDIR="$HOME/.wine/drive_c/Python34"
        MORE_COMMANDS= # Needs VC++ 10.0
        ;;
    py35_64)
        VERSION=3.5.1
        INSTALLER_URL="https://www.python.org/ftp/python/$VERSION/python-$VERSION-amd64.exe"
        INSTALL_COMMAND="wine python-$VERSION-amd64.exe /quiet DefaultAllUsersTargetDir=C:\Python35 InstallAllUsers=1 PrependPath=1 Include_test=0"
        CLEAN_COMMAND="del /f python-$VERSION-amd64.exe"
        EXECDIR="$HOME/.wine/drive_c/Python35"
        MORE_COMMANDS= # Needs VC++ 10.0
        ;;
    py35)
        VERSION=3.5.1
        INSTALLER_URL="https://www.python.org/ftp/python/$VERSION/python-$VERSION.exe"
        INSTALL_COMMAND="wine python-$VERSION.exe /quiet DefaultAllUsersTargetDir=C:\Python35 InstallAllUsers=1 PrependPath=1 Include_test=0"
        CLEAN_COMMAND="del /f python-$VERSION.exe"
        EXECDIR="$HOME/.wine/drive_c/Python35"
        MORE_COMMANDS= # Needs VC++ 10.0
        ;;
        
    pypy)
        VERSION=2.5.0
        INSTALLER_URL="https://bitbucket.org/pypy/pypy/downloads/pypy-$VERSION-win32.zip"
        INSTALL_COMMAND="unzip pypy-$VERSION-win32.zip"
        CLEAN_COMMAND="del /f pypy-$VERSION-win32.zip"
        EXECDIR="$PWD/pypy-$VERSION-win32"
        PYTHON="$EXECDIR/pypy.exe"
        PIP="$EXECDIR/bin/pip.exe"
        EASY_INSTALL="$EXECDIR/bin/easy_install.exe"
        ;;
    *)
        echo "WINEENV $WINEENV not supported."
        exit 1
esac

[[ -z "$PYTHON" ]] && PYTHON="$EXECDIR/python.exe"
[[ -z "$EASY_INSTALL" ]] && EASY_INSTALL="$EXECDIR/Scripts/easy_install.exe"
[[ -z "$PIP" ]] && PIP="$EXECDIR/Scripts/pip.exe"

export PATH="/opt/wine-staging/bin:$PATH"

WINEARCH=wineboot

wget http://winetricks.org/winetricks
chmod +x winetricks
./winetricks nocrashdialog

#wget http://www.orbitals.com/programs/py.exe
wget $INSTALLER_URL
eval $INSTALL_COMMAND
eval $CLEAN_COMMAND

ls -al /home/travis/.wine/drive_c/

sed -i 's/_windows_cert_stores = .*/_windows_cert_stores = ("ROOT",)/' "$EXECDIR/Lib/ssl.py"

eval $MORE_COMMANDS

echo "/opt/wine-staging/bin/wine $PYTHON" '$@' > _python
echo "/opt/wine-staging/bin/wine $EASY_INSTALL" '$@' > _easy_install
echo "/opt/wine-staging/bin/wine $PIP" '$@' > _pip
chmod +x _python _easy_install _pip

wget https://bootstrap.pypa.io/ez_setup.py -O - | ./_python
./_easy_install pip
