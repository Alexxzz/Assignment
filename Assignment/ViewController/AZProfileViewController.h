//
//  AZProfileViewController.h
//  Assignment
//
//  Created by Alexander Zagorsky on 8/14/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AZProfileViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *currentUsername;
@property (strong, nonatomic) IBOutlet UIButton *logOutButton;
- (IBAction)onRevealLeftMenu:(id)sender;
- (IBAction)onLogOutButton:(id)sender;

@end
