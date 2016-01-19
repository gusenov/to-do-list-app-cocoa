//
//  PSBPanel.m
//  PopupInStatusBar
//
//  Created by Abbas on 12/5/15.
//  Copyright © 2015 Gussenov. All rights reserved.
//

#import "PSBPanel.h"
#import "PSBBgView.h"

@implementation PSBPanel

#pragma mark - NSWindow

- (BOOL)canBecomeKeyWindow
{
    return YES;
}

- (id)initWithContentRect:(NSRect)aContentRect
                styleMask:(NSUInteger)aStyle
                  backing:(NSBackingStoreType)aBufferingType
                    defer:(BOOL)aFlag
{
    self = [super initWithContentRect:aContentRect
                            styleMask:aStyle
                              backing:aBufferingType
                                defer:aFlag];
    if (self) {
        PSBBgView *theBgView = [[PSBBgView alloc]
            initWithFrame:NSMakeRect(0, 0, aContentRect.size.width, aContentRect.size.height)];
        [self setContentView:theBgView];

    }
    return self;
}

@end
