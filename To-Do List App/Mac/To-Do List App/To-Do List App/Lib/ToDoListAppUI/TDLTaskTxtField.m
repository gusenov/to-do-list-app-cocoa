//
//  TDLTaskTxtField.m
//  To-Do List App UI
//
//  Created by Abbas Gussenov on 1/29/16.
//  Copyright © 2016 Gussenov Lab. All rights reserved.
//

#import "TDLTaskTxtField.h"


#define TASK_TXT_FIELD_DEF_VALUE @"Type your task..."


@interface TDLTaskTxtField ()

@end


@implementation TDLTaskTxtField

#pragma mark - TDLTaskTxtField

- (void)setDefaultValue
{
    self.stringValue = TASK_TXT_FIELD_DEF_VALUE;
}

#pragma mark - NSView

- (void)drawRect:(NSRect)aDirtyRect
{
    [super drawRect:aDirtyRect];
    
    // Drawing code here.
}

#pragma mark - NSControl

- (void)mouseDown:(NSEvent *)anEvent
{
    if ([self.stringValue isEqualToString:TASK_TXT_FIELD_DEF_VALUE]) {
        self.stringValue = @"";
    }
}

@end
