THEOS_DEVICE_IP = 127.0.0.1
THEOS_DEVICE_PORT = 22
ARCHS = arm64 arm64e
TARGET = iphone:clang:latest:latest
PACKAGE_VERSION = 1.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = FakePurchase
FakePurchase_FILES = Tweak.xm
FakePurchase_FRAMEWORKS = StoreKit Foundation
FakePurchase_CFLAGS = -Wno-error

include $(THEOS_MAKE_PATH)/tweak.mk
