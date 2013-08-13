//
//  Employee.m
//  Assignment
//
//  Created by Alexander Zagorsky on 8/12/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import "Employee.h"
#import "User.h"


@implementation Employee

@dynamic firstName;
@dynamic lastName;
@dynamic country;
@dynamic profilePictureUrl;
@dynamic user;

- (NSString *)fullName {
    NSString *fullName = @"";
    
    BOOL firstName = [self.firstName length] > 0;
    BOOL lastName = [self.lastName length] > 0;
    
    if (firstName && lastName)
        fullName = [NSString stringWithFormat:@"%@ %@", self.firstName, self.lastName];
    else if (firstName)
        fullName = self.firstName;
    else if (lastName)
        fullName = self.lastName;

    return fullName;
}

- (NSString *)sectionTitle {
    NSString *sectionTitle = nil;
    if ([self.lastName length] > 0)
        sectionTitle = [self.lastName substringToIndex:1];
    
    return sectionTitle;
}

@end
