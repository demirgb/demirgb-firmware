host := demirgb-test.snowman.lan
command_port := 80
upload_port := 9999

FROZEN = demirgb_boot.mpy demirgb_inisetup.mpy demirgb.mpy demirgb_websetup.mpy
MPYCROSS = mpy-cross

all: $(FROZEN)

%.mpy: %.py
	$(MPYCROSS) -v $<

clean:
	$(RM) *.mpy

upload-all: $(patsubst %,upload-%,$(FROZEN))

upload: upload-demirgb.mpy

upload-%: %
	(echo "RECV:$<"; cat "$<") | nc -v -N $(host) $(upload_port)

device-demo:
	curl -v --data-binary '{"cmd":"demo"}' -H 'Content-type: application/json' http://$(host):$(command_port)/command | json_pp

.PHONY: all clean upload upload-all device-demo
