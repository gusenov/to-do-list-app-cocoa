//
//  TDLBtnNew.m
//  To-Do List App UI
//
//  Created by Gussenov on 1/30/16.
//  Copyright © 2016 Gussenov. All rights reserved.
//

#import "TDLBtnNew.h"

@implementation TDLBtnNew

- (void)setTitle:(NSString *)aTitle
{
    [super setTitle:aTitle];
    
    NSMutableAttributedString *theColorTitle = [[NSMutableAttributedString alloc]
        initWithAttributedString:[self attributedTitle]];
    [theColorTitle addAttribute:NSForegroundColorAttributeName
                          value:[NSColor whiteColor]
                          range:NSMakeRange(0, [theColorTitle length])];
    [self setAttributedTitle:theColorTitle];
}

#pragma mark - NSView

- (id)initWithFrame:(NSRect)aFrameRect
{
    self = [super initWithFrame:aFrameRect];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.autoresizingMask = NSViewMinXMargin;
        self.bezelStyle = NSInlineBezelStyle;
        self.bordered = NO;
        [self setImagePosition:NSImageOverlaps];
        [self setButtonType:NSMomentaryChangeButton];
        [self.cell setImageScaling:NSImageScaleProportionallyDown];
        [self setImage:[NSImage imageNamed:@"to-do_list_app_btn_new"]];
        [self setFont:[NSFont fontWithName:@"Arial Bold" size:12]];
    }
    return self;
}

- (void)drawRect:(NSRect)aDirtyRect
{
    [super drawRect:aDirtyRect];
    
    // Drawing code here.
}

@end
