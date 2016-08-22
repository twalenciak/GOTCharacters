//
//  CharacterDetailsView.h
//  GOTFavChars
//
//  Created by Bitcats on 12/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShortCharacterItem.h"

@protocol CharacterDetailsViewDelegate <NSObject>

- (void)didSelectedExternalLink;

@end

@interface CharacterDetailsView : UIView

@property (nonatomic, weak) id<CharacterDetailsViewDelegate> delegate;

- (void)decorateWithItem:(ShortCharacterItem *)item;

@end
