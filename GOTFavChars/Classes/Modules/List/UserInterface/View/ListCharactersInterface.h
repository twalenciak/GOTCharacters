//
//  ListCharactersInterface.h
//  GOTFavChars
//
//  Created by Bitcats on 09/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CharacterItem;

@protocol ListCharactersInterface <NSObject>

- (void)showCharactersItems:(NSArray*)items;

- (void)changeItem:(NSInteger)index toFavouritedState:(BOOL)newFavourited;

@end