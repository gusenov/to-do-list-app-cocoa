//
//  TDLTblRowView.m
//  To-Do List App UI
//
//  Created by Abbas on 12/23/15.
//  Copyright © 2015 Gussenov. All rights reserved.
//

#import "TDLTblRowView.h"


@interface TDLTblRowView ()

@property NSMutableArray *customCstr;
@property NSMutableDictionary *viewsForCstr;
@property NSMutableDictionary *metricsForCstr;

@property BOOL isConstructed;

@property NSImageView *bgImgView;
@property NSImageView *hrImgView;

@end


@implementation TDLTblRowView

- (void)constructor
{
    if (!_isConstructed) {
        _customCstr = [NSMutableArray array];
        _viewsForCstr = [NSMutableDictionary dictionary];
        _metricsForCstr = [NSMutableDictionary dictionaryWithObjectsAndKeys:
              @38, @"rowHeight"
            ,  @1, @"hrHeight"
            , nil];
        
        _bgImgView = [NSImageView new];
        [_bgImgView setTranslatesAutoresizingMaskIntoConstraints:NO];
//        [_bgImgView setImage:[NSImage imageNamed:@"to-do_list_app_row_bg"]];
        [self.viewsForCstr setObject:_bgImgView forKey:@"bgImgView"];
        [self addSubview:_bgImgView];
        
        _hrImgView = [NSImageView new];
        [_hrImgView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_hrImgView setImage:[NSImage imageNamed:@"to-do_list_app_row_hr"]];
        [self.viewsForCstr setObject:_hrImgView forKey:@"hrImgView"];
        [self addSubview:_hrImgView];
        
        _isShowUnderline = YES;
    }
}

#pragma mark - TDLTblRowView 

- (void)setShowUnderline:(BOOL)aShowUnderline
{
    _isShowUnderline = aShowUnderline;
    if (_isShowUnderline) {
        if (self.hrImgView.superview != self) {
            [self addSubview:self.hrImgView];
        }
    } else {
        [self.hrImgView removeFromSuperview];
    }
}

#pragma mark - NSResponder

- (id)init
{
    self = [super init];
    if (self) {
        [self constructor];
    }
    return self;
}

#pragma mark - NSView

- (void)drawRect:(NSRect)aDirtyRect
{
    [super drawRect:aDirtyRect];
    
    // Drawing code here.
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    [self removeConstraints:self.customCstr];
    [self.customCstr removeAllObjects];
    
    // bgImgView
    
    NSString *theShowUnderline = @"V:|-0-[bgImgView(rowHeight)]-0-[hrImgView(hrHeight)]-0-|";
    NSString *theRowWithoutUnderline = @"V:|-0-[bgImgView(rowHeight)]-0-|";
    [self.customCstr addObjectsFromArray:[NSLayoutConstraint
        constraintsWithVisualFormat:self.isShowUnderline ? theShowUnderline : theRowWithoutUnderline
        options:0 metrics:self.metricsForCstr views:self.viewsForCstr]];
    
    [self.customCstr addObjectsFromArray:[NSLayoutConstraint
        constraintsWithVisualFormat:@"H:|-0-[bgImgView]-0-|"
        options:0 metrics:self.metricsForCstr views:self.viewsForCstr]];

    [self addConstraints:self.customCstr];
}

@end
