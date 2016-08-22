//
//  InternalDataStoreTests.m
//  GOTFavChars
//
//  Created by Bitcats on 10/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "InternalDataStore.h"

@interface InternalDataStoreTests : XCTestCase

@property (nonatomic) InternalDataStore *dataStore;

@end

@implementation InternalDataStoreTests

- (void)setUp {
    [super setUp];
    self.dataStore = [InternalDataStore new];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testConsistency {
    BOOL tNo1 = [self.dataStore isFavouritedItemWithIndex:2];
    BOOL tNo2 = [self.dataStore isFavouritedItemWithIndex:4];
    XCTAssertFalse(tNo1 || tNo2, @"shuld be not favourited readed");
    [self.dataStore storeFavourited:YES itemWithIndex:3];
    BOOL tYesIndex = [self.dataStore isFavouritedItemWithIndex:3];
    XCTAssertTrue(tYesIndex, @"not recognized stored item");
    [self.dataStore storeFavourited:NO itemWithIndex:3];
    BOOL tNo3 = [self.dataStore isFavouritedItemWithIndex:3];
    XCTAssertFalse(tNo3, @"should remove value from data store");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
