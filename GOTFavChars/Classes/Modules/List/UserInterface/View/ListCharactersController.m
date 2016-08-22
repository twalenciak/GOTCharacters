//
//  ListCharactersController.m
//  GOTFavChars
//
//  Created by Bitcats on 09/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import "ListCharactersController.h"
#import "ListCharacterCell.h"
#import "ListCharacterCell+CharacterListDecorator.h"
#import "ListMessageCell.h"
#import "DeviceMacro.h"

#import "NSArray+IndexPathsCompare.h"
#import "CharacterCellMetrics.h"

static NSString *messageCellId = @"messageCellId";
static NSString *itemCellId = @"itemCellId";

static NSString *messageWaitContent = @"Fetching content...";
static NSString *messageNoFavs = @"No favourited characters";
static NSString *messageNoData = @"No data retreived";

@interface ListCharactersController () <UICollectionViewDelegateFlowLayout, ListCharacterCellDelegate>

@property (nonatomic) BOOL isMessageCellMode;
@property (nonatomic) NSString *messageCellInfo;

@property (nonatomic) NSArray *items;

@property (nonatomic) BOOL showsFavourited;
@property (nonatomic) UIBarButtonItem *filterButtonItem;

@property (nonatomic) CharacterCellMetrics *cellMetrics;
@end

@implementation ListCharactersController

- (void)viewDidLoad
{
    [super viewDidLoad];
 
    [self.collectionView registerClass:[ListCharacterCell class] forCellWithReuseIdentifier:itemCellId];
    [self.collectionView registerClass:[ListMessageCell class] forCellWithReuseIdentifier:messageCellId];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    UILongPressGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(handleLongPress:)];
    self.collectionView.delaysContentTouches = YES;
    [self.collectionView addGestureRecognizer:longPressRecognizer];
    
    UIBarButtonItem *filterButton = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"FilterIcon"]
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:self
                                                                   action:@selector(handleFilterIconPressed)];
    filterButton.tintColor = [UIColor darkGrayColor];
    self.filterButtonItem = filterButton;
    
    self.navigationItem.rightBarButtonItem = filterButton;
    
    if (IS_IPHONE_5 || IS_IPHONE_4_OR_LESS) {
        self.cellMetrics = [CharacterCellMetrics cellMetricsForiPhone5orLess];
    } else if (IS_IPHONE_6) {
        self.cellMetrics = [CharacterCellMetrics cellMetricsForiPhone6];
    } else {
        self.cellMetrics = [CharacterCellMetrics cellMetricsForiPhone6p];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!self.items || [self.items count] == 0) {
        [self showWaitForContent];
    }
    [self.eventHandler updateViewFavourited:self.showsFavourited];
}

- (void)viewWillTransitionToSize:(CGSize)size withTransitionCoordinator:(id<UIViewControllerTransitionCoordinator>)coordinator {
    [self.collectionView.collectionViewLayout invalidateLayout];
    [super viewWillTransitionToSize:size withTransitionCoordinator:coordinator];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.isMessageCellMode) {
        return 1;
    }
    return [self.items count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isMessageCellMode) {
        ListMessageCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:messageCellId forIndexPath:indexPath];
        
        cell.infoLabel.text = self.messageCellInfo;
        [cell.infoLabel sizeToFit];
        return cell;
    } else {
        ShortCharacterItem *item = [self.items objectAtIndex:indexPath.row];
        
        ListCharacterCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:itemCellId forIndexPath:indexPath];
        
        cell.metrics = self.cellMetrics;
        [cell decorateWith:item];
        
        cell.delegate = self;
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isMessageCellMode) {
        return CGSizeMake(collectionView.bounds.size.width, collectionView.bounds.size.height - self.topLayoutGuide.length);
    } else {
        ShortCharacterItem *item = [self.items objectAtIndex:indexPath.row];
        if (item.isExpanded) {
            CGFloat height = [self.cellMetrics cellExpandedCellForText:item.overview boundingWidth:collectionView.bounds.size.width];
            return CGSizeMake(collectionView.bounds.size.width, height);
        } else {
            return CGSizeMake(collectionView.bounds.size.width, [self.cellMetrics cellCollapsedHeight]);
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.isMessageCellMode) {
        ShortCharacterItem *item = [self.items objectAtIndex:indexPath.row];
        [self.eventHandler selectedCharacter:item];
    }
}

#pragma mark - Actions

