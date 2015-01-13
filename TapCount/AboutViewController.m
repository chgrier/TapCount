//
//  AboutViewController.m
//  Lab Counter
//
//  Created by Charles Grier on 1/12/15.
//  Copyright (c) 2015 Grier Mobile Development. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *htmlFile = [[NSBundle mainBundle]pathForResource:@"AboutLabCounter" ofType:@"html"];
    
    NSData *htmlData = [NSData dataWithContentsOfFile:htmlFile];
    
    NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle]bundlePath]];
    
    [self.webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseURL];
    
}

// open links in Safari rather than UIWebView
-(BOOL) webView:(UIWebView *)inWeb shouldStartLoadWithRequest:(NSURLRequest *)inRequest navigationType:(UIWebViewNavigationType)inType {
    if ( inType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[inRequest URL]];
        return NO;
    }
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    
}



@end
