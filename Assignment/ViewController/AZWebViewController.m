//
//  AZWebViewController.m
//  Assignment
//
//  Created by Alexander Zagorsky on 8/14/13.
//  Copyright (c) 2013 az. All rights reserved.
//

#import "AZWebViewController.h"

static NSString *kBaseUrl = @"http://www.m2mobi.com";
static NSString *kHttpPrefix = @"http://";
static NSString *kHttpsPrefix = @"https://";

@interface AZWebViewController () <UITextFieldDelegate, UIWebViewDelegate>

@end

@implementation AZWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [self openUrlString:kBaseUrl];
}

- (void)viewDidUnload {
    [self setWebView:nil];
    [self setAddressField:nil];
    [super viewDidUnload];
}

- (void)openUrlString:(NSString *)urlStr {
    if ([urlStr hasPrefix:kHttpPrefix] == NO && [urlStr hasPrefix:kHttpsPrefix] == NO)
        urlStr = [kHttpPrefix stringByAppendingString:urlStr];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
    [self.webView loadRequest:request];
}

#pragma mark - IBActions
- (IBAction)onControllPressed:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 0:
            [self.webView goBack];
            break;
            
        case 1:
            [self.webView goForward];
            break;
            
        case 2:
            [self.webView reload];
            break;
    }
}

- (IBAction)onRevealLeftMenu:(UIBarButtonItem *)sender {
    [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self openUrlString:textField.text];
    [textField resignFirstResponder];
    
    return YES;
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.addressField.text = [[webView.request URL] absoluteString];
}

@end
