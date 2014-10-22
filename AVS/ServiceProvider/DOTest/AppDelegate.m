//
//  AppDelegate.m
//  DOTest
//
//  Created by Alexander Dobrynin on 22.10.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "HoughTransformator.h"
#import "Circle.h"
#import "CPUUsage.h"
#import "InformantProtocol.h"

#include <opencv/cv.h>
#include <opencv/highgui.h>
#include <math.h>

@implementation AppDelegate

@synthesize window = _window;
@synthesize nameTextField = _nameTextField;
@synthesize loggerTextField = _loggerTextField;
@synthesize usageTextField = _usageTextField;

- (void)dealloc
{
    [super dealloc];
}
	
- (void)worker:(id)host{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    NSString* currentHost = [[[NSHost currentHost] localizedName] stringByAppendingString:@"hallo"];

    NSSocketPort *port = [[NSSocketPort alloc] init];
    NSConnection *connection = [NSConnection connectionWithReceivePort:port sendPort:port];
    BOOL isConnected = [[NSSocketPortNameServer sharedInstance] registerPort:port name:currentHost];
    
    
    NSLog(@"I am %@.", currentHost);
    
    HoughTransformator * hough = [[HoughTransformator alloc] init];
    [connection setRootObject: hough];
    
    if (!isConnected) {
        NSLog(@"Impossible to vend this object.");
    } else {
        NSLog(@"Object vended.");
    }
    [[NSRunLoop currentRunLoop] run];
    
    [pool release];
}

- (void)informant:(id)host{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    NSString* currentHost = [[[NSHost currentHost] localizedName] stringByAppendingString:@"hallo"];
    NSString * serviceHost = [currentHost stringByAppendingString:@"_service"];
    
    NSSocketPort *port = [[NSSocketPort alloc] init];
    NSConnection *connection = [NSConnection connectionWithReceivePort:port sendPort:port];
    BOOL isConnected = [[NSSocketPortNameServer sharedInstance] registerPort:port name:serviceHost];
    
    NSLog(@"I am %@.", serviceHost);
    [self.nameTextField setStringValue:serviceHost];
    
    CPUUsage * informant = [[CPUUsage alloc] init];
    [connection setRootObject: informant];
    
    
    if (!isConnected) {
        NSLog(@"Impossible to vend this object.");
    } else {
        NSLog(@"Object vended.");
    }
    [[NSRunLoop currentRunLoop] run];
    
    [pool release];
}

- (IplImage*)drawCircles:(NSMutableArray*) circles on:(IplImage*) img {
    for (Circle* circle in circles) {
        cvCircle(img, cvPoint(circle.x, circle.y), circle.r, CV_RGB(255,0,0), 3, 8, 0);
    }
    return img;
}

- (double)getFps:(time_t)end i:(int *)i start:(time_t)start
{
    time(&end);   
    return ++(*i) / (difftime (end, start));
}

-(void) logMessages:(NSNotification*) notification {
    [self.loggerTextField setStringValue:[notification object]];
}

-(void) logUsage:(NSNotification*) notification {
    [self.usageTextField setStringValue:[notification object]];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSLog(@"applicationDidFinishLaunching");
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    [self.loggerTextField setEditable:NO];
    [self.usageTextField setEditable:NO];
    
    NSThread* worker = [[NSThread alloc] initWithTarget:self selector:@selector(worker:) object:nil];
    NSThread* informant = [[NSThread alloc] initWithTarget:self selector:@selector(informant:) object:nil];
    
    [worker start];
    [informant start];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logMessages:) name:@"logger" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logUsage:) name:@"cpu" object:nil];

    [pool drain];
    
}

@end
