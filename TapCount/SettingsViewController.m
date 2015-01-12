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
    
    [self.tableView reloadData];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


#pragma mark - Select Language Delegate

-(void) setLanguage:(SelectLanguageTableTableViewController *)controller didSelectLanguage:(Language *)language {
    
    //self.languageSettings = [[Settings alloc]init];
    //self.languageSettings.leftLanguageCode = language.leftLanguageCode;
    
    self.language = [[Language alloc]init];
    self.language = language;
    
    self.languageNameLeft.text = self.language.leftLanguageName;
    self.settings.leftLanguageCode = self.language.leftLanguageCode;
    
    
    
    NSLog(@"**Language code passed: %@", self.language.leftLanguageCode);
   
    [self.delegate setSettings:self didSelectSettings:self.settings];
    
    // set defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:language.leftLanguageCode forKey:@"leftLanguageCode"];
    [defaults setValue:language.leftLanguageName forKey:@"leftLanguageName"];
    [defaults setValue:language.rightLanguageCode forKey:@"rightLanguageCode"];
    [defaults setValue:language.rightLanguageName forKey:@"rightLanguageName"];
    
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
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([_vibrateTenSwitchToggle isOn]) {
        
        self.settings.vibrateTenOn = YES;
        NSLog(@"Vibrate on");
        
        [self.delegate setSettings:self didSelectSettings:self.settings];
        [defaults setBool:self.settings.vibrateTenOn forKey:@"vibrateTenOn"];

        
    } else {
        
        self.settings.vibrateTenOn = NO;
        NSLog(@"Vibrate off");
        [self.delegate setSettings:self didSelectSettings:self.settings];
        [defaults setBool:self.settings.vibrateTenOn forKey:@"vibrateTenOn"];
    }
}

- (IBAction)speechSwitch:(id)sender{
    
    if ([_speechSwitchToggle isOn]) {
        self.settings.speechOn = YES;
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"speechOn"];
        [self.delegate setSettings:self didSelectSettings:self.settings];
        
        
    } else {
        self.settings.speechOn = NO;
         [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"speechOn"];
        [self.delegate setSettings:self didSelectSettings:self.settings];
        
        }
}

// cast sender as UISwitch (rather than generic id) to create condition
- (IBAction)soundsSwitch:(UISwitch *)sender
{
    if (sender.on){
        self.settings.soundOn = YES;
    
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"soundOn"];
        [self.delegate setSettings:self didSelectSettings:self.settings];
        
    } else {
        self.settings.soundOn = NO;

        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"soundOn"];
        [self.delegate setSettings:self didSelectSettings:self.settings];
        
    }
    
}

- (IBAction)rightPitchChange:(id)sender {
    float min = 0.5;
    float max = 1.5;
    
    self.rightPitchSlider.minimumValue = min;
    self.rightPitchSlider.maximumValue = max;
    
    [[NSUserDefaults standardUserDefaults] setFloat:self.rightPitchSlider.value forKey:@"rightPitch"];
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
    
    [[NSUserDefaults standardUserDefaults] setFloat:self.leftPitchSlider.value forKey:@"leftPitch"];
    [self.delegate setSettings:self didSelectSettings:self.settings];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"SelectLanguage"]) {
        
        UINavigationController *navigationController = segue.destinationViewController;
        SelectLanguageTableTableViewController *controller = (SelectLanguageTableTableViewController *) navigationController.topViewController;
        controller.delegate = self;
    }
}


@end


