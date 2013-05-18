//
//  ViewController.h
//  FuzzyNinja
//
//  Created by stranbird on 13-5-18.
//  Copyright (c) 2013年 stranbird. All rights reserved.
//

#import <UIKit/UIKit.h>
#include <ZBarSDK.h>

@interface ViewController : UIViewController<ZBarReaderViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *playButton;
- (IBAction)startReadQRCode:(id)sender;

@end
