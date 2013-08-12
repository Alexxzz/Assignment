//
//  AZLoginViewController.m
//  Assignment
//
//  Created by Alexander Zagorsky on 8/11/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import "AZLoginViewController.h"
#import "AZInputFieldCell.h"
#import "AZLoginController.h"

typedef NS_ENUM(NSUInteger, eLoginTableCell) {
    eLoginTableCell_username = 0,
    eLoginTableCell_password,
    eLoginTableCell_repeatPassword,
};

@interface AZLoginViewController () <UITextFieldDelegate>

@end

@implementation AZLoginViewController
{
    BOOL _isRegistring;
}

#pragma mark - IB Actions
- (void)loginUser {
    UITextField *usernameTextField = [self textFieldForCellWithType:eLoginTableCell_username];
    UITextField *passwordTextField = [self textFieldForCellWithType:eLoginTableCell_password];
    
    BOOL loggedIn = [AZLoginController loginWithUsername:usernameTextField.text
                                                password:passwordTextField.text];
    if (loggedIn == YES) {
        [self performSegueWithIdentifier:@"ShowMainVC" sender:self];
    } else {
        [self showOkAlertWithText:NSLocalizedString(@"Username or password incorrect", @"Alert text shown if username or pass is incorrect")];
        [usernameTextField becomeFirstResponder];
    }
}

- (void)registerUser {
    UITextField *usernameTextField = [self textFieldForCellWithType:eLoginTableCell_username];
    UITextField *passwordTextField = [self textFieldForCellWithType:eLoginTableCell_password];
    UITextField *repeatPassTextField = [self textFieldForCellWithType:eLoginTableCell_repeatPassword];
    
    NSString *username = usernameTextField.text;
    NSString *pass = passwordTextField.text;
    
    if ([AZLoginController usernameExists:username]) {
        [self showOkAlertWithText:NSLocalizedString(@"Username exists", @"Alert text shown if user tries to reg with exsiting username")];
        [usernameTextField becomeFirstResponder];
    } else {
        if ([pass isEqualToString:repeatPassTextField.text] == NO) {
            [self showOkAlertWithText:NSLocalizedString(@"Please repeat password", @"Alert text shown if password check during reg fails")];
            [repeatPassTextField becomeFirstResponder];
        } else {
            [AZLoginController createUserWithUsername:username
                                             password:pass];
            [AZLoginController loginWithUsername:username
                                        password:pass];
            
            [self performSegueWithIdentifier:@"ShowMainVC" sender:self];
        }
    }
}

- (IBAction)onLogin:(id)sender {
    if ([self fieldsAreCorrect] == NO)
        return;
    
    if (_isRegistring)
        [self registerUser];
    else
        [self loginUser];
}

- (IBAction)onRegister:(id)sender {
    if (_isRegistring == NO) {
        _isRegistring = YES;
        
        [[self textFieldForCellWithType:eLoginTableCell_username] setText:@""];
        [[self textFieldForCellWithType:eLoginTableCell_password] setText:@""];
        [[self textFieldForCellWithType:eLoginTableCell_repeatPassword] setText:@""];
        
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:eLoginTableCell_repeatPassword inSection:0]]
                              withRowAnimation:UITableViewRowAnimationTop];
        
        [UIView animateWithDuration:.3f
                         animations:^{
                             self.registerButton.alpha = 0.f;
                             [self.loginButton setTitle:NSLocalizedString(@"Register", @"Register button title on the login screen")
                                               forState:UIControlStateNormal];
                         }];
    }
}

- (IBAction)onTapGesture:(id)sender {
    [[self textFieldForCellWithType:eLoginTableCell_username] resignFirstResponder];
    [[self textFieldForCellWithType:eLoginTableCell_password] resignFirstResponder];
    [[self textFieldForCellWithType:eLoginTableCell_repeatPassword] resignFirstResponder];
}

#pragma mark - UITableView datasource/delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (_isRegistring ? 3 : 2);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"InputfieldCellId";
    AZInputFieldCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellId];
    
    [self configCell:cell withType:indexPath.row];
    
    return cell;
}

- (void)configCell:(AZInputFieldCell *)cell withType:(eLoginTableCell)type {
    switch (type) {
        case eLoginTableCell_username:
            cell.textField.placeholder = NSLocalizedString(@"Username", @"Username field placeholder text in login screen");
            cell.textField.returnKeyType = UIReturnKeyNext;
            break;
            
        case eLoginTableCell_password:
            cell.textField.placeholder = NSLocalizedString(@"Password", @"Password field placeholder text in login screen");
            cell.textField.returnKeyType = _isRegistring ? UIReturnKeyNext : UIReturnKeyGo;
            cell.textField.secureTextEntry = YES;
            break;
            
        case eLoginTableCell_repeatPassword:
            cell.textField.placeholder = NSLocalizedString(@"Repeat password", @"Repeat password field placeholder text in login screen");
            cell.textField.returnKeyType = UIReturnKeyGo;
            cell.textField.secureTextEntry = YES;
            break;
    }
    
    cell.textField.delegate = self;
}

