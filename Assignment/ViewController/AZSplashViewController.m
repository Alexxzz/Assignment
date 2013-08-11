//
//  AZSplashViewController.m
//  Assignment
//
//  Created by Alexander Zagorsky on 8/11/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import "AZSplashViewController.h"

@interface AZSplashViewController ()

@end

@implementation AZSplashViewController

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
	// Do any additional setup after loading the view.
    
    __weak AZSplashViewController *weakSelf = self;
    double delayInSeconds = .1;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        AZSplashViewController *strongSelf = weakSelf;
        [strongSelf performSegueWithIdentifier:@"ShowLogin" sender:strongSelf];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
