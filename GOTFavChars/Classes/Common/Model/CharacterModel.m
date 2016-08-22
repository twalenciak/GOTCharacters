//
//  CharacterModel.m
//  GOTFavChars
//
//  Created by Bitcats on 10/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import "CharacterModel.h"

@implementation CharacterModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
                 @"identifier" : @"id",
                 @"title" : @"title",
                 @"externalPathURL" : @"url",
                 @"abstract" : @"abstract",
                 @"thumbURL" : @"thumbnail",
             };
}

@end
