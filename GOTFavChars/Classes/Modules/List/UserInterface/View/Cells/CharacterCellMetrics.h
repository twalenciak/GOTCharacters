//
//  CharacterCellMetrics.h
//  GOTFavChars
//
//  Created by Bitcats on 19/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CharacterCellMetrics : NSObject

@property (nonatomic) CGFloat imageBoxSize;
@property (nonatomic) CGFloat favIconBoxSize;
@property (nonatomic) CGFloat singleMargin;
@property (nonatomic) CGFloat titleHeight;

@property (nonatomic) UIFont *abstractFont;

- (CGFloat)cellCollapsedHeight;
- (CGFloat)cellExpandedCellForText:(NSString *)text boundingWidth:(CGFloat)boundingWidth;

+ (instancetype)cellMetricsForiPhone5orLess;
+ (instancetype)cellMetricsForiPhone6;
+ (instancetype)cellMetricsForiPhone6p;

@end
