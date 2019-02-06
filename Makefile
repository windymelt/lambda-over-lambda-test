.PHONY: default distclean

default: out.zip

distclean:
	-rm out.zip bootstrap libcrypt-2.26.so libssl3.so

libcrypt-2.26.so:
	docker-compose run --rm cl cp /lib64/$@ /app/

libssl3.so:
	docker-compose run --rm cl cp /lib64/$@ /app/

out.zip: bootstrap libcrypt-2.26.so libssl3.so
	zip out.zip $^

bootstrap: bootstrap.ros
	docker-compose run --rm cl ros build $< --bundle-shared-object
