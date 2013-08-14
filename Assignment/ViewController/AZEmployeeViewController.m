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

static const CGFloat kPickerToolbatHeight = 44.f;
static const CGFloat kPickerHeight = 490.f;

@interface AZEmployeeViewController () <UIPickerViewDataSource, UIPickerViewDelegate>

@end

@implementation AZEmployeeViewController
{
    AZDataModelController *_modelController;
    BOOL _isNewEmployee;
    UIActionSheet *_countryPickerActionSheet;
    NSArray *_countries;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _modelController = [AZDataModelController sharedInstance];
    _isNewEmployee = (_employee == nil);
    
    _countries = [self getCountiesArray];
    
    NSString *title = nil;
    NSString *country = nil;
    if (_isNewEmployee) {
        title = NSLocalizedString(@"New Employee", @"Nav bar title for new employee VC");
        country = NSLocalizedString(@"Not set", @"When country not set");
        
        _employee = [_modelController addNewEmployeeToCurrentUser];
    } else {
        title = _employee.fullName;
        country = _employee.country;
        NSUInteger row = [_countries indexOfObject:country];
        if (row != NSNotFound)
            [self.countryPicker selectRow:row inComponent:0 animated:NO];
    }
    self.navigationItem.title = title;
    
    self.firstNameLabel.text = _employee.firstName;
    self.lastNameLabel.text = _employee.lastName;
    
    self.countryTitleLabel.text = NSLocalizedString(@"Country", @"Country selection cell title");
    self.countryLabel.text = country;
    
    self.tableView.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.png"]];
}

- (void)viewDidDisappear:(BOOL)animated {
     if (_isNewEmployee == YES && [_employee.firstName length] == 0 && [_employee.lastName length] == 0 && [_employee.country length] == 0) {
         [_employee MR_deleteEntity];
     }
}

#pragma mark - Countries
- (NSArray *)getCountiesArray {
    NSLocale *locale = [NSLocale currentLocale];
    NSArray *countryArray = [NSLocale ISOCountryCodes];
    
    NSMutableArray *sortedCountryArray = [[NSMutableArray alloc] init];
    
    for (NSString *countryCode in countryArray) {
        NSString *displayNameString = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
        [sortedCountryArray addObject:displayNameString];
    }
    
    [sortedCountryArray sortUsingSelector:@selector(localizedCompare:)];
    
    return [sortedCountryArray copy];
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _isNewEmployee ? 2 : 3;
}

- (void)showPickerActionSheet {
    _countryPickerActionSheet = [[UIActionSheet alloc] initWithTitle:nil
                                                            delegate:nil
                                                   cancelButtonTitle:nil
                                              destructiveButtonTitle:nil
                                                   otherButtonTitles:nil];
    
    CGRect selfFrame = self.view.frame;
    
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                                                               target:self
                                                                               action:nil];
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                             target:self
                                                                             action:@selector(onDatePickerDone:)];
    UIToolbar *pickerDateToolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetHeight(selfFrame), kPickerToolbatHeight)];
    pickerDateToolbar.barStyle = UIBarStyleBlackOpaque;
    [pickerDateToolbar sizeToFit];
    [pickerDateToolbar setItems:@[flexSpace, doneBtn] animated:YES];
    
    [_countryPickerActionSheet addSubview:pickerDateToolbar];
    [_countryPickerActionSheet addSubview:self.countryPicker];
    [_countryPickerActionSheet showInView:self.view];
    
    [self.countryPicker sizeToFit];
    CGRect pickerFrame = self.countryPicker.frame;
    pickerFrame.origin.y = kPickerToolbatHeight;
    self.countryPicker.frame = pickerFrame;
    
    CGFloat width = self.view.frame.size.width;
    [_countryPickerActionSheet setBounds:CGRectMake(0, 0, width, kPickerHeight)];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1)
        [self showPickerActionSheet];
}

- (void)onDatePickerDone:(id)sender {
    [_countryPickerActionSheet dismissWithClickedButtonIndex:0
                                                    animated:YES];
    _countryPickerActionSheet = nil;
}

#pragma mark - IBActions
- (IBAction)onSetProfilePicture:(id)sender {

}

- (void)showOkAlertWithText:(NSString *)alertText {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Assigment", @"App title used in aler views")
                                                    message:alertText
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"Ok", @"OK buton title")
                                          otherButtonTitles:nil];
    [alert show];
}

- (IBAction)onSave:(id)sender {
    if ([self.firstNameLabel.text length] == 0) {
        [self.firstNameLabel becomeFirstResponder];
        
        [self showOkAlertWithText:NSLocalizedString(@"Please enter First Name", @"Alert message text if First Name is empty")];
    } else if ([self.lastNameLabel.text length] == 0) {
        [self.lastNameLabel becomeFirstResponder];
        
        [self showOkAlertWithText:NSLocalizedString(@"Please enter Last Name", @"Alert message text if Last Name is empty")];
    } else {
        _employee.firstName = self.firstNameLabel.text;
        _employee.lastName = self.lastNameLabel.text;
        _employee.country = self.countryLabel.text;
        
        [_modelController save];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)onRemoveButton:(id)sender {
    [_employee MR_deleteEntity];
    
    [_modelController save];
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UIPickerViewDataSource, UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [_countries count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _countries[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.countryLabel.text = _countries[row];
}

- (void)viewDidUnload {
    [self setRemoveButton:nil];
    [self setCountryTitleLabel:nil];
    [self setCountryLabel:nil];
    [super viewDidUnload];
}
@end
