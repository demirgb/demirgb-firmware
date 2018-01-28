# This file is not meant to be uploaded to the DemiRGB during normal
# use.  It's executed after the demirgb.main() loop is broken, and is to
# aid in development.


def recv(*args, **kwargs):
    import demirgb_uploader

    reset = True
    if 'reset' in kwargs:
        reset = kwargs['reset']
        del(kwargs['reset'])

    try:
        demirgb_uploader.recv(*args, **kwargs)
    except KeyboardInterrupt:
        pass

    if reset:
        import machine
        machine.reset()
