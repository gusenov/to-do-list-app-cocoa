//
//  ViewController.m
//  PopupInStatusBar
//
//  Created by Abbas on 12/5/15.
//  Copyright © 2015 Gussenov. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (IBAction)updateViewValues:(id)sender
{
    self.statItemViewGlobalRectX.stringValue = [[NSNumber numberWithFloat:[self.statusItemView globalRect].origin.x] stringValue];
    self.statItemViewGlobalRectY.stringValue = [[NSNumber numberWithFloat:[self.statusItemView globalRect].origin.y] stringValue];
    self.statItemViewGlobalRectW.stringValue = [[NSNumber numberWithFloat:[self.statusItemView globalRect].size.width] stringValue];
    self.statItemViewGlobalRectH.stringValue = [[NSNumber numberWithFloat:[self.statusItemView globalRect].size.height] stringValue];
    
    self.statItemViewHighlightedChkBox.state = self.statusItemView.isHighlighted ? NSOnState : NSOffState;
}

- (IBAction)statItemViewHighlighted:(id)aSender
{
    [self.statusItemView setHighlighted:self.statItemViewHighlightedChkBox.state == NSOnState ? YES : NO];
}

- (IBAction)windowDidMoveOrResize:(NSNotification *)aNotification
{
    if (aNotification.object == self.statusItemView.window) {
        [self updateViewValues:aNotification.object];
    }
}

#pragma mark - NSViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)viewDidAppear
{
    [self updateViewValues:self];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(windowDidMoveOrResize:)
                                                 name:NSWindowDidMoveNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(windowDidMoveOrResize:)
                                                 name:NSWindowDidResizeNotification
                                               object:nil];
}

- (void)setRepresentedObject:(id)representedObject
{
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

#pragma mark - NSObject

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSWindowDidMoveNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSWindowDidResizeNotification
                                                  object:nil];
}

@end
