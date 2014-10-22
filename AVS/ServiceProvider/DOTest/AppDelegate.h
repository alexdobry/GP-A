//
//  AppDelegate.h
//  DOTest
//
//  Created by Alexander Dobrynin on 22.10.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;

@property (assign) IBOutlet NSTextField *nameTextField;
@property (assign) IBOutlet NSTextField *loggerTextField;
@property (assign) IBOutlet NSTextField *usageTextField;

@end