//
//  PSBPanel.m
//  PopupInStatusBar
//
//  Created by Abbas Gussenov on 12/5/15.
//  Copyright © 2015 Gussenov Lab. All rights reserved.
//

#import "PSBPanel.h"
#import "PSBBgView.h"
#import "PSBPanelCtrl.h"

@implementation PSBPanel

- (void)winDidResize:(NSNotification *)aNotification
{
    PSBBgView *theBgView = self.contentView;
    
    PSBPanelCtrl *theWinCtrl = self.windowController;
    NSRect theStatusRect = [theWinCtrl statusRectForWindow:self];
    NSRect thePanelRect = [self frame];
    
    CGFloat theStatusX = roundf(NSMidX(theStatusRect));
    CGFloat thePanelX = theStatusX - NSMinX(thePanelRect);
    
    theBgView.arrowX = thePanelX;
}

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
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(winDidResize:)
                                                     name:NSWindowDidResizeNotification
                                                   object:self];


    }
    return self;
}

#pragma mark - NSObject

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSWindowDidResizeNotification
                                                  object:self];
}

@end
