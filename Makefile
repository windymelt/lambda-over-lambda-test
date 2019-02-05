.PHONY: default

default: out.zip

libcrypto.so.1.0.0: /lib64/libcrypto.so.1.0.0
	cp /lib64/libcrypto.so.1.0.0 .

libssl.so.1.0.0: /lib64/libssl.so.1.0.0
	cp /lib64/libssl.so.1.0.0 .

out.zip: bootstrap libcrypto.so.1.0.0 libssl.so.1.0.0
	zip out.zip bootstrap libcrypto.so.1.0.0 libssl.so.1.0.0

bootstrap: bootstrap.ros
	ros build bootstrap.ros
