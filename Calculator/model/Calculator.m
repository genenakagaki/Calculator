//
//  Calculator.m
//  Calculator
//
//  Created by User on 12/2/15.
//  Copyright (c) 2015 Lehman College. All rights reserved.
//

#import "Calculator.h"

@interface Calculator()

@property (nonatomic)NSString *expression;
@property (nonatomic)double result;

@property (nonatomic)BOOL calculated;

@property (nonatomic)History *history;

@end

@implementation Calculator

@synthesize history = _history;

- (History *)history {
    if (!_history) {
        _history = [[History alloc] init];
    }
    
    return _history;
}

- (void)calculate {
    
    if (self.expression == nil || self.expression.length == 0) {
        return;
    }
    
    Infix *infix = [[Infix alloc] initWithExpression:self.expression];
    Postfix *postfix = [infix toPostfix];
    
    if (infix.error) {
        self.expression = infix.errorMessage;
        
    } else {
        self.expression = [postfix evaluate];
    }
    
    NSString *result = [infix toString];
    result = [result stringByAppendingString:@" = "];
    result = [result stringByAppendingString:self.expression];
    
    [self.history addHistory:result];
    
    self.calculated = YES;
}

- (void)allClear {
    NSLog(@"allClear");
    
    [self.history addHistory:@"Cleared"];
    
    self.expression = @"";
}

- (void)clearEntry {
    // remove last operator or number
    [self.expression substringToIndex:self.expression.length -2];
}

- (void)appendToExpression:(NSString *)character {
    NSLog(@"appendToExpression: %@", character);
    
    if (self.expression == nil) {
        self.expression = character;
        if ([Calculator isScientificOperator:character]) {
            self.expression = [self.expression stringByAppendingString:@"("];
        }
    }
    else {
        if (self.calculated) {
            self.calculated = NO;
            if ([self.expression isEqualToString:@"Wrong input"]) {
                [self allClear];
            }
            if ([Calculator isNumber:character]) {
                self.expression = character;
            } else {
                if ([Calculator isScientificOperator:character]) {
                    if ([character isEqualToString:@"^"]) {
                        self.expression = [self.expression stringByAppendingString:character];
                        if ([Calculator isScientificOperator:character]) {
                            self.expression = [self.expression stringByAppendingString:@"("];
                        }
                    // if sin cos tan or sqrt
                    } else {
                        self.expression = character;
                        self.expression = [self.expression stringByAppendingString:@"("];
                    }
                } else {
                    self.expression = [self.expression stringByAppendingString:character];
                    if ([Calculator isScientificOperator:character]) {
                        self.expression = [self.expression stringByAppendingString:@"("];
                    }
                }
            }
        } else {
            self.expression = [self.expression stringByAppendingString:character];
            if ([Calculator isScientificOperator:character]) {
                self.expression = [self.expression stringByAppendingString:@"("];
            }
        }
    }
    
    NSLog(@"    expression: %@", self.expression);
}

- (double)getResult {
    return self.result;
}

- (NSString *)getExpressionString {
    NSLog(@"getExpressionString: %@", self.expression);
    return self.expression;
}

+ (int)getPrecedence:(NSString *)operator {
    if ([operator isEqualToString:@"("]) {
        return 0;
    } else if ([operator isEqualToString:@"+"] || [operator isEqualToString:@"-"]) {
        return 1;
    } else if ([operator isEqualToString:@"x"]
               || [operator isEqualToString:@"÷"]
               || [operator isEqualToString:@"%"]) {
        return 2;
    } else if ([self isScientificOperator:operator]) {
        return 3;
    }
    
    return 0;
}

+ (BOOL)isNumber:(NSString *)str {
    if (str.length > 1) {
        str = [str substringFromIndex:str.length-1];
    }
    
    NSArray *numbers = @[@".", @"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"];
    
    for (NSString *number in numbers) {
        if ([str isEqualToString:number]) {
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)isOperator:(NSString *)str {
    
    NSArray *operators = @[@"+", @"-", @"x", @"÷", @"%", @"^", @"√", @"sin", @"cos", @"tan", @"(", @")"];
    
    for (NSString *operator in operators) {
        if ([str isEqualToString:operator]) {
            return YES;
        }
    }
    
    return NO;
}

+ (BOOL)isScientificOperator:(NSString *)str {
    
    NSArray *operators = @[@"^", @"√", @"sin", @"cos", @"tan"];
    
    for (NSString *operator in operators) {
        if ([str isEqualToString:operator]) {
            return YES;
        }
    }
    
    return NO;
}

@end
