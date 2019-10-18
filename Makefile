ARCHS = arm64
TARGET = appletv:10.1:10.1
export GO_EASY_ON_ME=1
export SDKVERSION=10,1
THEOS_DEVICE_IP=guest-room.local
DEBUG=0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = sleepSpring
sleepSpring_FILES = sleepSpring.xm UIView+RecursiveFind.m
sleepSpring_LIBRARIES = substrate
sleepSpring_FRAMEWORKS = Foundation UIKit
sleepSpring_PRIVATE_FRAMEWORKS = MediaRemote
#sleepSpring_LDFLAGS = -undefined dynamic_lookup

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 backboardd"
