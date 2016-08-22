//
//  ListMessageCell.m
//  GOTFavChars
//
//  Created by Bitcats on 09/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import "ListMessageCell.h"


@interface ListMessageCell ()

@property (nonatomic, assign) BOOL didSetupConstraints;
@property (nonatomic, weak) NSLayoutConstraint *imgWidthConstraint;
@property (nonatomic, weak) NSLayoutConstraint *imgHeightConstraint;


@end

@implementation ListMessageCell

#pragma mark - Setters

- (void)setImageBoxSize:(CGFloat)imageBoxSize {
    
    _imageBoxSize = imageBoxSize;
    self.imgHeightConstraint.constant = imageBoxSize;
    self.imgWidthConstraint.constant = imageBoxSize;
    
    [self.contentView setNeedsLayout];
}


#pragma mark - Lifecycle Layout

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
        
        UIView *contentView = self.contentView;
        
        // Image View
        
        CGFloat halfLabelHeight = 10.f;
        
        NSLayoutConstraint *imgCenterX = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                            attribute:NSLayoutAttributeCenterX
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:contentView
                                                                            attribute:NSLayoutAttributeCenterX
                                                                           multiplier:1
                                                                             constant:0];
        
        NSLayoutConstraint *imgCenterY = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                           attribute:NSLayoutAttributeCenterY
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:contentView
                                                                           attribute:NSLayoutAttributeCenterY
                                                                          multiplier:1
                                                                            constant:-halfLabelHeight];
        
        NSLayoutConstraint *imgHeightConstr = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                           attribute:NSLayoutAttributeHeight
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:nil
                                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                                          multiplier:1
                                                                            constant:100];

        NSLayoutConstraint *imgWidthConstr = [NSLayoutConstraint constraintWithItem:self.imageView
                                                                           attribute:NSLayoutAttributeWidth
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:nil
                                                                           attribute:NSLayoutAttributeNotAnAttribute
                                                                          multiplier:1
                                                                            constant:100];
        self.imgWidthConstraint = imgWidthConstr;
        self.imgHeightConstraint = imgHeightConstr;
        
        // Info label:
        
        NSLayoutConstraint *labCenterConstr = [NSLayoutConstraint constraintWithItem:self.infoLabel
                                                                            attribute:NSLayoutAttributeCenterX
                                                                            relatedBy:NSLayoutRelationEqual
                                                                               toItem:contentView
                                                                            attribute:NSLayoutAttributeCenterX
                                                                           multiplier:1
                                                                             constant:0];
        NSLayoutConstraint *labImageConstr = [NSLayoutConstraint constraintWithItem:self.infoLabel
                                                                          attribute:NSLayoutAttributeTop
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:self.imageView
                                                                           attribute:NSLayoutAttributeBottom
                                                                          multiplier:1
                                                                            constant:8];

        [NSLayoutConstraint activateConstraints:@[labCenterConstr,
                                                  labImageConstr,
                                                  imgCenterX,
                                                  imgCenterY,
                                                  imgWidthConstr, imgHeightConstr,
                                                  ]];
        
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}

- (void)setupViews
{
    UIImageView *imageView = [self instantiateImageView];
    UILabel *infoLabel = [self instantiateInfoLabel];
    
    [self.contentView addSubview:imageView];
    [self.contentView addSubview:infoLabel];
    
    self.imageView = imageView;
    self.infoLabel = infoLabel;
    
    [self setNeedsUpdateConstraints];
}

#pragma mark - Views Factory

- (UIImageView *)instantiateImageView
{
    UIImageView *result = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Problem"]];
    result.contentMode = UIViewContentModeScaleAspectFit;
    result.translatesAutoresizingMaskIntoConstraints = NO;
    return result;
}

- (UILabel *)instantiateInfoLabel
{
    UILabel *result = [[UILabel alloc]init];
    result.translatesAutoresizingMaskIntoConstraints = NO;
    return result;
}

@end
