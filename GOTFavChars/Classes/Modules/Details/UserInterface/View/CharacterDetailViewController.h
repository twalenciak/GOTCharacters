//
//  CharacterDetailViewController.h
//  GOTFavChars
//
//  Created by Bitcats on 11/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DetailsCharacterInterface.h"
#import "DetailModuleInterface.h"

@interface CharacterDetailViewController : UIViewController <DetailsCharacterInterface>

@property (nonatomic) id<DetailModuleInterface> eventHandler;
@property (nonatomic) ShortCharacterItem *presentedItem;

@end
