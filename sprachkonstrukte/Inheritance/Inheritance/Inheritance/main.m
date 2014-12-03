//
//  main.m
//  Inheritance
//
//  Created by Stefan Heruth on 03.12.14.
//  Copyright (c) 2014 Stefan Heruth. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

{
    NSString *name;
}

- (id)initWithName:(NSString *)name;
@end

@implementation Person

- (id)initWithName:(NSString *)name{
    name = name;
    return self;
}

@end

@interface Arbeitnehmer : Person

{
    NSString *arbeitgeber;
}

- (id)initWithName:(NSString *)name
      andArbeitgeber:(NSString *)arbeitgeber;

@end


@implementation Arbeitnehmer

- (id)initWithName:(NSString *)name
      andArbeitgeber: (NSString *)arbeitgeber
{
    name = name;
    arbeitgeber = arbeitgeber;
    return self;
}


@end


int main(int argc, const char * argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    Person *person = [[Person alloc]initWithName:@"Raj"];
    
    Arbeitnehmer *employee = [[Arbeitnehmer alloc]initWithName:@"Raj"
                                                andEducation:@"MBA"];
    
    [pool drain];
    return 0;
}
