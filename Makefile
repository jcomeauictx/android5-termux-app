# https://stackoverflow.com/a/43039679/493161
# https://stackoverflow.com/a/58652345/493161`
ANDROID_HOME ?= $(HOME)/Downloads/adt-bundle-linux-x86_64-20130717
TOOLS := $(ANDROID_HOME)/sdk/tools
ANDROID := $(TOOLS)/android
SDKMANAGER := $(TOOLS)/bin/sdkmanager
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
clean:
	rm -rf $(ANDROID_HOME)/licenses
