//
//  NinjaModeViewController.m
//  FuzzyNinja
//
//  Created by stranbird on 13-5-19.
//  Copyright (c) 2013年 stranbird. All rights reserved.
//

#import "NinjaModeViewController.h"

@interface NinjaModeViewController ()

@end

@implementation NinjaModeViewController

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
    
    [[NSBundle mainBundle] loadNibNamed:@"PhoneContent" owner:self options:nil];
    

    
//    [self.navigationController pushViewController:<#(UIViewController *)#> animated:<#(BOOL)#>]
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
