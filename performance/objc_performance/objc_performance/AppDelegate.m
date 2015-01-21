//
//  AppDelegate.m
//  objc_performance
//
//  Created by Patrick Englert on 21.01.15.
//  Copyright (c) 2015 Patrick Englert. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    int times = 5;
    [self mappedTwoDimensionalArray:times];
//        dictArrays(times)
    [self floats:times];
    [self arrayAccessing:times];
    [self twoDimArray:times];
//        
//        
//        
//        
}
    


- (void)mappedTwoDimensionalArray:(int)times {
        if (times == 0) {
            return;
        }
    
        int arr[180000];
    
        for (int i = 0; i < 180000; i++)
            arr[i] = 1;

        
        NSDate *start = [NSDate date];
        for (int x = 0; x < 1000000; x++) {
            int tmp = x%180 * 1000 + x%1000;
            arr[tmp]++;
        }
        
        NSDate *end = [NSDate date];
        NSLog(@"One-Dimensional Array with mapped 2nd Dimension: %f", [end timeIntervalSinceDate:start]);
    
        [self mappedTwoDimensionalArray:times-1];
    }
    
//- (void) dictArrays:(int)times {
//    if (times == 0) {
//        return;
//    }
//        
//    int n = 10000000;
//    
//    NSDictionary *dict = [[NSDictionary alloc] init];
//        
//    for (int i = 0; i < 180;) {
//        int arr[1000];
//
//        dict[i] = arr;
//    }
//        
//        
//        var start = NSDate()
//        for x in 0...1000000-1 {
//            var i = x%180
//            var arr = dict.removeValueForKey(i)
//            arr![x%1000]++
//            dict.updateValue(arr!, forKey: i)
//            
//        }
//        
//        
//        var end = NSDate()
//        var interval: Double = end.timeIntervalSinceDate(start)
//        
//        println("Dictionary with arrays: \(interval)")
//        dictArrays(times - 1)
//    }
//
-(void) floats:(int)times {
        if (times == 0) {
            return;
        }
        
    int n = 10000000;
    float x = 0.999999;
    float a = 1.0;
    NSDate *start = [NSDate date];
    for (int i = 0; i < n-1; i++) {
        a = a * x;
        }
        
    NSDate *end = [NSDate date];
    NSLog(@"Multiplying floats: %f last float: %f", [end timeIntervalSinceDate:start], a);
    [self floats:times-1];
    }
    
//
-(void) arrayAccessing:(int)times {
        if (times == 0) {
            return;
        }
    int n = 10000;
    int x[10000];
    for (int i = 0; i < n; i++)
        x[i] = 1;
    
    
    NSDate *start = [NSDate date];
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                x[i] = x[j]++;
            }
        }
        
    NSDate *end = [NSDate date];

    NSLog(@"Accessing array: %f", [end timeIntervalSinceDate:start]);
    [self arrayAccessing:times-1];
    }
//
-(void) twoDimArray:(int)times {
        if (times == 0) {
            return;
        }
    
    //arr = [[Int]](count: 180, repeatedValue: [Int](count: 1000, repeatedValue: 2))
    int arr[180][1000];
    for (int x = 0; x < 180; x++) {
        for (int y = 0; y < 1000; y++) {
            arr[x][y] = 2;
        }
    }
    NSDate *start2 = [NSDate date];
    
    for (int i = 0; i < 1000000; i++) {
        arr[i%180][i%1000]++;
        }
        
        
    NSDate *end2 = [NSDate date];
    
    NSLog(@"Two-Dimensional array: %f", [end2 timeIntervalSinceDate:start2]);
    [self twoDimArray:times-1];
    }


- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

@end
