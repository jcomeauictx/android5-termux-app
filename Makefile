ANDROID_HOME := $(HOME)/Downloads/adt-bundle-linux-x86_64-20130717
export
all: gradlew
	./$< build
env:
	$@
