//
//  TDLDataSource.h
//  To-Do List App UI
//
//  Created by Abbas Gussenov on 12/25/15.
//  Copyright © 2015 Gussenov Lab. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TDLDataSourceDelegate.h"
#import "TDLItem.h"


@interface TDLDataSource : NSObject <NSOutlineViewDataSource>

@property (strong) id<TDLDataSourceDelegate> delegate;

- (id)initWithDelegate:(id<TDLDataSourceDelegate>)aDelegate;
- (id)initWithItems:(NSArray *)anItems;

- (void)addItem:(TDLItem *)anItem;
- (void)removeItem:(TDLItem *)anItem;
- (void)removeAll;

@end
