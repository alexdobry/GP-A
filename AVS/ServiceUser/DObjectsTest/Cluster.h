//
//  ClusterManager.h
//  DObjectsTest
//
//  Created by Markus Müller on 19.11.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataSource.h"
#import "Machine.h"

@interface Cluster : NSObject

@property(retain) DataSource* dataSource;
@property(retain) NSMutableArray* machineThreads;

-(Cluster*) initWithDataSource:(DataSource* )source andProviderNames:(NSArray*) providerNames;

@end
