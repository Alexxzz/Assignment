//
//  AZWebViewController.h
//  Assignment
//
//  Created by Alexander Zagorsky on 8/14/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AZWebViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UITextField *addressField;

- (IBAction)onControllPressed:(id)sender;
- (IBAction)onRevealLeftMenu:(id)sender;

@end