#pragma mark - Cells and Texfield access methods
- (AZInputFieldCell *)cellForType:(eLoginTableCell)type {
    if (type > [self.tableView numberOfRowsInSection:0] - 1)
        return nil;
    
    return (AZInputFieldCell*)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:type
                                                                                       inSection:0]];
}

- (UITextField *)textFieldForCellWithType:(eLoginTableCell)type {
    AZInputFieldCell *cell = [self cellForType:type];
    return cell.textField;
}

- (eLoginTableCell)cellTypeForTextField:(UITextField *)textfield {
    if ([textfield isEqual:[self textFieldForCellWithType:eLoginTableCell_username]])
        return eLoginTableCell_username;
    else if ([textfield isEqual:[self textFieldForCellWithType:eLoginTableCell_password]])
        return eLoginTableCell_password;
    else if ([textfield isEqual:[self textFieldForCellWithType:eLoginTableCell_repeatPassword]])
        return eLoginTableCell_repeatPassword;
    else
        return NSUIntegerMax;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    eLoginTableCell cellType = [self cellTypeForTextField:textField];
    
    if (cellType == eLoginTableCell_password) {
        textField.returnKeyType = _isRegistring ? UIReturnKeyNext : UIReturnKeyGo;
    } else if (cellType == eLoginTableCell_repeatPassword) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:eLoginTableCell_repeatPassword inSection:0]
                              atScrollPosition:UITableViewScrollPositionBottom
                                      animated:YES];
    }
    
    return YES;
}

- (void)showOkAlertWithText:(NSString *)alertText {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Assigment", @"App title used in aler views")
                                                    message:alertText
                                                   delegate:nil
                                          cancelButtonTitle:NSLocalizedString(@"Ok", @"OK buton title")
                                          otherButtonTitles:nil];
    [alert show];
}

- (BOOL)fieldsAreCorrect {
    UITextField *usernameTextField = [self textFieldForCellWithType:eLoginTableCell_username];
    UITextField *passwordTextField = [self textFieldForCellWithType:eLoginTableCell_password];
    UITextField *repeatPassTextField = [self textFieldForCellWithType:eLoginTableCell_repeatPassword];
    
    if ([usernameTextField.text length] == 0) {
        [usernameTextField becomeFirstResponder];
        
        [self showOkAlertWithText:NSLocalizedString(@"Please enter username", @"If username is empty")];
        
        return NO;
    } else if ([passwordTextField.text length] == 0) {
        [passwordTextField becomeFirstResponder];
        
        [self showOkAlertWithText:NSLocalizedString(@"Please enter password", @"If password is empty")];
        
        return NO;
    } else if ([repeatPassTextField.text length] == 0 && _isRegistring) {
        [repeatPassTextField becomeFirstResponder];
        
        [self showOkAlertWithText:NSLocalizedString(@"Please enter password again", @"If repeat password is empty")];
        
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    eLoginTableCell cellType = [self cellTypeForTextField:textField];
    
    UITextField *usernameTextField = [self textFieldForCellWithType:eLoginTableCell_username];
    UITextField *passwordTextField = [self textFieldForCellWithType:eLoginTableCell_password];
    UITextField *repeatPassTextField = [self textFieldForCellWithType:eLoginTableCell_repeatPassword];
    
    switch (cellType) {
        case eLoginTableCell_username: {
            if ([usernameTextField.text length] == 0)
                [self showOkAlertWithText:NSLocalizedString(@"Please enter username", @"If username is empty")];
            else
                [passwordTextField becomeFirstResponder];
            
            break;
        }
            
        case eLoginTableCell_password: {
            if ([passwordTextField.text length] == 0) {
                [self showOkAlertWithText:NSLocalizedString(@"Please enter password", @"If password is empty")];
            } else {
                if (_isRegistring == YES) {
                    [repeatPassTextField becomeFirstResponder];
                } else {
                    [passwordTextField resignFirstResponder];
                    [self onLogin:nil];
                }
            }
    
            break;
        }
            
        case eLoginTableCell_repeatPassword: {
            if ([repeatPassTextField.text length] == 0 && _isRegistring) {
                [self showOkAlertWithText:NSLocalizedString(@"Please enter password again", @"If repeat password is empty")];
            } else {
                [repeatPassTextField resignFirstResponder];
                [self onLogin:nil];
            }
            
            break;
        }
    }
    
    return YES;
}

@end
