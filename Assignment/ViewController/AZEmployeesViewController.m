//
//  AZEmployeesViewController.m
//  Assignment
//
//  Created by Alexander Zagorsky on 8/12/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import "AZEmployeesViewController.h"
#import "AZEmployeeViewController.h"
#import "AZDataModelController.h"
#import "Employee.h"
#import "User.h"

@interface AZEmployeesViewController () <NSFetchedResultsControllerDelegate>

@end

@implementation AZEmployeesViewController
{
    AZDataModelController *_modelController;
    NSFetchedResultsController *_fetchedController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _modelController = [AZDataModelController sharedInstance];
    
    _fetchedController = [_modelController employeesForCurrentUserFetchControllerWithDelegate:self];
    
    self.emptyDMMessageLabel.text = NSLocalizedString(@"No Employees found. Please add new", @"Message text for employees table when DB is empty");
    [self.addNewEmployeeButton setTitle:NSLocalizedString(@"Add Employee", @"Add Employee button title") forState:UIControlStateNormal];
}

- (void)viewDidUnload {
    self.emptyDMMessageFooterView = nil;
    self.emptyDMMessageLabel = nil;
    self.addNewEmployeeButton = nil;
    [super viewDidUnload];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"viewEmployeeSegueId"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Employee *selectedEmployee = [_fetchedController objectAtIndexPath:indexPath];
        
        AZEmployeeViewController *employeeVC = segue.destinationViewController;
        employeeVC.employee = selectedEmployee;
    }
}

#pragma mark - IBActions
- (IBAction)onRevealLeftMenu:(UIBarButtonItem *)sender {
    [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];
}

#pragma mark - UITableView datasource/delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger sectionsNum = [[_fetchedController sections] count];
    
    tableView.tableFooterView = (sectionsNum == 0) ? self.emptyDMMessageFooterView : nil;
    
    return sectionsNum;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[_fetchedController sections][section] objects] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"employeeCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellId];
    
    [self configureCell:cell
            atIndexPath:indexPath];
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [[_fetchedController sections][section] indexTitle];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return [_fetchedController sectionIndexTitles];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return [_fetchedController sectionForSectionIndexTitle:title atIndex:index];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)idxPath {
    Employee *employee = [_fetchedController objectAtIndexPath:idxPath];
    
    cell.textLabel.text = employee.fullName;
    cell.detailTextLabel.text = employee.country;
}

#pragma mark - NSFetchedResultsController
- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    if (self.isViewLoaded == YES)
        [self.tableView reloadData];
}

@end
