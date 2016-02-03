//
//  PSBSearchTxtWin.m
//  PopupInStatusBar
//
//  Created by Abbas Gussenov on 1/18/16.
//  Copyright © 2016 Gussenov Lab. All rights reserved.
//

#import "PSBSearchTxtWin.h"
#import "PSBPanelCtrl.h"
#import "PSBBgView.h"

@implementation PSBSearchTxtWin

- (void)windowDidResize:(NSNotification *)aNotification
{
    PSBBgView *theBgView = self.contentView;
        
    NSRect theSearchRect = [self.searchTxtView.searchField frame];
    theSearchRect.size.width = NSWidth([theBgView bounds]) - self.searchInset * 2;
    theSearchRect.origin.x = self.searchInset;
    theSearchRect.origin.y = NSHeight([theBgView bounds]) - theBgView.arrowHeight - self.searchInset - NSHeight(theSearchRect);
    
    if (NSIsEmptyRect(theSearchRect)) {
        [self.searchTxtView.searchField setHidden:YES];
    } else {
        [self.searchTxtView.searchField setFrame:theSearchRect];
        [self.searchTxtView.searchField setHidden:NO];
    }
    
    NSRect theTextRect = [self.searchTxtView.txtField frame];
    theTextRect.size.width = NSWidth([theBgView bounds]) - self.searchInset * 2;
    theTextRect.origin.x = self.searchInset;
    theTextRect.size.height = NSHeight([theBgView bounds]) - theBgView.arrowHeight - self.searchInset * 3 - NSHeight(theSearchRect);
    theTextRect.origin.y = self.searchInset;
    
    if (NSIsEmptyRect(theTextRect)) {
        [self.searchTxtView.txtField setHidden:YES];
    } else {
        [self.searchTxtView.txtField setFrame:theTextRect];
        [self.searchTxtView.txtField setHidden:NO];
    }
}

#pragma mark - NSWindow

- (void)setWindowController:(__kindof NSWindowController * __nullable)aWinCtrl
{
    [super setWindowController:aWinCtrl];
    
    [aWinCtrl addObserver:self
               forKeyPath:@"hasActivePanel"
                  options:(NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld)
                  context:NULL];
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
        self.searchInset = 17;

        self.searchTxtView = [[PSBSearchTxtView alloc]
            initWithFrame:NSMakeRect(0, 0, aContentRect.size.width, aContentRect.size.height)];
        [self.contentView addSubview:self.searchTxtView];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(windowDidResize:)
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

#pragma mark - NSObject(NSKeyValueObserving)

- (void)observeValueForKeyPath:(NSString *)aKeyPath
                      ofObject:(id)anObject
                        change:(NSDictionary *)aChange
                       context:(void *)aContext
{
    
    if ([aKeyPath isEqual:@"hasActivePanel"] && [[aChange objectForKey:NSKeyValueChangeNewKey] boolValue]) {
        PSBPanelCtrl *theWinCtrl = self.windowController;

        [self performSelector:@selector(makeFirstResponder:)
                   withObject:self.searchTxtView.searchField
                   afterDelay:theWinCtrl.openDuration];
    }
}

@end
