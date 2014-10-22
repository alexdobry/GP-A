//
//  xyzAppDelegate.m
//  DObjectsTest
//
//  Created by Patrick Englert on 22.10.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "Cluster.h"
#import "DataSource.h"
#import "Circle.h"
#import "HoughTransformationProtocol.h"

#include <opencv/cv.h>
#include <opencv/cxcore.h>
#include <opencv/highgui.h>
#include <math.h>

@implementation AppDelegate

@synthesize window = _window;
@synthesize pip01TextField = _pip01TextField;
@synthesize pip02TextField = _pip02TextField;
@synthesize pip03TextField = _pip03TextField;
@synthesize pip04TextField = _pip04TextField;
@synthesize pip05TextField = _pip05TextField;
@synthesize pip06TextField = _pip06TextField;
@synthesize pip07TextField = _pip07TextField;
@synthesize pip08TextField = _pip08TextField;
@synthesize pip09TextField = _pip09TextField;
@synthesize pip10TextField = _pip10TextField;

@synthesize pip01UsageTextField = _pip01UsageTextField;
@synthesize pip02UsageTextField = _pip02UsageTextField;
@synthesize pip03UsageTextField = _pip03UsageTextField;
@synthesize pip04UsageTextField = _pip04UsageTextField;
@synthesize pip05UsageTextField = _pip05UsageTextField;
@synthesize pip06UsageTextField = _pip06UsageTextField;
@synthesize pip07UsageTextField = _pip07UsageTextField;
@synthesize pip08UsageTextField = _pip08UsageTextField;
@synthesize pip09UsageTextField = _pip09UsageTextField;
@synthesize pip10UsageTextField = _pip10UsageTextField;

@synthesize providerTextFieldMapping = _providerTextFieldMapping;
@synthesize cpuTextFieldMapping = _cpuTextFieldMapping;


- (void)dealloc
{
    [super dealloc];
}

-(void) updateConnectedProvider:(NSNotification*) notification {
    NSString* name = [notification object];
    [[self.providerTextFieldMapping valueForKey:name] setBackgroundColor:[NSColor greenColor]];
}

-(void) updateDisconnectedProvider:(NSNotification*) notification {
    NSString* name = [notification object];
    [[self.providerTextFieldMapping valueForKey:name] setBackgroundColor:[NSColor redColor]];
}

-(void) updateCpuUsage:(NSNotification*) notification {
    NSMutableArray* array = [notification object];
    NSTextField* cpuField = [self.cpuTextFieldMapping valueForKey:[array lastObject]];
    [array removeLastObject];
    NSString* display = [[NSString alloc] init];
    
    for (NSNumber* number in array) {
        display = [display stringByAppendingFormat:@"%.2f\n", [number floatValue]];
    }
    
    [cpuField setStringValue:display];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // benötigte pip rechner an den neuen namen anpassen
    NSArray* providerNames = [NSArray arrayWithObjects:@"pip01hallo",@"pip02hallo",@"pip03hallo",@"pip04hallo",@"pip05hallo",@"pip06hallo",@"pip07s Mac Prohallo",@"pip08s Mac Prohallo",@"pip09s Mac Prohallo",@"pip10hallo", nil];
    NSArray* providerTextFields = [NSArray arrayWithObjects:self.pip01TextField,self.pip02TextField,self.pip03TextField,self.pip04TextField,self.pip05TextField,self.pip06TextField,self.pip07TextField,self.pip08TextField,self.pip09TextField,self.pip10TextField, nil];
    NSArray* cpuTextFields = [NSArray arrayWithObjects:self.pip01UsageTextField,self.pip02UsageTextField,self.pip03UsageTextField,self.pip04UsageTextField,self.pip05UsageTextField,self.pip06UsageTextField,self.pip07UsageTextField,self.pip08UsageTextField,self.pip09UsageTextField,self.pip10UsageTextField, nil];
   
    self.providerTextFieldMapping = [[NSDictionary alloc] initWithObjects:providerTextFields forKeys:providerNames];
    self.cpuTextFieldMapping = [[NSDictionary alloc] initWithObjects:cpuTextFields forKeys:providerNames];

    [self.pip01UsageTextField setEditable:NO];
    [self.pip02UsageTextField setEditable:NO];
    [self.pip03UsageTextField setEditable:NO];
    [self.pip04UsageTextField setEditable:NO];
    [self.pip05UsageTextField setEditable:NO];
    [self.pip06UsageTextField setEditable:NO];
    [self.pip07UsageTextField setEditable:NO];
    [self.pip08UsageTextField setEditable:NO];
    [self.pip09UsageTextField setEditable:NO];
    [self.pip10UsageTextField setEditable:NO];
    
    DataSource* source = [[DataSource alloc] init];
    [[Cluster alloc] initWithDataSource:source andProviderNames:providerNames];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateConnectedProvider:) name:@"connected" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateDisconnectedProvider:) name:@"disconnected" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateCpuUsage:) name:@"usage" object:nil];

}

@end
