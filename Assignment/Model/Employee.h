//
//  Employee.h
//  Assignment
//
//  Created by Alexander Zagorsky on 8/12/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface Employee : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * country;
@property (nonatomic, retain) NSString * profilePictureUrl;
@property (nonatomic, retain) User *user;

@property (nonatomic, readonly) NSString *fullName;

@end
