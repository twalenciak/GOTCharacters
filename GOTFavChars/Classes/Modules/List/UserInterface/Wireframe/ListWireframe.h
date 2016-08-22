//
//  ListWireframe.h
//  GOTFavChars
//
//  Created by Bitcats on 11/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RootWireframe.h"
#import "ListPresenter.h"
#import "DetailWireframe.h"

@interface ListWireframe : NSObject

@property (nonatomic) ListPresenter *listPresenter;
@property (nonatomic) RootWireframe *rootWireframe;
@property (nonatomic) DetailWireframe *detailWireframe;

- (void)presentListInterfaceForWindow:(UIWindow *)window;
- (void)presentDetailsFor:(ShortCharacterItem *)item;

@end
