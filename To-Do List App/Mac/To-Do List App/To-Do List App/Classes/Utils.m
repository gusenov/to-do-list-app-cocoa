//
//  Utils.m
//  To-Do List App
//
//  Created by Abbas on 1/20/16.
//  Copyright © 2016 Gussenov. All rights reserved.
//

#import "Utils.h"

@implementation Utils

+ (NSArray *)fillView:(NSView *)aView withAutoresizingSubview:(NSView *)aSubview
{
    NSParameterAssert(aView);
    NSParameterAssert(aSubview);
    [aSubview setTranslatesAutoresizingMaskIntoConstraints:NO];
    [aView addSubview:aSubview];
    NSDictionary *theViews = NSDictionaryOfVariableBindings(aSubview);
    NSMutableArray *theCustomConstraints = [NSMutableArray array];
    [theCustomConstraints addObjectsFromArray:[NSLayoutConstraint
        constraintsWithVisualFormat:@"H:|[aSubview]|" options:0 metrics:nil views:theViews]];
    [theCustomConstraints addObjectsFromArray:[NSLayoutConstraint
        constraintsWithVisualFormat:@"V:|[aSubview]|" options:0 metrics:nil views:theViews]];
    [aView addConstraints:theCustomConstraints];
    
    return theCustomConstraints;
}

@end
