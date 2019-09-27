#!/bin/bash
sudo add-apt-repository -y ppa:pipelight/daily
sudo apt-get -qy update
sudo apt-get install -y wine-staging winbind xvfb cabextract

WINETRICKS=https://raw.githubusercontent.com/Winetricks/winetricks/3fd9a36d9fb973ccf334413937e4d71aa5401311/src/winetricks

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
        VERSIONSHORT=35
        cat <<EOF > install_list.txt
        https://www.python.org/ftp/python/$VERSION/amd64/core.msi
        https://www.python.org/ftp/python/$VERSION/amd64/dev.msi
        https://www.python.org/ftp/python/$VERSION/amd64/lib.msi
        https://www.python.org/ftp/python/$VERSION/amd64/exe.msi
        https://www.python.org/ftp/python/$VERSION/amd64/tools.msi
        https://www.python.org/ftp/python/$VERSION/amd64/pip.msi
EOF
        cat install_list.txt
        INSTALLER_URL="-i install_list.txt"
        INSTALL_COMMAND="wget $WINETRICKS;chmod +x winetricks;Xvfb :1& export DISPLAY=:1;./winetricks nocrashdialog -q vcrun2015;pkill Xvfb;export DISPLAY=;wine msiexec /i core.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i dev.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i lib.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i exe.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i tools.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i pip.msi TARGETDIR=C:\Python$VERSIONSHORT;"
        CLEAN_COMMAND=""
        EXECDIR="$HOME/.wine/drive_c/Python35"
        MORE_COMMANDS= # Needs VC++ 10.0
        ;;
    py35)
        VERSION=3.5.1
        VERSIONSHORT=35
        cat <<EOF > install_list.txt
        https://www.python.org/ftp/python/$VERSION/win32/core.msi
        https://www.python.org/ftp/python/$VERSION/win32/dev.msi
        https://www.python.org/ftp/python/$VERSION/win32/lib.msi
        https://www.python.org/ftp/python/$VERSION/win32/exe.msi
        https://www.python.org/ftp/python/$VERSION/win32/tools.msi
        https://www.python.org/ftp/python/$VERSION/win32/pip.msi
EOF
        cat install_list.txt
        INSTALLER_URL="-i install_list.txt"
        INSTALL_COMMAND="wget $WINETRICKS;chmod +x winetricks;Xvfb :1& export DISPLAY=:1;./winetricks nocrashdialog -q vcrun2015;pkill Xvfb;export DISPLAY=;wine msiexec /i core.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i dev.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i lib.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i exe.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i tools.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i pip.msi TARGETDIR=C:\Python$VERSIONSHORT;"
        CLEAN_COMMAND=""
        EXECDIR="$HOME/.wine/drive_c/Python35"
        MORE_COMMANDS= # Needs VC++ 10.0
        ;;

    py36_64)
        VERSION=3.6.1
        VERSIONSHORT=36
        cat <<EOF > install_list.txt
        https://www.python.org/ftp/python/$VERSION/amd64/core.msi
        https://www.python.org/ftp/python/$VERSION/amd64/dev.msi
        https://www.python.org/ftp/python/$VERSION/amd64/lib.msi
        https://www.python.org/ftp/python/$VERSION/amd64/exe.msi
        https://www.python.org/ftp/python/$VERSION/amd64/tools.msi
        https://www.python.org/ftp/python/$VERSION/amd64/pip.msi
EOF
        cat install_list.txt
        INSTALLER_URL="-i install_list.txt"
        INSTALL_COMMAND="wget $WINETRICKS;chmod +x winetricks;Xvfb :1& export DISPLAY=:1;./winetricks nocrashdialog -q vcrun2015;pkill Xvfb;export DISPLAY=;wine msiexec /i core.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i dev.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i lib.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i exe.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i tools.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i pip.msi TARGETDIR=C:\Python$VERSIONSHORT;"
        CLEAN_COMMAND=""
        EXECDIR="$HOME/.wine/drive_c/Python36"
        MORE_COMMANDS= # Needs VC++ 10.0
        ;;
    py36)
        VERSION=3.6.1
        VERSIONSHORT=36
        cat <<EOF > install_list.txt
        https://www.python.org/ftp/python/$VERSION/win32/core.msi
        https://www.python.org/ftp/python/$VERSION/win32/dev.msi
        https://www.python.org/ftp/python/$VERSION/win32/lib.msi
        https://www.python.org/ftp/python/$VERSION/win32/exe.msi
        https://www.python.org/ftp/python/$VERSION/win32/tools.msi
        https://www.python.org/ftp/python/$VERSION/win32/pip.msi
