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
    
    AZLoginController *_loginController;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _loginController = [[AZLoginController alloc] init];
}

#pragma mark - IB Actions
- (IBAction)onLogin:(id)sender {
    [self performSegueWithIdentifier:@"ShowMainVC" sender:self];
}

- (IBAction)onRegister:(id)sender {
    if (_isRegistring == NO) {
        _isRegistring = YES;
        
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
            break;
            
        case eLoginTableCell_repeatPassword:
            cell.textField.placeholder = NSLocalizedString(@"Repeat password", @"Repeat password field placeholder text in login screen");
            cell.textField.returnKeyType = UIReturnKeyGo;
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

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    eLoginTableCell cellType = [self cellTypeForTextField:textField];
    
    UITextField *passwordTextField = [self textFieldForCellWithType:eLoginTableCell_password];
    UITextField *repeatPassTextField = [self textFieldForCellWithType:eLoginTableCell_repeatPassword];
    
    switch (cellType) {
        case eLoginTableCell_username: {
            [passwordTextField becomeFirstResponder]; 
            break;
        }
            
        case eLoginTableCell_password: {
            if (_isRegistring == YES)
                [repeatPassTextField becomeFirstResponder];
            else
                [passwordTextField resignFirstResponder];
            break;
        }
            
        case eLoginTableCell_repeatPassword: {
            [repeatPassTextField resignFirstResponder];
            break;
        }
    }
    
    return YES;
}

@end
