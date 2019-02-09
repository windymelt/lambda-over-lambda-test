.PHONY: default distclean build

OUT = out.zip
LIBCRYPTO = libcrypto.so.1.0.0
LIBCRYPTO2 = libcrypto.so.41.0.1
LIBSSL = libssl.so.1.0.0
LIBSSL2 = libssl.so.43.0.2

default: $(OUT)

distclean:
	-rm $(OUT) bootstrap $(LIBCRYPTO) $(LIBSSL)

$(LIBCRYPTO):
	docker-compose run --rm cl cp /lib/$@ /app/

$(LIBSSL):
	docker-compose run --rm cl cp /lib/$@ /app/

$(LIBCRYPTO2):
	docker-compose run --rm cl cp /lib/$@ /app/

$(LIBSSL2):
	docker-compose run --rm cl cp /lib/$@ /app/

$(OUT): bootstrap $(LIBCRYPTO) $(LIBSSL) $(LIBCRYPTO2) $(LIBSSL2)
	-rm $@
	zip --symlinks $@ $^

bootstrap: bootstrap.ros
	docker-compose run --rm cl ros build $<

build: temporary.ros $(LIBCRPTO) $(LIBSSL) $(LIBCRYPTO2) $(LIBSSL2)
	docker-compose run --rm cl ros build temporary.ros --bundle-shared-object
	-rm temporary.ros
	mv temporary bootstrap
	-ln -s $(LIBCRYPTO2) libcrypto.so.41
	-ln -s $(LIBSSL2) libssl.so.43
	zip out.zip --symlinks bootstrap $(LIBCRYPTO) $(LIBSSL) $(LIBCRYPTO2) $(LIBSSL2) libcrypto.so.41 libssl.so.43
