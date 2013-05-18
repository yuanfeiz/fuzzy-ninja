//
//  AppDelegate.h
//  FuzzyNinja
//
//  Created by stranbird on 13-5-18.
//  Copyright (c) 2013年 stranbird. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ControlViewController;
@class SplashViewController;
@class SRWebSocket;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) SRWebSocket *ws;


@end
