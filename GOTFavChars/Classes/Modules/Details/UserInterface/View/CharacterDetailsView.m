//
//  CharacterDetailsView.m
//  GOTFavChars
//
//  Created by Bitcats on 12/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import "CharacterDetailsView.h"
#import "SDWebimage-umbrella.h"

@interface CharacterDetailsView ()

@property (nonatomic, weak) UIImageView *imagePhoto;
@property (nonatomic, weak) UIImageView *imageFavourited;
@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UILabel *abstractLabel;
@property (nonatomic, weak) UIButton *externalLinkButton;
//
@property (nonatomic, weak) UIScrollView *abstractScrollView;

@property (nonatomic) BOOL areConstraintsUpdated;

@end

@implementation CharacterDetailsView

- (void)decorateWithItem:(ShortCharacterItem *)item
{
    self.titleLabel.text = item.title;
    self.abstractLabel.text = item.overview;
    [self.abstractLabel sizeToFit];
    self.imageFavourited.image = [self imageForFavourited:item.isFavourited];
    [self.imagePhoto sd_setImageWithURL:item.thumbURL];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.imagePhoto];
        [self addSubview:self.titleLabel];
        [self addSubview:self.imageFavourited];
        [self addSubview:self.externalLinkButton];
        
        [self addSubview:self.abstractScrollView];
        [self.abstractScrollView addSubview:self.abstractLabel];
        self.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.abstractScrollView.contentSize = self.abstractLabel.frame.size;
}

- (void)updateConstraints
{
    if (!self.areConstraintsUpdated) {
        NSDictionary *views = @{
                                @"photo" : self.imagePhoto,
                                @"title" : self.titleLabel,
                                @"fav" : self.imageFavourited,
                                @"external" : self.externalLinkButton,
                                @"scroll" : self.abstractScrollView,
                                @"abstract" : self.abstractLabel,
                                };
        
        NSArray *topConstr = [NSLayoutConstraint constraintsWithVisualFormat:@"|-[photo(100)]-[title]-[fav(50)]-|"
                                                                     options:NSLayoutFormatAlignAllTop
                                                                     metrics:nil
                                                                       views:views];
        NSArray *horExt = [NSLayoutConstraint constraintsWithVisualFormat:@"[photo]-[external(100)]"
                                                                     options:0
                                                                     metrics:nil
                                                                     views:views];
        NSArray *vertExt = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[external(40)]-[scroll]"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:views];
        NSArray *vertScroll = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[photo(100)]-[scroll]|"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:views];
        NSArray *horScroll = [NSLayoutConstraint constraintsWithVisualFormat:@"|-[scroll]-|"
                                                                     options:0
                                                                     metrics:nil
                                                                       views:views];
        NSArray *abstractScroll = [NSLayoutConstraint constraintsWithVisualFormat:@"|[abstract(==scroll)]|"
                                                                      options:0
                                                                      metrics:nil
                                                                        views:views];
        NSArray *abstractTop = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[abstract]"
                                                                          options:0
                                                                          metrics:nil
                                                                            views:views];
        
        
        NSArray *allConstraints = topConstr;
        allConstraints = [allConstraints arrayByAddingObjectsFromArray:vertExt];
        allConstraints = [allConstraints arrayByAddingObjectsFromArray:horExt];
        allConstraints = [allConstraints arrayByAddingObjectsFromArray:horScroll];
        allConstraints = [allConstraints arrayByAddingObjectsFromArray:vertScroll];
        allConstraints = [allConstraints arrayByAddingObjectsFromArray:abstractScroll];
        allConstraints = [allConstraints arrayByAddingObjectsFromArray:abstractTop];
        
        [NSLayoutConstraint activateConstraints:allConstraints];
        
        self.areConstraintsUpdated = YES;
    }
    [super updateConstraints];
}

#pragma mark - Utils

- (UIImage *)imageForFavourited:(BOOL)isFav
{
    NSString *name = isFav ? @"FavIconFull" : @"FavIcon";
    return [UIImage imageNamed:name];
}

#pragma mark - Actions

- (void)handleButtonTap:(UIButton *)sender
{
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectedExternalLink)]) {
        [self.delegate didSelectedExternalLink];
    }
}

#pragma mark - Getters

- (UIScrollView *)abstractScrollView {
    if (!_abstractScrollView) {
        UIScrollView *scrollView = [[UIScrollView alloc]init];
        scrollView.translatesAutoresizingMaskIntoConstraints = NO;
        
        _abstractScrollView = scrollView;
        return _abstractScrollView;
    }
    return _abstractScrollView;
}

- (UIImageView *)imagePhoto
{
    if (!_imagePhoto) {
        UIImageView *resultView = [[UIImageView alloc]init];
        resultView.translatesAutoresizingMaskIntoConstraints = NO;
        _imagePhoto = resultView;
        return _imagePhoto;
    }
    return _imagePhoto;
}

- (UIImageView *)imageFavourited
{
    if (!_imageFavourited) {
        UIImageView *resultView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"FavIcon"]];
        resultView.translatesAutoresizingMaskIntoConstraints = NO;
        resultView.contentMode = UIViewContentModeScaleAspectFit;
        
        _imageFavourited = resultView;
        return _imageFavourited;
    }
    return _imageFavourited;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:16.f];
        label.numberOfLines = 0;
        _titleLabel = label;
        return _titleLabel;
    }
    return _titleLabel;
}

- (UILabel *)abstractLabel
{
    if (!_abstractLabel) {
        UILabel *label = [[UILabel alloc]init];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.numberOfLines = 0;
        label.textColor = [UIColor darkGrayColor];
        _abstractLabel = label;
        return _abstractLabel;
    }
    return _abstractLabel;
}

- (UIButton *)externalLinkButton
{
    if (!_externalLinkButton) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, 100, 40);
        [button setTitle:@"More..." forState:UIControlStateNormal];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        button.backgroundColor = self.tintColor;
        [button addTarget:self action:@selector(handleButtonTap:) forControlEvents:UIControlEventTouchUpInside];
        
        _externalLinkButton = button;
        return _externalLinkButton;
    }
    return _externalLinkButton;
}
@end
