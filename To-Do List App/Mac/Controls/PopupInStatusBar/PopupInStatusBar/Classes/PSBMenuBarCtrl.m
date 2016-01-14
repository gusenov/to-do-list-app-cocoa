//
//  PSBMenuBarCtrl.m
//  PopupInStatusBar
//
//  Created by Abbas on 12/22/15.
//  Copyright © 2015 Gussenov. All rights reserved.
//

#import "PSBMenuBarCtrl.h"
#import "PSBStatusItemView.h"

@implementation PSBMenuBarCtrl

#pragma mark - PSBMenuBarCtrl

- (NSStatusItem *)statusItem
{
    return self.statusItemView.statusItem;
}

- (BOOL)hasActiveIcon
{
    return self.statusItemView.isHighlighted;
}

- (void)setHasActiveIcon:(BOOL)flag
{
    self.statusItemView.isHighlighted = flag;
}

- (id)initWithImg:(NSImage *)anImg
           altImg:(NSImage *)anAltImg
              act:(SEL)anAct
           target:(id)aTarget
{
    self = [self init];
    if (self) {
        // Install status item into the menu bar
        _statusItemViewWidth = 24.;
        NSStatusItem *statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:_statusItemViewWidth];
        _statusItemView = [[PSBStatusItemView alloc] initWithStatusItem:statusItem];
        _statusItemView.image = anImg;
        _statusItemView.alternateImage = anAltImg;
        _statusItemView.action = anAct;
        _statusItemView.target = aTarget;
    }
    return self;
}

#pragma mark - NSObject

- (void)dealloc
{
    [[NSStatusBar systemStatusBar] removeStatusItem:self.statusItem];
}

@end
