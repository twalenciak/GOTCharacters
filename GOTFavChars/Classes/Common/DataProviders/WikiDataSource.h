//
//  WikiDataSource.h
//  GOTFavChars
//
//  Created by Bitcats on 10/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^JSONResponseBlock)(NSError *err, NSDictionary *response);

@interface WikiDataSource : NSObject

- (void)fetchCharactersWithCompletion:(JSONResponseBlock)completionBlock;

@end
