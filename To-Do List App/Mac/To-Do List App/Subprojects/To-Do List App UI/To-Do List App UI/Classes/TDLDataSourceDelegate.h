//
//  TDLDataSourceDelegate.h
//  To-Do List App UI
//
//  Created by Abbas Gussenov on 2/2/16.
//  Copyright © 2016 Gussenov Lab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TDLItem.h"

@protocol TDLDataSourceDelegate <NSObject>

- (void)onItemAdded:(TDLItem *)anItem;
- (void)onItemRemoved:(TDLItem *)anItem;
- (void)onAllItemsRemoved;
- (void)onItemChanged:(TDLItem *)anItem;

@end
