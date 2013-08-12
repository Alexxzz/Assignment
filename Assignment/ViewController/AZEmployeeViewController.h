//
//  AZEmployeeViewController.h
//  Assignment
//
//  Created by Alexander Zagorsky on 8/13/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Employee;

@interface AZEmployeeViewController : UITableViewController
@property(nonatomic,strong) Employee *employee;

@property(weak,nonatomic) IBOutlet UITextField *firstNameLabel;
@property(weak,nonatomic) IBOutlet UITextField *lastNameLabel;
@property(weak,nonatomic) IBOutlet UILabel *countryLabel;
@property(weak,nonatomic) IBOutlet UIPickerView *countryPicker;

- (IBAction)onSetProfilePicture:(id)sender;
- (IBAction)onSave:(id)sender;

@end
