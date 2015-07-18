#import <Preferences/Preferences.h>

#define tweakPrefsPath @"/private/var/mobile/Library/Preferences/com.i0sa.mailnoreadetc.plist"

@interface mailnoreadprefsListController: PSListController {
}
@end

@implementation mailnoreadprefsListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"mailnoreadprefs" target:self] retain];
		 PSSpecifier *specifierToSetValuesFor = [self specifierForID:@"mailAccs"];
        if (specifierToSetValuesFor) {
		    NSMutableDictionary* prefs = [[NSMutableDictionary alloc] initWithContentsOfFile: tweakPrefsPath];
            [prefs objectForKey:@"accs"];
            [specifierToSetValuesFor setValues:[prefs objectForKey:@"accs"] titles:[prefs objectForKey:@"accs"]];
        }

	}
	return _specifiers;
}
@end

// vim:ft=objc

