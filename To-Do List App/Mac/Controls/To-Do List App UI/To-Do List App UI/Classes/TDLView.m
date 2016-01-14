//
//  TDLView.m
//  To-Do List App UI
//
//  Created by Abbas on 12/23/15.
//  Copyright © 2015 Gussenov. All rights reserved.
//

#import "TDLView.h"
#import "TDLOutlineView.h"
#import "TDLScrollView.h"
#import "TDLDataSource.h"
#import "TDLOutlineViewDelegate.h"


@interface TDLView ()

@property NSMutableArray *customCstr;
@property NSMutableDictionary *viewsForCstr;
@property NSMutableDictionary *metricsForCstr;

@property BOOL isConstructed;

@property NSImageView *topImgView;
@property TDLScrollView *scrollView;
@property TDLOutlineView *outlineView;
@property NSImageView *txtFieldImgView;
@property (strong) NSTextField *taskTxtField;
@property NSImageView *bottomImgView;

@property TDLOutlineViewDelegate *outlineViewDelegate;

@end


@implementation TDLView

- (void)constructor
{
    if (!_isConstructed) {
        _customCstr = [NSMutableArray array];
        _viewsForCstr = [NSMutableDictionary dictionary];
        _metricsForCstr = [NSMutableDictionary dictionary];
        
        
        _topImgView = [NSImageView new];
        [_topImgView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_topImgView setImage:[NSImage imageNamed:@"to-do_list_app_top"]];
        [self.viewsForCstr setObject:_topImgView forKey:@"topImgView"];
        [self addSubview:_topImgView];
        
        
        _outlineView = [TDLOutlineView new];
        _outlineViewDelegate = [[TDLOutlineViewDelegate alloc] init];
        [_outlineView setDelegate:_outlineViewDelegate];
        _outlineView.focusRingType = NSFocusRingTypeNone;
        [_outlineView setGridStyleMask:NSTableViewGridNone];
        [_outlineView setIntercellSpacing:NSMakeSize(0, 0)];
        [_outlineView setBackgroundColor:[NSColor clearColor]];

        NSRect theOutlineViewHeaderFrame = _outlineView.headerView.frame;
        theOutlineViewHeaderFrame.size.height = 0;
        _outlineView.headerView.frame = theOutlineViewHeaderFrame;
        _outlineView.headerView = nil;
        
        NSTableColumn *theColumn = [NSTableColumn new];
        [_outlineView addTableColumn:theColumn];
        
        _scrollView = [TDLScrollView new];
        [_scrollView setDocumentView:_outlineView];
        [_scrollView setHasVerticalScroller:NO];
//        [_scrollView setDrawsBackground:NO];
        [_scrollView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.viewsForCstr setObject:_scrollView forKey:@"scrollView"];
        [self addSubview:_scrollView];
        [_scrollView setBackgroundColor:[NSColor colorWithPatternImage:[NSImage imageNamed:@"to-do_list_app_row_bg"]]];
        

        _txtFieldImgView = [NSImageView new];
        [_txtFieldImgView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_txtFieldImgView setImage:[NSImage imageNamed:@"to-do_list_app_txt_field"]];
        [self.viewsForCstr setObject:_txtFieldImgView forKey:@"txtFieldImgView"];
        [self addSubview:_txtFieldImgView];
        
        
        _taskTxtField = [NSTextField new];
        [_taskTxtField setAlignment:NSTextAlignmentLeft];
        [_taskTxtField setBezeled:NO];
        [_taskTxtField setDrawsBackground:NO];
        [_taskTxtField setFocusRingType:NSFocusRingTypeNone];
//        [_taskTxtField setEditable:NO];
//        [_taskTxtField setSelectable:NO];
        [_taskTxtField setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_taskTxtField.cell setLineBreakMode:NSLineBreakByTruncatingTail];
        [_taskTxtField setContentCompressionResistancePriority:NSLayoutPriorityDefaultLow forOrientation:NSLayoutConstraintOrientationHorizontal];
        [_taskTxtField setFont:[NSFont fontWithName:@"Helvetica Neue Light Italic" size:11]];
        [_taskTxtField setTextColor:[NSColor colorWithDeviceCyan:0.96 magenta:0.88 yellow:0.47 black:0.58 alpha:1.0]];
        [_taskTxtField setStringValue:@"Type your task..."];
        [self.viewsForCstr setObject:_taskTxtField forKey:@"taskTxtField"];
        [self addSubview:_taskTxtField];

        
        _bottomImgView = [NSImageView new];
        [_bottomImgView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_bottomImgView setImage:[NSImage imageNamed:@"to-do_list_app_bottom"]];
        [self.viewsForCstr setObject:_bottomImgView forKey:@"bottomImgView"];
        [self addSubview:_bottomImgView];
        
        
        _isConstructed = YES;
    }
}

