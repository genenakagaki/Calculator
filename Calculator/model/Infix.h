//
//  Infix.h
//  Calculator
//
//  Created by User on 12/7/15.
//  Copyright (c) 2015 Lehman College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calculator.h"
#import "Stack.h"
@class Postfix;

@interface Infix : NSObject

- (instancetype)initWithExpression:(NSString *)expression;

- (Postfix *)toPostfix;
- (BOOL)error;
- (NSString *)errorMessage;

- (NSString *)toString;

@end
