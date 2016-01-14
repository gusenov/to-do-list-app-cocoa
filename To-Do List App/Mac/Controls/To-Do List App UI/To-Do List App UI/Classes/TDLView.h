//
//  TDLView.h
//  To-Do List App UI
//
//  Created by Abbas on 12/23/15.
//  Copyright © 2015 Gussenov. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class TDLDataSource;


@interface TDLView : NSView

- (void)setDataSource:(TDLDataSource *)aDataSource;

@end
