//
//  SettingsViewController.m
//  TapCount
//
//  Created by Charles Grier on 10/29/14.
//  Copyright (c) 2014 Grier Mobile Development. All rights reserved.
//

#import "SettingsViewController.h"
#import "Settings.h"
#import "Language.h"
#import "SelectLanguageTableTableViewController.h"

@interface SettingsViewController ()
{
    
}

@end

@implementation SettingsViewController

{
    float _leftSliderValue;
}

/*
+ (void) initialize
{
    // NSDictionary *defaults = [NSDictionary dictionaryWithObject:@"en-US" forKey:@"leftLanguageCode"];
    //[[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
    
    NSDictionary *initialDefaults = [NSDictionary dictionaryWithObjectsAndKeys:
                                     @"en-US", @"leftLanguageCode",
                                     @"en-GB", @"rightLanguageCode",
                                     @"English (United States)", @"leftLanguageName",
                                     @"English (United Kingdom)", @"rightLanguageName",
                                     [NSNumber numberWithBool:YES] , @"speechOn",
                                     [NSNumber numberWithBool:NO], @"vibrateOn",
                                     [NSNumber numberWithBool:YES], @"vibrateTenOn",
                                     [NSNumber numberWithBool:YES], @"soundOn",
                                     [NSNumber numberWithFloat:1.0], @"leftPitch",
                                     [NSNumber numberWithFloat:1.0], @"rightPitch",
                                     nil];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:initialDefaults];
    [[NSUserDefaults standardUserDefaults] synchronize];

    
}
 */

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // load defaults for settings
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // -- Speech settings --
    self.language = [[Language alloc]init];
    self.settings = [[Settings alloc]init];
    
    self.settings.speechOn = [defaults boolForKey:@"speechOn"];
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"speechOn"] == YES) {
            [_speechSwitchToggle setOn:YES];
        } else {
            [_speechSwitchToggle setOn:NO];
        }
    
    
    // -- Vibrate settings --
    self.settings.vibrateOn = [defaults boolForKey:@"vibrateOn"];
        if ([defaults boolForKey:@"vibrateOn"] == YES) {
            [_vibrateSwitchToggle setOn:YES];
        } else {
            [_vibrateSwitchToggle setOn:NO];
        }
    
    
    // -- Vibrate on Ten settings --
    self.settings.vibrateTenOn =[defaults boolForKey:@"vibrateTenOn"];
        if ([defaults boolForKey:@"vibrateTenOn"] == YES) {
            [_vibrateTenSwitchToggle setOn:YES];
        } else {
            [_vibrateTenSwitchToggle setOn:NO];
        }
    
    
   // -- Sound settings --

    self.settings.soundOn = [defaults boolForKey:@"soundOn"];
        if ([defaults boolForKey:@"soundOn"] == YES) {
            [_soundsSwitchToggle setOn:YES];
        } else {
            [_soundsSwitchToggle setOn:NO];
        }
    
    // -- Left pitch settings --
    self.settings.leftSliderValue = [defaults floatForKey:@"leftPitch"];
    self.leftPitchSlider.value = [defaults floatForKey:@"leftPitch"];
    NSLog(@"Left slider value: %f", self.leftPitchSlider.value);

    // -- Right pitch settings --
    self.settings.rightSliderValue = [defaults floatForKey:@"rightPitch"];
    self.rightPitchSlider.value = [defaults floatForKey:@"rightPitch"];
    NSLog(@"Right slider value: %f", self.rightPitchSlider.value);
    
    // -- left Language Name and Code --
    self.languageNameLeft.text = [defaults objectForKey:@"leftLanguageName"];
    self.settings.leftLanguageCode = [defaults objectForKey:@"leftLanguageCode"];
    
    // -- right Language Name and Code --
    self.languageNameRight.text = [defaults objectForKey:@"rightLanguageName"];
    self.settings.leftLanguageCode = [defaults objectForKey:@"rightLanguageCode"];
    
    // delegate
    SelectLanguageTableTableViewController *languageViewController = [[SelectLanguageTableTableViewController alloc]init];
    languageViewController.delegate = self;
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
     //[self.delegate setSettings:self didSelectSettings:self.settings];
}

#pragma mark - Select Language Delegate


