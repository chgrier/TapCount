//
//  SettingsViewController.m
//  TapCount
//
//  Created by Charles Grier on 10/29/14.
//  Copyright (c) 2014 Grier Mobile Development. All rights reserved.
//

#import "SettingsViewController.h"
#import "Settings.h"

@interface SettingsViewController ()
{
    
}

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.settings = [[Settings alloc]init];
    self.settings.vibrateOn = YES;
    self.settings.speechOn = YES;
    self.settings.soundOn = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillDisappear:(BOOL)animated
{
     //[self.delegate setSettings:self didSelectSettings:self.settings];
}

// UISWITCH CONTROLS

-(IBAction)vibrateSwitch:(id)sender
{
    
        if ([_vibrateSwitchToggle isOn]) {
        
        self.settings.vibrateOn = YES;
        NSLog(@"Vibrate on");
        
        [self.delegate setSettings:self didSelectSettings:self.settings];
        
        } else {
            
            self.settings.vibrateOn = NO;
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
        self.settings.vibrateOn = YES;
        self.settings.speechOn = YES;
        self.settings.soundOn = YES;
        
        //[self.delegate currencyPicker:self didPickCurrency:currency];
        
        [self.delegate setSettings:self didSelectSettings:self.settings];
        
        [_speechSwitchToggle setOn:YES];
        [_vibrateSwitchToggle setOn:YES];
        
    } else {
        
       self.settings.vibrateOn = NO;
        self.settings.soundOn = NO;
        self.settings.speechOn = NO;
        
        [_speechSwitchToggle setOn:NO];
        [_vibrateSwitchToggle setOn:NO];
        
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

@end
