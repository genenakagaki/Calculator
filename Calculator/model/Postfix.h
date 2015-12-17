//
//  Postfix.h
//  Calculator
//
//  Created by User on 12/14/15.
//  Copyright (c) 2015 Lehman College. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stack.h"
#import "Calculator.h"

@interface Postfix : NSObject

- (instancetype)initWithArray:(NSArray *)postfix;

- (NSString *)evaluate;

@end