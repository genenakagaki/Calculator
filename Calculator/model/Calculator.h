//
//  Calculator.h
//  Calculator
//
//  Created by User on 12/2/15.
//  Copyright (c) 2015 Lehman College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stack.h"
#import "Infix.h"
#import "Postfix.h"
#import "History.h"

@interface Calculator : NSObject

- (void)calculate;
- (void)allClear;
- (void)clearEntry;
- (void)appendToExpression:(NSString *)character;

- (double)getResult;
- (NSString *)getExpressionString;
- (History *)history;

+ (int)getPrecedence:(NSString *)operator;
+ (BOOL)isNumber:(NSString *)str;
+ (BOOL)isOperator:(NSString *)str;
+ (BOOL)isScientificOperator:(NSString *)str;

@end