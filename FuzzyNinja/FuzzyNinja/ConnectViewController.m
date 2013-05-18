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
#import <JSONKit.h>
#import <JSONKit/JSONKit.h>
#import "MyClient.h"
#import "NinjaModeViewController.h"

#import "AppDelegate.h"

@interface ConnectViewController ()<ZXCaptureDelegate, SRWebSocketDelegate>

@property (nonatomic, strong) ZXCapture* capture;
@property (nonatomic, strong) NSDictionary *m;

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
}

- (void)viewWillAppear:(BOOL)animated {
    self.capture = [[ZXCapture alloc] init];
    self.capture.delegate = self;
    self.capture.rotation = -90.0f;
    self.capture.camera = self.capture.back;
    self.capture.layer.frame = self.view.bounds;
    [self.view.layer addSublayer:self.capture.layer];
    
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.capture.layer removeFromSuperlayer];
    [self.capture stop];
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
        NSString *code = [self displayForResult:result];
        NSLog(@"%@", [self displayForResult:result]);
        // Vibrate
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        [theCapture stop];
        
        [[NSUserDefaults standardUserDefaults] setValue:@"2222" forKey:@"controller_id"];
        [[NSUserDefaults standardUserDefaults] setValue:code forKey:@"player_id"];
        AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"matching", @"cmdType", @"mobile", @"sourceType", @"2222", @"mobileID", code, @"codeID", nil];
        
        
        appDelegate.ws.delegate = self;
        [appDelegate.ws send:[params JSONString]];
        
        
    }
}



- (void)captureSize:(ZXCapture *)capture width:(NSNumber *)width height:(NSNumber *)height {
    
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSLog(@"%@", message);
    self.m = [message objectFromJSONString];
    [[NSUserDefaults standardUserDefaults] setValuesForKeysWithDictionary:self.m];
    
    [self.capture stop];
    
    UIButton *zenButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    zenButton.frame = CGRectMake(100, 300, 100, 50);
    [zenButton setTitle:@"ZenMode" forState:UIControlStateNormal];
    [self.view addSubview:zenButton];
    [zenButton addTarget:self action:@selector(enterZenMode:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *ninjaButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    ninjaButton.frame = CGRectMake(100, 400, 100, 50);
    [ninjaButton setTitle:@"NinjaMode" forState:UIControlStateNormal];
    [self.view addSubview:ninjaButton];
    [ninjaButton addTarget:self action:@selector(enterNinjaMode:) forControlEvents:UIControlEventTouchUpInside];
}

- (IBAction)enterZenMode:(id)sender {
    ControlViewController *controlViewController = [[ControlViewController alloc] initWithNibName:@"ControlViewController" bundle:nil];
    controlViewController.mediaInfo = self.m;
    [self.navigationController pushViewController:controlViewController animated:YES];
}

- (IBAction)enterNinjaMode:(id)sender {
    NinjaModeViewController *ninjaVC = [[NinjaModeViewController alloc] initWithNibName:@"NinjaModeViewController" bundle:nil];
    [self.navigationController pushViewController:ninjaVC animated:YES];
}

@end
