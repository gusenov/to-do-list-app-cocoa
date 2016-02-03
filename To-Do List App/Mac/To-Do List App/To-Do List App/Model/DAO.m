//
//  DAO.m
//  To-Do List App
//
//  Created by Abbas Gussenov on 2/2/16.
//  Copyright © 2016 Gussenov Lab. All rights reserved.
//

#import "DAO.h"

@implementation DAO

- (NSFetchRequest *)taskFetchRequest
{
    NSEntityDescription *theEntityDescription = [NSEntityDescription entityForName:@"Task"
                                                            inManagedObjectContext:self.MOC];
    NSFetchRequest *theRequest = [[NSFetchRequest alloc] init];
    [theRequest setEntity:theEntityDescription];
    
    return theRequest;
}

- (Task *)taskWithItem:(TDLItem *)anItem
{
    NSParameterAssert(anItem);
    NSFetchRequest *theRequest = [self taskFetchRequest];
    [theRequest setPredicate:[NSPredicate predicateWithFormat:@"uuid == %@", anItem.uuid]];
    NSError *theError = nil;
    NSArray *theResult = [self.MOC executeFetchRequest:theRequest error:&theError];
    assert(theResult.count == 1);
    return [theResult firstObject];
}

- (void)fromItem:(TDLItem *)anItem
          toTask:(Task *)aTask
{
    aTask.title = anItem.title;
    aTask.finished = [NSNumber numberWithBool:anItem.isCompleted];
    aTask.uuid = anItem.uuid;
    aTask.creation = anItem.creationDate;
    aTask.completion = anItem.completionDate;
    aTask.author = anItem.userName;
    aTask.modification = anItem.modificationDate;
}

- (void)save
{
    @synchronized(self) {
        if (self.MOC && [self.MOC commitEditing] && [self.MOC hasChanges]) {
            NSError *theError = nil;
            [self.MOC save:&theError];
        }
    }
}

#pragma mark - DAO

- (id)initWithMOC:(NSManagedObjectContext *)aMOC
{
    self = [self init];
    if (self) {
        _MOC = aMOC;
    }
    return self;
}

- (NSArray *)tasks
{
    NSFetchRequest *theRequest = [self taskFetchRequest];
    [theRequest setSortDescriptors:@[ [[NSSortDescriptor alloc] initWithKey:@"creation" ascending:NO] ]];
    
    NSError *theError = nil;
    NSArray *theResult = [self.MOC executeFetchRequest:theRequest error:&theError];
    if (theResult == nil) {
        return [NSArray array];
    }
    
    return theResult;
}

- (NSArray *)items
{
    NSMutableArray *theItems = [NSMutableArray array];
    for (Task *theTask in [self tasks]) {
        [theItems addObject:[[TDLItem alloc] initWithTitle:theTask.title
                                                 completed:[theTask.finished boolValue]
                                                      UUID:theTask.uuid
                                              creationDate:theTask.creation
                                            completionDate:theTask.completion
                                                  userName:theTask.author
                                          modificationDate:theTask.modification]];
    }
    return theItems;
}

#pragma mark - TDLDataSourceDelegate

- (void)onItemAdded:(TDLItem *)anItem
{
    NSParameterAssert(anItem);
    Task *theNewTask = [[Task alloc] initWithEntity:[NSEntityDescription entityForName:@"Task" inManagedObjectContext:self.MOC]
                     insertIntoManagedObjectContext:self.MOC];
    [self fromItem:anItem toTask:theNewTask];
    
    [self save];
}

- (void)onItemRemoved:(TDLItem *)anItem
{
    [self.MOC deleteObject:[self taskWithItem:anItem]];
    
    [self save];
}

- (void)onAllItemsRemoved
{
    for (Task *theTask in [self tasks]) {
        [self.MOC deleteObject:theTask];
    }
    
    [self save];
}

- (void)onItemChanged:(TDLItem *)anItem
{
    Task *theChangedTask = [self taskWithItem:anItem];
    [self fromItem:anItem toTask:theChangedTask];
    
    [self save];
}


@end
