//
//  TDLWinCtrl.h
//  To-Do List App UI
//
//  Created by Abbas on 12/24/15.
//  Copyright © 2015 Gussenov. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@class TDLDataSource;


@interface TDLWinCtrl : NSWindowController

- (void)setDataSource:(TDLDataSource *)aDataSource;

@end
