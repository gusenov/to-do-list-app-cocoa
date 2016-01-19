//
//  AppDelegate.m
//  PopupInStatusBar
//
//  Created by Abbas on 12/5/15.
//  Copyright © 2015 Gussenov. All rights reserved.
//

#import "AppDelegate.h"
#import "PSBPopupInStatusBar.h"
#import "PSBSearchTxtWin.h"


@interface AppDelegate ()

@property (strong) PSBPopupInStatusBar *popupInStatusBar;

@end


@implementation AppDelegate

#pragma mark - NSApplicationDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    PSBSearchTxtWin *thePanel  = [[PSBSearchTxtWin alloc] initWithContentRect:NSMakeRect(162, 101, 280, 180)
                                                                    styleMask:128
                                                                      backing:NSBackingStoreBuffered
                                                                        defer:NO];

    self.popupInStatusBar = [[PSBPopupInStatusBar alloc] initWithWindow:thePanel];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    self.popupInStatusBar = nil;
}

@end
