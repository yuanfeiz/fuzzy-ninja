//
//  ViewController.m
//  FuzzyNinja
//
//  Created by stranbird on 13-5-18.
//  Copyright (c) 2013年 stranbird. All rights reserved.
//

#import "RootViewController.h"
#import "ControlViewController.h"
#import <AFNetworking.h>
#import <JSONKit/JSONKit.h>
#import "NinjaModeViewController.h"

#import "MyClient.h"
#import "AppDelegate.h"

#import <SRWebSocket.h>
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


@interface ControlViewController ()<SRWebSocketDelegate>

@property (strong, nonatomic) SRWebSocket *ws;

@end

@implementation ControlViewController

@synthesize mediaInfo;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"noise"]];

    
    UIButton *button =  [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"arrow"] forState:UIControlStateNormal];
    [button addTarget:self.navigationController action:@selector(popViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    [button setFrame:CGRectMake(10, 0, 32, 32)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    NSLog(@"%@", mediaInfo);
    [mediaInfo setValue:@"Now Playing: MIKE RELM vs ZOETROPE" forKey:@"name"];
    
    [self.MediaLabel setText:[mediaInfo valueForKey:@"name"]];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    self.ws = appDelegate.ws;
    self.ws.delegate = self;
    
    [self.mySlider setThumbImage:[UIImage imageNamed:@"slideblock"] forState:UIControlStateNormal];
    [self.mySlider setMinimumTrackTintColor:UIColorFromRGB(0x85250D)];
    [self.mySlider setMaximumTrackTintColor:UIColorFromRGB(0x85250D)];
    
    NSLog(@"OK");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doNext:(id)sender {
    NSUserDefaults *db = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"matching", @"cmdType", @"mobile", @"sourceType", [db valueForKey:@"controller_id"], @"mobileID", [db valueForKey:@"player_id"], @"codeID", @"next", @"cmd", nil];
    [self.ws send:[params JSONString]];
}

- (IBAction)doPrevious:(id)sender {
    NSUserDefaults *db = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"matching", @"cmdType", @"mobile", @"sourceType", [db valueForKey:@"controller_id"], @"mobileID", [db valueForKey:@"player_id"], @"codeID", @"prev", @"cmd", nil];
    [self.ws send:[params JSONString]];
}

- (IBAction)togglePlayPause:(id)sender {

    NSUserDefaults *db = [NSUserDefaults standardUserDefaults];

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"matching", @"cmdType", @"mobile", @"sourceType", [db valueForKey:@"controller_id"], @"mobileID", [db valueForKey:@"player_id"], @"codeID", @"play", @"cmd", nil];
    [self.ws send:[params JSONString]];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSLog(@"%@", message);
    NSLog(@"%@", [message objectFromJSONString]);
}
- (IBAction)doFullSize:(id)sender {
    NSUserDefaults *db = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"matching", @"cmdType", @"mobile", @"sourceType", [db valueForKey:@"controller_id"], @"mobileID", [db valueForKey:@"player_id"], @"codeID", @"fullScreen", @"cmd", nil];
    [self.ws send:[params JSONString]];
}

- (IBAction)toggleMute:(id)sender {
    NSUserDefaults *db = [NSUserDefaults standardUserDefaults];
    
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"matching", @"cmdType", @"mobile", @"sourceType", [db valueForKey:@"controller_id"], @"mobileID", [db valueForKey:@"player_id"], @"codeID", @"silent", @"cmd", nil];
    [self.ws send:[params JSONString]];
}

- (IBAction)switchMode:(UIButton *)sender {
    NinjaModeViewController *vc = [[NinjaModeViewController alloc] initWithNibName:@"ControlViewController" bundle:nil];

//    RootViewController *vc = [[RootViewController alloc] initWithNibName:@"PhoneContent" bundle:nil];
    [self.navigationController presentViewController:vc animated:NO completion:nil];
}
@end
