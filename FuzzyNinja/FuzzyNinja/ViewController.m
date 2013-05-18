//
//  ViewController.m
//  FuzzyNinja
//
//  Created by stranbird on 13-5-18.
//  Copyright (c) 2013年 stranbird. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import <ZBarSDK.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, 100.0f)];
    imageView.backgroundColor = [UIColor redColor];
    [imageView setImageWithURL:[NSURL URLWithString:@"http://i.imgur.com/r4uwx.jpg"]];
    [self.view addSubview:imageView];
    
    
    
    NSLog(@"OK");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image {
    NSLog(@"here");
}

- (IBAction)startReadQRCode:(id)sender {
    ZBarReaderController *reader = [ZBarReaderController new];
    reader.readerDelegate = self;
    
    [reader.scanner setSymbology: ZBAR_QRCODE
                          config: ZBAR_CFG_ENABLE
                              to: 0];
    
    [self presentViewController:reader animated:YES completion:nil];
    
    NSLog(@"3");
}
@end
