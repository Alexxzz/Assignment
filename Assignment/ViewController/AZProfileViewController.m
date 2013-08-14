//
//  AZProfileViewController.m
//  Assignment
//
//  Created by Alexander Zagorsky on 8/14/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import "AZProfileViewController.h"
#import "AZLoginController.h"

@interface AZProfileViewController ()

@end

@implementation AZProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.currentUsername.text = [NSString stringWithFormat:NSLocalizedString(@"Logged in Username: %@", @"Label text format for displaying username"), [AZLoginController currentUsername]];
    [self.logOutButton setTitle:NSLocalizedString(@"Log out", @"Log out button title text") forState:UIControlStateNormal];
}

#pragma mark - IBActions
- (IBAction)onRevealLeftMenu:(UIBarButtonItem *)sender {
    [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];
}

- (IBAction)onLogOutButton:(id)sender {
    [AZLoginController logout];
    [[[self navigationController] revealController].navigationController popViewControllerAnimated:YES];
}

- (void)viewDidUnload {
    [self setCurrentUsername:nil];
    [self setLogOutButton:nil];
    [super viewDidUnload];
}
@end
