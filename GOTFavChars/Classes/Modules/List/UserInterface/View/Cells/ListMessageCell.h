//
//  ListMessageCell.h
//  GOTFavChars
//
//  Created by Bitcats on 09/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListMessageCell : UICollectionViewCell

@property (nonatomic) CGFloat imageBoxSize;

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *infoLabel;

@end
