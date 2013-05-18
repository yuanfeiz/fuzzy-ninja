//
//  MyClient.h
//  FuzzyNinja
//
//  Created by stranbird on 13-5-18.
//  Copyright (c) 2013年 stranbird. All rights reserved.
//

#import "AFHTTPClient.h"

@interface MyClient : AFHTTPClient

+ (MyClient *)sharedClient;

@end
