//
//  ListPresenter.m
//  GOTFavChars
//
//  Created by Bitcats on 11/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import "ListPresenter.h"
#import "ListWireframe.h"

@implementation ListPresenter

- (void)updateViewFavourited:(BOOL)favourited
{
    [self.listInteractor findCharacterItemsFavourited:favourited];
}

- (void)toggleFavourited:(ShortCharacterItem *)item
{
    [self.listInteractor toggleFavouritedCharacterWithId:item.identifier];
}

- (void)selectedCharacter:(ShortCharacterItem *)item
{
    [self.listWireframe presentDetailsFor:item];
}

- (void)foundCharacterItems:(NSArray *)items
{
    [self.userInterface showCharactersItems:items];
}

- (void)didChangeCharacter:(NSInteger)index toFavourited:(BOOL)newFavouritedState
{
    [self.userInterface changeItem:index toFavouritedState:newFavouritedState];
}

@end