EOF
        cat install_list.txt
        INSTALLER_URL="-i install_list.txt"
        INSTALL_COMMAND="wget $WINETRICKS;chmod +x winetricks;Xvfb :1& export DISPLAY=:1;./winetricks nocrashdialog -q vcrun2015;pkill Xvfb;export DISPLAY=;wine msiexec /i core.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i dev.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i lib.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i exe.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i tools.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i pip.msi TARGETDIR=C:\Python$VERSIONSHORT;"
        CLEAN_COMMAND=""
        EXECDIR="$HOME/.wine/drive_c/Python36"
        MORE_COMMANDS= # Needs VC++ 10.0
        ;;


    py37_64)
        VERSION=3.7.0
        VERSIONSHORT=37
        cat <<EOF > install_list.txt
        https://www.python.org/ftp/python/$VERSION/amd64/core.msi
        https://www.python.org/ftp/python/$VERSION/amd64/dev.msi
        https://www.python.org/ftp/python/$VERSION/amd64/lib.msi
        https://www.python.org/ftp/python/$VERSION/amd64/exe.msi
        https://www.python.org/ftp/python/$VERSION/amd64/tools.msi
        https://www.python.org/ftp/python/$VERSION/amd64/pip.msi
EOF
        cat install_list.txt
        INSTALLER_URL="-i install_list.txt"
        INSTALL_COMMAND="wget $WINETRICKS;chmod +x winetricks;Xvfb :1& export DISPLAY=:1;./winetricks nocrashdialog -q vcrun2015;pkill Xvfb;export DISPLAY=;wine msiexec /i core.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i dev.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i lib.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i exe.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i tools.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i pip.msi TARGETDIR=C:\Python$VERSIONSHORT;"
        CLEAN_COMMAND=""
        EXECDIR="$HOME/.wine/drive_c/Python37"
        MORE_COMMANDS= # Needs VC++ 10.0
        ;;
    py37)
        VERSION=3.7.0
        VERSIONSHORT=37
        cat <<EOF > install_list.txt
        https://www.python.org/ftp/python/$VERSION/win32/core.msi
        https://www.python.org/ftp/python/$VERSION/win32/dev.msi
        https://www.python.org/ftp/python/$VERSION/win32/lib.msi
        https://www.python.org/ftp/python/$VERSION/win32/exe.msi
        https://www.python.org/ftp/python/$VERSION/win32/tools.msi
        https://www.python.org/ftp/python/$VERSION/win32/pip.msi
EOF
        cat install_list.txt
        INSTALLER_URL="-i install_list.txt"
        INSTALL_COMMAND="wget $WINETRICKS;chmod +x winetricks;Xvfb :1& export DISPLAY=:1;./winetricks nocrashdialog -q vcrun2015;pkill Xvfb;export DISPLAY=;wine msiexec /i core.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i dev.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i lib.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i exe.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i tools.msi TARGETDIR=C:\Python$VERSIONSHORT;wine msiexec /i pip.msi TARGETDIR=C:\Python$VERSIONSHORT;"
        CLEAN_COMMAND=""
        EXECDIR="$HOME/.wine/drive_c/Python37"
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

#export WINEARCH=win32
wine wineboot

# Needed  for the vcrun2015 installer

#wget http://www.orbitals.com/programs/py.exe
wget $INSTALLER_URL
eval $INSTALL_COMMAND
sleep 60;
eval $CLEAN_COMMAND

ls -al /home/travis/.wine/drive_c/

sed -i 's/_windows_cert_stores = .*/_windows_cert_stores = ("ROOT",)/' "$EXECDIR/Lib/ssl.py"

eval $MORE_COMMANDS

echo "/opt/wine-staging/bin/wine $PYTHON" '$@' > _python
echo "/opt/wine-staging/bin/wine $EASY_INSTALL" '$@' > _easy_install
echo "/opt/wine-staging/bin/wine $PIP" '$@' > _pip
chmod +x _python _easy_install _pip

wget https://bootstrap.pypa.io/ez_setup.py -O - | sed "s/DEFAULT_VERSION = .*/DEFAULT_VERSION = '24.3.0'/g" | ./_python
./_easy_install pip
