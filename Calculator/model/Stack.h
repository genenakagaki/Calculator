//
//  Stack.h
//  Calculator
//
//  Created by User on 12/2/15.
//  Copyright (c) 2015 Lehman College. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject

- (void)push:(id)object;
- (id)pop;
- (id)top;

- (BOOL)isEmpty;
- (void)removeAll;

@end
