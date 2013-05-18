//
//  ViewController.m
//  FuzzyNinja
//
//  Created by stranbird on 13-5-18.
//  Copyright (c) 2013年 stranbird. All rights reserved.
//

#import "ControlViewController.h"
#import <AFNetworking.h>
#import <JSONKit/JSONKit.h>

#import "MyClient.h"
#import "AppDelegate.h"

#import <SRWebSocket.h>

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
    
    [self.MediaLabel setText:[mediaInfo valueForKey:@"name"]];
    
    AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    self.ws = appDelegate.ws;
    self.ws.delegate = self;
    
    
    NSLog(@"OK");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doNext:(id)sender {
//    
//    NSString *server = @"2222";
//    
//    NSDictionary *params = [NSDictionary dictionaryWithObject:@"next" forKey:@"control"];
//    
//    NSString *path = [NSString stringWithFormat:@"/players/%@/control", server];
//    [[MyClient sharedClient] postPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@", responseObject);
//    } failure:nil];
    NSUserDefaults *db = [NSUserDefaults standardUserDefaults];
    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[db valueForKey:@"controller_id"], @"controller_id",
                            [db valueForKey:@"player_id"], @"player_id", @"next", @"control_signal", nil];
    [self.ws send:[params JSONString]];
}

- (IBAction)doPrevious:(id)sender {
    
//    NSString *server = @"2222";
//    
//    NSDictionary *params = [NSDictionary dictionaryWithObject:@"previous" forKey:@"control"];
//    
//    NSString *path = [NSString stringWithFormat:@"/players/%@/control", server];
//    [[MyClient sharedClient] postPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@", responseObject);
//    } failure:nil];
    NSUserDefaults *db = [NSUserDefaults standardUserDefaults];

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[db valueForKey:@"controller_id"], @"controller_id",
                            [db valueForKey:@"player_id"], @"player_id", @"previous", @"control_signal", nil];
    [self.ws send:[params JSONString]];
}

- (IBAction)togglePlayPause:(id)sender {
//    NSString *server = @"2222";
//    
//    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:@"toggle", @"control", nil];
//    
//    NSString *path = [NSString stringWithFormat:@"/players/%@/control", server];
//    [[MyClient sharedClient] postPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSLog(@"%@", responseObject);
//        if ([[responseObject valueForKey:@"play_status"] isEqual:@"1"]) {
//            NSLog(@"current play status: %@", @"play");
//        }
//        else {
//            NSLog(@"current play status: %@", @"pause");
//        }
//    } failure:nil];
    NSUserDefaults *db = [NSUserDefaults standardUserDefaults];

    NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:[db valueForKey:@"controller_id"], @"controller_id",
                            [db valueForKey:@"player_id"], @"player_id", @"toggleStatus", @"control_signal", nil];
    [self.ws send:[params JSONString]];
}

- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessage:(id)message {
    NSLog(@"%@", message);
    NSLog(@"%@", [message objectFromJSONString]);
}
@end
