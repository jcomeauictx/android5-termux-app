# https://stackoverflow.com/a/43039679/493161
# https://stackoverflow.com/a/58652345/493161
APPNAME := termux
ANDROID_HOME ?= $(HOME)/Downloads/adt-bundle-linux-x86_64-20130717/sdk
PATH := $(ANDROID_HOME)/platform-tools:$(PATH)
TOOLS := $(ANDROID_HOME)/tools
ANDROID := $(TOOLS)/android
SDKMANAGER := $(TOOLS)/bin/sdkmanager
APK := $(APPNAME).apk
UNSIGNED := app/build/outputs/apk/release/app-release-unsigned.apk
SIGNED := $(UNSIGNED:-unsigned.apk=-signed.apk)
KEYS := $(HOME)/$(APPNAME)key.keystore
ZIPALIGN := $(shell ls $(ANDROID_HOME)/build-tools/*/zipalign | tail -n 1)
export
$(APK): $(SIGNED)
	$(ZIPALIGN) -f 4 $< $@
$(SIGNED): $(UNSIGNED) $(KEYS)
	cp -f $< $@  # jarsigner signs file "in-place"
	@echo Enter password as: $(APPNAME)
	jarsigner \
	 -verbose \
	 -sigalg SHA1withRSA \
	 -digestalg SHA1 \
	 -keystore $(KEYS) \
	 $@ $(APPNAME)
$(UNSIGNED): gradlew
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
install: $(SIGNED)
	adb install $< || echo Connect one and only one Android phone >&2
