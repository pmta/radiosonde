# Radiosonde autorx


https://github.com/projecthorus/radiosonde_auto_rx

https://github.com/projecthorus/radiosonde_auto_rx/wiki



# RTL-SDR device

https://www.rtl-sdr.com/buy-rtl-sdr-dvb-t-dongles/

USB should recognized and available in linux:

```
[me@i7 ~]$ dmesg
:
[ 7085.661269] usb 3-10.2: new high-speed USB device number 14 using xhci_hcd
[ 7085.768938] usb 3-10.2: New USB device found, idVendor=0bda, idProduct=2838, bcdDevice= 1.00
[ 7085.768949] usb 3-10.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 7085.768955] usb 3-10.2: Product: RTL2838UHIDIR
[ 7085.768961] usb 3-10.2: Manufacturer: Realtek
[ 7085.768966] usb 3-10.2: SerialNumber: 00000001
[ 7085.776795] usb 3-10.2: dvb_usb_v2: found a 'Realtek RTL2832U reference design' in warm state
[ 7085.830864] usb 3-10.2: dvb_usb_v2: will pass the complete MPEG2 transport stream to the software demuxer
[ 7085.830876] dvbdev: DVB: registering new adapter (Realtek RTL2832U reference design)
[ 7085.838040] i2c i2c-2: Added multiplexed i2c bus 3
[ 7085.838047] rtl2832 2-0010: Realtek RTL2832 successfully attached
[ 7085.838072] usb 3-10.2: DVB: registering adapter 0 frontend 0 (Realtek RTL2832 (DVB-T))...
[ 7085.838250] r820t 3-001a: creating new instance
[ 7085.845111] r820t 3-001a: Rafael Micro r820t successfully identified

[me@i7 ~]$ lsusb | grep RTL
Bus 003 Device 014: ID 0bda:2838 Realtek Semiconductor Corp. RTL2838 DVB-T
[me@i7 ~]$ 


```



# Running the container

Running the container in privileged mode to allow the container access to SDR USB module.

Exposing port 5000 allows access to the building webservice at http://localhost:5000


```
[me@i7 ~]$ docker run -it --privileged -v /dev/bus/usb:/dev/bus/usb -p 5000:5000 pmta/radiosonde
Unable to find image 'pmta/radiosonde:latest' locally
latest: Pulling from pmta/radiosonde
2746a4a261c9: Pull complete 
:
80dba13ee92d: Pull complete 
Digest: sha256:b5c42358e6c38bbcdebb39240e5ab129ec0c940fc34f0a9c9c23f1fcf0808c0a
Status: Downloaded newer image for pmta/radiosonde:latest
2020-01-13 17:58:19,631 INFO:Reading configuration file...
2020-01-13 17:58:19,632 ERROR:Config - Invalid or missing email settings. Disabling.
2020-01-13 17:58:19,632 WARNING:Config - Did not find web control / ngp_tweak / gpsd options, using defaults (disabled)
 2020-01-13 17:58:27,844 INFO:Config - Tested SDR #0 OK
2020-01-13 17:58:27,847 INFO:Started Flask server on http://0.0.0.0:5000
2020-01-13 17:58:27,849 INFO:Telemetry Logger - Started Telemetry Logger Thread.
 * Serving Flask app "autorx.web" (lazy loading)
 * Environment: production
   WARNING: This is a development server. Do not use it in a production deployment.
2020-01-13 17:58:27,850 INFO:OziMux - Started OziMux / Payload Summary Exporter
   Use a production WSGI server instead.
 * Debug mode: off
2020-01-13 17:58:28,092 INFO:Version - Local Version: 1.2.3  Current Master Version: 1.2.3
2020-01-13 17:58:28,093 INFO:SDR #0 has been allocated to Scanner.
2020-01-13 17:58:36,097 INFO:Scanner #0 - Starting Scanner Thread
2020-01-13 17:58:36,098 INFO:Scanner #0 - Running frequency scan.
2020-01-13 17:58:56,185 INFO:Scanner #0 - Detected peaks on 11 frequencies (MHz): [ 403.    404.95  402.18  403.2   402.35  405.46  405.51  405.    401.76
  404.38  400.87]
:
```


