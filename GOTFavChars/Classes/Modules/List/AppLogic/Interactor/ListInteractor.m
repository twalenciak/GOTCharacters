//
//  ListInteractor.m
//  GOTFavChars
//
//  Created by Bitcats on 11/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import "ListInteractor.h"

@interface ListInteractor ()

@property (nonatomic) CharactersDataManager *dataManager;

@end

@implementation ListInteractor 

- (void)findCharacterItemsFavourited:(BOOL)filterFavouritedOnly
{
    __weak ListInteractor *wself = self;
    
    [self.dataManager fetchCharacters:^(NSError *err, NSArray *items) {
        if (!err) {
            [wself.output foundCharacterItems:items];
        } else {
            [wself.output foundCharacterItems:nil];
        }
    } filteringFavourited:filterFavouritedOnly];
}

- (void)toggleFavouritedCharacterWithId:(NSInteger)index
{
    BOOL isFav = [self.dataManager.dataStore isFavouritedItemWithIndex:index];
    BOOL newFav = !isFav;
    [self.dataManager.dataStore storeFavourited:newFav itemWithIndex:index];
    [self.output didChangeCharacter:index toFavourited:newFav];
}

- (instancetype)initWithDataManager:(CharactersDataManager *)dataManager
{
    if (self = [super init]) {
        self.dataManager = dataManager;
    }
    return self;
}

@end
