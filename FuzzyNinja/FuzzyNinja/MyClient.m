//
//  MyClient.m
//  FuzzyNinja
//
//  Created by stranbird on 13-5-18.
//  Copyright (c) 2013年 stranbird. All rights reserved.
//

#import "MyClient.h"
#import <AFNetworking.h>

@implementation MyClient

+ (MyClient *)sharedClient
{
    static MyClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[MyClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://169.254.208.16:3001/"]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setParameterEncoding:AFJSONParameterEncoding];
//    [self setParameterEncoding = AFJSONParameterEncoding;
     [self setDefaultHeader:@"Accept" value:@"application/json"];
//     [httpClient registerHTTPOperationClass:[AFJSONRequestOperation class]];
    return self;
}

@end
