//
//  AZLoginViewController.h
//  Assignment
//
//  Created by Alexander Zagorsky on 8/11/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AZLoginViewController : UITableViewController

@property(nonatomic,weak) IBOutlet UIButton *loginButton;
@property(nonatomic,weak) IBOutlet UIButton *registerButton;

- (IBAction)onLogin:(id)sender;
- (IBAction)onRegister:(id)sender;

@end
