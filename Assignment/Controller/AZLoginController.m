//
//  AZLoginController.m
//  Assignment
//
//  Created by Alexander Zagorsky on 8/11/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import "AZLoginController.h"
#import "KeychainItemWrapper.h"

static NSString *kKeyChainIdentifier = @"AppKeychain";
static NSString *kCurrentUsername = @"CurrentUsername"; // Used for store logged in username

@implementation AZLoginController

#pragma mark - Internal methods
+ (KeychainItemWrapper *)keychainItemWrapperForAccount:(NSString *)account {
    if ([account length] == 0)
        return nil;
    
    return [[KeychainItemWrapper alloc] initWithIdentifier:kKeyChainIdentifier
                                                   account:account
                                               accessGroup:nil];
}

+ (NSString *)passwordForUsername:(NSString *)username {
    KeychainItemWrapper *existingKeychainItem = [self keychainItemWrapperForAccount:username];
    NSString *password = [existingKeychainItem objectForKey:(__bridge id)(kSecValueData)];
    
    return password;
}

+ (void)setCurrentUsername:(NSString *)username {
    [self createUserWithUsername:kCurrentUsername
                        password:username];
}

#pragma mark - Interface methods
+ (BOOL)isLoggedIn {
    return ([[self currentUsername] length] > 0);
}

+ (NSString *)currentUsername {
    return [self passwordForUsername:kCurrentUsername];
}

+ (void)logout {
    KeychainItemWrapper *currentAccItem = [self keychainItemWrapperForAccount:kCurrentUsername];
    [currentAccItem setObject:@""
                       forKey:(__bridge id)(kSecValueData)];
}

+ (BOOL)loginWithUsername:(NSString *)username password:(NSString *)password {
    NSString *storedPass = [self passwordForUsername:username];
    if ([storedPass length] == 0)
        return NO; // Username does not exists
    
    if ([storedPass isEqualToString:password]) {
        [self setCurrentUsername:username];
        return YES;
    }
    
    return NO; // Wrong password
}

+ (BOOL)usernameExists:(NSString *)username {
    NSString *pass = [self passwordForUsername:username];
    
    return ([pass length] > 0);
}

+ (void)createUserWithUsername:(NSString *)username password:(NSString *)password {
    if ([username length] == 0 || [password length] == 0)
        return;
    
    KeychainItemWrapper *newKeyChainItem = [self keychainItemWrapperForAccount:username];
    
    [newKeyChainItem setObject:username
                      forKey:(__bridge id)(kSecAttrAccount)];
    
    [newKeyChainItem setObject:password
                      forKey:(__bridge id)(kSecValueData)];
    
    [newKeyChainItem setObject:(__bridge id)(kSecAttrAccessibleWhenUnlocked)
                        forKey:(__bridge id)(kSecAttrAccessible)];
}

@end
