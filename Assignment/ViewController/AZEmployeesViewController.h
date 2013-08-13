//
//  AZEmployeesViewController.h
//  Assignment
//
//  Created by Alexander Zagorsky on 8/12/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AZEmployeesViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UIView *emptyDMMessageFooterView;
@property (strong, nonatomic) IBOutlet UILabel *emptyDMMessageLabel;
@property (strong, nonatomic) IBOutlet UIButton *addNewEmployeeButton;

- (IBAction)onRevealLeftMenu:(UIBarButtonItem *)sender;

@end
