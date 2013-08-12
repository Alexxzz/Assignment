//
//  User.h
//  Assignment
//
//  Created by Alexander Zagorsky on 8/12/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Employee;

@interface User : NSManagedObject

@property (nonatomic, retain) NSString *username;
@property (nonatomic, retain) NSSet *employees;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addEmployeesObject:(Employee *)value;
- (void)removeEmployeesObject:(Employee *)value;
- (void)addEmployees:(NSSet *)values;
- (void)removeEmployees:(NSSet *)values;

@end
