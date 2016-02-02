//
//  TDLDataSource.m
//  To-Do List App UI
//
//  Created by Abbas Gussenov on 12/25/15.
//  Copyright © 2015 Gussenov Lab. All rights reserved.
//

#import "TDLDataSource.h"


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
        for (TDLItem *theItem in _items) {
            [theItem addObserver:self
                      forKeyPath:@"propertiesChanged"
                         options:NSKeyValueObservingOptionNew
                         context:nil];
        }
    }
    return self;
}


- (void)addItem:(TDLItem *)anItem
{
    NSParameterAssert(anItem);
    [self.items insertObject:anItem atIndex:0];
    if (self.delegate) [self.delegate onItemAdded:anItem];
    
    [anItem addObserver:self
             forKeyPath:@"propertiesChanged"
                options:NSKeyValueObservingOptionNew
                context:nil];
}

- (void)removeItem:(TDLItem *)anItem
{
    NSParameterAssert(anItem);
    [anItem removeObserver:self forKeyPath:@"propertiesChanged"];
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

- (void)dealloc
{
    for (TDLItem *theItem in self.items) {
        [theItem removeObserver:self forKeyPath:@"propertiesChanged"];
    }
}

#pragma mark - NSObject(NSKeyValueObserving)

- (void)observeValueForKeyPath:(NSString *)aKeyPath
                      ofObject:(id)anObject
                        change:(NSDictionary *)aChange
                       context:(void *)aContext
{
    if (self.delegate) [self.delegate onItemChanged:anObject];
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
