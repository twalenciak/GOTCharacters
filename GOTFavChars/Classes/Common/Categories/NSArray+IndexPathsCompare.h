//
//  NSArray+IndexPathsCompare.h
//  GOTFavChars
//
//  Created by Bitcats on 18/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^IndexPathsDiffBlock)(NSArray *removedIndexPaths, NSArray *insertedIndexPaths, NSArray *movedFromIndexPaths, NSArray *movedToIndexPaths);

@interface NSArray (IndexPathsCompare)

- (void)compareWithArray:(NSArray *)newArray section:(NSInteger)section withBlock:(IndexPathsDiffBlock)resultBlock;

@end
