//
//  AZSplashViewController.m
//  Assignment
//
//  Created by Alexander Zagorsky on 8/11/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import "AZSplashViewController.h"
#import "AZLoginController.h"

@interface AZSplashViewController ()

@end

@implementation AZSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    __weak AZSplashViewController *weakSelf = self;
    double delayInSeconds = 1.f;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        AZSplashViewController *strongSelf = weakSelf;
        
        NSString *segueId = [AZLoginController isLoggedIn] ? @"ShowMainUI" : @"ShowLogin";
        
        [strongSelf performSegueWithIdentifier:segueId
                                        sender:strongSelf];
    });
}

@end
