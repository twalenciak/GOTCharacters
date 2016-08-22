//
//  RootWireframe.m
//  GOTFavChars
//
//  Created by Bitcats on 11/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import "RootWireframe.h"

@implementation RootWireframe

- (void)presentRootViewController:(UIViewController *)rootController inWindow:(UIWindow *)window
{
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:rootController];
    window.backgroundColor = [UIColor whiteColor];
    window.rootViewController = navController;
    [window makeKeyAndVisible];
}

@end
