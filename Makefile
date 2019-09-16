TARGET := iphone:clang:latest:5.0
ARCHS := arm64

include $(THEOS)/makefiles/common.mk

TOOL_NAME = OpenApp
OpenApp_PRIVATE_FRAMEWORKS = SpringBoardServices
OpenApp_CODESIGN_FLAGS = -SEntitlements.plist

INSTALL_TARGET_PROCESSES = SpringBoard

OpenApp_FILES = open.m
OpenApp_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tool.mk
include $(THEOS_MAKE_PATH)/tweak.mk