//
//  ViewController.m
//  TapCount
//
//  Created by Charles Grier on 9/10/14.
//  Copyright (c) 2014 Grier Mobile Development. All rights reserved.
//

#import "ViewController.h"
//#import <AudioToolbox/AudioToolbox.h>
//#import <AVFoundation/AVFoundation.h>
@import AVFoundation;

@interface ViewController ()

@end


@implementation ViewController
{
   
    
    //Settings *_speechVibrate;
    
    
    SystemSoundID _soundID;
    SystemSoundID _soundIDLeft;
    SystemSoundID _soundIDRight;
    
    AVSpeechSynthesizer *_speechSynthesizer;
    AVSpeechSynthesizer *_speechSynthesizerTwo;
    
}
- (void)viewWillAppear:(BOOL)animated
{
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    SettingsViewController *svc = [self.tabBarController.viewControllers objectAtIndex:2];
    svc.delegate = self;
    
       
    self.allSettings = [[Settings alloc]init];
    
    self.allSettings.speechOn = YES;
    self.allSettings.soundOn = YES;
    self.allSettings.leftSliderValue = 1.0;
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    self.allSettings.leftLanguageCode = [defaults objectForKey:@"leftLanguageCode"];
    BOOL vibrateOn = [defaults boolForKey:@"vibrateOn"];
    
    if ([defaults boolForKey:@"vibrateOn"] != 1 && [defaults boolForKey:@"vibrateOn"] !=0) {
        self.allSettings.vibrateOn = YES;
    } else {
        self.allSettings.vibrateOn = vibrateOn;
    }

   
    _speechSynthesizer = [[AVSpeechSynthesizer alloc]init];
    _speechSynthesizerTwo = [[AVSpeechSynthesizer alloc]init];
    

    
  
    
    AVSpeechUtterance *utteranceTwo = [[AVSpeechUtterance alloc]initWithString:@"Ready"];
    // [_speechSynthesizer speakUtterance:utterance];
    [_speechSynthesizerTwo speakUtterance:utteranceTwo];
    
    [self loadSoundEffect];
    [self loadSoundEffectLeft];
    
    
    
}

-(void) setSettings:(SettingsViewController *)controller didSelectSettings:(Settings *)settings {
    
    // set selected code passed from settings controls to code object
    self.allSettings = [[Settings alloc]init];
    
    self.allSettings.vibrateOn = settings.vibrateOn;
    self.allSettings.vibrateTenOn = settings.vibrateTenOn;
    self.allSettings.speechOn = settings.speechOn;
    self.allSettings.soundOn = settings.soundOn;
    self.allSettings.leftSliderValue = settings.leftSliderValue;
    self.allSettings.rightSliderValue = settings.rightSliderValue;
    self.allSettings.leftLanguageCode = settings.leftLanguageCode;
    self.allSettings.rightLanguageCode = settings.rightLanguageCode;
    
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:settings.leftLanguageCode forKey:@"leftLanguageCode"];
    [defaults setValue:settings.leftLanguageName forKey:@"leftLanguageName"];
    [defaults setBool:settings.vibrateOn forKey:@"vibrateOn"];
    [defaults setBool:settings.vibrateOn forKey:@"vibrateTenOn"];
    [defaults setBool:settings.vibrateOn forKey:@"speechOn"];
    [defaults setBool:settings.vibrateOn forKey:@"soundOn"];
    [defaults setFloat:settings.leftSliderValue forKey:@"leftPitch"];
    [defaults setFloat:settings.rightSliderValue forKey:@"rightPitch"];
    [defaults synchronize];
        
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    //[self unloadSoundEffect];
    //_speechOn = NO;
}


- (BOOL)stopSpeakingAtBoundary:(AVSpeechBoundary)boundary{
    
    return YES;
}


