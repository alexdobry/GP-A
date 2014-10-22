//
//  CPUUsage.m
//  DOTest
//
//  Created by Alexander Dobrynin on 26.11.13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "CPUUsage.h"

@implementation CPUUsage

processor_info_array_t cpuInfo, prevCpuInfo;
mach_msg_type_number_t numCpuInfo, numPrevCpuInfo;
unsigned numCPUs;
NSTimer *updateTimer;
NSLock *CPUUsageLock;
float coreUsage[16];

- (CPUUsage*)init
{    
    
    
    int mib[2U] = { CTL_HW, HW_NCPU };
    size_t sizeOfNumCPUs = sizeof(numCPUs);
    
    int status = sysctl(mib, 2U, &numCPUs, &sizeOfNumCPUs, NULL, 0U);
    if(status)
        numCPUs = 1;
    
    CPUUsageLock = [[NSLock alloc] init];
    
    return self;
    
}


- (NSMutableArray*)getInfo
{
    NSMutableArray * coreUsage = [[[NSMutableArray alloc] init] autorelease];
    NSString* usage = @"";
    
    natural_t numCPUsU = 0U;
    kern_return_t err = host_processor_info(mach_host_self(), PROCESSOR_CPU_LOAD_INFO, &numCPUsU, &cpuInfo, &numCpuInfo);
    if(err == KERN_SUCCESS) {
        [CPUUsageLock lock];
        
        for(unsigned i = 0U; i < numCPUs; ++i) {
            float inUse, total;
            if(prevCpuInfo) {
                inUse = (
                         (cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER]   - prevCpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER])
                         + (cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] - prevCpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM])
                         + (cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE]   - prevCpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE])
                         );
                total = inUse + (cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE] - prevCpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE]);
            } else {
                inUse = cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_USER] + cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_SYSTEM] + cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_NICE];
                total = inUse + cpuInfo[(CPU_STATE_MAX * i) + CPU_STATE_IDLE];
            }
            
            //NSLog(@"Core: %u Usage: %f %f %f",i,inUse / total, inUse, total);
            NSLog(@"Core : %u, Usage: %.2f%%", i, inUse / total * 100.f);
            [coreUsage addObject: [NSNumber numberWithFloat:inUse / total * 100.f]];
            usage = [usage stringByAppendingFormat:@"Core: %u, Usage: %.2f%%\n", i, inUse / total * 100.f];
        }
        
        [CPUUsageLock unlock];
        
        if(prevCpuInfo) {
            size_t prevCpuInfoSize = sizeof(integer_t) * numPrevCpuInfo;
            vm_deallocate(mach_task_self(), (vm_address_t)prevCpuInfo, prevCpuInfoSize);
        }
        
        prevCpuInfo = cpuInfo;
        numPrevCpuInfo = numCpuInfo;
        
        cpuInfo = NULL;
        numCpuInfo = 0U;
    } else {
        NSLog(@"Error!");
        [NSApp terminate:nil];
    }
        
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cpu" object:usage];

    return coreUsage;
}


@end
