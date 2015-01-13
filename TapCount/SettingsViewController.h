//
//  SettingsViewController.h
//  TapCount
//
//  Created by Charles Grier on 10/29/14.
//  Copyright (c) 2014 Grier Mobile Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings.h"
#import "SelectLanguageTableTableViewController.h"
#import "SelectRightLanguageViewController.h"

@class SettingsViewController;

@protocol SettingsViewControllerDelegate <NSObject>

- (void)setSettings:(SettingsViewController *)controller didSelectSettings: (Settings *)settings;

@end

@interface SettingsViewController : UITableViewController <SelectLanguageViewControllerDelegate, SelectRightLanguageViewControllerDelegate>


- (IBAction)vibrateSwitch:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *vibrateSwitchToggle;

- (IBAction)vibrateTenSwitch:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *vibrateTenSwitchToggle;

- (IBAction)speechSwitch:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *speechSwitchToggle;

- (IBAction)soundsSwitch:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *soundsSwitchToggle;

@property (weak, nonatomic) IBOutlet UISlider *leftPitchSlider;
- (IBAction)leftSliderChange:(id)sender;

@property (weak, nonatomic) IBOutlet UISlider *rightPitchSlider;
- (IBAction)rightPitchChange:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *languageNameLeft;
@property (weak, nonatomic) IBOutlet UILabel *languageNameRight;

@property (nonatomic, weak) id<SettingsViewControllerDelegate> delegate;


@property Settings *settings;
@property Language *language;




@end
