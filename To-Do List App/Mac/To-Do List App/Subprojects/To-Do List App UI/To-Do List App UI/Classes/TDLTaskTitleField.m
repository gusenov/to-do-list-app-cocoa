//
//  TDLTaskTitleField.m
//  To-Do List App UI
//
//  Created by Abbas Gussenov on 2/3/16.
//  Copyright © 2016 Gussenov Lab. All rights reserved.
//

#import "TDLTaskTitleField.h"


@interface TDLTaskTitleField ()

@property (strong) NSTrackingArea *trackingArea;

@end


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

- (void)updateTrackingAreas
{
    if (self.trackingArea != nil) {
        [self removeTrackingArea:self.trackingArea];
        self.trackingArea = nil;
    }
    int theOptions = (NSTrackingMouseEnteredAndExited | NSTrackingActiveAlways);
    self.trackingArea = [ [NSTrackingArea alloc] initWithRect:[self bounds]
                                                      options:theOptions
                                                        owner:self
                                                     userInfo:nil];
    [self addTrackingArea:self.trackingArea];
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

- (void)mouseEntered:(nonnull NSEvent *)anEvent
{
    [super mouseEntered:anEvent];
    
    NSRect theExpansionRect = [[self cell] expansionFrameWithFrame:self.frame
                                                         inView:self];
    BOOL theTruncating = !NSEqualRects(NSZeroRect, theExpansionRect);
    if (theTruncating) [self setToolTip:self.stringValue];
}

- (void)mouseExited:(nonnull NSEvent *)anEvent
{
    [super mouseExited:anEvent];
    
    [self setToolTip:nil];
}

#pragma mark - NSTextField

- (void)textDidEndEditing:(NSNotification *)aNotification;
{
    [super textDidEndEditing:aNotification];
    
    [self setEditable:NO];
}

- (void)setStringValue:(NSString * __nonnull)aStringValue
{
    [super setStringValue:aStringValue];
}

@end
