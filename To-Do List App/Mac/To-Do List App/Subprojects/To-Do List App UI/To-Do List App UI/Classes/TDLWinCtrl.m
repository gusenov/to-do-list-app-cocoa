//
//  TDLWinCtrl.m
//  To-Do List App UI
//
//  Created by Abbas Gussenov on 12/24/15.
//  Copyright © 2015 Gussenov Lab. All rights reserved.
//

#import "TDLWinCtrl.h"
#import "TDLViewCtrl.h"
#import "TDLDataSource.h"


@interface TDLWinCtrl ()

@property TDLViewCtrl *viewCtrl;

@end


@implementation TDLWinCtrl 

#pragma mark - TDLWinCtrl

- (void)setDataSource:(TDLDataSource *)aDataSource
{
    [self.viewCtrl setDataSource:aDataSource];
}

#pragma mark - NSResponder

- (id)initWithWindow:(NSWindow *)aWin
{
    self = [super initWithWindow:aWin];
    if (self) {
        _viewCtrl = [[TDLViewCtrl alloc] init];
    }
    return self;
}

#pragma mark - NSWindowController

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    
    [self.window setContentView:self.viewCtrl.view];
}

- (void)loadWindow
{
    [self windowDidLoad];
}

@end
