//
//  TDLItem.h
//  To-Do List App UI
//
//  Created by Abbas Gussenov on 12/25/15.
//  Copyright © 2015 Gussenov Lab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDLItem : NSObject

@property (strong) NSString *title;
@property (nonatomic, setter = setCompleted:) BOOL isCompleted;
@property (strong, readonly) NSString *uuid;
@property (strong, readonly) NSDate *creationDate;
@property (strong, readonly) NSDate *completionDate;
@property (strong, readonly) NSString *userName;
@property (strong, readonly) NSDate *modificationDate;

@property (nonatomic, strong, readonly) id propertiesChanged;

- (id)initWithTitle:(NSString *)aTitle
          completed:(BOOL)aCompleted;

- (id)initWithTitle:(NSString *)aTitle
          completed:(BOOL)aCompleted
               UUID:(NSString *)anUUID
       creationDate:(NSDate *)aCreationDate
     completionDate:(NSDate *)aCompletionDate
           userName:(NSString *)anUserName
   modificationDate:(NSDate *)aModificationDate;

@end