#pragma mark - TDLView

- (void)setDataSource:(TDLDataSource *)aDataSource
{
    [self.outlineView setDataSource:aDataSource];
}

#pragma mark - NSObject

- (void)awakeFromNib
{
    [self constructor];
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
}

- (void)updateConstraints
{
    [super updateConstraints];
    
    [self removeConstraints:self.customCstr];
    [self.customCstr removeAllObjects];
    
    // bgImgView
    
    [self.customCstr addObjectsFromArray:[NSLayoutConstraint
        constraintsWithVisualFormat:@"V:|-0-[topImgView]"
        options:0 metrics:self.metricsForCstr views:self.viewsForCstr]];

    [self.customCstr addObjectsFromArray:[NSLayoutConstraint
        constraintsWithVisualFormat:@"H:|-0-[topImgView(234)]-0-|"
        options:0 metrics:self.metricsForCstr views:self.viewsForCstr]];
    
    // scrollView
    
    [self.customCstr addObjectsFromArray:[NSLayoutConstraint
        constraintsWithVisualFormat:@"V:[topImgView]-0-[scrollView(>=194)]-0-[txtFieldImgView]"
        options:0 metrics:self.metricsForCstr views:self.viewsForCstr]];
    
    [self.customCstr addObjectsFromArray:[NSLayoutConstraint
        constraintsWithVisualFormat:@"H:|-0-[scrollView]-0-|"
        options:0 metrics:self.metricsForCstr views:self.viewsForCstr]];

    // txtFieldImgView
    
    [self.customCstr addObjectsFromArray:[NSLayoutConstraint
        constraintsWithVisualFormat:@"V:[txtFieldImgView]-0-[bottomImgView]"
        options:0 metrics:self.metricsForCstr views:self.viewsForCstr]];
    
    [self.customCstr addObjectsFromArray:[NSLayoutConstraint
        constraintsWithVisualFormat:@"H:|-0-[txtFieldImgView]-0-|"
        options:0 metrics:self.metricsForCstr views:self.viewsForCstr]];

    // taskTxtField
    
    [self.customCstr addObjectsFromArray:[NSLayoutConstraint
        constraintsWithVisualFormat:@"V:[taskTxtField]-14-[bottomImgView]"
        options:0 metrics:self.metricsForCstr views:self.viewsForCstr]];
    
    [self.customCstr addObjectsFromArray:[NSLayoutConstraint
        constraintsWithVisualFormat:@"H:|-74-[taskTxtField]-17-|"
        options:0 metrics:self.metricsForCstr views:self.viewsForCstr]];

    // bottomImgView
    
    [self.customCstr addObjectsFromArray:[NSLayoutConstraint
        constraintsWithVisualFormat:@"V:[bottomImgView]-0-|"
        options:0 metrics:self.metricsForCstr views:self.viewsForCstr]];

    [self.customCstr addObjectsFromArray:[NSLayoutConstraint
        constraintsWithVisualFormat:@"H:|-0-[bottomImgView]-0-|"
        options:0 metrics:self.metricsForCstr views:self.viewsForCstr]];

    [self addConstraints:self.customCstr];
}

@end
