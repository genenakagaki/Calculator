//
//  History.m
//  Calculator
//
//  Created by User on 12/17/15.
//  Copyright (c) 2015 Lehman College. All rights reserved.
//

#import "History.h"

@interface History()

@property (nonatomic)NSString *history;

@end

@implementation History

@synthesize history = _history;

- (NSString *)history {
    if (!_history) {
        _history = @"";
    }
    
    return _history;
}

NSString *const ADD  = @"Addition";
NSString *const SUB  = @"Subtraction";
NSString *const MULT = @"Multiplication";
NSString *const DIV  = @"Division";
NSString *const MOD  = @"Modulo";

- (void)addHistory:(NSString *)expression {
    self.history = [self.history stringByAppendingString:expression];
    self.history = [self.history stringByAppendingString:@"\n"];
}

- (BOOL)isAddition:(NSString *)expression {
    for (int i = 0; i < expression.length; i++) {
        NSString *character = [expression substringWithRange:NSMakeRange(i, 0)];
        if ([character isEqualToString:@"+"]) {
            return YES;
        }
    }
    
    return NO;
}

@end
