//
//  TDLOutlineView.m
//  To-Do List App UI
//
//  Created by Abbas Gussenov on 12/23/15.
//  Copyright © 2015 Gussenov Lab. All rights reserved.
//

#import "TDLOutlineView.h"
#import "TDLDataSource.h"


@interface TDLOutlineView ()

@property NSInteger indexOfRowUnderPointer;

@property (strong) NSMenu *contextMenu;

@property BOOL isConstructed;

@end


@implementation TDLOutlineView

- (void)constructor
{
    if (!_isConstructed) {
        self.focusRingType = NSFocusRingTypeNone;
        [self setGridStyleMask:NSTableViewGridNone];
        [self setIntercellSpacing:NSMakeSize(0, 0)];
        [self setBackgroundColor:[NSColor clearColor]];
        [self setSelectionHighlightStyle:NSTableViewSelectionHighlightStyleNone];

        NSRect theOutlineViewHeaderFrame = self.headerView.frame;
        theOutlineViewHeaderFrame.size.height = 0;
        self.headerView.frame = theOutlineViewHeaderFrame;
        self.headerView = nil;
        
        NSTableColumn *theColumn = [NSTableColumn new];
        [self addTableColumn:theColumn];

        _contextMenu = [[NSMenu alloc] init];
        [_contextMenu setDelegate:self];
        [self setMenu:_contextMenu];
        
        _isConstructed = YES;
    }
}

- (void)drawContextMenuHighlightForRow:(int)aRow
{
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

- (NSMenu *)menuForEvent:(NSEvent *)anEvent
{
    NSPoint thePoint = [self convertPoint:[anEvent locationInWindow] fromView:nil];
    self.indexOfRowUnderPointer = [self rowAtPoint:thePoint];
    return [super menuForEvent:anEvent];
}

#pragma mark - NSMenuDelegate

- (void)menuNeedsUpdate:(NSMenu *)aMenu
{
    [aMenu removeAllItems];
    NSInteger theMenuIndex = 0;
    
    NSUInteger theIndexOfRowUnderPointer = self.indexOfRowUnderPointer;
    
    if (theIndexOfRowUnderPointer != -1) {
        [aMenu insertItemWithTitle:@"Delete"
                            action:@selector(removeItem:)
                     keyEquivalent:@""
                           atIndex:theMenuIndex++];
    }
    
    if (self.numberOfRows > 0) {
        [aMenu insertItemWithTitle:@"Delete All"
                            action:@selector(removeAllTasks:)
                     keyEquivalent:@""
                           atIndex:theMenuIndex++];
    }

}

- (IBAction)removeItem:(id)aSender
{
    TDLItem *theItem = [self itemAtRow:self.indexOfRowUnderPointer];
    TDLDataSource *theDataSource = [self dataSource];
    [theDataSource removeItem:theItem];
    
    [self beginUpdates];
    [self removeItemsAtIndexes:[NSIndexSet indexSetWithIndex:self.indexOfRowUnderPointer]
                      inParent:nil
                 withAnimation:NSTableViewAnimationEffectFade];
    [self endUpdates];
}

- (IBAction)removeAllTasks:(id)aSender
{
    TDLDataSource *theDataSource = [self dataSource];
    [theDataSource removeAll];
    
    [self beginUpdates];
    [self reloadData];
    [self endUpdates];
}

#pragma mark - NSResponder

- (void)scrollWheel:(NSEvent *)anEvent
{
    [super scrollWheel:anEvent];
}

@end
