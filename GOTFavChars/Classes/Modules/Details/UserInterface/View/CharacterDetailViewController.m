//
//  CharacterDetailViewController.m
//  GOTFavChars
//
//  Created by Bitcats on 11/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import "CharacterDetailViewController.h"

#import "CharacterDetailsView.h"

@interface CharacterDetailViewController () <CharacterDetailsViewDelegate>

@property (nonatomic, weak) CharacterDetailsView *detailsView;

@property (nonatomic) BOOL updatedConstraints;
@end

@implementation CharacterDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    CharacterDetailsView *detailView = [[CharacterDetailsView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    detailView.translatesAutoresizingMaskIntoConstraints = NO;
    detailView.delegate = self;
    
    self.detailsView = detailView;
    [self.view addSubview:detailView];

    [self.view setNeedsUpdateConstraints];
    
}

- (void)showCharacter:(ShortCharacterItem *)item
{
    
    self.presentedItem = item;
    if (self.viewIfLoaded) {
        [self.detailsView decorateWithItem:self.presentedItem];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.detailsView decorateWithItem:self.presentedItem];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.detailsView setNeedsLayout];
}

- (void)updateViewConstraints
{
    if (!self.updatedConstraints) {
        NSDictionary *views = @{
                                @"topLayout" : self.topLayoutGuide,
                                @"content" : self.detailsView,
                                };
        NSArray *vert = [NSLayoutConstraint constraintsWithVisualFormat:@"|[content]|"
                                                                options:NSLayoutFormatAlignAllTop
                                                                metrics:nil
                                                                  views:views];
        NSArray *hor = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[topLayout][content]|"
                                                                options:0
                                                                metrics:nil
                                                                  views:views];
        NSArray *allConstr = [vert arrayByAddingObjectsFromArray:hor];
        [NSLayoutConstraint activateConstraints:allConstr];
        
        self.updatedConstraints = YES;
    }
    
    [super updateViewConstraints];
}

#pragma mark CharacterDetailsViewDelegate

- (void)didSelectedExternalLink
{
    if (self.eventHandler && [self.eventHandler respondsToSelector:@selector(showExternalWebpageForUrl:)]) {
        [self.eventHandler showExternalWebpageForUrl:self.presentedItem.externalLinkURL];
    }
}

@end
