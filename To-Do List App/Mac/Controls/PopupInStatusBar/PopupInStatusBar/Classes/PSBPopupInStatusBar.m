//
//  PSBPopupInStatusBar.m
//  PopupInStatusBar
//
//  Created by Abbas on 1/7/16.
//  Copyright © 2016 Gussenov. All rights reserved.
//

#import "PSBPopupInStatusBar.h"
#import "PSBMenuBarCtrl.h"


@interface PSBPopupInStatusBar ()

@property (nonatomic, strong) PSBMenuBarCtrl *menuBarCtrl;

@end


@implementation PSBPopupInStatusBar

void *kContextActivePanel = &kContextActivePanel;

- (IBAction)togglePanel:(id)sender
{
    self.menuBarCtrl.hasActiveIcon = !self.menuBarCtrl.hasActiveIcon;
    self.panelCtrl.hasActivePanel = self.menuBarCtrl.hasActiveIcon;
}

- (PSBPanelCtrl *)panelCtrl
{
    static PSBPanelCtrl *thePanelCtrl;
    if (thePanelCtrl == nil) {
        thePanelCtrl = [[PSBPanelCtrl alloc] initWithDelegate:self];
        [thePanelCtrl addObserver:self forKeyPath:@"hasActivePanel" options:0 context:kContextActivePanel];
    }
    return thePanelCtrl;
}

#pragma mark - NSObject

- (id)init
{
    self = [super init];
    if (self) {
        self.menuBarCtrl = [[PSBMenuBarCtrl alloc] initWithImg:[NSImage imageNamed:@"Status"]
                                                        altImg:[NSImage imageNamed:@"StatusHighlighted"]
                                                           act:@selector(togglePanel:)
                                                        target:self];
    }
    return self;
}

- (void)dealloc
{
    [self.panelCtrl removeObserver:self forKeyPath:@"hasActivePanel"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if (context == kContextActivePanel) {
        self.menuBarCtrl.hasActiveIcon = [self panelCtrl].hasActivePanel;
    }
    else {
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}

#pragma mark - PSBPanelCtrlDelegate

- (PSBStatusItemView *)statusItemViewForPanelCtrl:(PSBPanelCtrl *)aCtrl
{
    return self.menuBarCtrl.statusItemView;
}

- (float)statusItemViewWidth
{
    return self.menuBarCtrl.statusItemViewWidth;
}

@end