- (void)listCharacterCellDidTappedFavouritedButton:(ListCharacterCell *)cell
{
    NSIndexPath *ip =[self.collectionView indexPathForCell:cell];
    ShortCharacterItem *item = [self.items objectAtIndex:ip.row];
    [self.eventHandler toggleFavourited:item];
}

- (void)handleLongPress:(UILongPressGestureRecognizer *)recognizer
{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        CGPoint point = [recognizer locationInView:self.collectionView];
        NSIndexPath *ip = [self.collectionView indexPathForItemAtPoint:point];
        if (ip) {
            UICollectionViewCell *cell = [self.collectionView cellForItemAtIndexPath:ip];
            if ([cell isKindOfClass:[ListCharacterCell class]]) {
                ShortCharacterItem *item = [self.items objectAtIndex:ip.row];
                item.isExpanded = !item.isExpanded;
                
                [self.collectionView reloadItemsAtIndexPaths:@[ip]];
                
            }
        }
    }
}

- (void)handleFilterIconPressed
{
    self.showsFavourited = !self.showsFavourited;
    [self.eventHandler updateViewFavourited:self.showsFavourited];
}

#pragma mark - Utils

- (void)changeItem:(NSInteger)identifier toFavouritedState:(BOOL)newFavourited
{
    ShortCharacterItem *found = [self itemWithId:identifier];
    found.isFavourited = newFavourited;
    
    BOOL shouldRemoveItemFromCurrentItems = self.showsFavourited && !newFavourited;
    if (shouldRemoveItemFromCurrentItems) {

        NSMutableArray *deletedNotFavourited = [self.items mutableCopy];
        [deletedNotFavourited removeObject:found];
        [self showCharactersItems:deletedNotFavourited];

    } else {
        
        NSInteger index = [self.items indexOfObject:found];
        NSIndexPath *ip = [NSIndexPath indexPathForRow:index inSection:0];
        [self.collectionView reloadItemsAtIndexPaths:@[ip]];
    }
}

- (void)setShowsFavourited:(BOOL)showsFavourited
{
    _showsFavourited = showsFavourited;
    NSString *iconName = showsFavourited ? @"FilterIconHover" : @"FilterIcon";
    [self.filterButtonItem setImage:[UIImage imageNamed:iconName]];
}

- (void)showCharactersItems:(NSArray *)items
{
    if (!self.items || self.isMessageCellMode == YES) {
        
        self.isMessageCellMode = NO;
        self.items = items;
        [self.collectionView reloadData];
    } else {
        if (!items || items.count == 0) {
            if (self.showsFavourited) {
                [self showNoFavouritedOnList];
            } else {
                [self showNoContentAvailable];
            }
        } else {
            [self.items compareWithArray:items section:0 withBlock:^(NSArray *removedIndexPaths, NSArray *insertedIndexPaths, NSArray *movedFromIndexPaths, NSArray *movedToIndexPaths) {
                
                [self.collectionView performBatchUpdates:^{
                    
                    [self.collectionView deleteItemsAtIndexPaths:removedIndexPaths];
                    [self.collectionView insertItemsAtIndexPaths:insertedIndexPaths];
                    
                    for (NSUInteger i = 0; i < [movedFromIndexPaths count]; i++) {
                        NSIndexPath *fromPath = movedFromIndexPaths[i];
                        NSIndexPath *toPath = movedToIndexPaths[i];
                        
                        [self.collectionView moveItemAtIndexPath:fromPath toIndexPath:toPath];
                    }
                    
                    self.items = items;
                } completion:^(BOOL finished) {
                    if (finished) {
                    }
                }];
            }];
        }
    }
}

- (void)showNoContentAvailable
{
    [self messageModeWithInfo:messageNoData];
}

- (void)showNoFavouritedOnList
{
    [self messageModeWithInfo:messageNoFavs];
}

- (void)showWaitForContent
{
    [self messageModeWithInfo:messageWaitContent];
}

- (void)messageModeWithInfo:(NSString *)message
{
    self.isMessageCellMode = YES;
    self.messageCellInfo = message;
    [self.collectionView reloadData];
}

#pragma mark - Utils

- (ShortCharacterItem *)itemWithId:(NSInteger)index
{
    ShortCharacterItem *found;
    for (ShortCharacterItem *item in self.items) {
        if (item.identifier == index) {
            found = item;
            break;
        }
    }
    return found;
}

@end
