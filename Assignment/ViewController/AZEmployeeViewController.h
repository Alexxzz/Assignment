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

@property(strong,nonatomic) IBOutlet UITextField *firstNameLabel;
@property(strong,nonatomic) IBOutlet UITextField *lastNameLabel;
@property(strong,nonatomic) IBOutlet UIPickerView *countryPicker;
@property(strong,nonatomic) IBOutlet UIButton *removeButton;
@property(strong,nonatomic) IBOutlet UILabel *countryTitleLabel;
@property(strong,nonatomic) IBOutlet UILabel *countryLabel;

- (IBAction)onSetProfilePicture:(id)sender;
- (IBAction)onSave:(id)sender;
- (IBAction)onRemoveButton:(id)sender;

@end
