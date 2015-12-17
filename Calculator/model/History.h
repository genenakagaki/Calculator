//
//  History.h
//  Calculator
//
//  Created by User on 12/17/15.
//  Copyright (c) 2015 Lehman College. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface History : NSObject

- (void)addHistory:(NSString *)expression;

- (NSString *)history;

@end
