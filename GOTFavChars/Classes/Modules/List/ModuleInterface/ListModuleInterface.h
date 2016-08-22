//
//  ListModuleInterface.h
//  GOTFavChars
//
//  Created by Bitcats on 11/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import "ShortCharacterItem.h"

@protocol ListModuleInterface <NSObject>

- (void)updateViewFavourited:(BOOL)favourited;
- (void)toggleFavourited:(ShortCharacterItem *)item;
- (void)selectedCharacter:(ShortCharacterItem *)item;

@end