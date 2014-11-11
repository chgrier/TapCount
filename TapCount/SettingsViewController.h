//
//  SettingsViewController.h
//  TapCount
//
//  Created by Charles Grier on 10/29/14.
//  Copyright (c) 2014 Grier Mobile Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings.h"

@class SettingsViewController;

@protocol SettingsViewControllerDelegate <NSObject>

- (void)setSettings:(SettingsViewController *)controller didSelectSettings: (Settings *)settings;

@end

@interface SettingsViewController : UITableViewController


- (IBAction)vibrateSwitch:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *vibrateSwitchToggle;

- (IBAction)speechSwitch:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *speechSwitchToggle;

- (IBAction)soundsSwitch:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *soundsSwitchToggle;

@property (weak, nonatomic) IBOutlet UISlider *leftPitchSlider;
- (IBAction)leftSliderChange:(id)sender;


@property (weak, nonatomic) IBOutlet UISlider *rightPitch;
- (IBAction)rightPitchSlider:(id)sender;



@property (nonatomic, weak) id<SettingsViewControllerDelegate> delegate;

@property Settings *settings;

@end
