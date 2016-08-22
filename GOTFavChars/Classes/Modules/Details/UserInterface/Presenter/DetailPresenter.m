//
//  DetailPresenter.m
//  GOTFavChars
//
//  Created by Bitcats on 11/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import "DetailPresenter.h"
#import "DetailWireframe.h"

@implementation DetailPresenter

- (void)showExternalWebpageForUrl:(NSURL *)url
{
    [self.detailWierframe presentExternalURL:url];
}

@end
