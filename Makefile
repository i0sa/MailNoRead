TARGET := iphone:clang
ARCHS = armv7 arm64
include theos/makefiles/common.mk

TWEAK_NAME = MailNoRead
MailNoRead_FILES = Tweak.xm
MailNoRead_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 MobileMail"
SUBPROJECTS += mailnoreadprefs
include $(THEOS_MAKE_PATH)/aggregate.mk
