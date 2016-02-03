//
//  PSBSearchTxtView.m
//  PopupInStatusBar
//
//  Created by Abbas Gussenov on 1/18/16.
//  Copyright © 2016 Gussenov Lab. All rights reserved.
//

#import "PSBSearchTxtView.h"


@interface PSBSearchTxtView ()

@property NSMutableArray *customCstr;
@property NSMutableDictionary *viewsForCstr;
@property NSMutableDictionary *metricsForCstr;

@property BOOL isConstructed;

@end


@implementation PSBSearchTxtView

- (void)initialization
{
    if (!_isConstructed) {
        _customCstr = [NSMutableArray array];
        _viewsForCstr = [NSMutableDictionary dictionary];
        _metricsForCstr = [NSMutableDictionary dictionary];
        
        _searchField = [[NSSearchField alloc] initWithFrame:NSMakeRect(20, 138, 240, 22)];
        [_searchField setAutoresizingMask:NSViewMinXMargin | NSViewWidthSizable | NSViewMaxXMargin | NSViewMinYMargin];
        [_searchField setFocusRingType:NSFocusRingTypeNone];
        [_viewsForCstr setObject:_searchField forKey:@"searchField"];
        [self addSubview:_searchField];

        _txtField = [[NSTextField alloc] initWithFrame:NSMakeRect(17, 20, 246, 110)];
        [_txtField setAutoresizingMask:NSViewMinXMargin | NSViewWidthSizable | NSViewMaxXMargin | NSViewMinYMargin | NSViewHeightSizable | NSViewMaxYMargin];
        [_txtField setBezeled:NO];
        [_txtField setDrawsBackground:NO];
        [_txtField setEditable:NO];
        [_txtField setSelectable:NO];
        [_txtField setAlignment:NSTextAlignmentCenter];
        [_viewsForCstr setObject:_txtField forKey:@"txtField"];
        [self addSubview:_txtField];
        
        // Follow search string
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(runSearch)
                                                     name:NSControlTextDidChangeNotification
                                                   object:self.searchField];

        _isConstructed = YES;
    }
}

- (void)runSearch
{
    NSString *theSearchFormat = @"";
    NSString *theSearchString = [self.searchField stringValue];
    
    if ([theSearchString length] > 0) {
        theSearchFormat = NSLocalizedString(@"Search for ‘%@’…", @"Format for search request");
    }
    
    NSString *theSearchRequest = [NSString stringWithFormat:theSearchFormat, theSearchString];
    [self.txtField setStringValue:theSearchRequest];
}

#pragma mark - NSObject

- (void)awakeFromNib
{
    [self initialization];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:NSControlTextDidChangeNotification
                                                  object:self.searchField];
}

#pragma mark - NSResponder

- (id)init
{
    self = [super init];
    if (self) {
        [self initialization];
    }
    return self;
}

#pragma mark - NSView

- (id)initWithFrame:(NSRect)aFrameRect
{
    self = [super initWithFrame:aFrameRect];
    if (self) {
        [self initialization];
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
    
    [self addConstraints:self.customCstr];
}

@end
