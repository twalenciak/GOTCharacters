//
//  ListWireframe.m
//  GOTFavChars
//
//  Created by Bitcats on 11/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import "ListWireframe.h"
#import "ListCharactersController.h"

@interface ListWireframe ()

@property (nonatomic) ListCharactersController *charactersController;

@end

@implementation ListWireframe

- (void)presentListInterfaceForWindow:(UIWindow *)window
{
    ListCharactersController *controller = [self instantiateCharactersController];
    controller.eventHandler = self.listPresenter;
    self.listPresenter.userInterface = controller;
    self.charactersController = controller;
    
    [self.rootWireframe presentRootViewController:controller inWindow:window];
}

- (void)presentDetailsFor:(ShortCharacterItem *)item
{
    [self.detailWireframe presentDetailInterfaceFromViewController:self.charactersController withItem:item];
}

- (ListCharactersController *)instantiateCharactersController
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.minimumInteritemSpacing = 0.f;
    flowLayout.minimumLineSpacing = 0.f;
    
    ListCharactersController *controller = [[ListCharactersController alloc]initWithCollectionViewLayout:flowLayout];
    return controller;
}

@end
