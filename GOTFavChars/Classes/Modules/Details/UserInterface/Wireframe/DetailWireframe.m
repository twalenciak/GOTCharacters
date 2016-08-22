//
//  DetailWireframe.m
//  GOTFavChars
//
//  Created by Bitcats on 11/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import "DetailWireframe.h"
#import "CharacterDetailViewController.h"

@interface DetailWireframe ()

@property (nonatomic) CharacterDetailViewController *detailController;

@end

@implementation DetailWireframe

- (void)presentDetailInterfaceFromViewController:(UIViewController *)viewController
                                        withItem:(ShortCharacterItem *)item
{
    CharacterDetailViewController *detailController = [self instantiateDetailController];
    detailController.eventHandler = self.detailPresenter;
    detailController.presentedItem = item;
    
    [viewController.navigationController pushViewController:detailController animated:YES];
}

- (void)presentExternalURL:(NSURL *)url
{
    [[UIApplication sharedApplication] openURL:url];
}

- (CharacterDetailViewController *)instantiateDetailController
{
    CharacterDetailViewController *resultController = [CharacterDetailViewController new];
    
    return resultController;
}

@end
