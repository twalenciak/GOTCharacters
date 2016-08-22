//
//  ListCharacterCell+CharacterListDecorator.h
//  GOTFavChars
//
//  Created by Bitcats on 10/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import "ListCharacterCell.h"

#import "ShortCharacterItem.h"

@interface ListCharacterCell (CharacterListDecorator)

- (void)decorateWith:(ShortCharacterItem *)item;

@end
