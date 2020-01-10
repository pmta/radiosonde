FROM ubuntu

ENV LC_ALL=C.UTF-8 
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update && apt-get -y upgrade
RUN apt-get install -y python-numpy python-setuptools python-crcmod python-requests python-dateutil python-pip sox git build-essential cmake usbutils libusb-1.0-0-dev rng-tools libsamplerate-dev vim
RUN pip install flask flask-socketio
RUN apt-get install rtl-sdr librtlsdr0 librtlsdr-dev

COPY rtlsdr-blacklist.conf /etc/modprobe.d/rtlsdr-blacklist.conf
RUN git clone https://github.com/projecthorus/radiosonde_auto_rx.git
WORKDIR /radiosonde_auto_rx/auto_rx/
RUN ./build.sh
COPY station.cfg /radiosonde_auto_rx/auto_rx/station.cfg

EXPOSE 5000
CMD python auto_rx.py

