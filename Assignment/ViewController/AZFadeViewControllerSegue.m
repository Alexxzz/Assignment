//
//  AZLoginViewControllerSegue.m
//  Assignment
//
//  Created by Alexander Zagorsky on 8/11/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import "AZFadeViewControllerSegue.h"
#import "AZSplashViewController.h"
#import "AZLoginViewController.h"

@implementation AZFadeViewControllerSegue

- (void)perform {
    UIViewController *sourceVC = self.sourceViewController;
    UIViewController *destVC = self.destinationViewController;
    
    destVC.view.alpha = 0.f;
    [sourceVC.navigationController pushViewController:destVC animated:NO];
    [UIView transitionWithView:destVC.view
                      duration:.3f
                       options:0
                    animations:^{
                        sourceVC.view.alpha = 0.f;
                        destVC.view.alpha = 1.f;
                    } completion:nil];
}

@end
