//
//  IndexPathCompareTest.m
//  GOTFavChars
//
//  Created by Bitcats on 18/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "NSArray+IndexPathsCompare.h"

#import "CharacterModel.h"
#import "NSArray+IndexPathsCompare.h"

NSString *JSSingleModelSnow = @"JonSnowTestChar";
NSString *JSResponseBody42 = @"ResponseBody42";

@interface IndexPathCompareTest : XCTestCase

@property NSArray *inputDataSource;

@end

@implementation IndexPathCompareTest

- (void)setUp {
    [super setUp];
    
    NSDictionary *rootItem = [self rootFromPath:JSResponseBody42];
    
    NSError *err;
    
    NSArray *items = rootItem[@"items"];
    
    NSArray *modelArray = [MTLJSONAdapter modelsOfClass:[CharacterModel class] fromJSONArray:items error:&err];
    
    self.inputDataSource = modelArray;
    
    XCTAssertNotNil(modelArray);
    XCTAssertEqual([modelArray count], 42);
    
}

- (void)tearDown {
    [super tearDown];
}

- (void)testAddedElements {
    NSArray *subArray2to7 = [self.inputDataSource subarrayWithRange:NSMakeRange(2, 5)];
    
    [subArray2to7 compareWithArray:self.inputDataSource
                           section:0
                         withBlock:^(NSArray *removedIndexPaths, NSArray *insertedIndexPaths) {
        XCTAssertTrue([removedIndexPaths count]==0, @"should not be any new elements");
        XCTAssertTrue([insertedIndexPaths count]==37, @"should be expected elements count");
    }];
    
    [self.inputDataSource compareWithArray:subArray2to7
                                   section:0
                                 withBlock:^(NSArray *removedIndexPaths, NSArray *insertedIndexPaths) {
        XCTAssertTrue([insertedIndexPaths count]==0, @"should not be any new elements");
        XCTAssertTrue([removedIndexPaths count]==37, @"should be expected elements count");
    }];
    
}

#pragma mark -

- (NSDictionary *)rootFromPath:(NSString *)JSPath {
    NSString* filepath = [[NSBundle bundleForClass:[self class]]pathForResource:JSPath ofType:@"json"];
    NSError *err;
    
    NSData *data = [NSData dataWithContentsOfFile:filepath];
    NSDictionary *rootItem = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
    
    return rootItem;
}

@end
