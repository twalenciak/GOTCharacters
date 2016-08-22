//
//  ListInteractor.h
//  GOTFavChars
//
//  Created by Bitcats on 11/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ListInteractorIO.h"
#import "CharactersDataManager.h"

@interface ListInteractor : NSObject <ListInteractorInput>

@property (nonatomic, weak) id<ListInteractorOutput> output;

- (instancetype)initWithDataManager:(CharactersDataManager *)dataManager;

@end
