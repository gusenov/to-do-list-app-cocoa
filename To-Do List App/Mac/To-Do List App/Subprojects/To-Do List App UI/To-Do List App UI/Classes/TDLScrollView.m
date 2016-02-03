//
//  TDLScrollView.m
//  To-Do List App UI
//
//  Created by Abbas Gussenov on 12/23/15.
//  Copyright © 2015 Gussenov Lab. All rights reserved.
//

#import "TDLScrollView.h"

@implementation TDLScrollView

- (void)scrollToTop
{
    NSPoint theNewScrollOrigin;
    if ([[self documentView] isFlipped]) {
        theNewScrollOrigin = NSMakePoint(0.0, 0.0);
    } else {
        theNewScrollOrigin = NSMakePoint(0.0
            , NSMaxY([[self documentView] frame]) - NSHeight([[self contentView] bounds]));
    }
    [[self documentView] scrollPoint:theNewScrollOrigin];
}

#pragma mark - NSScrollView

- (void)scrollWheel:(NSEvent *)anEvent
{
    [super scrollWheel:anEvent];
}

#pragma mark - NSView

- (void)drawRect:(NSRect)aDirtyRect
{
    [super drawRect:aDirtyRect];
    
    // Drawing code here.
}

@end
