//
//  PSBPanelCtrl.h
//  PopupInStatusBar
//
//  Created by Abbas on 12/22/15.
//  Copyright © 2015 Gussenov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PSBBgView.h"
#import "PSBStatusItemView.h"
#import "PSBPanel.h"


@class PSBPanelCtrl;


@protocol PSBPanelCtrlDelegate <NSObject>

@optional

- (PSBStatusItemView *)statusItemViewForPanelCtrl:(PSBPanelCtrl *)aPanelCtrl;
- (float)statusItemViewWidth;

@end


@interface PSBPanelCtrl : NSWindowController <NSWindowDelegate> {
    __unsafe_unretained id<PSBPanelCtrlDelegate> _delegate;
    BOOL _hasActivePanel;
}

@property (nonatomic, unsafe_unretained, readonly) id<PSBPanelCtrlDelegate> delegate;
@property (nonatomic) BOOL hasActivePanel;

@property (nonatomic) CGFloat popupHeight;
@property (nonatomic) CGFloat panelWidth;
@property (nonatomic) NSTimeInterval openDuration;
@property (nonatomic) NSTimeInterval closeDuration;

- (id)initWithWindow:(PSBPanel *)aWindow
            delegate:(id<PSBPanelCtrlDelegate>)aDelegate;

- (NSRect)statusRectForWindow:(NSWindow *)aWindow;

- (void)openPanel;
- (void)closePanel;

@end
