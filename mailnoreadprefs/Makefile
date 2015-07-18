TARGET := iphone:clang
ARCHS = armv7 arm64
include theos/makefiles/common.mk

BUNDLE_NAME = mailnoreadprefs
mailnoreadprefs_FILES = mailnoreadprefs.mm
mailnoreadprefs_INSTALL_PATH = /Library/PreferenceBundles
mailnoreadprefs_FRAMEWORKS = UIKit
mailnoreadprefs_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/mailnoreadprefs.plist$(ECHO_END)
