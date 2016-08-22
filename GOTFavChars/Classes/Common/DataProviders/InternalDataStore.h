//
//  InternalDataStore.h
//  GOTFavChars
//
//  Created by Bitcats on 10/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InternalDataStore : NSObject

- (void)storeFavourited:(BOOL)isFavourited itemWithIndex:(NSInteger)index;
- (BOOL)isFavouritedItemWithIndex:(NSInteger)index;
- (void)resetDataStore;

+ (instancetype)internalDataStoreWithKey:(NSString *)uniqueStoreKey;

@end
