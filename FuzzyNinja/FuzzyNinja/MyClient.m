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
        _sharedClient = [[MyClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://169.254.130.53:3001/"]];
    });
    
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        return nil;
    }
    return self;
}

@end
