#!/bin/sh

VERSION=5.25
XC8_VERSION=2.10
INSTALL_DIR=/opt/microchip/mplabx/v${VERSION}
echo "Installing MPLABX v${VERSION}"

# Install dependencies and helpers
dpkg --add-architecture i386 \
    && apt-get -qq update \
    && apt-get -qq install -y --no-install-recommends \
    wget \
    libc6:i386 \
    libstdc++6:i386 \
    libexpat1:i386

# Download MPLABX installer if required
if [ -f "MPLABX-v${VERSION}-linux-installer.tar" ]; then
    echo "Installer imported from host."
else
    echo "Downloading MPLABX v${VERSION} installer..."
    wget -q http://ww1.microchip.com/downloads/en/DeviceDoc/MPLABX-v${VERSION}-linux-installer.tar
    wget -q http://ww1.microchip.com/downloads/en/DeviceDoc/xc8-v${XC8_VERSION}-full-install-linux-installer.run
fi


# Unpack and install
tar xf MPLABX-v${VERSION}-linux-installer.tar
echo "Installing MPLABX v${VERSION}"
su -c "./MPLABX-v${VERSION}-linux-installer.sh --nolibrarycheck --nox11  -- --ipe 0 --mode unattended --16bitmcu 0 --32bitmcu 0 --othermcu 0 --collectInfo 0"
echo "Installing XC8 v${XC8_VERSION}"
chmod u+x xc8-v${XC8_VERSION}-full-install-linux-installer.run
su -c "./xc8-v${XC8_VERSION}-full-install-linux-installer.run --mode unattended --Add\ to\ PATH 1 --LicenseType FreeMode --netservername $(date | md5sum| cut -c 1-32)"

# strip uneeded packs
echo "Cleaning up..."
apt-get purge -y --auto-remove wget
rm MPLABX-v${VERSION}-linux-installer.*
rm xc8-v${XC8_VERSION}-full-install-linux-installer.run
rm ${INSTALL_DIR}/Uninstall_MPLAB_X_IDE*
rm -rf /opt/microchip/mplabcomm
rm -rf ${INSTALL_DIR}/packs/arm
rm -rf ${INSTALL_DIR}/packs/Microchip/AT*
rm -rf ${INSTALL_DIR}/packs/Microchip/SAM*
rm -rf ${INSTALL_DIR}/packs/Microchip/XMEGA*
rm -rf ${INSTALL_DIR}/mpasmx/examples
find ${INSTALL_DIR} -type d -name docs -prune -exec rm -rf {} \;
find ${INSTALL_DIR} -name *.pdf -exec rm {} \;
find ${INSTALL_DIR} -name *.txt -exec rm {} \;


# Link in microchip included tools
ln -s /opt/microchip/mplabx/v${VERSION}/mplab_platform/bin/make /usr/bin/make
ln -s /opt/microchip/mplabx/v${VERSION}/mplab_platform/bin/hexmate /usr/bin/hexmate
