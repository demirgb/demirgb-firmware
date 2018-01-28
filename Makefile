host := 10.9.8.133
command_port := 80
upload_port := 9999

FROZEN = demirgb_boot.mpy demirgb_inisetup.mpy demirgb.mpy demirgb_uploader.mpy frozensetup.mpy demirgb_websetup.mpy

all: $(FROZEN)

%.mpy: %.py
	mpy-cross -v $<

clean:
	$(RM) *.mpy

upload-all: $(patsubst %,upload-%,$(FROZEN))

upload: upload-demirgb.mpy

upload-%: %
	(echo "RECV:$<"; cat "$<") | nc -v -N $(host) $(upload_port)

device-demo:
	curl -v --data-binary '{"cmd":"demo"}' -H 'Content-type: application/json' http://$(host):$(command_port)/command | json_pp

.PHONY: all clean upload upload-all device-demo
