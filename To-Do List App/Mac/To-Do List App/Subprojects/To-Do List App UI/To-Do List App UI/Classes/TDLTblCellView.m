//
//  TDLTblCellView.m
//  To-Do List App UI
//
//  Created by Abbas on 12/25/15.
//  Copyright © 2015 Gussenov. All rights reserved.
//

#import "TDLTblCellView.h"


@interface TDLTblCellView ()

@property NSMutableArray *customCstr;
@property NSMutableDictionary *viewsForCstr;
@property NSMutableDictionary *metricsForCstr;

@property BOOL isConstructed;

@property (strong) NSTextField *titleTxtField;
@property (strong) NSButton *boxImgView;
@property (strong) NSImageView *strikeImgView;

@property (strong) TDLItem *item;

@end


@implementation TDLTblCellView

- (void)constructor
{
    if (!_isConstructed) {
        _customCstr = [NSMutableArray array];
        _viewsForCstr = [NSMutableDictionary dictionary];
        _metricsForCstr = [NSMutableDictionary dictionary];
        
        _boxImgView = [[NSButton alloc] initWithFrame:NSMakeRect(0, 0, 23, 24)];
        _boxImgView.target = self;
        _boxImgView.action = @selector(toggleCompleted);
        _boxImgView.translatesAutoresizingMaskIntoConstraints = NO;
        _boxImgView.autoresizingMask = NSViewMinXMargin;
        _boxImgView.bezelStyle = NSInlineBezelStyle;
        _boxImgView.bordered = NO;
        _boxImgView.title = @"";
        [_boxImgView setImagePosition:NSImageOnly];
        [_boxImgView setButtonType:NSMomentaryChangeButton];
        [_boxImgView.cell setImageScaling:NSImageScaleProportionallyDown];
        [_boxImgView setImage:[NSImage imageNamed:@"to-do_list_app_box_uncheked"]];
        [self.viewsForCstr setObject:_boxImgView forKey:@"boxImgView"];
        [self addSubview:_boxImgView];

        _strikeImgView = [NSImageView new];
        [_strikeImgView setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_strikeImgView setImage:[NSImage imageNamed:@"to-do_list_app_strike"]];
        [self.viewsForCstr setObject:_strikeImgView forKey:@"strikeImgView"];
        
        _titleTxtField = [NSTextField new];
        [self setTextField:_titleTxtField];
        [self.textField setAlignment:NSTextAlignmentCenter];
        [self.textField setBezeled:NO];
        [self.textField setBackgroundColor:[NSColor clearColor]];
//        [self.textField setDrawsBackground:NO];
//        [self.textField setEditable:NO];
//        [self.textField setSelectable:NO];
        [self.textField setBordered:NO];
        [self.textField setFocusRingType:NSFocusRingTypeNone];
        [self.textField setTranslatesAutoresizingMaskIntoConstraints:NO];
        [self.textField.cell setLineBreakMode:NSLineBreakByTruncatingTail];
        [self.textField setContentCompressionResistancePriority:NSLayoutPriorityDefaultLow
            forOrientation:NSLayoutConstraintOrientationHorizontal];
        [self.textField setFont:[NSFont fontWithName:@"Helvetica Neue Bold" size:10]];
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(controlTextDidChange:)
                                                     name:NSControlTextDidChangeNotification
                                                   object:self.textField];
        [self.viewsForCstr setObject:self.textField forKey:@"titleTxtField"];
        [self addSubview:self.textField];
        
        [self setCompleted:NO];
    }
}

- (void)toggleCompleted
{
    [self setCompleted:!self.isCompleted];
}

- (void)controlTextDidChange:(NSNotification *)aNotification
{
    NSText *theFieldEditor = [[aNotification userInfo] objectForKey:@"NSFieldEditor"];
    NSInteger theCaretPos = [theFieldEditor selectedRange].location;
    theFieldEditor.string = self.item.title = [theFieldEditor.string uppercaseString];
    [theFieldEditor setSelectedRange:NSMakeRange(theCaretPos, 0)];
}

#pragma mark - TDLTblCellView

- (id)initWithItem:(TDLItem *)anItem
{
    self = [self init];
    if (self) {
        _item = anItem;
        
        [self.textField setStringValue:[_item.title uppercaseString]];
        [self setCompleted:_item.isCompleted];
    }
    return self;
}

- (void)setCompleted:(BOOL)aCompleted
{
    _isCompleted = aCompleted;
    if (_isCompleted) {
        [_boxImgView setImage:[NSImage imageNamed:@"to-do_list_app_box_checked"]];
        if (_strikeImgView.superview != self) {
            [self addSubview:_strikeImgView];
            [self updateConstraints];
        }
        [self.textField setTextColor:[NSColor colorWithDeviceCyan:0.88
                                                          magenta:0.62
                                                           yellow:0.49
                                                            black:0.35
                                                            alpha:0.3]];
        [self.textField.window makeFirstResponder:nil];
        [self.textField setEditable:NO];
    } else {
        [_boxImgView setImage:[NSImage imageNamed:@"to-do_list_app_box_uncheked"]];
        [_strikeImgView removeFromSuperview];
        [self.textField setTextColor:[NSColor colorWithDeviceCyan:0.88
                                                          magenta:0.62
                                                           yellow:0.49
                                                            black:0.35
                                                            alpha:1]];
        [self.textField setEditable:YES];
        [self.textField.window makeFirstResponder:self.textField];
    }
    
    [self.item setCompleted:_isCompleted];
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

- (void)updateConstraints
{
    [super updateConstraints];
    
    [self removeConstraints:self.customCstr];
    [self.customCstr removeAllObjects];
    
    // boxImgView
    
    [self.customCstr addObjectsFromArray:[NSLayoutConstraint
        constraintsWithVisualFormat:@"V:|-6-[boxImgView]"
        options:0 metrics:self.metricsForCstr views:self.viewsForCstr]];
    
    [self.customCstr addObjectsFromArray:[NSLayoutConstraint
        constraintsWithVisualFormat:@"H:|-12-[boxImgView]"
        options:0 metrics:self.metricsForCstr views:self.viewsForCstr]];
    
    // strikeImgView
    
    if (self.isCompleted) {
        [self.customCstr addObjectsFromArray:[NSLayoutConstraint
            constraintsWithVisualFormat:@"V:|-18-[strikeImgView]"
            options:0 metrics:self.metricsForCstr views:self.viewsForCstr]];
        
        [self.customCstr addObjectsFromArray:[NSLayoutConstraint
            constraintsWithVisualFormat:@"H:|-62-[strikeImgView(145)]"
            options:0 metrics:self.metricsForCstr views:self.viewsForCstr]];
    }

    // titleTxtField
    
    [self.customCstr addObjectsFromArray:[NSLayoutConstraint
        constraintsWithVisualFormat:@"V:|-10-[titleTxtField]"
        options:0
        metrics:self.metricsForCstr views:self.viewsForCstr]];
    
    [self.customCstr addObjectsFromArray:[NSLayoutConstraint
        constraintsWithVisualFormat:@"H:|-62-[titleTxtField]-27-|"
        options:0 metrics:self.metricsForCstr views:self.viewsForCstr]];

    [self addConstraints:self.customCstr];
}

#pragma mark - NSObject 

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSControlTextDidChangeNotification
                                                  object:self.textField];
}

@end
