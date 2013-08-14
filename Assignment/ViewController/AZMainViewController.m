//
//  AZMainViewController.m
//  Assignment
//
//  Created by Alexander Zagorsky on 8/9/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import "AZMainViewController.h"
#import "PKRevealController.h"

@interface AZMainViewController ()

@end

@implementation AZMainViewController

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
    
    UIViewController *frontViewController = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil]
                                             instantiateViewControllerWithIdentifier:@"EmployeesViewController"];
    UIViewController *menuViewController = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil]
                                             instantiateViewControllerWithIdentifier:@"MenuViewController"];
    
    [self setFrontViewController:frontViewController];
    [self setLeftViewController:menuViewController];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
}

@end
