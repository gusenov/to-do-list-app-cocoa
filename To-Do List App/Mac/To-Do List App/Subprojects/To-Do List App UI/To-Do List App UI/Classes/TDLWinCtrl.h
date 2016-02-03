//
//  TDLWinCtrl.h
//  To-Do List App UI
//
//  Created by Abbas Gussenov on 12/24/15.
//  Copyright © 2015 Gussenov Lab. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class TDLDataSource;


@interface TDLWinCtrl : NSWindowController

- (void)setDataSource:(TDLDataSource *)aDataSource;

@end
