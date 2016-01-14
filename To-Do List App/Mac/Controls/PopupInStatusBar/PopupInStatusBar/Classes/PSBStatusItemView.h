//
//  PSBStatusItemView.h
//  PopupInStatusBar
//
//  Created by Abbas on 12/5/15.
//  Copyright © 2015 Gussenov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PSBStatusItemView : NSView

@property (strong, readonly) NSStatusItem *statusItem;
@property (nonatomic, strong) NSImage *image;
@property (nonatomic, strong) NSImage *alternateImage;
@property (nonatomic, setter = setHighlighted:) BOOL isHighlighted;
@property SEL action;
@property (weak) id target;

- (id)initWithStatusItem:(NSStatusItem *)aStatusItem;
- (NSRect)globalRect;

@end
