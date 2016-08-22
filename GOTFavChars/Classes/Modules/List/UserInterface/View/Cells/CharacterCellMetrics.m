//
//  CharacterCellMetrics.m
//  GOTFavChars
//
//  Created by Bitcats on 19/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import "CharacterCellMetrics.h"

@implementation CharacterCellMetrics

- (CGFloat)cellCollapsedHeight
{
    return self.imageBoxSize + self.singleMargin;
}

- (CGFloat)cellExpandedCellForText:(NSString *)text boundingWidth:(CGFloat)boundingWidth
{
    NSDictionary *attrs = @{
                            NSFontAttributeName : self.abstractFont,
                            };
    CGFloat realWidth = boundingWidth - self.imageBoxSize - self.favIconBoxSize - 4 * self.singleMargin;
    CGSize size = CGSizeMake(realWidth, CGFLOAT_MAX);
    CGRect res = [text boundingRectWithSize:size
                                    options:NSStringDrawingUsesLineFragmentOrigin
                                 attributes:attrs
                                    context:nil];

    CGFloat heightTXT = res.size.height;
    return heightTXT + self.titleHeight + 3 * self.singleMargin;
}

+ (instancetype)cellMetricsForiPhone5orLess
{
    CharacterCellMetrics *result = [CharacterCellMetrics new];
    
    result.imageBoxSize = 72.f;
    result.favIconBoxSize = 45.f;
    result.singleMargin = 8.f;
    result.titleHeight = 20.f;
    
    result.abstractFont = [UIFont fontWithName:@"HelveticaNeue" size:13.f];
    
    return result;
}

+ (instancetype)cellMetricsForiPhone6
{
    CharacterCellMetrics *result = [CharacterCellMetrics new];
    
    result.imageBoxSize = 80.f;
    result.favIconBoxSize = 50.f;
    result.singleMargin = 8.f;
    result.titleHeight = 20.f;
    
    result.abstractFont = [UIFont fontWithName:@"HelveticaNeue" size:14.f];
    
    return result;
}


+ (instancetype)cellMetricsForiPhone6p
{
    CharacterCellMetrics *result = [CharacterCellMetrics new];
    
    result.imageBoxSize = 72.f;
    result.favIconBoxSize = 45.f;
    result.singleMargin = 8.f;
    result.titleHeight = 20.f;
    
    result.abstractFont = [UIFont fontWithName:@"HelveticaNeue" size:15.f];
    
    return result;
}

@end
