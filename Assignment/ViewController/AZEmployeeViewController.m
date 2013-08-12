//
//  AZEmployeeViewController.m
//  Assignment
//
//  Created by Alexander Zagorsky on 8/13/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import "AZEmployeeViewController.h"
#import "AZDataModelController.h"
#import "Employee.h"

@interface AZEmployeeViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@end

@implementation AZEmployeeViewController
{
    AZDataModelController *_modelController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _modelController = [AZDataModelController sharedInstance];
    
    NSString *title = nil;
    if (_employee != nil)
         title = _employee.fullName;
    else
        title = NSLocalizedString(@"New Employee", @"Nav bar title for new employee VC");
    self.navigationItem.title = title;
    
    self.firstNameLabel.text = _employee.firstName;
    self.lastNameLabel.text = _employee.lastName;
    
    if (_employee == nil)
        _employee = [_modelController addNewEmployeeToCurrentUser];
}

#pragma mark - IBActions
- (IBAction)onSetProfilePicture:(id)sender {

}

- (IBAction)onSave:(id)sender {
    _employee.firstName = self.firstNameLabel.text;
    _employee.lastName = self.lastNameLabel.text;
    
    [_modelController saveAsyncWithCompletion:^(BOOL success, NSError *error) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
}

#pragma mark - UIPickerViewDataSource, UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 2;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [@(component) stringValue];
}

@end
