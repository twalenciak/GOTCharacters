//
//  ShortCharacterItem.h
//  GOTFavChars
//
//  Created by Bitcats on 09/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ShortCharacterItem : NSObject

@property (nonatomic) BOOL isFavourited;
@property (nonatomic) BOOL isExpanded;

@property (nonatomic) NSInteger identifier;

@property (nonatomic) NSString *title;
@property (nonatomic) NSString *overview;

@property (nonatomic) NSURL *thumbURL;
@property (nonatomic) NSURL *externalLinkURL;

@end
