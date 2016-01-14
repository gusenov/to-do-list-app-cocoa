//
//  PSBMenuBarCtrl.h
//  PopupInStatusBar
//
//  Created by Abbas on 12/22/15.
//  Copyright © 2015 Gussenov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PSBStatusItemView;

@interface PSBMenuBarCtrl : NSObject {
@private
    PSBStatusItemView *_statusItemView;
}

@property (nonatomic) BOOL hasActiveIcon;
@property (nonatomic, strong, readonly) NSStatusItem *statusItem;
@property (nonatomic, strong, readonly) PSBStatusItemView *statusItemView;

@property (readonly) float statusItemViewWidth;

- (id)initWithImg:(NSImage *)anImg
           altImg:(NSImage *)anAltImg
              act:(SEL)anAct
           target:(id)aTarget;

@end
