//
//  ViewController.m
//  FuzzyNinja
//
//  Created by stranbird on 13-5-18.
//  Copyright (c) 2013年 stranbird. All rights reserved.
//

#import "ControlViewController.h"
#import <AFNetworking.h>

#import "MyClient.h"

@interface ControlViewController ()

@end

@implementation ControlViewController


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
    
    NSLog(@"OK");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doNext:(id)sender {
    
    NSString *server = @"2222";
    
    NSDictionary *params = [NSDictionary dictionaryWithObject:@"next" forKey:@"action"];
    
    NSString *path = [NSString stringWithFormat:@"/players/%@/connect", server];
    [[MyClient sharedClient] postPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
    } failure:nil];
}

- (IBAction)doPrevious:(id)sender {
    
    NSString *server = @"2222";
    
    NSDictionary *params = [NSDictionary dictionaryWithObject:@"previous" forKey:@"action"];
    
    NSString *path = [NSString stringWithFormat:@"/players/%@/connect", server];
    [[MyClient sharedClient] postPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
    } failure:nil];
}

- (IBAction)togglePlayPause:(id)sender {
    NSString *server = @"2222";
    
    NSDictionary *params = [NSDictionary dictionaryWithObject:@"play" forKey:@"action"];
    
    NSString *path = [NSString stringWithFormat:@"/players/%@/connect", server];
    [[MyClient sharedClient] postPath:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@", responseObject);
        if ([[responseObject valueForKey:@"play_status"] isEqual:@"1"]) {
            NSLog(@"current play status: %@", @"play");
        }
        else {
            NSLog(@"current play status: %@", @"pause");
        }
    } failure:nil];
}
@end
