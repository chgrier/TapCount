//
//  AboutViewController.h
//  Lab Counter
//
//  Created by Charles Grier on 1/12/15.
//  Copyright (c) 2015 Grier Mobile Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;

- (IBAction)close;

@end
