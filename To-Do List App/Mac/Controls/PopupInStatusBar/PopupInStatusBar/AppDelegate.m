//
//  AppDelegate.m
//  PopupInStatusBar
//
//  Created by Abbas on 12/5/15.
//  Copyright © 2015 Gussenov. All rights reserved.
//

#import "AppDelegate.h"
#import "PSBPopupInStatusBar.h"


@interface AppDelegate ()

@property (strong) PSBPopupInStatusBar *popupInStatusBar;

@end


@implementation AppDelegate

#pragma mark - NSApplicationDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.popupInStatusBar = [PSBPopupInStatusBar new];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    self.popupInStatusBar = nil;
}

@end
