//
//  MachineThread.h
//  DObjectsTest
//
//  Created by Markus Müller on 19.11.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HoughTransformationProtocol.h"
#import "InformantProtocol.h"
#import "DataSource.h"
#import "NSImage+IplImage.h"

#import "Circle.h"
#include <opencv/cv.h>
#include <opencv/cxcore.h>
#include <opencv/highgui.h>
#include <math.h>

@interface Machine : NSObject

@property(retain) NSString* portName;
@property BOOL connected;

@property(retain) DataSource* dataSource;

@property(retain) NSThread* statusThread;
@property(retain) NSThread* workerThread;

-(Machine*) initWithName:(NSString*)name dataSource:(DataSource*)source;
-(IplImage*) drawCircles:(NSMutableArray*) circles on:(IplImage*) iplImage;

@end
