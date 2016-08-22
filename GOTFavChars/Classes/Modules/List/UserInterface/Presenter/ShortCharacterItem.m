//
//  ShortCharacterItem.m
//  GOTFavChars
//
//  Created by Bitcats on 09/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import "ShortCharacterItem.h"

@implementation ShortCharacterItem

- (BOOL)isEqual:(id)object {
    if (!object) {
        return NO;
    }
    if (![object isKindOfClass:[ShortCharacterItem class]]) {
        return NO;
    }
    ShortCharacterItem *obj = (ShortCharacterItem *)object;
    return self.identifier == obj.identifier && self.isExpanded == obj.isExpanded;
}

@end
