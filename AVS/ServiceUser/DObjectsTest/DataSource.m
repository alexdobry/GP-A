//
//  DataSource.m
//  DObjectsTest
//
//  Created by Markus Müller on 19.11.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "DataSource.h"
#import "HoughImage.h"

@implementation DataSource

@synthesize capture = _capture;
@synthesize counter = _counter;
@synthesize lastShownImageId = _lastShownImageId;

- (id)init {
    self = [super init];
    if (self) {
        self.counter = 0;
        self.capture = cvCaptureFromCAM(-1);
        if (!self.capture) {
            NSLog(@"Cannot initialize webcam");
        }
        self.lastShownImageId = -1;
    }
    return self;
}

-(HoughImage*)getNextDataset {
    @synchronized(self) {
        return [[HoughImage alloc] initWithIplImage:cvCloneImage(cvQueryFrame(self.capture)) andId:self.counter++];
    }
}

-(bool)showImage:(HoughImage*) houghImg {
    @synchronized(self) {
        if (houghImg.imgId > self.lastShownImageId) {
            self.lastShownImageId = houghImg.imgId;
            return true;
        } else {
            return false;
        }
    }
}

@end
