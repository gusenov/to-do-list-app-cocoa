//
//  TDLDataSource.m
//  To-Do List App UI
//
//  Created by Abbas on 12/25/15.
//  Copyright © 2015 Gussenov. All rights reserved.
//

#import "TDLDataSource.h"
#import "TDLItem.h"


@interface TDLDataSource ()

@property (strong) NSMutableArray *items;

@end


@implementation TDLDataSource

#pragma mark - TDLDataSource

- (void)addItem:(TDLItem *)anItem
{
    NSParameterAssert(anItem);
    [self.items addObject:anItem];
}

#pragma mark - NSObject

- (id)init
{
    self = [super init];
    if (self) {
        _items = [NSMutableArray array];
    }
    return self;
}

#pragma mark - NSOutlineViewDataSource

- (NSInteger)outlineView:(NSOutlineView *)anOutlineView numberOfChildrenOfItem:(TDLItem *)anItem
{
    return self.items.count;
}

- (id)outlineView:(NSOutlineView *)anOutlineView child:(NSInteger)anIdx ofItem:(TDLItem *)anItem
{
    return [self.items objectAtIndex:anIdx];
}

- (BOOL)outlineView:(NSOutlineView *)anOutlineView isItemExpandable:(TDLItem *)anItem
{
    return NO;
}

@end
