FROM ubuntu:bionic

COPY setup.sh /setup.sh
RUN sh setup.sh && rm setup.sh

CMD ["/bin/bash"]
