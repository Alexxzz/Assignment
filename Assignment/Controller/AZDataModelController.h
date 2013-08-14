//
//  AZDataModelController.h
//  Assignment
//
//  Created by Alexander Zagorsky on 8/12/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Employee;
@class User;

@interface AZDataModelController : NSObject

@property(nonatomic,copy) NSString *currentUsername;
@property(nonatomic,strong,readonly) User *currentUser;

+ (instancetype)sharedInstance;

- (User *)addNewUserWithUsername:(NSString *)username;
- (User *)userWithUsername:(NSString *)username;

- (Employee *)addNewEmployeeToCurrentUser;
- (void)removeEmployee:(Employee *)employee;
- (NSUInteger)numberOfEmployeesForCurrentUser;

- (NSFetchedResultsController *)employeesForCurrentUserFetchControllerWithDelegate:(id<NSFetchedResultsControllerDelegate>)delegate;

- (void)saveAsyncWithCompletion:(void(^)(BOOL success, NSError *error))completion;
- (void)save;

@end
