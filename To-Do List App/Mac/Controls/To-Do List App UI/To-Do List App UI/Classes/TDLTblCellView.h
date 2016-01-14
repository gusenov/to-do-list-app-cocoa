//
//  TDLTblCellView.h
//  To-Do List App UI
//
//  Created by Abbas on 12/25/15.
//  Copyright © 2015 Gussenov. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface TDLTblCellView : NSTableCellView

@property (nonatomic, setter = setCompleted:) BOOL isCompleted;

@end
