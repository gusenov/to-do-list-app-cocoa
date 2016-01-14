//
//  TDLItem.m
//  To-Do List App UI
//
//  Created by Abbas on 12/25/15.
//  Copyright © 2015 Gussenov. All rights reserved.
//

#import "TDLItem.h"

@implementation TDLItem

#pragma mark - TDLItem

- (id)initWithTitle:(NSString *)aTitle completed:(BOOL)aCompleted
{
    self = [self init];
    if (self) {
        _title = aTitle;
        _isCompleted = aCompleted;
    }
    return self;
}

- (void)setCompleted:(BOOL)aCompleted
{
    _isCompleted = aCompleted;
}

@end
