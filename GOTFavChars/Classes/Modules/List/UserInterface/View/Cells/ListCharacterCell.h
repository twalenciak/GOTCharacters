//
//  ListCharacterCell.h
//  GOTFavChars
//
//  Created by Bitcats on 09/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CharacterCellMetrics.h"

@class ListCharacterCell;

@protocol ListCharacterCellDelegate <NSObject>

- (void)listCharacterCellDidTappedFavouritedButton:(ListCharacterCell *)cell;

@end

@interface ListCharacterCell : UICollectionViewCell

@property (nonatomic) CharacterCellMetrics *metrics;

@property (nonatomic) BOOL isFavourited;

@property (nonatomic, weak) id<ListCharacterCellDelegate> delegate;

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UIButton *favouritedButton;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *overviewLabel;

@end
