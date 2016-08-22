//
//  InternalDataStore.m
//  GOTFavChars
//
//  Created by Bitcats on 10/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import "InternalDataStore.h"

static NSString *standardFavArrayKey = @"favArrayKey";

@interface InternalDataStore ()

@property (nonatomic) NSString *storeKey;

@end

@implementation InternalDataStore

- (BOOL)isFavouritedItemWithIndex:(NSInteger)index
{
    BOOL result = NO;
    NSArray *arr = [self arrayFavourited];
    if (arr && [arr containsObject:@(index)]) {
        result = YES;
    }
    return result;
}

- (void)storeFavourited:(BOOL)isFavourited itemWithIndex:(NSInteger)index
{
    NSMutableArray *arr = [self arrayFavouritedMutable];
    if (isFavourited) {
        if (![arr containsObject:@(index)]) {
            [arr addObject:@(index)];
        }
    } else {
        [arr removeObject:@(index)];
    }
    [self saveArrayFavourited:arr];
}

- (void)resetDataStore
{
    [self saveArrayFavourited:@[]];
}

- (NSString *)arrayKey
{
    if (self.storeKey && ![self.storeKey isEqualToString:@""]) {
        return self.storeKey;
    }
    return standardFavArrayKey;
}

- (void)saveArrayFavourited:(NSArray *)array;
{
    [[NSUserDefaults standardUserDefaults]setObject:array forKey:[self arrayKey]];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

- (NSMutableArray *)arrayFavouritedMutable
{
    NSMutableArray *arr = [[[NSUserDefaults standardUserDefaults]arrayForKey:[self arrayKey]]mutableCopy];
    if (!arr) {
        arr = [NSMutableArray new];
    }
    return arr;
}

- (NSArray *)arrayFavourited
{
    NSArray *arr = [[NSUserDefaults standardUserDefaults]arrayForKey:[self arrayKey]];
    if (!arr) {
        arr = [NSArray new];
    }
    return arr;
}

+ (instancetype)internalDataStoreWithKey:(NSString *)uniqueStoreKey
{
    InternalDataStore *result = [InternalDataStore new];
    result.storeKey = uniqueStoreKey;
    
    return result;
}

@end
