//
//  SplashViewController.m
//  FuzzyNinja
//
//  Created by stranbird on 13-5-18.
//  Copyright (c) 2013年 stranbird. All rights reserved.
//

#import "SplashViewController.h"
#import "ConnectViewController.h"
#import "ControlViewController.h"

#import <AFNetworking.h>
#import "MyClient.h"

@interface SplashViewController ()
- (void)doSignin;
@end

@implementation SplashViewController

- (void)doSignin {
    NSURL *url = [NSURL URLWithString:@"http://169.254.130.53:3001/sessions"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
                             
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSLog(@"id %@", [JSON valueForKeyPath:@"id"]);
        
        [[NSUserDefaults standardUserDefaults] setObject:[JSON valueForKeyPath:@"id"] forKey:@"id"];
    } failure:nil];
    
    [operation start];
}

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
    [self doSignin];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doConnect:(id)sender {
    ConnectViewController *connectViewController = [[ConnectViewController alloc] initWithNibName:@"ConnectViewController" bundle:nil];
    [self.navigationController pushViewController:connectViewController animated:YES];
}
@end
