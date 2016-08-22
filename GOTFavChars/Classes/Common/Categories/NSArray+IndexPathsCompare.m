//
//  NSArray+IndexPathsCompare.m
//  GOTFavChars
//
//  Created by Bitcats on 18/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import "NSArray+IndexPathsCompare.h"

@implementation NSArray (IndexPathsCompare)

- (void)compareWithArray:(NSArray *)newArray section:(NSInteger)section withBlock:(IndexPathsDiffBlock)resultBlock
{
    NSMutableArray *insertedElements = [NSMutableArray new];
    NSMutableArray *removedElements = [NSMutableArray new];
    
    NSMutableArray *movedFromElements = [NSMutableArray new];
    NSMutableArray *movedToElements = [NSMutableArray new];
    
    // removes
    for (NSInteger i = 0; i < [self count]; i++) {
        NSObject *objOld = self[i];
        if (![newArray containsObject:objOld]) {
            NSUInteger indexes[] = {section, i};
            NSIndexPath *ip = [NSIndexPath indexPathWithIndexes:indexes length:2];
            [removedElements addObject:ip];
        }
    }
    
    // inserts / moves
    for (NSInteger newIdx = 0; newIdx < [newArray count]; newIdx++) {
        NSObject *newObj = newArray[newIdx];
        if (![self containsObject:newObj]) {
            NSUInteger indexes[] = {section, newIdx};
            NSIndexPath *ip = [NSIndexPath indexPathWithIndexes:indexes length:2];
            [insertedElements addObject:ip];
        } else {
            NSUInteger oldIdx = [self indexOfObject:newObj];
            if (oldIdx != newIdx) {
                NSUInteger idxFrom[] = {section, oldIdx};
                NSIndexPath *ipFrom = [NSIndexPath indexPathWithIndexes:idxFrom length:2];
                [movedFromElements addObject:ipFrom];
                
                NSUInteger idxTo[] = {section, newIdx};
                NSIndexPath *ipTo = [NSIndexPath indexPathWithIndexes:idxTo length:2];
                [movedToElements addObject:ipTo];
            }
        }
    }
    if (resultBlock) {
        resultBlock([NSArray arrayWithArray:removedElements],
                    [NSArray arrayWithArray:insertedElements],
                    [NSArray arrayWithArray:movedFromElements],
                    [NSArray arrayWithArray:movedToElements]);
    }
}

@end
