//
//  AZLoginViewControllerSegue.m
//  Assignment
//
//  Created by Alexander Zagorsky on 8/11/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import "AZLoginViewControllerSegue.h"
#import "AZSplashViewController.h"
#import "AZLoginViewController.h"

@implementation AZLoginViewControllerSegue

- (void)perform {
    AZSplashViewController *splashVC = self.sourceViewController;
    AZLoginViewController *loginVC = self.destinationViewController;
    
    loginVC.view.alpha = 0.f;
    [UIView transitionWithView:loginVC.view
                      duration:.3f
                       options:0
                    animations:^{
                        splashVC.view.alpha = 0.f;
                        loginVC.view.alpha = 1.f;
                        [splashVC.navigationController pushViewController:loginVC animated:NO];
                    } completion:^(BOOL finished) {
                        
                    }];
}

@end
