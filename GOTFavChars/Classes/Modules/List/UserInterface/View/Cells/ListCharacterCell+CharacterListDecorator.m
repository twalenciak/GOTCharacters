//
//  ListCharacterCell+CharacterListDecorator.m
//  GOTFavChars
//
//  Created by Bitcats on 10/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import "ListCharacterCell+CharacterListDecorator.h"
#import "SDWebimage-umbrella.h"

@implementation ListCharacterCell (CharacterListDecorator)

- (void)decorateWith:(ShortCharacterItem *)item {
    self.titleLabel.text = item.title;
    self.overviewLabel.text = item.overview;
    self.isFavourited = item.isFavourited;
    
    if (item.isExpanded) {
        self.overviewLabel.numberOfLines = 0;
    } else {
        self.overviewLabel.numberOfLines = 2;
    }
    
    [self.imageView sd_setImageWithURL:item.thumbURL];
    [self setNeedsLayout];
}

@end