-(IBAction)increment:(id)sender
{
   
    total++;
    [screen setText:[NSString stringWithFormat:@"%ld", (long)total]];
    
    [self updateTextWithAnimation];
   
    NSString *count = [NSString stringWithFormat:@"%ld",(long)total];
    
    static AVSpeechUtterance *utterance;
    utterance = [[AVSpeechUtterance alloc]initWithString:count];
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:self.allSettings.leftLanguageCode];
    
    // *** class method alternative ***
    //[_speechSynthesizer speakUtterance:[AVSpeechUtterance speechUtteranceWithString:count]];
    
    if (self.allSettings.speechOn == YES) {
       
        int a;
        a = total;
        int b;
        b = 10;
        
        
        if ( a % b == 0){
            AudioServicesPlayAlertSound (kSystemSoundID_Vibrate);
            
            NSString *count = [NSString stringWithFormat:@"%ld",(long)total];
            //NSString *count = [NSString stringWithFormat:@"Blasts"];
            
            
            AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:count];
            
            [_speechSynthesizer speakUtterance:utterance];
        } else {

            
            
    utterance.rate = AVSpeechUtteranceMinimumSpeechRate + ((AVSpeechUtteranceMaximumSpeechRate - AVSpeechUtteranceMinimumSpeechRate) * 0.5f);
    utterance.volume = 1.0f;
    //utterance.pitchMultiplier = 1.2f;
    utterance.pitchMultiplier = self.allSettings.leftSliderValue;
    NSLog(@"Pitch multiplier = %f", self.allSettings.leftSliderValue);
    //utterance.postUtteranceDelay = 0.0;
    utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:self.allSettings.leftLanguageCode];
    
    [_speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    
    [_speechSynthesizer speakUtterance:utterance];
    
    }
    }
    
    if (self.allSettings.vibrateOn == YES) {
        AudioServicesPlayAlertSound (kSystemSoundID_Vibrate);
    }
    
    if (self.allSettings.speechOn == NO && self.allSettings.soundOn == YES) {
        [self playSoundEffectLeft];
    }
    
    //if (self.allSettings.soundOn == YES) {
     //      }
    
   
}

-(IBAction)incrementTwo:(id)sender
{
    totalTwo++;
    [screenTwo setText:[NSString stringWithFormat:@"%ld", (long)totalTwo]];
    
    [self updateTextWithAnimation];
    
    NSString *count = [NSString stringWithFormat:@"%ld",(long)totalTwo];
    
    static AVSpeechUtterance *utterance;
    utterance = [[AVSpeechUtterance alloc]initWithString:count];
    //utterance.voice = nil;
    //utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:self.allSettings.rightLanguageCode];
    
    
    // *** class method alternative ***
    //[_speechSynthesizer speakUtterance:[AVSpeechUtterance speechUtteranceWithString:count]];
    
    if (self.allSettings.speechOn == YES) {
        
        int a;
        a = totalTwo;
        int b;
        b = 10;
        
        
        if ( a % b == 0){
            AudioServicesPlayAlertSound (kSystemSoundID_Vibrate);
            
            NSString *count = [NSString stringWithFormat:@"%ld",(long)totalTwo];
            //NSString *count = [NSString stringWithFormat:@"Blasts"];
            
            
            AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:count];

            
            [_speechSynthesizer speakUtterance:utterance];
            
        } else {
            
            // lower pitch for column two
            utterance.rate = AVSpeechUtteranceMinimumSpeechRate + ((AVSpeechUtteranceMaximumSpeechRate - AVSpeechUtteranceMinimumSpeechRate) * 0.5f);
            utterance.volume = 1.0f;
            //utterance.pitchMultiplier = 0.6f;
            //utterance.postUtteranceDelay = 0.0;
            //utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:self.allSettings.rightLanguageCode];
            
            [_speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
            
            [_speechSynthesizer speakUtterance:utterance];
            
            
            
            
            
            
            
        }
    }
    
    if (self.allSettings.vibrateOn == YES) {
        AudioServicesPlayAlertSound (kSystemSoundID_Vibrate);
    }
    
    //if (self.allSettings.soundOn == YES) {
    //}
    
    
}

-(IBAction)decrement:(id)sender
{
    total--;
    [screen setText:[NSString stringWithFormat:@"%ld", (long)total]];
    

    if (self.allSettings.soundOn == YES) {
        [self playSoundEffect];
    }
    
   
}

-(IBAction)decrementTwo:(id)sender
{
    totalTwo--;
    [screenTwo setText:[NSString stringWithFormat:@"%ld", (long)totalTwo]];
   
    if (self.allSettings.soundOn == YES) {
        [self playSoundEffect];
    }

}

// alert when tap clear button. If Yes, then go to didDismissWithButtonIndex method
-(IBAction)clear:(id)sender
{
    
    if (self.allSettings.speechOn == YES) {
    [_speechSynthesizer speakUtterance:[AVSpeechUtterance speechUtteranceWithString:@"Do you really want to clear the total?"]];
    }
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Clear Total?"
                                                       message:@"Do you really want to clear the total?"
                                                      delegate:self cancelButtonTitle:@"Yes"
                                             otherButtonTitles:@"Cancel", nil];
    
    
    [alertView show];

}


- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    // first button clears total
    if (buttonIndex == 0)
    {
        [self clearTotal];
        
    // other buttons just return and data is not cleared
    } else {
        return;
    }
    
}



-(void) clearTotal
{
    total = 0;
    totalTwo = 0;
    [screen setText:[NSString stringWithFormat:@"%ld", (long)total]];
    [screenTwo setText:[NSString stringWithFormat:@"%ld", (long)totalTwo]];
    
    if (self.allSettings.speechOn == YES) {
        [_speechSynthesizer speakUtterance:[AVSpeechUtterance speechUtteranceWithString:@"Okay"]];
    }

    
}


- (IBAction)sayTotal:(UIButton *)totalButton {
    if (self.allSettings.speechOn == YES) {
       
        if (totalButton.tag == 100) {
            NSString *count = [NSString stringWithFormat:@"Left TOTAL IS %ld",(long)total];
            AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:count];
        
            [_speechSynthesizer speakUtterance:utterance];
        }
        
        if (totalButton.tag == 101) {
                NSString *count = [NSString stringWithFormat:@"Right TOTAL IS %ld",(long)totalTwo];
                AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:count];
                utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-us"];
                [_speechSynthesizer speakUtterance:utterance];
            }

    }
    
}

- (void) updateTextWithAnimation
{
    
    CATransition *transition = [CATransition animation];
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromTop;
    
    transition.duration = .2;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    
    [screen.layer addAnimation:transition forKey:nil];
}

#pragma mark - Sounds Effects

- (void)loadSoundEffect
{
   
    NSString *path = [[NSBundle mainBundle]pathForResource:@"crisp.caf" ofType:nil];
    
    NSURL *fileURL = [NSURL fileURLWithPath:path isDirectory:NO];
    if (fileURL == nil) {
        NSLog(@"NSURL is nil");
        return;
    }
    OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &_soundID);
    
    if (error != kAudioServicesNoError) {
       // NSLog(@"Error code %ld loading sound at path: %@", error, path);
        
        return;
    }
}

- (void)loadSoundEffectLeft
{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Sound.caf" ofType:nil];
    
    NSURL *fileURL = [NSURL fileURLWithPath:path isDirectory:NO];
    if (fileURL == nil) {
        NSLog(@"NSURL is nil");
        return;
    }
    OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &_soundIDLeft);
    
    if (error != kAudioServicesNoError) {
        // NSLog(@"Error code %ld loading sound at path: %@", error, path);
        
        return;
    }
}

- (void) unloadSoundEffect
{
    AudioServicesDisposeSystemSoundID(_soundID);
    _soundID = 0;
}

- (void)playSoundEffect
{
    AudioServicesPlaySystemSound(_soundID);
}

- (void)playSoundEffectLeft
{
    AudioServicesPlaySystemSound(_soundIDLeft);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"SaveReport"]) {
       
        UINavigationController *navigationController = segue.destinationViewController;
        
        ReportDetailViewController *controller = (ReportDetailViewController *)navigationController.topViewController;
        
        controller.countTotalOne = total;
        controller.countTotalTwo = totalTwo;
        controller.managedObjectContext = self.managedObjectContext;
        
        
    }
    
    
    if ([segue.identifier isEqualToString:@"EmailReport"]) {
        
        //ReportViewController *reportViewController = segue.destinationViewController;
        //[reportViewController setManagedObjectContext:self.managedObjectContext];
        
        UINavigationController *navigationController = segue.destinationViewController;
        
        ReportViewController *controller = (ReportViewController *)navigationController.topViewController;
        
        controller.managedObjectContext = self.managedObjectContext;
        
        
    }
    
}


#pragma mark Delegate Callback Method
/*
-(void)currencyPicker:(CurrencyPickerViewController *)controller didPickCurrency:(Currency *)currencyCode{
    
    // set selected code passed from picker to code object
    self.code = currencyCode;
    
    
    // set field names for 'from currency'
    self.fromCurrencyCodeField.text = self.code.fromCodeName;
    self.fromCurrencyCodeFieldTwo.text = self.code.fromCodeName;
    self.fromCurrencyFullNameField.text = self.code.fromFullName;
*/








@end
