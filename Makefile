ANDROID_HOME ?= $(HOME)/Downloads/adt-bundle-linux-x86_64-20130717
TOOLS := $(ANDROID_HOME)/sdk/tools
SDKMANAGER := $(TOOLS)/android
export
all: gradlew
	./$< build
env:
	$@
accept: $(SDKMANAGER)
	@echo 'Review all licenses and "accept all"'
	$< sdk
tools: $(TOOLS)
	ls $<
