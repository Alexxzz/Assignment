//
//  AZLoginViewControllerSegue.m
//  Assignment
//
//  Created by Alexander Zagorsky on 8/11/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import "AZShowLoginViewControllerSegue.h"
#import "AZSplashViewController.h"
#import "AZLoginViewController.h"

@implementation AZShowLoginViewControllerSegue

- (void)perform {
    UIViewController *sourceVC = self.sourceViewController;
    UIViewController *destVC = self.destinationViewController;
    
    [[sourceVC.view superview] addSubview:destVC.view];
    [sourceVC.view removeFromSuperview];
    
    [sourceVC.navigationController pushViewController:destVC animated:NO];

}

@end
