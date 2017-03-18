#!/bin/bash

echo $TRAVIS_OS_NAME
if [ $TRAVIS_OS_NAME == "osx" ]; then
  echo 'Installing Unity on macOS'
  # Release details as of 2/24/17: http://download.unity3d.com/download_unity/3829d7f588f3/unity-5.5.2f1-osx.ini
  # Thanks to vergenzt for find this info. Writeup here: https://github.com/JonathanPorta/ci-build/pull/3#issue-132893904
  # More manual install details at https://docs.unity3d.com/Manual/InstallingUnity.html
  BASE_URL=http://netstorage.unity3d.com/unity
  HASH=3829d7f588f3
  VERSION=5.5.2f1

  download() {
    file=$1
    url="$BASE_URL/$HASH/$package"

    echo "Downloading from $url: "
    curl -o `basename "$package"` "$url"
  }

  install() {
    package=$1
    download "$package"

    echo "Installing "`basename "$package"`
    sudo installer -dumplog -package `basename "$package"` -target /
  }

  # See $BASE_URL/$HASH/unity-$VERSION-$PLATFORM.ini for complete list
  # of available packages, where PLATFORM is `osx` or `win`

  install "MacEditorInstaller/Unity-$VERSION.pkg"
  install "MacEditorTargetInstaller/UnitySetup-Windows-Support-for-Editor-$VERSION.pkg"
  install "MacEditorTargetInstaller/UnitySetup-Linux-Support-for-Editor-$VERSION.pkg"
elif [ $TRAVIS_OS_NAME == "osx" ]; then
  # latest Linux Unity details can be found at https://forum.unity3d.com/threads/unity-on-linux-release-notes-and-known-issues.350256/
  echo 'Installing Unity on Linux'
  curl -o unity.deb http://beta.unity3d.com/download/e06241adb51f/unity-editor_amd64-5.5.2xf1Linux.deb
  # from http://askubuntu.com/a/841240/310789
  sudo dpkg -i unity.deb
  sudo apt-get install -f
  sudo dpkg -i unity.deb
  #curl -o `basename install-linux.sh` http://beta.unity3d.com/download/e06241adb51f/unity-editor-installer-5.5.2xf1Linux.sh
  #./install-linux.sh
elif [ $TRAVIS_OS_NAME == "osx" ]; then
  echo 'Installing Unity on Windows'
else
  echo 'Unsupported OS'
  exit -1
fi
