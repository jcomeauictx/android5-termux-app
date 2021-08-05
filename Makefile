# https://stackoverflow.com/a/43039679/493161
# https://stackoverflow.com/a/58652345/493161
APPNAME := termux
ANDROID_HOME ?= $(HOME)/Downloads/adt-bundle-linux-x86_64-20130717/sdk
PATH := $(ANDROID_HOME)/platform-tools:$(PATH)
TOOLS := $(ANDROID_HOME)/tools
ANDROID := $(TOOLS)/android
SDKMANAGER := $(TOOLS)/bin/sdkmanager
export
all: gradlew
	./$< --no-daemon build
env:
	$@
update: $(SDKMANAGER)
	$< --update
accept: $(SDKMANAGER)
	@echo 'Review all licenses and "accept all"'
	yes | $< --licenses
tools: $(TOOLS)
	ls $<
keys:
	@echo Enter password as: $(APPNAME)
	keytool \
         -genkeypair \
         -validity 10000 \
         -keystore $(HOME)/$(APPNAME)key.keystore \
         -alias $(APPNAME) \
         -keyalg RSA \
         -keysize 2048
