.PHONY: default distclean

OUT = out.zip
LIBCRYPTO = libcrypto.so
LIBSSL = libssl.so

default: $(OUT)

distclean:
	-rm $(OUT) bootstrap $(LIBCRYPTO) $(LIBSSL)

$(LIBCRYPTO):
	docker-compose run --rm cl cp /usr/lib64/$@ /app/
#	ln -s $@ libcrypto.so.10

$(LIBSSL):
	docker-compose run --rm cl cp /usr/lib64/$@ /app/
#	ln -s $@ libssl.so.10

$(OUT): bootstrap #$(LIBCRYPTO) $(LIBSSL)
	-rm $@
	zip --symlinks $@ $^

bootstrap: bootstrap.ros
	docker-compose run --rm cl ros build $< --bundle-shared-object
