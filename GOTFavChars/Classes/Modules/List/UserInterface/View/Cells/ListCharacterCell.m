//
//  ListCharacterCell.m
//  GOTFavChars
//
//  Created by Bitcats on 09/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import "ListCharacterCell.h"

@interface ListCharacterCell ()

@property (nonatomic) BOOL didSetupConstraints;


@end

@implementation ListCharacterCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupViews];
    }
    return self;
}

- (void)updateConstraints
{
    if (!self.didSetupConstraints) {
        
        // Image View
        self.overviewLabel.preferredMaxLayoutWidth = self.contentView.bounds.size.width;
        self.overviewLabel.font = self.metrics.abstractFont;
        
        NSDictionary *viewsDict = @{
                                    @"contentView" : self.contentView,
                                    @"imageView" : self.imageView,
                                    @"title" : self.titleLabel,
                                    @"abstract" : self.overviewLabel,
                                    @"favImage" : self.favouritedButton,
                                    };
        NSDictionary *metrics = @{
                                    @"sm" : @(self.metrics.singleMargin),
                                    @"img" : @(self.metrics.imageBoxSize),
                                    @"fav" : @(self.metrics.favIconBoxSize),
                                    @"tHeight" : @(self.metrics.titleHeight)
                                    };
        NSArray *horizontalFirstLine = [NSLayoutConstraint constraintsWithVisualFormat:@"|-sm-[imageView(img)]-sm-[title]-sm@751-[favImage(fav)]-sm-|"
                                                                         options:NSLayoutFormatAlignAllTop
                                                                         metrics:metrics
                                                                           views:viewsDict];
        NSArray *horizontalSecond = [NSLayoutConstraint constraintsWithVisualFormat:@"[imageView]-sm-[abstract]-sm@751-[favImage(fav)]"
                                                                            options:0
                                                                            metrics:metrics
                                                                              views:viewsDict];
        NSArray *vertIcon = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-sm-[imageView(img)]-sm@751-|"
                                                                            options:0
                                                                            metrics:metrics
                                                                              views:viewsDict];
        
        NSArray *vertText = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-sm-[title(tHeight)]-sm-[abstract(>=20)]-sm-|"
                                                                    options:0
                                                                    metrics:metrics
                                                                      views:viewsDict];
        NSArray *vertFav = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-sm-[favImage(fav)]-sm@251-|"
                                                                    options:0
                                                                    metrics:metrics
                                                                      views:viewsDict];
        
        NSArray *allConstr = [horizontalSecond arrayByAddingObjectsFromArray:horizontalFirstLine];
        allConstr = [allConstr arrayByAddingObjectsFromArray:vertIcon];
        allConstr = [allConstr arrayByAddingObjectsFromArray:vertText];
        allConstr = [allConstr arrayByAddingObjectsFromArray:vertFav];
        
        [NSLayoutConstraint activateConstraints:allConstr];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (void)setupViews
{
    UIImageView *imageView = [self instantiateImageView];
    UILabel *titleLabel = [self instantiateTitleLabel];
    UILabel *overViewLabel = [self instantiateOverviewLabel];
    UIButton *favButton = [self instantiateFavouritedButton];
    
    [self.contentView addSubview:imageView];
    [self.contentView addSubview:titleLabel];
    [self.contentView addSubview:overViewLabel];
    [self.contentView addSubview:favButton];
    
    self.imageView = imageView;
    self.titleLabel = titleLabel;
    self.overviewLabel= overViewLabel;
    self.favouritedButton = favButton;
    
    [self setNeedsUpdateConstraints];
}

- (void)tapFavouritedButton
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(listCharacterCellDidTappedFavouritedButton:)]) {
        [self.delegate listCharacterCellDidTappedFavouritedButton:self];
    }
}

- (void)setIsFavourited:(BOOL)isFavourited
{
    _isFavourited = isFavourited;
    
    [self.favouritedButton setImage:[self imageForFavourited:isFavourited] forState:UIControlStateNormal];
}

#pragma mark - Utils

- (UIImage *)imageForFavourited:(BOOL)isFav
{
    NSString *name = isFav ? @"FavIconFull" : @"FavIcon";
    return [UIImage imageNamed:name];
}

// factory getters

- (UIImageView *)instantiateImageView
{
    UIImageView *result = [[UIImageView alloc]init];
    result.translatesAutoresizingMaskIntoConstraints = NO;

    result.contentMode = UIViewContentModeScaleAspectFit;
    result.layer.cornerRadius = 2.f;
    
    return result;
}

- (UIButton *)instantiateFavouritedButton
{
    UIButton *result = [[UIButton alloc]init];
    result.translatesAutoresizingMaskIntoConstraints = NO;
    [result setImage:[UIImage imageNamed:@"FavIcon"] forState:UIControlStateNormal];
    
    [result addTarget:self action:@selector(tapFavouritedButton) forControlEvents:UIControlEventTouchUpInside];
    
    return result;
}

- (UILabel *)instantiateTitleLabel
{
    UILabel *result = [[UILabel alloc]init];
    result.translatesAutoresizingMaskIntoConstraints = NO;
    return result;
}


- (UILabel *)instantiateOverviewLabel
{
    UILabel *result = [[UILabel alloc]init];
    result.translatesAutoresizingMaskIntoConstraints = NO;
    result.numberOfLines = 2.f;
    result.textColor = [UIColor darkGrayColor];
    return result;
}

@end
