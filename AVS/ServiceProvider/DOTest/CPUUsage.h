//
//  CPUUsage.h
//  DOTest
//
//  Created by Alexander Dobrynin on 26.11.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#include <sys/sysctl.h>
#include <sys/types.h>
#include <mach/mach.h>
#include <mach/processor_info.h>
#include <mach/mach_host.h>
#include "InformantProtocol.h"

@interface CPUUsage : NSObject

@end
