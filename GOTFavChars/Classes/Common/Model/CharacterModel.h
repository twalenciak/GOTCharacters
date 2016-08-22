//
//  CharacterModel.h
//  GOTFavChars
//
//  Created by Bitcats on 10/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import "Mantle.h"

@interface CharacterModel : MTLModel<MTLJSONSerializing>

@property (nonatomic) NSInteger identifier;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *abstract;
@property (nonatomic) NSString *thumbURL;
@property (nonatomic) NSString *externalPathURL;

@end
