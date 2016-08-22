//
//  CharactersDataManager.h
//  GOTFavChars
//
//  Created by Bitcats on 10/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WikiDataSource.h"
#import "InternalDataStore.h"

typedef void (^DataResponseBlock)(NSError *err, NSArray *items);

@interface CharactersDataManager : NSObject

@property (nonatomic) WikiDataSource *dataSource;
@property (nonatomic) InternalDataStore *dataStore;

- (void)fetchCharacters:(DataResponseBlock)completion filteringFavourited:(BOOL)filterFavourited;

+ (instancetype)charactersDataManagerDefaultSources;
+ (instancetype)charactersDataManagerTestSources;

@end
