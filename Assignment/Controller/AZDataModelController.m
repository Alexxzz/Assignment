//
//  AZDataModelController.m
//  Assignment
//
//  Created by Alexander Zagorsky on 8/12/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import "AZDataModelController.h"
#import "AZLoginController.h"
#import "Employee.h"
#import "User.h"

static AZDataModelController *sharedInstance = nil;

@implementation AZDataModelController

#pragma mark - Singelton
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[AZDataModelController alloc] init];
    });
    
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        [MagicalRecord setupCoreDataStack];
        
        _currentUsername = [AZLoginController currentUsername];
    }
    return self;
}

#pragma mark - Interface methods
- (User *)addNewUserWithUsername:(NSString *)username {
    User *newUser = [User MR_createEntity];
    newUser.username = username;
    
    return newUser;
}

- (User *)userWithUsername:(NSString *)username {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"username == %@", username];
    
    return [[User MR_findAllSortedBy:@"username"
                           ascending:YES
                       withPredicate:predicate] lastObject];
}

- (Employee *)addNewEmployeeToCurrentUser {
    if ([self currentUser] == nil) {
        NSLog(@"[self currentUser] == nil");
        return nil;
    }
    
    Employee *newEmploye = [Employee MR_createEntity];
    newEmploye.user = [self currentUser];
    
    return newEmploye;
}

- (void)removeEmployee:(Employee *)employee {
    [employee MR_deleteEntity];
    
}

- (NSFetchedResultsController *)employeesForCurrentUserFetchControllerWithDelegate:(id<NSFetchedResultsControllerDelegate>)delegate {
    return [Employee MR_fetchAllGroupedBy:@"sectionTitle"
                            withPredicate:[NSPredicate predicateWithFormat:@"user == %@", [self currentUser]]
                                 sortedBy:@"lastName,firstName"
                                ascending:YES
                                 delegate:delegate];
}

- (NSUInteger)numberOfEmployeesForCurrentUser {
    if ([self currentUser] == nil) {
        NSLog(@"[self currentUser] == nil");
        return 0;
    }
    
    return [[self currentUser].employees count];
}

- (User *)currentUser {
    static User *currentUser = nil;
    
    if (currentUser == nil) {
        if (_currentUsername == nil) {
            NSLog(@"_currentUsername == nil");
            return nil;
        }
        
        currentUser = [self userWithUsername:_currentUsername];
        if (currentUser == nil)
            currentUser = [self addNewUserWithUsername:_currentUsername];
    }
    
    return currentUser;
}

#pragma mark - Saving
- (void)saveAsyncWithCompletion:(void(^)(BOOL success, NSError *error))completion {
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion:^(BOOL success, NSError *error) {
        if (completion)
            completion(success, error);
    }];
}

- (void)save {
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
}

@end
