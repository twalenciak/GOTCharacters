//
//  DetailPresenter.h
//  GOTFavChars
//
//  Created by Bitcats on 11/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DetailModuleInterface.h"
@class DetailWireframe;

@interface DetailPresenter : NSObject <DetailModuleInterface>

@property (nonatomic) DetailWireframe *detailWierframe;

@end