-(void) setLanguage:(SelectLanguageTableTableViewController *)controller didSelectLanguage:(Language *)language {
    
    
    self.language = [[Language alloc]init];
    self.language = language;
    
    self.languageNameLeft.text = self.language.leftLanguageName;
    self.settings.leftLanguageCode = self.language.leftLanguageCode;
    
    self.languageNameRight.text = self.language.rightLanguageName;
    self.settings.rightLanguageCode = self.language.rightLanguageCode;
    
    NSLog(@"**Language code passed: %@", self.language.leftLanguageCode);
    NSLog(@"**Language code passed: %@", self.language.rightLanguageCode);
    
    
    [self.delegate setSettings:self didSelectSettings:self.settings];
    
    // set defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:self.language.leftLanguageCode forKey:@"leftLanguageCode"];
    [defaults setValue:self.language.leftLanguageName forKey:@"leftLanguageName"];
    [defaults setValue:self.language.rightLanguageCode forKey:@"rightLanguageCode"];
    [defaults setValue:self.language.rightLanguageName forKey:@"rightLanguageName"];
    
    [defaults synchronize];


    
    
}
 /*
  - (IBAction)shareSettingsSwitched:(UISwitch *)sender {
  NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
  if (sender.tag == 0) {
  if (sender.on == 0) {
  [standardDefaults setObject:@"Off" forKey:@"facebookKey"];
  } else if (sender.on == 1) {
  [standardDefaults setObject:@"On" forKey:@"facebookKey"];
  }
  } else if (sender.tag == 1) {
  if (sender.on == 0) {
  [standardDefaults setObject:@"Off" forKey:@"twitterKey"];
  } else if (sender.on == 1) {
  [standardDefaults setObject:@"On" forKey:@"twitterKey"];
  }
  } else if (sender.tag == 2) {
  if (sender.on == 0) {
  [standardDefaults setObject:@"Off" forKey:@"instagramKey"];
  } else if (sender.on == 1) {
  [standardDefaults setObject:@"On" forKey:@"instagramKey"];
  }
  }
  [standardDefaults synchronize];
  }
  
  
  
  NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
  if ([[standardDefaults stringForKey:@"facebookKey"] isEqualToString:@"On"]) {
  self.facebookSwitch.on = YES;
  } else {
  self.facebookSwitch.on = NO;
  }
  if ([[standardDefaults stringForKey:@"twitterKey"] isEqualToString:@"On"]) {
  self.twitterSwitch.on = YES;
  } else {
  self.twitterSwitch.on = NO;
  }
  if ([[standardDefaults stringForKey:@"instagramKey"] isEqualToString:@"On"]) {
  self.instagramSwitch.on = YES;
  } else {
  self.instagramSwitch.on = NO;
  }
  if ([[standardDefaults stringForKey:@"distanceSettingKey"] isEqualToString:@"Miles"]) {
  self.distancesSwitch.selectedSegmentIndex = 1;
  } else {
  self.distancesSwitch.selectedSegmentIndex = 0;
  }
  if ([[standardDefaults stringForKey:@"temperatureSettingKey"] isEqualToString:@"C"]) {
  self.temperatureSwitch.selectedSegmentIndex = 1;
  } else {
  self.temperatureSwitch.selectedSegmentIndex = 0;
  }
  
  
  
  
  
  */

// UISWITCH CONTROLS

-(IBAction)vibrateSwitch:(id)sender
{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    if ([_vibrateSwitchToggle isOn]) {
        
        self.settings.vibrateOn = YES;
        [self.delegate setSettings:self didSelectSettings:self.settings];
        [defaults setBool:YES forKey:@"vibrateOn"];
        [defaults synchronize];
       
    } else if (![_vibrateSwitchToggle isOn]) {
        
        self.settings.vibrateOn = NO;
        [self.delegate setSettings:self didSelectSettings:self.settings];
        [defaults setBool:NO forKey:@"vibrateOn"];
        [defaults synchronize];

    }
            
    
}

-(IBAction)vibrateTenSwitch:(id)sender
{
    
    if ([_vibrateTenSwitchToggle isOn]) {
        
        self.settings.vibrateTenOn = YES;
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool:YES forKey:@"vibrateTenOn"];
        [self.delegate setSettings:self didSelectSettings:self.settings];
        [defaults synchronize];
        
    } else if (![_vibrateTenSwitchToggle isOn]) {
        
        self.settings.vibrateTenOn = NO;
        NSLog(@"Vibrate off");
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"vibrateTenOn"];
        [self.delegate setSettings:self didSelectSettings:self.settings];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

- (IBAction)speechSwitch:(id)sender{
    
    if ([_speechSwitchToggle isOn]) {
        self.settings.speechOn = YES;
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"speechOn"];
        [self.delegate setSettings:self didSelectSettings:self.settings];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } else if (![_speechSwitchToggle isOn]) {
        self.settings.speechOn = NO;
        [self.delegate setSettings:self didSelectSettings:self.settings];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"speechOn"];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

// cast sender as UISwitch (rather than generic id) to create condition
- (IBAction)soundsSwitch:(UISwitch *)sender
{
    if (sender.on){
 
        self.settings.soundOn = YES;
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"soundOn"];
        [self.delegate setSettings:self didSelectSettings:self.settings];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } else {
        
        self.settings.soundOn = NO;
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"soundOn"];
        [self.delegate setSettings:self didSelectSettings:self.settings];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)rightPitchChange:(id)sender {
    float min = 0.5;
    float max = 1.5;
    
    self.rightPitchSlider.minimumValue = min;
    self.rightPitchSlider.maximumValue = max;
    
    //float rightSliderInitValue = [[NSUserDefaults standardUserDefaults] floatForKey:@"rightPitch"];
    //self.rightPitchSlider.value = rightSliderInitValue;
    
    NSLog(@"Right slider value: %f", self.rightPitchSlider.value);
    self.settings.rightSliderValue = self.rightPitchSlider.value;
    
    [[NSUserDefaults standardUserDefaults] setFloat:self.rightPitchSlider.value forKey:@"rightPitch"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self.delegate setSettings:self didSelectSettings:self.settings];
    
}
- (IBAction)leftSliderChange:(id)sender {
    
    float min = 0.5;
    float max = 1.5;
    
    self.leftPitchSlider.minimumValue = min;
    self.leftPitchSlider.maximumValue = max;
    NSLog(@"%f", self.leftPitchSlider.value);
    self.settings.leftSliderValue = self.leftPitchSlider.value;
    
    [self.delegate setSettings:self didSelectSettings:self.settings];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SelectLanguage"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        // 2
        SelectLanguageTableTableViewController *controller = (SelectLanguageTableTableViewController *) navigationController.topViewController;
        // 3
        controller.delegate = self;
}
}


@end
