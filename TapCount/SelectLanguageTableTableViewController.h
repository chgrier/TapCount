//
//  SelectLanguageTableTableViewController.h
//  TapCount
//
//  Created by Charles Grier on 11/10/14.
//  Copyright (c) 2014 Grier Mobile Development. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectLanguageTableTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *languageCodes;
@property (strong, nonatomic) NSDictionary *languageDictionary;

@end
