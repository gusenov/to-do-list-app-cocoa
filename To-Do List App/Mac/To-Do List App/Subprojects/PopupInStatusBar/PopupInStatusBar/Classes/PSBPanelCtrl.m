//
//  PSBPanelCtrl.m
//  PopupInStatusBar
//
//  Created by Abbas Gussenov on 12/22/15.
//  Copyright © 2015 Gussenov Lab. All rights reserved.
//

#import "PSBPanelCtrl.h"


@interface PSBPanelCtrl ()

@property BOOL isConstructed;

@end


@implementation PSBPanelCtrl

@synthesize delegate = _delegate;

- (void)constructor
{
    if (!_isConstructed) {
        self.popupHeight = self.window.frame.size.height;
        self.panelWidth = self.window.frame.size.width;
        self.openDuration = .15;
        self.closeDuration = .1;
        
        // Make a fully skinned panel
        NSPanel *thePanel = (id)[self window];
        [thePanel setAcceptsMouseMovedEvents:YES];
        [thePanel setLevel:NSPopUpMenuWindowLevel];
        [thePanel setOpaque:NO];
        [thePanel setBackgroundColor:[NSColor clearColor]];
        
        self.animation = (PSBAnimationFrame | PSBAnimationAlpha);
        
        _isConstructed = YES;
    }
}

#pragma mark - NSWindowDelegate

- (void)windowWillClose:(NSNotification *)notification
{
    self.hasActivePanel = NO;
}

- (void)windowDidResignKey:(NSNotification *)notification
{
    if ([[self window] isVisible]) {
        self.hasActivePanel = NO;
    }
}

#pragma mark - NSResponder

- (void)cancelOperation:(id)aSender
{
    self.hasActivePanel = NO;
}

#pragma mark - NSObject (NSNibAwaking)

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self constructor];
}

#pragma mark - PSBPanelCtrl

- (id)initWithWindow:(PSBPanel *)aWindow
            delegate:(id<PSBPanelCtrlDelegate>)aDelegate
{
    self = [super initWithWindow:aWindow];
    if (self != nil) {
        [[self window] setDelegate:self];
        _delegate = aDelegate;
        [self constructor];
    }
    return self;
}

- (NSRect)statusRectForWindow:(NSWindow *)aWindow
{
    NSRect theScreenRect = [[[NSScreen screens] objectAtIndex:0] frame];
    NSRect theStatusRect = NSZeroRect;
    
    PSBStatusItemView *statusItemView = nil;
    if ([self.delegate respondsToSelector:@selector(statusItemViewForPanelCtrl:)]) {
        statusItemView = [self.delegate statusItemViewForPanelCtrl:self];
    }
    
    if (statusItemView) {
        theStatusRect = [statusItemView globalRect];
        theStatusRect.origin.y = NSMinY(theStatusRect) - NSHeight(theStatusRect);
    } else {
        theStatusRect.size = NSMakeSize([self.delegate statusItemViewWidth], [[NSStatusBar systemStatusBar] thickness]);
        theStatusRect.origin.x = roundf((NSWidth(theScreenRect) - NSWidth(theStatusRect)) / 2);
        theStatusRect.origin.y = NSHeight(theScreenRect) - NSHeight(theStatusRect) * 2;
    }
    return theStatusRect;
}

#pragma mark -

- (BOOL)hasActivePanel
{
    return _hasActivePanel;
}

- (void)setHasActivePanel:(BOOL)aFlag
{
    if (_hasActivePanel != aFlag) {
        aFlag ? [self openPanel] : [self closePanel];
        _hasActivePanel = aFlag;
    }
}

#pragma mark -

- (void)openPanel
{
    PSBPanel *thePanel = (PSBPanel *)[self window];
    
    NSRect theScreenRect = [[[NSScreen screens] objectAtIndex:0] frame];
    NSRect theStatusRect = [self statusRectForWindow:thePanel];

    NSRect thePanelRect = [thePanel frame];
    thePanelRect.size.width = self.panelWidth;
    thePanelRect.size.height = self.popupHeight;
    thePanelRect.origin.x = roundf(NSMidX(theStatusRect) - NSWidth(thePanelRect) / 2);
    thePanelRect.origin.y = NSMaxY(theStatusRect) - NSHeight(thePanelRect);

    PSBBgView *theBgView = thePanel.contentView;
    if (NSMaxX(thePanelRect) > (NSMaxX(theScreenRect) - theBgView.arrowHeight))
        thePanelRect.origin.x -= NSMaxX(thePanelRect) - (NSMaxX(theScreenRect) - theBgView.arrowHeight);
    
    [NSApp activateIgnoringOtherApps:NO];
    
    if (self.animation & PSBAnimationAlpha) [thePanel setAlphaValue:0];
    if (self.animation & PSBAnimationFrame) [thePanel setFrame:theStatusRect display:YES];
    
    [thePanel makeKeyAndOrderFront:nil];

#ifdef DEBUG
    NSEvent *theCurrentEvent = [NSApp currentEvent];
    if ([theCurrentEvent type] == NSLeftMouseDown) {
        NSUInteger theClearFlags = ([theCurrentEvent modifierFlags] & NSDeviceIndependentModifierFlagsMask);
        BOOL theShiftPressed = (theClearFlags == NSShiftKeyMask);
        BOOL theShiftOptionPressed = (theClearFlags == (NSShiftKeyMask | NSAlternateKeyMask));
        if (theShiftPressed || theShiftOptionPressed) {
            self.openDuration *= 10;
            
            if (theShiftOptionPressed)
                NSLog(@"Icon is at %@\n\tMenu is on screen %@\n\tWill be animated to %@",
                      NSStringFromRect(theStatusRect), NSStringFromRect(theScreenRect), NSStringFromRect(thePanelRect));
        }
    }
#endif
    
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:self.openDuration];
    
    [(self.animation & PSBAnimationFrame ? [thePanel animator] : thePanel) setFrame:thePanelRect display:YES];
    [(self.animation & PSBAnimationAlpha ? [thePanel animator] : thePanel) setAlphaValue:1];

    [NSAnimationContext endGrouping];
}

- (void)closePanel
{
    [NSAnimationContext beginGrouping];
    [[NSAnimationContext currentContext] setDuration:self.closeDuration];
    [[[self window] animator] setAlphaValue:0];
    [NSAnimationContext endGrouping];
    
    dispatch_after(dispatch_walltime(NULL, NSEC_PER_SEC * self.closeDuration * 2), dispatch_get_main_queue(), ^{
        [self.window orderOut:nil];
    });
}

@end
