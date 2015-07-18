@interface MFLibraryMessage : NSObject
- (id)account;
@end

@interface DAMailAccount : NSObject
- (id)username;
@end

#define prefsPath @"/private/var/mobile/Library/Preferences/com.i0sa.mailnoreadetc.plist"
#define realPrefsPath @"/private/var/mobile/Library/Preferences/com.i0sa.mailnoreadprefs.plist"
BOOL isViewingMessage;

%hook MessageViewController
-(void)markMessageAsRead:(MFLibraryMessage *)swag{
    NSMutableDictionary* prefs = [[NSMutableDictionary alloc] initWithContentsOfFile: realPrefsPath];
    NSString *selectedAcc = [prefs objectForKey:@"accSelected"] ? [prefs objectForKey:@"accSelected"] : @"0";
    BOOL enabled = [prefs objectForKey:@"enabled"] == nil ? YES : [[prefs objectForKey:@"enabled"] boolValue];

    if(enabled){
     if(!isViewingMessage){ // to solve inside message manual marking
	    if([selectedAcc isEqualToString:[[swag account] username]]){
	    	return;
	    }
	  }  
	}

	return %orig;
}

-(void)viewDidAppear:(bool)xx{
	if(xx){
		isViewingMessage = YES;
	}
	return %orig;
}


-(void)viewDidDisappear:(bool)xx{
	if(xx){
		isViewingMessage = NO;
	}
	return %orig;
}
%end


%hook MailAppController
-(BOOL)application:(id)application didFinishLaunchingWithOptions:(id)options{
   NSSet *accs = MSHookIvar<NSSet *>(self, "_displayedAccounts");
  NSMutableArray *accs_usernames = [NSMutableArray array];

   if(accs){
	   for(id accc in [accs allObjects]){
	   		if(accc){
	   			[accs_usernames addObject:[accc username]];
	   		}
	   }

   }
   if([accs_usernames count] >= 1){
	   NSMutableDictionary *rootObj = [NSMutableDictionary dictionaryWithCapacity:10];
	   [rootObj setObject:accs_usernames forKey:@"accs"];//country
	 
	   NSData *xmlData = [NSPropertyListSerialization dataFromPropertyList:(id)rootObj
		                    format:NSPropertyListXMLFormat_v1_0
		                    errorDescription:nil];
	   if( xmlData ) {
	   	[xmlData writeToFile:prefsPath atomically:YES];
	   } 
   }


	return %orig;
}
%end


