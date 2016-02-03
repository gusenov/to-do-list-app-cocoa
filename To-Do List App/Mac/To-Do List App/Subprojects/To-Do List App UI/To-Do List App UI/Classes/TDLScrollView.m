//
//  TDLScrollView.m
//  To-Do List App UI
//
//  Created by Abbas Gussenov on 12/23/15.
//  Copyright © 2015 Gussenov Lab. All rights reserved.
//

#import "TDLScrollView.h"
#import "TDLScroller.h"

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

- (id)initWithFrame:(NSRect)aFrameRect
{
    self = [super initWithFrame:aFrameRect];
    if (self) {
        [self setHasVerticalScroller:YES];
        TDLScroller *theVerticalScroller = [[TDLScroller alloc] init];
        [self setVerticalScroller:theVerticalScroller];
        
        [self setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self setBackgroundColor:[NSColor colorWithPatternImage:[NSImage imageNamed:@"to-do_list_app_row_bg"]]];
    }
    return self;
}

- (void)drawRect:(NSRect)aDirtyRect
{
    [super drawRect:aDirtyRect];
    
    // Drawing code here.
}

@end
