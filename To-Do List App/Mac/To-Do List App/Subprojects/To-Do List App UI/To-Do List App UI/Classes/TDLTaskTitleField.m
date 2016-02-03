//
//  TDLTaskTitleField.m
//  To-Do List App UI
//
//  Created by Abbas Gussenov on 2/3/16.
//  Copyright © 2016 Gussenov Lab. All rights reserved.
//

#import "TDLTaskTitleField.h"

@implementation TDLTaskTitleField

#pragma mark - TDLTaskTitleField

@synthesize editMode = _editMode;

- (BOOL)editMode
{
    return _editMode;
}

- (void)setEditMode:(BOOL)aValue
{
    _editMode = aValue;
    if (!_editMode) {
        [self setEditable:NO];
    }
}

#pragma mark - NSView

- (void)drawRect:(NSRect)aDirtyRect
{
    [super drawRect:aDirtyRect];
    
    // Drawing code here.
}

- (BOOL)acceptsFirstMouse:(NSEvent *)anEvent
{
    return [super acceptsFirstMouse:anEvent];
}

#pragma mark - NSResponder 

- (BOOL)resignFirstResponder
{
    return [super resignFirstResponder];
}

#pragma mark - NSControl

- (void)mouseDown:(NSEvent *)anEvent
{    
    if (self.editMode) {
        [self setEditable:YES];
        [[self window] makeFirstResponder:self];
    }
}

#pragma mark - NSTextField

- (void)textDidEndEditing:(NSNotification *)aNotification;
{
    [super textDidEndEditing:aNotification];
    
    [self setEditable:NO];
}

@end
