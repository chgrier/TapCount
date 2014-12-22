//
//  SelectLanguageTableViewController.h
//  TapCount
//
//  Created by Charles Grier on 11/10/14.
//  Copyright (c) 2014 Grier Mobile Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings.h"
#import "Language.h"


@class SelectLanguageTableTableViewController;

@protocol SelectLanguageViewControllerDelegate <NSObject>

- (void)setLanguage:(SelectLanguageTableTableViewController *)controller didSelectLanguage: (Language *)language;

@end

@interface SelectLanguageTableTableViewController : UITableViewController

@property (strong, nonatomic) NSArray *languageCodes;
@property (strong, nonatomic) NSDictionary *languageDictionary;

@property (nonatomic, weak) id<SelectLanguageViewControllerDelegate> delegate;


@property Language *languageSettings;

- (IBAction)cancel:(id)sender;



@end
