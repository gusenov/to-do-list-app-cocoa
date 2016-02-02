//
//  DAO.h
//  To-Do List App
//
//  Created by Abbas Gussenov on 2/2/16.
//  Copyright © 2016 Gussenov Lab. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "Task.h"
#import <PopupToDoGUI/TDLDataSourceDelegate.h>

@interface DAO : NSObject <TDLDataSourceDelegate>

@property (strong) NSManagedObjectContext *MOC;

- (id)initWithMOC:(NSManagedObjectContext *)aMOC;

- (NSArray *)tasks;
- (NSArray *)items;

@end
