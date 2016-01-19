//
//  AppDelegate.m
//  To-Do List App UI
//
//  Created by Abbas on 12/23/15.
//  Copyright © 2015 Gussenov. All rights reserved.
//

#import "AppDelegate.h"
#import "TDLWinCtrl.h"
#import "TDLDataSource.h"
#import "TDLItem.h"


@interface AppDelegate ()

@property (weak) IBOutlet NSWindow *window;

@end


@implementation AppDelegate{
    TDLWinCtrl *winCtrl;
    TDLDataSource *dataSource;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (IBAction)showToDoListWin:(id)sender {
    NSWindow *theWin  = [[NSWindow alloc] initWithContentRect:NSMakeRect(1000, 500, 234, 307)
        styleMask:NSClosableWindowMask | NSTitledWindowMask | NSResizableWindowMask | NSMiniaturizableWindowMask
        backing:NSBackingStoreBuffered defer:NO];
    [theWin setBackgroundColor:[NSColor colorWithCalibratedWhite:1.0 alpha:0.0]];
    [theWin setOpaque:NO];
    [theWin makeKeyAndOrderFront:NSApp];

    winCtrl = [[TDLWinCtrl alloc] initWithWindow:theWin];
    // [winCtrl showWindow:nil];
    [winCtrl loadWindow];
    [winCtrl.window makeKeyAndOrderFront:nil];
    
    dataSource = [[TDLDataSource alloc] init];
    [dataSource addItem:[[TDLItem alloc] initWithTitle:@"buy a mac" completed:NO]];
    [dataSource addItem:[[TDLItem alloc] initWithTitle:@"pick up the kids" completed:YES]];
    [dataSource addItem:[[TDLItem alloc] initWithTitle:@"buy an ipad" completed:NO]];
    [dataSource addItem:[[TDLItem alloc] initWithTitle:@"save psd" completed:NO]];
    [dataSource addItem:[[TDLItem alloc] initWithTitle:@"email david" completed:YES]];
    [winCtrl setDataSource:dataSource];
}

- (IBAction)showContentViewFrame:(id)sender {
    NSRect theFrame = winCtrl.window.contentView.frame;
    NSLog(@"x = %f; y = %f; w = %f; h = %f"
        , theFrame.origin.x, theFrame.origin.y, theFrame.size.width, theFrame.size.height);
}

@end
