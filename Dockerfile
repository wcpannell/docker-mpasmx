FROM ubuntu:bionic

# TEST use local copy and include some rando projects to test
# ENV VERSION=5.15
# COPY MPLABX-v${VERSION}-linux-installer.tar /MPLABX-v${VERSION}-linux-installer.tar
# COPY test /test

COPY setup.sh /setup.sh
RUN sh setup.sh && rm setup.sh

CMD ["/bin/bash"]
