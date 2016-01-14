//
//  TDLDataSource.h
//  To-Do List App UI
//
//  Created by Abbas on 12/25/15.
//  Copyright © 2015 Gussenov. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class TDLItem;


@interface TDLDataSource : NSObject <NSOutlineViewDataSource>

- (void)addItem:(TDLItem *)anItem;

@end
