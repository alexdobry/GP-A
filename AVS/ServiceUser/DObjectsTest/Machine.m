//
//  MachineThread.m
//  DObjectsTest
//
//  Created by Markus Müller on 19.11.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "Machine.h"
#import "HoughImage.h"

@implementation Machine

@synthesize portName;
@synthesize connected;

@synthesize dataSource;

@synthesize statusThread;
@synthesize workerThread;

-(Machine*) initWithName:(NSString*)name dataSource:(DataSource*)source {
    [self setConnected:NO];
    [self setPortName:name];
    [self setDataSource:source];
    
    //Create "Status"-Thread
    statusThread = [[NSThread alloc] initWithTarget:self
                                                 selector:@selector(checkStatus:)
                                             object:nil];
    //start
    [statusThread start];
    
    return self;
}

-(void)checkStatus:(id)arg {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    id infoProtocol;
    
    NSConnection *theConnection = nil;
    NSSocketPort *port = nil;
    
    int currentNumber;
    
    NSString * servicePort = [portName stringByAppendingString:@"_service"];
    
    while (true) {
        sleep(3);
        // conncection loss?
        if (!connected) {
            // reconnect
            port = (NSSocketPort *) [[NSSocketPortNameServer sharedInstance] portForName:servicePort host:@"*"];
            if (port == nil) {
                // can't reconnent
                sleep(5);
                continue;
            }
            theConnection = [NSConnection connectionWithReceivePort:nil sendPort:port];
            
            // update connection
            [self setConnected:YES];
            // ui benachrichtigen, dass provider verbunden ist
            [[NSNotificationCenter defaultCenter] postNotificationName:@"connected" object:portName];
            
            
            [theConnection setRequestTimeout:10];
            [theConnection setReplyTimeout:10];
            
            infoProtocol = [[theConnection rootProxy] retain];                
            [infoProtocol setProtocolForProxy:@protocol(InformantProtocol)];
            
            // create and start worker thread
            workerThread = [[NSThread alloc] initWithTarget:self selector:@selector(doWork:) object:nil];
            [workerThread start];
            
        }
        
        //  Der try Block ist für den Ausfall eines Service Providers nötig. Der aufruf des Distributed Objects wirft eine Exception nach Timeout.
        @try {
            NSMutableArray* coreUsage = [infoProtocol getInfo];
            [coreUsage addObject:self.portName];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"usage" object:coreUsage];
            
        }
        @catch (NSException *exception) {
            // service provider connection is lost
            if ([[exception name] isEqualToString:NSPortTimeoutException]) {
                // update connection
                [self setConnected:NO]; 
                
                // ui benachrichtigen, dass provider nicht mehr verbunden ist
                [[NSNotificationCenter defaultCenter] postNotificationName:@"disconnected" object:portName];
                
                // release ressources
                NSLog(@"Verbindung verloren: %@ %d", portName, currentNumber);
                [infoProtocol release];
                [[NSSocketPortNameServer sharedInstance] removePortForName:portName];
                [port release];
                [theConnection release];
                infoProtocol = nil;
                theConnection = nil;
                port = nil;
                
                // wait for the next connection attempt
                sleep(120); 
            }
        }
        
    }
    
    
    [pool release];

}

-(void)doWork:(id)arg {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    
    NSConnection *theConnection = nil;
    NSSocketPort *port = nil;
    
    id houghProtocol;
 
    // connect
    port = (NSSocketPort *) [[[NSSocketPortNameServer sharedInstance] portForName:portName host:@"*"] retain];
    theConnection = [NSConnection connectionWithReceivePort:nil sendPort:port];
    
    [theConnection setRequestTimeout:60];
    [theConnection setReplyTimeout:60];
            
    houghProtocol = [[theConnection rootProxy] retain];                
    [houghProtocol setProtocolForProxy:@protocol(HoughTransformationProtocol)];
    
    
    HoughImage* houghImg = NULL;
    NSMutableArray* circles = [[NSMutableArray alloc] init];
    
    // do the actual work
    while (connected) {
        //  Der try Block ist für den Ausfall eines Service Providers nötig. Der aufruf des Distributed Objects wirft eine Exception nach Timeout.
        @try {
            @autoreleasepool {
                houghImg = [dataSource getNextDataset];
                circles = [houghProtocol performHoughTransformationWithNSImage:[NSImage imageWithIplImage:houghImg.img]];
                if ([dataSource showImage:houghImg]) {
                    @synchronized(dataSource) {
                        houghImg.img = [self drawCircles:circles on:houghImg.img];
                        cvShowImage("result", houghImg.img);
                    }
                }
            }
        }
        
        @catch (NSException *exception) {
            if ([[exception name] isEqualToString:NSPortTimeoutException]) {
                NSLog(@"Datenpaket Nr. ... konnte nicht bearbeitet werden (Timeout).");
            }
            
        }
  }
    [pool release];

}

- (IplImage*)drawCircles:(NSMutableArray*) circles on:(IplImage*) iplImage {
    for (Circle* circle in circles) {
        cvCircle(iplImage, cvPoint(circle.x, circle.y), circle.r, CV_RGB(255,0,0), 3, 8, 0);
    }
    return iplImage;
}

@end
