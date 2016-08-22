//
//  DetailWireframe.h
//  GOTFavChars
//
//  Created by Bitcats on 11/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShortCharacterItem.h"
#import "DetailPresenter.h"

@interface DetailWireframe : NSObject

@property (nonatomic) DetailPresenter *detailPresenter;

- (void)presentDetailInterfaceFromViewController:(UIViewController *)viewController
                                        withItem:(ShortCharacterItem *)item;
- (void)presentExternalURL:(NSURL *)url;

@end
