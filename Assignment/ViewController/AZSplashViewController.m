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


- (void)viewDidAppear:(BOOL)animated {
    __weak AZSplashViewController *weakSelf = self;
    
    CGRect logoImageViewFrame = self.logoImageView.frame;
    logoImageViewFrame.size.height = 120.f;
    logoImageViewFrame.size.width = 150.f;
    logoImageViewFrame.origin.y = 0;
    logoImageViewFrame.origin.x = ceilf((CGRectGetWidth(self.view.frame) - 150.f) / 2.f);
    [UIView animateWithDuration:1.f
                          delay:.5f
                        options:0
                     animations:^{
                         weakSelf.logoImageView.frame = logoImageViewFrame;
                     } completion:^(BOOL finished) {
                         AZSplashViewController *strongSelf = weakSelf;
                         
                         NSString *segueId = [AZLoginController isLoggedIn] ? @"ShowMainUI" : @"ShowLogin";
                         
                         [strongSelf performSegueWithIdentifier:segueId
                                                         sender:strongSelf];
                     }];
}

- (void)viewDidUnload {
    [self setLogoImageView:nil];
    [super viewDidUnload];
}
@end
