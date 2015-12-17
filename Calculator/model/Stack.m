//
//  Stack.m
//  Calculator
//
//  Created by User on 12/2/15.
//  Copyright (c) 2015 Lehman College. All rights reserved.
//

#import "Stack.h"

@interface Stack()

@property (nonatomic)NSMutableArray *stack;

@end

@implementation Stack

@synthesize stack = _stack;

- (NSMutableArray *)stack {
    if (!_stack) {
        _stack = [[NSMutableArray alloc] init];
    }
    
    return _stack;
}

- (void)push:(id)object {
    [self.stack insertObject:object atIndex:0];
}

- (id)pop {
    if ([self isEmpty]) {
        return nil;
    }
    
    id object = [self.stack objectAtIndex:0];
    
    [self.stack removeObjectAtIndex:0];
    
    return object;
}

- (id)top {
    if ([self isEmpty]) {
        return nil;
    }
    
    return [self.stack objectAtIndex:0];
}

- (BOOL)isEmpty {
    return [self.stack count] <= 0;
}

- (void)removeAll {
    while ([self.stack count] > 0) {
        [self pop];
    }
}

@end
