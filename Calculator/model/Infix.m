//
//  Infix.m
//  Calculator
//
//  Created by User on 12/7/15.
//  Copyright (c) 2015 Lehman College. All rights reserved.
//

#import "Infix.h"

@interface Infix()

@property (nonatomic)NSMutableArray *infix;
@property (nonatomic)BOOL error;
@property (nonatomic)NSString *errorMessage;

@end

@implementation Infix

@synthesize error = _error;
@synthesize errorMessage = _errorMessage;

- (BOOL)error {
    return _error;
}

- (NSString *)errorMessage {
    return _errorMessage;
}

- (instancetype)initWithExpression:(NSString *)expression {
    self = [super init];
    
    [self toInfix:expression];
    
    return self;
}

- (void)toInfix:(NSString *)expression {
    NSLog(@"toInfix: %@", expression);
    
    self.infix = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < expression.length; i++) {
        NSString *character = [expression substringWithRange:NSMakeRange(i, 1)];
        
        if ([Calculator isNumber:character]) {
            NSString *lastString = [self.infix lastObject];
            NSString *lastChar = [lastString substringFromIndex:lastString.length -1];
            
            if ([self.infix count] == 0) {
                [self.infix addObject:character];
            }
            else if ([Calculator isNumber:lastChar]) {
                lastString = [lastString stringByAppendingString:character];
                [self.infix removeLastObject];
                [self.infix addObject:lastString];
            }
            else if ([Calculator isOperator:lastChar]) {
                [self.infix addObject:character];
            }
        }
        else if ([Calculator isOperator:character]) {
            [self.infix addObject:character];
        }
        else if ([character isEqualToString:@"s"]) {
            [self.infix addObject:@"sin"];
        }
        else if ([character isEqualToString:@"c"]) {
            [self.infix addObject:@"cos"];
        }
        else if ([character isEqualToString:@"t"]) {
            [self.infix addObject:@"tan"];
        }
    }
    
    // DEBUG
    NSString *infixString = @"";
    
    for (int i = 0; i < [self.infix count]; i++) {
        infixString = [infixString stringByAppendingString:[self.infix objectAtIndex:i]];
        infixString = [infixString stringByAppendingString:@" "];
    }
    
    NSLog(@"    infixString: %@", infixString);
    
}

- (Postfix *)toPostfix {
    NSLog(@"toPostfix");
    
    NSMutableArray *postfix = [[NSMutableArray alloc] init];
    Stack *operatorStack = [[Stack alloc] init];
    
    for (NSString *string in self.infix) {
        NSLog(@"    string: %@", string);
        
        if ([postfix count] <= 0) {
            if ([Calculator isOperator:string]) {
                if ([string isEqualToString:@"("])
                    [operatorStack push:string];
                else if ([string isEqualToString:@"sin"])
                    [operatorStack push:string];
                else if ([string isEqualToString:@"cos"])
                    [operatorStack push:string];
                else if ([string isEqualToString:@"tan"])
                    [operatorStack push:string];
                else {
                    self.error = YES;
                    self.errorMessage = @"Wrong input";
                }
            }
            else if ([Calculator isNumber:string]) {
                [postfix addObject:string];
            }
        }
        else if ([Calculator isNumber:string]) {
            NSLog(@"    isNumber");
            
            [postfix addObject:string];
        }
        else if ([Calculator isOperator:string]) {
            
            NSLog(@"    isOperator");
            
            NSLog(@"    top: %@", [operatorStack top]);
            int topPrecedence = [Calculator getPrecedence:[operatorStack top]];
            int characterPrecedence = [Calculator getPrecedence:string];
            if ([operatorStack top] == nil) {
                [operatorStack push:string];
            }
            else if ([string isEqualToString:@"("]) {
                [operatorStack push:string];
            }
            else if ([string isEqualToString:@")"]) {
                NSString *operator = [operatorStack pop];
                
                while (![operator isEqualToString:@"("]) {
                    [postfix addObject:operator];
                    
                    if (operatorStack.top == nil) {
                        self.error = YES;
                        self.errorMessage = @"Wrong input";
                        break;
                    }
                    
                    operator = [operatorStack pop];
                    NSLog(@"%@", operator);
                }
            }
            else if (topPrecedence < characterPrecedence) {
                NSLog(@"pushing: %@", string);
                [operatorStack push:string];
            }
            else if (topPrecedence >= characterPrecedence) {
                
                while (topPrecedence >= characterPrecedence) {
                    NSString *operator = [operatorStack pop];
                    
                    [postfix addObject:operator];
                    
                    topPrecedence = [Calculator getPrecedence:[operatorStack top]];
                }
                
                [operatorStack push:string];
            }
        // if its not a valid input
        } else {
            self.error = YES;
            self.errorMessage = @"Wrong input";
        }
    }
    
    while (![operatorStack isEmpty]) {
        NSString *operator = [operatorStack pop];
        if ([operator isEqualToString:@"("]) {
            self.error = YES;
            self.errorMessage = @"Wrong input";
        }
        [postfix addObject:operator];
    }
    
    // DEBUG
    NSString *postfixString = @"";
    for (int i = 0; i < [postfix count]; i++) {
        postfixString = [postfixString stringByAppendingString:[postfix objectAtIndex:i]];
        postfixString = [postfixString stringByAppendingString:@" "];
    }
    
    NSLog(@"    postfix: %@",postfixString);
    
    return [[Postfix alloc] initWithArray:postfix];
}

- (NSString *)toString {
    NSString *result = @"";
    
    for (NSString *string in self.infix) {
        result = [result stringByAppendingString:string];
    }
    
    return result;
}

@end
