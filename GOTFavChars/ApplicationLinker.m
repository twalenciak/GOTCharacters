//
//  ApplicationWrapper.m
//  GOTFavChars
//
//  Created by Bitcats on 11/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import "ApplicationLinker.h"

#import "RootWireframe.h"
#import "ListWireframe.h"

#import "ListInteractor.h"

@interface ApplicationLinker ()

@property (nonatomic) ListWireframe *listWireframe;

@end

@implementation ApplicationLinker

- (instancetype)init
{
    if (self = [super init]) {
        [self configure];
    }
    return self;
}

- (void)installDependenciesIntoWindow:(UIWindow *)window {
    [self.listWireframe presentListInterfaceForWindow:window];
}

- (void)configure {
    // common
    CharactersDataManager *charDataManager = [CharactersDataManager charactersDataManagerDefaultSources];
    RootWireframe *rootWireframe = [RootWireframe new];
    
    // list
    ListWireframe *listWireframe = [ListWireframe new];
    ListInteractor *interactor = [[ListInteractor alloc]initWithDataManager:charDataManager];
    ListPresenter *presenter = [[ListPresenter alloc]init];
    
    listWireframe.rootWireframe = rootWireframe;
    listWireframe.listPresenter = presenter;
    
    interactor.output = presenter;
    
    presenter.listInteractor = interactor;
    presenter.listWireframe = listWireframe;
    
    self.listWireframe = listWireframe;
    
    // details
    DetailWireframe *detailsWireframe = [DetailWireframe new];
    DetailPresenter *detailPresenter = [DetailPresenter new];
    detailsWireframe.detailPresenter = detailPresenter;
    detailPresenter.detailWierframe = detailsWireframe;
    
    
    listWireframe.detailWireframe = detailsWireframe;
    
    
}

@end
