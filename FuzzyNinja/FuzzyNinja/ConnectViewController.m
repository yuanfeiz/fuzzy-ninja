//
//  ConnectViewController.m
//  FuzzyNinja
//
//  Created by stranbird on 13-5-18.
//  Copyright (c) 2013年 stranbird. All rights reserved.
//

#import "ConnectViewController.h"
#import "ControlViewController.h"
#import <ZXingObjC.h>
#import <SRWebSocket.h>
#import "MyClient.h"

#import "AppDelegate.h"

@interface ConnectViewController ()<ZXCaptureDelegate, SRWebSocketDelegate>

@property (nonatomic, retain) ZXCapture* capture;

@end

@implementation ConnectViewController

@synthesize capture;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)] ) {
        UIImage *image = [UIImage imageNamed:@"naviTab"];
        [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }
    
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(10, 0, 32, 32)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    
    
    self.capture = [[ZXCapture alloc] init];
    self.capture.delegate = self;
    self.capture.rotation = -90.0f;
    self.capture.camera = self.capture.back;
    
    self.capture.layer.frame = self.view.bounds;
    [self.view.layer addSublayer:self.capture.layer];
    
    NSLog(@"1");
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString*)displayForResult:(ZXResult*)result {
    NSString *formatString;
    switch (result.barcodeFormat) {
        case kBarcodeFormatAztec:
            formatString = @"Aztec";
            break;
            
        case kBarcodeFormatCodabar:
            formatString = @"CODABAR";
            break;
            
        case kBarcodeFormatCode39:
            formatString = @"Code 39";
            break;
            
        case kBarcodeFormatCode93:
            formatString = @"Code 93";
            break;
            
        case kBarcodeFormatCode128:
            formatString = @"Code 128";
            break;
            
        case kBarcodeFormatDataMatrix:
            formatString = @"Data Matrix";
            break;
            
        case kBarcodeFormatEan8:
            formatString = @"EAN-8";
            break;
            
        case kBarcodeFormatEan13:
            formatString = @"EAN-13";
            break;
            
        case kBarcodeFormatITF:
            formatString = @"ITF";
            break;
            
        case kBarcodeFormatPDF417:
            formatString = @"PDF417";
            break;
            
        case kBarcodeFormatQRCode:
            formatString = @"QR Code";
            break;
            
        case kBarcodeFormatRSS14:
            formatString = @"RSS 14";
            break;
            
        case kBarcodeFormatRSSExpanded:
            formatString = @"RSS Expanded";
            break;
            
        case kBarcodeFormatUPCA:
            formatString = @"UPCA";
            break;
            
        case kBarcodeFormatUPCE:
            formatString = @"UPCE";
            break;
            
        case kBarcodeFormatUPCEANExtension:
            formatString = @"UPC/EAN extension";
            break;
            
        default:
            formatString = @"Unknown";
            break;
    }
    
    return result.text;
}

- (void)captureResult:(ZXCapture *)theCapture result:(ZXResult *)result {
    if (result) {
        // We got a result. Display information about the result onscreen.
//        [self.decodedLabel performSelectorOnMainThread:@selector(setText:) withObject:[self displayForResult:result] waitUntilDone:YES];
        NSString *code = [self displayForResult:result];
        NSLog(@"%@", [self displayForResult:result]);
        // Vibrate
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        [theCapture stop];
        
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        NSString *data = [NSString stringWithFormat:@"{player_id: \"%@\", controller_id: \"%@\"}", code, @"2222"];
        
        
        appDelegate.ws.delegate = self;
        [appDelegate.ws send:data];
        
        
//        NSString *path = [NSString stringWithFormat:@"/players/%@/connect", code];
//        
//        UIView *hud = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
//        [hud setBackgroundColor:[UIColor grayColor]];
//        [self.view addSubview:hud];
//        
//        [[MyClient sharedClient] postPath:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//            NSLog(@"%@", responseObject);
//            if ([[responseObject valueForKeyPath:@"status"] isEqual:@"ok"]) {
//                [hud removeFromSuperview];
//                ControlViewController *controlViewController = [[ControlViewController alloc] initWithNibName:@"ControlViewController" bundle:nil];
//                controlViewController.mediaInfo = responseObject;
//                NSLog(@"%@\n", [responseObject valueForKeyPath:@"name"]);
//                [self.navigationController pushViewController:controlViewController animated:YES];
//            }
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            NSLog(@"%@", error);
//        }];
        
        
    }
}



- (void)captureSize:(ZXCapture *)capture width:(NSNumber *)width height:(NSNumber *)height {
    
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSLog(@"%@", message);
    ControlViewController *controlViewController = [[ControlViewController alloc] initWithNibName:@"ControlViewController" bundle:nil];
    controlViewController.mediaInfo = [NSJSONSerialization JSONObjectWithData:message options:0 error:0];
    NSLog(@"%@", controlViewController.mediaInfo);
    [self.navigationController pushViewController:controlViewController animated:YES];
}

@end
