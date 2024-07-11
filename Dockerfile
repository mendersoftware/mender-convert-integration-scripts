FROM ubuntu:20.04

RUN apt-get update && \
	apt-get install -y \
		wget \
		gcc-arm-linux-gnueabi \
		gcc-arm-linux-gnueabihf \
		git \
		build-essential \
		bison \
		flex \
		bc \
		u-boot-tools \
		# to compile for 64bit ARM, particularly RPi3/4/5
		gcc-aarch64-linux-gnu \
		# required to build recent versions of u-boot (noticed on 2024.04)
		libssl-dev

# To provide support for Raspberry Pi Zero W a toolchain tuned for ARMv6 architecture must be used.
# https://tracker.mender.io/browse/MEN-2399
RUN wget -nc -q https://toolchains.bootlin.com/downloads/releases/toolchains/armv6-eabihf/tarballs/armv6-eabihf--glibc--stable-2018.11-1.tar.bz2 \
    && tar -xjf armv6-eabihf--glibc--stable-2018.11-1.tar.bz2 \
    && rm armv6-eabihf--glibc--stable-2018.11-1.tar.bz2

COPY build-uboot-bbb.sh /usr/local/bin/
COPY build-uboot-rpi.sh /usr/local/bin/

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
