//
//  ListInteractorIO.h
//  GOTFavChars
//
//  Created by Bitcats on 11/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ListInteractorInput <NSObject>

- (void)findCharacterItemsFavourited:(BOOL)filterFavouritedOnly;
- (void)toggleFavouritedCharacterWithId:(NSInteger)index;

@end

@protocol ListInteractorOutput <NSObject>

- (void)foundCharacterItems:(NSArray *)items;
- (void)didChangeCharacter:(NSInteger)index toFavourited:(BOOL)newFavouritedState;

@end