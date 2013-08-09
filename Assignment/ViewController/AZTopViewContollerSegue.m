//
//  AZTopViewContollerSegue.m
//  Assignment
//
//  Created by Alexander Zagorsky on 8/9/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import "AZTopViewContollerSegue.h"
#import "PKRevealController.h"

@implementation AZTopViewContollerSegue

- (void)perform {
    PKRevealController *revealController = ((UIViewController*)self.sourceViewController).revealController;
    UIViewController *destVc = self.destinationViewController;
    
    [revealController setFrontViewController:destVc];
    [revealController showViewController:destVc];
}

@end
