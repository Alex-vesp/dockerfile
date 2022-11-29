FROM python:3.9.4-alpine

ENV PACKAGES_DEV="\
    build-base \
    freetype-dev \
    gfortran \
    linux-headers \
    openblas-dev \
    pkgconfig \
    portaudio-dev \
    "

ENV PACKAGES="\
    alsa-plugins \
    alsa-plugins-a52 \
    alsa-plugins-jack \
    alsa-plugins-lavrate \
    alsa-plugins-pulse \
    libc6-compat \
    libgfortran \
    libstdc++ \
    openblas \
    portaudio \
    pulseaudio-alsa \
    pulseaudio-jack \
    "

ENV PYTHON_PACKAGES="\
    gpiozero \
    numpy \
    picovoice \
    pigpio \
    pyaudio \
    spidev \
    wave \
    "

RUN apk add --virtual build-deps $PACKAGES_DEV \
    && ln -s /usr/include/locale.h /usr/include/xlocale.h \
    && pip install --no-cache-dir $PYTHON_PACKAGES \
    && apk del build-deps \
    && apk add --no-cache --virtual build-runtime $PACKAGES \
    && rm -rf /var/cache/apk/*

WORKDIR /usr/src/app/mics_hat

COPY . .

ENTRYPOINT ["python3"]
CMD ["interfaces/pixels_demo.py"]

