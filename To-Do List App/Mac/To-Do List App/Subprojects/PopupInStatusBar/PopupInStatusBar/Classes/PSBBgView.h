//
//  PSBBgView.h
//  PopupInStatusBar
//
//  Created by Abbas Gussenov on 12/5/15.
//  Copyright © 2015 Gussenov Lab. All rights reserved.
//

#import <Cocoa/Cocoa.h>

/**
 Rounded Rectangular Callout
 */
@interface PSBBgView : NSView {
@private
}

@property (nonatomic) float arrowWidth;
@property (nonatomic) float arrowHeight;
@property (nonatomic) NSInteger arrowX;
@property (nonatomic) float fillOpacity;
@property (nonatomic) float strokeOpacity;
@property (nonatomic) float lineThickness;
@property (nonatomic) float cornerRadius;
@property (nonatomic) NSColor *strokeColor;
@property (nonatomic) NSColor *fillColor;

@end
