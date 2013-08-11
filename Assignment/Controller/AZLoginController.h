//
//  AZLoginController.h
//  Assignment
//
//  Created by Alexander Zagorsky on 8/11/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AZLoginController : NSObject

- (BOOL)isLoggedIn;
- (NSString *)currentUsername;
- (void)logout;

- (BOOL)loginWithUsername:(NSString *)username password:(NSString *)password;

- (void)createUserWithUsername:(NSString *)username password:(NSString *)password;

@end
