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

- (void)viewDidLoad {
    [super viewDidLoad];
   
    // load defaults for settings
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    // -- Speech settings --
    self.language = [[Language alloc]init];
    self.settings = [[Settings alloc]init];
    
    self.settings.speechOn = [defaults boolForKey:@"speechOn"];
        if (self.settings.speechOn == YES) {
            [_speechSwitchToggle setOn:YES];
        } else {
            [_speechSwitchToggle setOn:NO];
        }
    
    
    // -- Vibrate settings --
    self.settings.vibrateOn = [defaults boolForKey:@"vibrateOn"];
        if (self.settings.vibrateOn == YES) {
            [_vibrateSwitchToggle setOn:YES];
        } else {
            [_vibrateSwitchToggle setOn:NO];
        }
    
    
    // -- Vibrate on Ten settings --
    self.settings.vibrateTenOn =[defaults boolForKey:@"vibrateTenOn"];
        if (self.settings.vibrateTenOn == YES) {
            [_vibrateTenSwitchToggle setOn:YES];
        } else {
            [_vibrateTenSwitchToggle setOn:NO];
        }
    
    
   // -- Sound settings --

    self.settings.soundOn = [defaults boolForKey:@"soundOn"];
        if (self.settings.soundOn == YES) {
            [_soundsSwitchToggle setOn:YES];
        } else {
            [_soundsSwitchToggle setOn:NO];
        }
    
    // -- Left pitch settings --
    self.settings.leftSliderValue = [defaults floatForKey:@"leftPitch"];
    self.leftPitchSlider.value = self.settings.leftSliderValue;
    
    // -- Right pitch settings --
    self.settings.rightSliderValue = [defaults floatForKey:@"leftPitch"];
    self.rightPitchSlider.value = self.settings.rightSliderValue;
    
    // -- left Language Code --
    self.languageNameLeft.text = [defaults objectForKey:@"leftLanguageName"];
    self.settings.leftLanguageCode = [defaults objectForKey:@"leftLanguageCode"];
    
    // -- right Language Code --
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
 
 
// UISWITCH CONTROLS

-(IBAction)vibrateSwitch:(id)sender
{
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([_vibrateSwitchToggle isOn]) {
        
        self.settings.vibrateOn = YES;
        NSLog(@"Vibrate on");
        
        [self.delegate setSettings:self didSelectSettings:self.settings];
            [defaults setBool:self.settings.vibrateOn forKey:@"vibrateOn"];
        } else {
            
            self.settings.vibrateOn = NO;
            NSLog(@"Vibrate off");
       [self.delegate setSettings:self didSelectSettings:self.settings];
            [defaults setBool:self.settings.vibrateOn forKey:@"vibrateOn"];

            
    }
}

-(IBAction)vibrateTenSwitch:(id)sender
{
    
    if ([_vibrateTenSwitchToggle isOn]) {
        
        self.settings.vibrateTenOn = YES;
        NSLog(@"Vibrate on");
        
        [self.delegate setSettings:self didSelectSettings:self.settings];
        
    } else {
        
        self.settings.vibrateTenOn = NO;
        NSLog(@"Vibrate off");
        [self.delegate setSettings:self didSelectSettings:self.settings];
        
        
    }
}

- (IBAction)speechSwitch:(id)sender{
    
    if ([_speechSwitchToggle isOn]) {
        self.settings.speechOn = YES;
        [_soundsSwitchToggle setOn:YES];
        
        
        [self.delegate setSettings:self didSelectSettings:self.settings];
        
    } else {
        self.settings.speechOn = NO;
        [self.delegate setSettings:self didSelectSettings:self.settings];
        if (![_vibrateSwitchToggle isOn])
        {
            [_soundsSwitchToggle setOn:NO];
            
        }
    }
}

// cast sender as UISwitch (rather than generic id) to create condition
- (IBAction)soundsSwitch:(UISwitch *)sender
{
    if (sender.on){
        //self.settings.vibrateOn = YES;
        //self.settings.speechOn = YES;
        self.settings.soundOn = YES;
        
        //[self.delegate currencyPicker:self didPickCurrency:currency];
        
        [self.delegate setSettings:self didSelectSettings:self.settings];
        
        //[_speechSwitchToggle setOn:YES];
       // [_vibrateSwitchToggle setOn:YES];
        
    } else {
        
       //self.settings.vibrateOn = NO;
        self.settings.soundOn = NO;
        //self.settings.speechOn = NO;
        
        //[_speechSwitchToggle setOn:NO];
        //[_vibrateSwitchToggle setOn:NO];
        
        [self.delegate setSettings:self didSelectSettings:self.settings];
        
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
    
    
    self.settings.RightSliderValue = self.rightPitchSlider.value;
    
    [self.delegate setSettings:self didSelectSettings:self.settings];
    
}
- (IBAction)leftSliderChange:(id)sender {
    
    float min = 0.5;
    float max = 1.5;
    
    self.leftPitchSlider.minimumValue = min;
    self.leftPitchSlider.maximumValue = max;
    NSLog(@"%f", self.leftPitchSlider.value);
    
    self.settings.LeftSliderValue = self.leftPitchSlider.value;
    
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
