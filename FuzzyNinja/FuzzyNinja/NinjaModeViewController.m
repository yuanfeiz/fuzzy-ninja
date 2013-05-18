//
//  NinjaModeViewController.m
//  FuzzyNinja
//
//  Created by stranbird on 13-5-19.
//  Copyright (c) 2013年 stranbird. All rights reserved.
//

#import "NinjaModeViewController.h"
#import "ImageTargetsAppDelegate.h"
#import "ImageTargetsQCARutils.h"

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
    
    ImageTargetsQCARutils *qUtils = [ImageTargetsQCARutils getInstance];
    qUtils.deviceOrientationLock = DeviceOrientationLockAuto;
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    window = [[UIWindow alloc] initWithFrame: screenBounds];
    
    // Provide a list of targets we're expecting - the first in the list is the default
    [qUtils addTargetName:@"Stones & Chips" atPath:@"StonesAndChips.xml"];
    [qUtils addTargetName:@"Tarmac" atPath:@"Tarmac.xml"];
    
    
    // Add the EAGLView and the overlay view to the window
    ImageTargetsParentViewController *arParentViewController = [[ImageTargetsParentViewController alloc] initWithWindow:window];
    arParentViewController.arViewRect = screenBounds;
    
    [self.navigationController pushViewController:arParentViewController animated:NO];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
