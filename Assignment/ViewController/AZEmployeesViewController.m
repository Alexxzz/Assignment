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
#import "PKRevealController.h"
#import "Employee.h"
#import "User.h"

@interface AZEmployeesViewController () <NSFetchedResultsControllerDelegate>

@end

@implementation AZEmployeesViewController
{
    AZDataModelController *_modelController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _modelController = [AZDataModelController sharedInstance];
    
    self.emptyDMMessageLabel.text = NSLocalizedString(@"No Employees found. Please add new", @"Message text for employees table when DB is empty");
    [self.addNewEmployeeButton setTitle:NSLocalizedString(@"Add Employee", @"Add Employee button title") forState:UIControlStateNormal];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"viewEmployeeSegueId"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        Employee *selectedEmployee = [self.fetchedController objectAtIndexPath:indexPath];
        
        AZEmployeeViewController *employeeVC = segue.destinationViewController;
        employeeVC.employee = selectedEmployee;
    }
}

#pragma mark - IBActions
- (IBAction)onRevealLeftMenu:(UIBarButtonItem *)sender {
    [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];
}

- (void)viewDidUnload {
    [self setEmptyDMMessageFooterView:nil];
    [self setEmptyDMMessageLabel:nil];
    [self setAddNewEmployeeButton:nil];
    [super viewDidUnload];
}

#pragma mark - UITableView datasource/delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[[self.fetchedController sections][section] objects] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"employeeCell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellId];
    
    [self configureCell:cell
            atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)idxPath {
    Employee *employee = [self.fetchedController objectAtIndexPath:idxPath];
    
    cell.textLabel.text = employee.fullName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", [employee.country intValue]];
}

#pragma mark - NSFetchedResultsController
- (NSFetchedResultsController *)fetchedController {
    static NSFetchedResultsController *fetchedController = nil;
    
    if (fetchedController == nil) {
        fetchedController = [_modelController employeesForCurrentUserFetchControllerWithDelegate:self];
    }
    
    return fetchedController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath]
                    atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
                             withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}


@end
