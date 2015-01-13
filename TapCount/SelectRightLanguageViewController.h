//
//  SelectRightLanguageViewController.h
//  Lab Counter
//
//  Created by Charles Grier on 1/12/15.
//  Copyright (c) 2015 Grier Mobile Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings.h"
#import "Language.h"


@class SelectRightLanguageViewController;

@protocol SelectRightLanguageViewControllerDelegate <NSObject>

- (void)setRightLanguage:(SelectRightLanguageViewController *)controller didSelectLanguage: (Language *)language;

@end

@interface SelectRightLanguageViewController : UITableViewController

@property (strong, nonatomic) NSArray *languageCodes;
@property (strong, nonatomic) NSDictionary *languageDictionary;

@property (nonatomic, weak) id<SelectRightLanguageViewControllerDelegate> delegate;


@property Language *languageSettings;

- (IBAction)cancel:(id)sender;



@end
