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
@property (nonatomic, strong) PSBPanelCtrl *panelCtrl;

@end


@implementation PSBPopupInStatusBar

void *kContextActivePanel = &kContextActivePanel;

- (IBAction)togglePanel:(id)sender
{
    self.menuBarCtrl.hasActiveIcon = !self.menuBarCtrl.hasActiveIcon;
    self.panelCtrl.hasActivePanel = self.menuBarCtrl.hasActiveIcon;
}

#pragma mark - PSBPopupInStatusBar

- (id)initWithWindow:(PSBPanel *)aWindow
{
    NSParameterAssert(aWindow && [aWindow isKindOfClass:[PSBPanel class]]);
    
    self = [super init];
    if (self) {
        self.menuBarCtrl = [[PSBMenuBarCtrl alloc] initWithImg:[NSImage imageNamed:@"Status"]
                                                        altImg:[NSImage imageNamed:@"StatusHighlighted"]
                                                           act:@selector(togglePanel:)
                                                        target:self];
        
        _panelCtrl = [[PSBPanelCtrl alloc] initWithWindow:aWindow
                                                 delegate:self];
        [_panelCtrl addObserver:self
                     forKeyPath:@"hasActivePanel"
                        options:0
                        context:kContextActivePanel];
    }
    return self;
}

#pragma mark - NSObject

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
