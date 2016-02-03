//
//  TDLScroller.m
//  To-Do List App UI
//
//  Created by Abbas Gussenov on 2/4/16.
//  Copyright © 2016 Gussenov Lab. All rights reserved.
//

#import "TDLScroller.h"

@implementation TDLScroller

#pragma mark - NSView

- (void)drawRect:(NSRect)aDirtyRect
{
    [super drawRect:aDirtyRect];
    
    // Drawing code here.
}

- (void)setHidden:(BOOL)aFlag
{
    // Ugly hack: make sure we are always hidden.
    [super setHidden:YES];
}

#pragma mark - NSScroller

+ (CGFloat)scrollerWidthForControlSize:(NSControlSize)aControlSize
                         scrollerStyle:(NSScrollerStyle)aScrollerStyle
{
    return 0;
}

+ (BOOL)isCompatibleWithOverlayScrollers
{
    // Let this scroller sit on top of the content view, rather than next to it.
    return YES;
}

@end
