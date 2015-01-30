//
//  struct-objc.m
//  
//
//  Created by Alex on 13.01.15.
//
//

#import <Foundation/Foundation.h>

struct Bruch{ // obj-c struct
    int zähler;
    int nenner;
};

@interface BruchService : NSObject
    - (void) multiply: (struct Bruch) bruch; // methoden bekanntmachen
@end

@implementation BruchService
    - (struct Bruch) multiply: (struct Bruch) this with: (struct Bruch) that {
    struct Bruch ergebnis;
    ergebnis.zähler = this.zähler * that.zähler;
    ergebnis.nenner = this.nenner * that.nenner;
    return ergebnis;
} // methoden implementierung
@end

int main() {
    struct Bruch a, b, ergebnis;
    
    a.zähler = 3;
    a.nenner = 5;
    b.zähler = 10;
    b.nenner = 2;
    
    BruchService *bruchService = [[BruchService alloc] init];
    ergebnis = [bruchService multiply:a with:b];
    
    return 0;
}
