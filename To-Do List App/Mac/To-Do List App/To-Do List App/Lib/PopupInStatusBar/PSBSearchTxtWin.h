//
//  PSBSearchTxtWin.h
//  PopupInStatusBar
//
//  Created by Abbas on 1/18/16.
//  Copyright © 2016 Gussenov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PSBPanel.h"
#import "PSBSearchTxtView.h"

@interface PSBSearchTxtWin : PSBPanel

@property (nonatomic) CGFloat searchInset;
@property (nonatomic) PSBSearchTxtView *searchTxtView;

@end
