//
//  WikiDataSource.m
//  GOTFavChars
//
//  Created by Bitcats on 10/08/16.
//  Copyright © 2016 TWalenciak. All rights reserved.
//

#import "WikiDataSource.h"

#import "STHTTPRequest.h"

static NSString *apiBasepath = @"https://gameofthrones.wikia.com/api/v1/Articles/Top?expand=1&category=Characters&limit=75&abstract=500";

@interface WikiDataSource ()

@end

@implementation WikiDataSource

- (void)fetchCharactersWithCompletion:(JSONResponseBlock)completion
{
    STHTTPRequest *request = [STHTTPRequest requestWithURLString:apiBasepath];

    request.completionBlock = ^(NSDictionary *headers, NSString *body) {
        NSData *data = [body dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&err];
        if (!err) {
            completion(nil, json);
        } else {
            completion(err, nil);
        }
    };
    
    request.errorBlock = ^(NSError *error) {
        completion(error, nil);
    };
    [request startAsynchronous];
}

@end
