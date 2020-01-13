# Radiosonde autorx


https://github.com/projecthorus/radiosonde_auto_rx

https://github.com/projecthorus/radiosonde_auto_rx/wiki



# RTL-SDR device

https://www.rtl-sdr.com/buy-rtl-sdr-dvb-t-dongles/

USB device should recognized and available in linux (container will fail to run if device is not found):

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


About the options below:

--privileged -v /dev/bus/usb:/dev/bus/usb
  Running the container in privileged mode to allow the container access to SDR USB module.

-v $(pwd)/log:/radiosonde_auto_rx/auto_rx/log/
  Bind mount folder "log" from host to container so container can write logs to host. Optional, if not given 
  logs are kept inside container and are lost when container is destroyed.

-p 5000:5000
  Exposing port 5000 allows access to the webservice running in the container from host by connecting to http://localhost:5000 on host



```
[me@i7 ~]$ mkdir log
[me@i7 ~]$ docker run -it --privileged -v /dev/bus/usb:/dev/bus/usb -v $(pwd)/log:/radiosonde_auto_rx/auto_rx/log/ -p 5000:5000 pmta/radiosonde
Unable to find image 'pmta/radiosonde:latest' locally
latest: Pulling from pmta/radiosonde
2746a4a261c9: Pull complete 
4c1d20cdee96: Pull complete 
0d3160e1d0de: Pull complete 
c8e37668deea: Pull complete 
70a286f60403: Pull complete 
f7d43e5627bd: Pull complete 
9b4319c64244: Pull complete 
11208b0ba384: Pull complete 
38c2941ec186: Pull complete 
868454f1c30a: Pull complete 
357c4ae0142c: Pull complete 
5ff70816a7b5: Pull complete 
Digest: sha256:69c6e05b082c0437d44e272aa26987b473004aee632377176d527e5dee9121d0
Status: Downloaded newer image for pmta/radiosonde:latest
2020-01-13 18:17:12,564 INFO:Reading configuration file...
2020-01-13 18:17:12,565 ERROR:Config - Invalid or missing email settings. Disabling.
2020-01-13 18:17:12,565 WARNING:Config - Did not find web control / ngp_tweak / gpsd options, using defaults (disabled)
2020-01-13 18:17:20,528 INFO:Config - Tested SDR #0 OK
2020-01-13 18:17:20,532 INFO:Started Flask server on http://0.0.0.0:5000
2020-01-13 18:17:20,533 INFO:Telemetry Logger - Started Telemetry Logger Thread.
 * Serving Flask app "autorx.web" (lazy loading)
 * Environment: production
   WARNING: This is a development server. Do not use it in a production deployment.
2020-01-13 18:17:20,534 INFO:OziMux - Started OziMux / Payload Summary Exporter
   Use a production WSGI server instead.
 * Debug mode: off
2020-01-13 18:17:20,790 INFO:Version - Local Version: 1.2.3  Current Master Version: 1.2.3
2020-01-13 18:17:20,791 INFO:SDR #0 has been allocated to Scanner.
2020-01-13 18:17:29,042 INFO:Scanner #0 - Starting Scanner Thread
2020-01-13 18:17:29,043 INFO:Scanner #0 - Running frequency scan.
2020-01-13 18:17:29,898 INFO:Flask - New Web Client connected!
:
:
2020-01-13 18:23:16,557 INFO:Scanner #0 - Running frequency scan.
2020-01-13 18:23:37,207 INFO:Scanner #0 - Detected peaks on 11 frequencies (MHz): [ 403.    405.46  402.18  403.    400.87  405.    403.2   400.69  401.04
  401.76  401.29]
2020-01-13 18:23:39,380 INFO:Task Manager - Detected new RS41 sonde on 403.000 MHz!
2020-01-13 18:23:39,381 INFO:Halting Scanner to decode detected radiosonde.
2020-01-13 18:23:39,382 INFO:Scanner #0 - Waiting for current scan to finish...
2020-01-13 18:23:55,422 INFO:Scanner #0 - Scanner Thread Closed.
2020-01-13 18:23:55,422 INFO:SDR #0 has been allocated to Decoder (RS41, 403.000 MHz).
2020-01-13 18:24:03,258 INFO:Decoder #0 RS41 403.000 - Using experimental decoder chain.
2020-01-13 18:24:03,272 INFO:Decoder #0 RS41 403.000 - Starting decoder subprocess.
2020-01-13 18:24:06,487 INFO:Telemetry Logger - Opening new log file: /radiosonde_auto_rx/auto_rx/log/20200113-182406_R1940199_RS41_403000_sonde.log
:
```

# WebUI

When new sonde has been detected and decoding was successful it can be seen on webui

![alt text](https://raw.githubusercontent.com/pmta/radiosonde/master/images/webui_sonde_found.png)

