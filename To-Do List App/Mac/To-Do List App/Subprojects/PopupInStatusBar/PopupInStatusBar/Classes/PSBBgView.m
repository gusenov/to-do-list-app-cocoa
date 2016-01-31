//
//  PSBBgView.m
//  PopupInStatusBar
//
//  Created by Abbas on 12/5/15.
//  Copyright © 2015 Gussenov. All rights reserved.
//

#import "PSBBgView.h"

@implementation PSBBgView

- (void)constructor
{
    self.arrowWidth = 12;
    self.arrowHeight = 8;
    self.fillOpacity = 0.9;
    self.strokeOpacity = 1.0;
    self.lineThickness = 1;
    self.cornerRadius = 6.0;
    self.strokeColor = [NSColor whiteColor];
    self.fillColor = [NSColor colorWithDeviceWhite:1 alpha:self.fillOpacity];
    self.arrowX = NSMidX(self.bounds);
}

#pragma mark - PSBBgView

@synthesize arrowWidth = _arrowWidth;

- (void)setArrowWidth:(float)anArrowWidth
{
    _arrowWidth = anArrowWidth;
    [self setNeedsDisplay:YES];
}

#pragma mark -

@synthesize arrowHeight = _arrowHeight;

- (void)setArrowHeight:(float)anArrowHeight
{
    _arrowHeight = anArrowHeight;
    [self setNeedsDisplay:YES];
}

#pragma mark -

@synthesize arrowX = _arrowX;

- (void)setArrowX:(NSInteger)aValue
{
    _arrowX = aValue;
    [self setNeedsDisplay:YES];
}

#pragma mark -

@synthesize fillOpacity = _fillOpacity;

- (void)setFillOpacity:(float)aFillOpacity
{
    _fillOpacity = aFillOpacity;
    [self setFillColor:self.fillColor];
    [self setNeedsDisplay:YES];
}

#pragma mark -

@synthesize strokeOpacity = _strokeOpacity;

- (void)setStrokeOpacity:(float)aStrokeOpacity
{
    _strokeOpacity = aStrokeOpacity;
    [self setStrokeColor:self.strokeColor];
    [self setNeedsDisplay:YES];
}

#pragma mark -

@synthesize lineThickness = _lineThickness;

- (void)setLineThickness:(float)aLineThickness
{
    _lineThickness = aLineThickness;
    [self setNeedsDisplay:YES];
}

#pragma mark -

@synthesize cornerRadius = _cornerRadius;

- (void)setCornerRadius:(float)aCornerRadius
{
    _cornerRadius = aCornerRadius;
    [self setNeedsDisplay:YES];
}

#pragma mark -

@synthesize strokeColor = _strokeColor;

- (void)setStrokeColor:(NSColor *)aStrokeColor
{
    _strokeColor = [aStrokeColor colorWithAlphaComponent:self.strokeOpacity];
    [self setNeedsDisplay:YES];
}

#pragma mark -

@synthesize fillColor = _fillColor;

- (void)setFillColor:(NSColor *)aFillColor
{
    _fillColor = [aFillColor colorWithAlphaComponent:self.fillOpacity];
    [self setNeedsDisplay:YES];
}

#pragma mark - NSObject (NSNibAwaking)

- (void)awakeFromNib
{
    [self constructor];
}

#pragma mark - NSView

- (id)initWithFrame:(NSRect)aFrameRect
{
    self = [super initWithFrame:aFrameRect];
    if (self) {
        [self constructor];
    }
    return self;
}

- (void)drawRect:(NSRect)aDirtyRect
{
    [super drawRect:aDirtyRect];
    
    // Drawing code here.
    
    NSRect theContentRect = NSInsetRect([self bounds], self.lineThickness, self.lineThickness);
    NSBezierPath *thePath = [NSBezierPath bezierPath];
    
    [thePath moveToPoint:NSMakePoint(self.arrowX, NSMaxY(theContentRect))];
    [thePath lineToPoint:NSMakePoint(self.arrowX + self.arrowWidth / 2, NSMaxY(theContentRect) - self.arrowHeight)];
    [thePath lineToPoint:NSMakePoint(NSMaxX(theContentRect) - self.cornerRadius, NSMaxY(theContentRect) - self.arrowHeight)];
    
    NSPoint theTopRightCorner = NSMakePoint(NSMaxX(theContentRect), NSMaxY(theContentRect) - self.arrowHeight);
    [thePath curveToPoint:NSMakePoint(NSMaxX(theContentRect), NSMaxY(theContentRect) - self.arrowHeight - self.cornerRadius)
         controlPoint1:theTopRightCorner controlPoint2:theTopRightCorner];
    
    [thePath lineToPoint:NSMakePoint(NSMaxX(theContentRect), NSMinY(theContentRect) + self.cornerRadius)];
    
    NSPoint theBottomRightCorner = NSMakePoint(NSMaxX(theContentRect), NSMinY(theContentRect));
    [thePath curveToPoint:NSMakePoint(NSMaxX(theContentRect) - self.cornerRadius, NSMinY(theContentRect))
         controlPoint1:theBottomRightCorner controlPoint2:theBottomRightCorner];
    
    [thePath lineToPoint:NSMakePoint(NSMinX(theContentRect) + self.cornerRadius, NSMinY(theContentRect))];
    
    [thePath curveToPoint:NSMakePoint(NSMinX(theContentRect), NSMinY(theContentRect) + self.cornerRadius)
         controlPoint1:theContentRect.origin controlPoint2:theContentRect.origin];
    
    [thePath lineToPoint:NSMakePoint(NSMinX(theContentRect), NSMaxY(theContentRect) - self.arrowHeight - self.cornerRadius)];
    
    NSPoint theTopLeftCorner = NSMakePoint(NSMinX(theContentRect), NSMaxY(theContentRect) - self.arrowHeight);
    [thePath curveToPoint:NSMakePoint(NSMinX(theContentRect) + self.cornerRadius, NSMaxY(theContentRect) - self.arrowHeight)
         controlPoint1:theTopLeftCorner controlPoint2:theTopLeftCorner];
    
    [thePath lineToPoint:NSMakePoint(self.arrowX - self.arrowWidth / 2, NSMaxY(theContentRect) - self.arrowHeight)];
    [thePath closePath];
    
    [self.fillColor setFill];
    [thePath fill];
    
    [NSGraphicsContext saveGraphicsState];
    
    NSBezierPath *theClip = [NSBezierPath bezierPathWithRect:[self bounds]];
    [theClip appendBezierPath:thePath];
    [theClip addClip];
    
    [thePath setLineWidth:self.lineThickness * 2];
    [self.strokeColor setStroke];
    [thePath stroke];
    
    [NSGraphicsContext restoreGraphicsState];
}

@end
