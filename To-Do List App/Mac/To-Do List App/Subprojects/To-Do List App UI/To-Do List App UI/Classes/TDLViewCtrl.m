//
//  TDLViewCtrl.m
//  To-Do List App UI
//
//  Created by Abbas on 12/23/15.
//  Copyright © 2015 Gussenov. All rights reserved.
//

#import "TDLViewCtrl.h"
#import "TDLView.h"


@interface TDLViewCtrl ()

@property TDLView *mainView;

@end


@implementation TDLViewCtrl

#pragma mark - TDLViewCtrl

- (void)setDataSource:(TDLDataSource *)aDataSource
{
    [self.mainView setDataSource:aDataSource];
}

#pragma mark - NSResponder

- (id)init
{
    self = [super init];
    if (self) {
        _mainView = [[TDLView alloc] initWithFrame:NSMakeRect(0, 0, 234, 61)];
    }
    return self;
}

#pragma mark - NSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do view setup here.
}

- (void)loadView
{
    [self setView:self.mainView];
    [self updateViewConstraints];
}

@end
