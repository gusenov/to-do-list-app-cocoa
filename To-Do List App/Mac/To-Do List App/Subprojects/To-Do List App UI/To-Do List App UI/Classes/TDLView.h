//
//  TDLView.h
//  To-Do List App UI
//
//  Created by Abbas Gussenov on 12/23/15.
//  Copyright © 2015 Gussenov Lab. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class TDLDataSource;


@interface TDLView : NSView

- (void)setDataSource:(TDLDataSource *)aDataSource;
- (TDLDataSource *)dataSource;

@end
