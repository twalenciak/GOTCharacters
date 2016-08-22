//
//  ListPresenter.h
//  GOTFavChars
//
//  Created by Bitcats on 11/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ListModuleInterface.h"
#import "ListInteractorIO.h"
#import "ListCharactersInterface.h"

@class ListWireframe;

@interface ListPresenter : NSObject<ListModuleInterface, ListInteractorOutput>

@property (nonatomic, strong) id<ListInteractorInput> listInteractor;
@property (nonatomic, strong) ListWireframe *listWireframe;

@property (nonatomic, strong) UIViewController<ListCharactersInterface> *userInterface;

@end
