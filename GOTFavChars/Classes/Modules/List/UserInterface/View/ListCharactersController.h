//
//  ListCharactersController.h
//  GOTFavChars
//
//  Created by Bitcats on 09/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ListCharactersInterface.h"
#import "ListModuleInterface.h"

@interface ListCharactersController : UICollectionViewController <ListCharactersInterface>

@property (nonatomic) id<ListModuleInterface> eventHandler;

@end
