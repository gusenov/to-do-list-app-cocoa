//
//  PSBPopupInStatusBar.h
//  PopupInStatusBar
//
//  Created by Abbas Gussenov on 1/7/16.
//  Copyright © 2016 Gussenov Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSBPanelCtrl.h"
#import "PSBMenuBarCtrl.h"

@interface PSBPopupInStatusBar : NSObject <PSBPanelCtrlDelegate>

@property (nonatomic, strong, readonly) PSBMenuBarCtrl *menuBarCtrl;
@property (nonatomic, strong, readonly) PSBPanelCtrl *panelCtrl;

- (id)initWithWindow:(PSBPanel *)aWindow;

@end
