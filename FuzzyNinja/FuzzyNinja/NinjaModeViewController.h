//
//  NinjaModeViewController.h
//  FuzzyNinja
//
//  Created by stranbird on 13-5-19.
//  Copyright (c) 2013年 stranbird. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ContentController;

@interface NinjaModeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *MediaLabel;
@property (weak, nonatomic) IBOutlet UISlider *mySlider;
@property (weak, nonatomic) IBOutlet UIButton *switchButton;
@property (nonatomic, strong) IBOutlet ContentController *contentController;
@end
