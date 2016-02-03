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

- (void)unregisterForChangeNotification
{
    for (TDLItem *theItem in self.items) {
        [theItem removeObserver:self
                     forKeyPath:@"propertiesChanged"];
    }
}

- (NSArray *)visibleItems
{
    NSArray *theVisibleItems = [self.items objectsAtIndexes:[self.items indexesOfObjectsPassingTest:
        ^BOOL(TDLItem *anItem, NSUInteger anIdx, BOOL *aStop) {
            BOOL theResult = YES;
            if (self.searchKeyword && self.searchKeyword.length != 0) {
                theResult = [anItem.title rangeOfString:self.searchKeyword
                    options:NSCaseInsensitiveSearch].location != NSNotFound ? YES : NO;
            }
            return theResult;
    }]];

    return theVisibleItems;
}

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

- (void)removeAll
{
    [self unregisterForChangeNotification];
    [self.items removeAllObjects];
    if (self.delegate) [self.delegate onAllItemsRemoved];
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
    [self unregisterForChangeNotification];
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

- (NSInteger)outlineView:(NSOutlineView *)anOutlineView
  numberOfChildrenOfItem:(TDLItem *)anItem
{
    return [self visibleItems].count;
}

- (id)outlineView:(NSOutlineView *)anOutlineView
            child:(NSInteger)anIdx
           ofItem:(TDLItem *)anItem
{
    return [[self visibleItems] objectAtIndex:anIdx];
}

- (BOOL)outlineView:(NSOutlineView *)anOutlineView
   isItemExpandable:(TDLItem *)anItem
{
    return NO;
}

@end
