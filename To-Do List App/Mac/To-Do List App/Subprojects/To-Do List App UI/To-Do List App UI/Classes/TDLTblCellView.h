//
//  TDLTblCellView.h
//  To-Do List App UI
//
//  Created by Abbas Gussenov on 12/25/15.
//  Copyright © 2015 Gussenov Lab. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "TDLItem.h"

@interface TDLTblCellView : NSTableCellView

@property (nonatomic, setter = setCompleted:) BOOL isCompleted;

- (id)initWithItem:(TDLItem *)anItem;

@end
