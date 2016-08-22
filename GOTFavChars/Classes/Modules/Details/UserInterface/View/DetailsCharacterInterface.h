//
//  DetailsCharacterInterface.h
//  GOTFavChars
//
//  Created by Bitcats on 11/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShortCharacterItem.h"

@protocol DetailsCharacterInterface <NSObject>

- (void)showCharacter:(ShortCharacterItem *)item;

@end