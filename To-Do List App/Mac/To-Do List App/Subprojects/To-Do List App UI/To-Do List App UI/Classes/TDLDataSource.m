//
//  TDLDataSource.m
//  To-Do List App UI
//
//  Created by Abbas Gussenov on 12/25/15.
//  Copyright © 2015 Gussenov Lab. All rights reserved.
//

#import "TDLDataSource.h"
#import "TDLItem.h"


@interface TDLDataSource ()

@property (strong) NSMutableArray *items;

@end


@implementation TDLDataSource

#pragma mark - TDLDataSource

- (id)initWithDelegate:(id<TDLDataSourceDelegate>)aDelegate
{
    self = [self init];
    if (self) {
        _delegate = aDelegate;
    }
    return self;
}

- (id)initWithItems:(NSArray *)anItems
{
    self = [self init];
    if (self) {
        [_items addObjectsFromArray:anItems];
    }
    return self;
}


- (void)addItem:(TDLItem *)anItem
{
    NSParameterAssert(anItem);
    [self.items insertObject:anItem atIndex:0];
    if (self.delegate) [self.delegate onItemAdded:anItem];
}

- (void)removeItem:(TDLItem *)anItem
{
    NSParameterAssert(anItem);
    [self.items removeObject:anItem];
    if (self.delegate) [self.delegate onItemRemoved:anItem];
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
