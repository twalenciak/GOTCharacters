//
//  ListInteractorTest.m
//  GOTFavChars
//
//  Created by Bitcats on 19/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ListInteractor.h"
#import "ShortCharacterItem.h"

@interface ListInteractorTest : XCTestCase

@property (nonatomic) CharactersDataManager *dataInteractorManager;

@end

@implementation ListInteractorTest

- (void)setUp {
    [super setUp];
    CharactersDataManager *datManager = [CharactersDataManager charactersDataManagerTestSources];
    self.dataInteractorManager = datManager;
}

- (void)tearDown {
    [self.dataInteractorManager.dataStore resetDataStore];
    
    [super tearDown];
}

- (void)testAddToFavourited {
    
    [self.dataInteractorManager fetchCharacters:^(NSError *err, NSArray *items) {
        XCTAssert([items count] == 0, @"should be zero favourited");
        [self.dataInteractorManager fetchCharacters:^(NSError *err, NSArray *items) {
            XCTAssert([items count] == 75, @"expected 75 favourited");
            ShortCharacterItem *item = [items firstObject];
            ShortCharacterItem *itemLast = [items lastObject];
            XCTAssert([item isKindOfClass:[ShortCharacterItem class]] && [itemLast isKindOfClass:[ShortCharacterItem class]], @"class should be ShortCharacterItem");
            [self.dataInteractorManager.dataStore storeFavourited:YES itemWithIndex:item.identifier];
            [self.dataInteractorManager.dataStore storeFavourited:YES itemWithIndex:itemLast.identifier];
            
            [self.dataInteractorManager fetchCharacters:^(NSError *err, NSArray *items) {
                XCTAssert(items.count == 2, @"should return 2 favourited");
                BOOL cont1 = [items containsObject:item];
                BOOL cont2 = [items containsObject:itemLast];
                
                XCTAssert(cont1 && cont2, @"expected exact favourited set");
                
            } filteringFavourited:YES];
        } filteringFavourited:NO];
    } filteringFavourited:YES];
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
