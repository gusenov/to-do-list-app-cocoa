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


@class PSBPanelCtrl;


@protocol PSBPanelCtrlDelegate <NSObject>

@optional

- (PSBStatusItemView *)statusItemViewForPanelCtrl:(PSBPanelCtrl *)aPanelCtrl;
- (float)statusItemViewWidth;

@end


@interface PSBPanelCtrl : NSWindowController {
    BOOL _hasActivePanel;
    __unsafe_unretained PSBBgView *_backgroundView;
    __unsafe_unretained id<PSBPanelCtrlDelegate> _delegate;
    __unsafe_unretained NSSearchField *_searchField;
    __unsafe_unretained NSTextField *_textField;
}

@property (nonatomic, unsafe_unretained) IBOutlet PSBBgView *backgroundView;
@property (nonatomic, unsafe_unretained) IBOutlet NSSearchField *searchField;
@property (nonatomic, unsafe_unretained) IBOutlet NSTextField *textField;

@property (nonatomic) BOOL hasActivePanel;
@property (nonatomic, unsafe_unretained, readonly) id<PSBPanelCtrlDelegate> delegate;

- (id)initWithDelegate:(id<PSBPanelCtrlDelegate>)delegate;

- (void)openPanel;
- (void)closePanel;

@end
