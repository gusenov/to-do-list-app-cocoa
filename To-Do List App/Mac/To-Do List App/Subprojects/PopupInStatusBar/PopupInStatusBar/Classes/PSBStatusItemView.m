//
//  PSBStatusItemView.m
//  PopupInStatusBar
//
//  Created by Abbas Gussenov on 12/5/15.
//  Copyright © 2015 Gussenov Lab. All rights reserved.
//

#import "PSBStatusItemView.h"

@implementation PSBStatusItemView

#pragma mark - PSBStatusItemView

- (id)initWithStatusItem:(NSStatusItem *)aStatusItem
{
    CGFloat theItemWidth = [aStatusItem length];
    CGFloat theItemHeight = [[NSStatusBar systemStatusBar] thickness];
    NSRect theItemRect = NSMakeRect(0.0, 0.0, theItemWidth, theItemHeight);
    self = [super initWithFrame:theItemRect];
    if (self != nil) {
        _statusItem = aStatusItem;
        _statusItem.view = self;
    }
    return self;
}

- (NSRect)globalRect
{
    NSRect theFrame = [self frame];
    return [self.window convertRectToScreen:theFrame];
}

- (void)setHighlighted:(BOOL)aNewFlag
{
    if (_isHighlighted == aNewFlag) return;
    _isHighlighted = aNewFlag;
    [self setNeedsDisplay:YES];
}

- (void)setImage:(NSImage *)aNewImage
{
    if (_image != aNewImage) {
        _image = aNewImage;
        [self setNeedsDisplay:YES];
    }
}

- (void)setAlternateImage:(NSImage *)aNewImage
{
    if (_alternateImage != aNewImage) {
        _alternateImage = aNewImage;
        if (self.isHighlighted) {
            [self setNeedsDisplay:YES];
        }
    }
}

#pragma mark - NSView

- (void)drawRect:(NSRect)aDirtyRect
{
    [super drawRect:aDirtyRect];
    
    // Drawing code here.
    
    // Set up dark mode for icon
    if ([[[NSUserDefaults standardUserDefaults] stringForKey:@"AppleInterfaceStyle"] isEqual:@"Dark"]) {
        self.image = [NSImage imageNamed:@"StatusHighlighted"];
    } else {
        if (self.isHighlighted) {
            self.image = [NSImage imageNamed:@"StatusHighlighted"];
        } else {
            self.image = [NSImage imageNamed:@"Status"];
        }
    }
    [self.statusItem drawStatusBarBackgroundInRect:aDirtyRect withHighlight:self.isHighlighted];
    
    NSImage *theIcon = self.image;
    NSSize theIconSize = [theIcon size];
    NSRect theBounds = self.bounds;
    CGFloat theIconX = roundf((NSWidth(theBounds) - theIconSize.width) / 2);
    CGFloat theIconY = roundf((NSHeight(theBounds) - theIconSize.height) / 2);
    NSPoint theIconPoint = NSMakePoint(theIconX, theIconY);
    
    [theIcon drawAtPoint:theIconPoint
                fromRect:NSZeroRect
               operation:NSCompositeSourceOver
                fraction:1.0];
}

#pragma mark - NSResponder

- (void)mouseDown:(NSEvent *)anEvent
{
    [NSApp sendAction:self.action
                   to:self.target
                 from:self];
}

@end
