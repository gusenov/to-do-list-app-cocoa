//
//  TDLItem.h
//  To-Do List App UI
//
//  Created by Abbas on 12/25/15.
//  Copyright © 2015 Gussenov. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDLItem : NSObject

@property (strong) NSString *title;
@property (nonatomic, setter = setCompleted:) BOOL isCompleted;

- (id)initWithTitle:(NSString *)aTitle completed:(BOOL)aCompleted;

@end
