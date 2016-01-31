//
//  ViewController.h
//  PopupInStatusBar
//
//  Created by Abbas on 12/5/15.
//  Copyright © 2015 Gussenov. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "PSBBgView.h"
#import "PSBStatusItemView.h"

@interface ViewController : NSViewController

@property IBOutlet PSBBgView *bgView;

@property IBOutlet PSBStatusItemView *statusItemView;
@property IBOutlet NSTextField *statItemViewGlobalRectX;
@property IBOutlet NSTextField *statItemViewGlobalRectY;
@property IBOutlet NSTextField *statItemViewGlobalRectW;
@property IBOutlet NSTextField *statItemViewGlobalRectH;
@property IBOutlet NSButton *statItemViewHighlightedChkBox;

@end

