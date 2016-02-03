//
//  Task+CoreDataProperties.h
//  To-Do List App
//
//  Created by Abbas Gussenov on 2/2/16.
//  Copyright © 2016 Gussenov Lab. All rights reserved.
//
//  Delete this file and regenerate it using "Create NSManagedObject Subclass…"
//  to keep your implementation up to date with your model.
//

#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface Task (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *author;
@property (nullable, nonatomic, retain) NSDate *completion;
@property (nullable, nonatomic, retain) NSDate *creation;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSNumber *finished;
@property (nullable, nonatomic, retain) NSDate *modification;
@property (nullable, nonatomic, retain) NSString *uuid;

@end

NS_ASSUME_NONNULL_END
