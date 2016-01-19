//
//  TDLOutlineViewDelegate.m
//  To-Do List App UI
//
//  Created by Abbas on 12/25/15.
//  Copyright © 2015 Gussenov. All rights reserved.
//

#import "TDLOutlineViewDelegate.h"
#import "TDLTblRowView.h"
#import "TDLItem.h"
#import "TDLTblCellView.h"

@implementation TDLOutlineViewDelegate

- (NSTableRowView *)outlineView:(NSOutlineView *)anOutlineView
                 rowViewForItem:(id)anItem
{
    TDLTblRowView *theRowView = [[TDLTblRowView alloc] init];
    if ([anOutlineView rowForItem:anItem] == anOutlineView.numberOfRows - 1) {
        [theRowView setShowUnderline:NO];
    }
    return theRowView;
}

- (NSView *)outlineView:(NSOutlineView *)anOutlineView viewForTableColumn:(NSTableColumn *)aTblColumn item:(TDLItem *)anItem
{
    TDLTblCellView *theTblCellView = [TDLTblCellView new];
    [theTblCellView.textField setStringValue:[anItem.title uppercaseString]];
    [theTblCellView setCompleted:anItem.isCompleted];
    return theTblCellView;
}

- (CGFloat)outlineView:(NSOutlineView *)anOutlineView heightOfRowByItem:(TDLItem *)anItem
{
    CGFloat theHeight = 38;
    if ([anOutlineView rowForItem:anItem] == anOutlineView.numberOfRows - 1) {
        return theHeight;
    } else {
        return theHeight + 1;
    }
}

- (BOOL)outlineView:(NSOutlineView *)anOutlineView shouldSelectItem:(TDLItem *)anItem
{
    return NO;
}

@end
