//
//  xyzAppDelegate.h
//  DObjectsTest
//
//  Created by Patrick Englert on 22.10.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextField *pip01TextField;
@property (assign) IBOutlet NSTextField *pip02TextField;
@property (assign) IBOutlet NSTextField *pip03TextField;
@property (assign) IBOutlet NSTextField *pip04TextField;
@property (assign) IBOutlet NSTextField *pip05TextField;
@property (assign) IBOutlet NSTextField *pip06TextField;
@property (assign) IBOutlet NSTextField *pip07TextField;
@property (assign) IBOutlet NSTextField *pip08TextField;
@property (assign) IBOutlet NSTextField *pip09TextField;
@property (assign) IBOutlet NSTextField *pip10TextField;

@property (assign) IBOutlet NSTextField *pip01UsageTextField;
@property (assign) IBOutlet NSTextField *pip02UsageTextField;
@property (assign) IBOutlet NSTextField *pip03UsageTextField;
@property (assign) IBOutlet NSTextField *pip04UsageTextField;
@property (assign) IBOutlet NSTextField *pip05UsageTextField;
@property (assign) IBOutlet NSTextField *pip06UsageTextField;
@property (assign) IBOutlet NSTextField *pip07UsageTextField;
@property (assign) IBOutlet NSTextField *pip08UsageTextField;
@property (assign) IBOutlet NSTextField *pip09UsageTextField;
@property (assign) IBOutlet NSTextField *pip10UsageTextField;

@property (assign) NSDictionary* providerTextFieldMapping;
@property (assign) NSDictionary* cpuTextFieldMapping;

@end
