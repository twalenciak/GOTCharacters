//
//  CharactersDataManager.m
//  GOTFavChars
//
//  Created by Bitcats on 10/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import "CharactersDataManager.h"
#import "CharacterModel.h"
#import "ShortCharacterItem.h"

@interface CharactersDataManager ()

@property (nonatomic) NSArray *cachedModel;
@property (nonatomic) NSString *basepath;
@end

@implementation CharactersDataManager

- (void)fetchCharacters:(DataResponseBlock)completion filteringFavourited:(BOOL)filterFavourited
{
    [self.dataSource fetchCharactersWithCompletion:^(NSError *err, NSDictionary *response) {
        if (err) {
            completion(err, nil);
        } else {
            
            NSString *basepath = response[@"basepath"];
            self.basepath = basepath;
            NSArray *items = response[@"items"];
            NSError *err;
            NSArray *modelsArray = [MTLJSONAdapter modelsOfClass:[CharacterModel class] fromJSONArray:items error:&err];
            NSArray *result = [self modelItemsFromArray:modelsArray filterFavouritedOnly:filterFavourited];
            self.cachedModel = result;
            completion(nil, result);
        }
    }];
}

- (NSArray *)modelItemsFromArray:(NSArray *)modelArray filterFavouritedOnly:(BOOL)filterFavourited
{
    NSMutableArray *result = [NSMutableArray new];
    for (CharacterModel *model in modelArray) {
        NSInteger identifier = model.identifier;
        BOOL favourited = [self.dataStore isFavouritedItemWithIndex:identifier];
        if (filterFavourited && !favourited) {
            continue;
        }
        
        ShortCharacterItem *item = [ShortCharacterItem new];
        
        item.identifier = model.identifier;
        item.title = model.title;
        item.overview = model.abstract;
        item.thumbURL = [NSURL URLWithString:model.thumbURL];
        item.isFavourited = favourited;
        
        NSString *fullPath = [self.basepath stringByAppendingPathComponent:model.externalPathURL];
        item.externalLinkURL = [NSURL URLWithString:fullPath];
        
        [result addObject:item];
    }
    
    return [NSArray arrayWithArray:result];
}

+ (instancetype)charactersDataManagerDefaultSources
{
    CharactersDataManager *dataManager = [CharactersDataManager new];
    WikiDataSource *datSource = [WikiDataSource new];
    InternalDataStore *datStore = [InternalDataStore new];
    dataManager.dataStore = datStore;
    dataManager.dataSource = datSource;
    
    return dataManager;
}

+ (instancetype)charactersDataManagerTestSources
{
    CharactersDataManager *dataManager = [CharactersDataManager new];
    WikiDataSource *datSource = [WikiDataSource new];
    InternalDataStore *datStore = [InternalDataStore internalDataStoreWithKey:@"testKey"];
    
    dataManager.dataStore = datStore;
    dataManager.dataSource = datSource;
    
    return dataManager;
}

@end
