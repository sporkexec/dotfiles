#!/usr/bin/env python2
# Quick and dirty daemon to allow DPMS off over the LAN.
# (Currently triggered via Tasker.)
# I'm sure there's a much cleaner way to do one-off things like this.
 
# This code is written by Stephen C Phillips.
# It is in the public domain, so you can do what you like with it
# but a link to http://scphillips.com would be nice.
 
import socket
import re
import os
 
# Standard socket stuff:
host = ''  # do we need socket.gethostname() ?
port = 10001
sock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
sock.bind((host, port))
sock.listen(1)  # don't queue up any requests
 
# Loop forever, listening for requests:
while True:
	csock, caddr = sock.accept()
	print "Connection from: " + `caddr`
	req = csock.recv(1024)  # get the request, 1kB max
	print req
	match = re.match('GET /dpms/off\sHTTP/1', req)
	if match:
		#FIXME Hardcoded DISPLAY
		os.system('DISPLAY=:0 xset dpms force off') # Here's where the magic happens
		csock.sendall("""HTTP/1.0 200 OK
Content-Type: text/html
 
<html>
<head>
<title>Success</title>
</head>
<body></body>
</html>
""")
	else:
		# If there was no recognised command then return a 404 (page not found)
		print "Returning 404"
		csock.sendall("HTTP/1.0 404 Not Found\r\n")
	csock.close()
