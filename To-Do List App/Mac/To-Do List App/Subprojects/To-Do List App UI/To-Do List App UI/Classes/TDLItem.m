//
//  TDLItem.m
//  To-Do List App UI
//
//  Created by Abbas Gussenov on 12/25/15.
//  Copyright © 2015 Gussenov Lab. All rights reserved.
//

#import "TDLItem.h"

@implementation TDLItem

#pragma mark - TDLItem

- (id)initWithTitle:(NSString *)aTitle completed:(BOOL)aCompleted
{
    self = [self init];
    if (self) {
        _title = aTitle;
        _isCompleted = aCompleted;
        _uuid = [[NSUUID UUID] UUIDString];
        _creationDate = [NSDate date];
        _userName = NSFullUserName();
    }
    return self;
}

- (id)initWithTitle:(NSString *)aTitle
          completed:(BOOL)aCompleted
               UUID:(NSString *)anUUID
       creationDate:(NSDate *)aCreationDate
     completionDate:(NSDate *)aCompletionDate
           userName:(NSString *)anUserName
   modificationDate:(NSDate *)aModificationDate
{
    self = [self init];
    if (self) {
        _title = aTitle;
        _isCompleted = aCompleted;
        _uuid = anUUID;
        _creationDate = aCreationDate;
        _completionDate = aCompletionDate;
        _userName = anUserName;
        _modificationDate = aModificationDate;
    }
    return self;

}

- (void)setCompleted:(BOOL)aCompleted
{
    _isCompleted = aCompleted;
    _completionDate = _isCompleted ? [NSDate date] : nil;
}

- (id)propertiesChanged {
    return nil;
}

+ (NSSet *)keyPathsForValuesAffectingPropertiesChanged
{
    return [NSSet setWithObjects:
          @"title"
        , @"completed"
        , @"uuid"
        , @"creationDate"
        , @"completionDate"
        , @"userName"
        , @"modificationDate"
        , nil];
}

@end
