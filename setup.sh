#!/bin/sh

VERSION=5.20
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
fi


# Unpack and install
tar xf MPLABX-v${VERSION}-linux-installer.tar
su -c "./MPLABX-v${VERSION}-linux-installer.sh --nolibrarycheck --nox11  -- --ipe 0 --mode unattended"

# strip uneeded packs
echo "Cleaning up..."
apt-get purge -y --auto-remove wget
rm MPLABX-v${VERSION}-linux-installer.*
rm ${INSTALL_DIR}/Uninstall_MPLAB_X_IDE*
rm -rf /opt/microchip/mplabcomm
rm -rf ${INSTALL_DIR}/packs/arm
rm -rf ${INSTALL_DIR}/packs/Microchip/AT*
rm -rf ${INSTALL_DIR}/packs/Microchip/SAM*
rm -rf ${INSTALL_DIR}/packs/Microchip/XMEGA*
rm -rf ${INSTALL_DIR}/packs/Microchip/PIC24*
rm -rf ${INSTALL_DIR}/packs/Microchip/PIC32*
rm -rf ${INSTALL_DIR}/mpasmx/examples
find ${INSTALL_DIR} -type d -name docs -prune -exec rm -rf {} \;
find ${INSTALL_DIR} -name *.pdf -exec rm {} \;
find ${INSTALL_DIR} -name *.txt -exec rm {} \;


# Link in microchip included tools
ln -s /opt/microchip/mplabx/v${VERSION}/mplab_platform/bin/make /usr/bin/make
ln -s /opt/microchip/mplabx/v${VERSION}/mplab_platform/bin/hexmate /usr/bin/hexmate
