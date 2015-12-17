//
//  Postfix.m
//  Calculator
//
//  Created by User on 12/14/15.
//  Copyright (c) 2015 Lehman College. All rights reserved.
//

#import "Postfix.h"

@interface Postfix()

@property NSMutableArray *postfix;

@end

@implementation Postfix

- (instancetype)initWithArray:(NSArray *)postfix {
    self = [super init];
    
    self.postfix = [postfix mutableCopy];
    
    return self;
}

- (NSString *)evaluate {
    // show postfix to evaluate
    NSString *postfixString = @"";
    for (NSString *string in self.postfix) {
        postfixString = [postfixString stringByAppendingString:string];
        postfixString = [postfixString stringByAppendingString:@" "];
    }
    
    NSLog(@"evaluate: %@", postfixString);
    
    Stack *evalStack = [[Stack alloc] init];
    
    for (NSString *string in self.postfix) {
        if (evalStack.isEmpty || [Calculator isNumber:string]) {
            [evalStack push:string];
            
        } else if ([Calculator isOperator:string]) {
            // calculate with operator
            double result;
            
            double first = [[evalStack pop] doubleValue];
            
            if ([Calculator isScientificOperator:string]) {
                if ([string isEqualToString:@"^"]) {
                    double second = [[evalStack pop] doubleValue];
                    result = pow(second, first);
                }
                else if ([string isEqualToString:@"√"])
                    result = sqrt(first);
                else if ([string isEqualToString:@"sin"])
                    result = sin(first);
                else if ([string isEqualToString:@"cos"])
                    result = cos(first);
                else if ([string isEqualToString:@"tan"])
                    result = tan(first);
                
            } else {
                double second = [[evalStack pop] doubleValue];
                
                if ([string isEqualToString:@"+"])
                    result = second + first;
                else if ([string isEqualToString:@"-"])
                    result = second - first;
                else if ([string isEqualToString:@"x"])
                    result = second * first;
                else if ([string isEqualToString:@"÷"])
                    result = second / first;
                else if ([string isEqualToString:@"%"])
                    result = fmod(second, first);
            }
            
            
            NSString *resultStr = [NSString stringWithFormat:@"%f", result];
            [evalStack push:resultStr];
        }
    }
    
    NSString *result = [evalStack pop];
    
    NSLog(@"    result: %@", result);
    
    return result;
}

@end
