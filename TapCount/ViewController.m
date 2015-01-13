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
    SystemSoundID _soundIDIncrementLeft;
    SystemSoundID _soundIDIncrementRight;
    SystemSoundID _soundIDDecrementLeft;
    SystemSoundID _soundIDDecrementRight;
    
    AVSpeechSynthesizer *_speechSynthesizer;
    AVSpeechSynthesizer *_speechSynthesizerTwo;
    
}

+ (void) initialize
{
   // NSDictionary *defaults = [NSDictionary dictionaryWithObject:@"en-US" forKey:@"leftLanguageCode"];
    //[[NSUserDefaults standardUserDefaults] registerDefaults:defaults];

    if([[NSUserDefaults standardUserDefaults] objectForKey:@"speechOn"] == nil) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"speechOn"];
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"vibrateOn"] == nil) {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"vibrateOn"];
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"vibrateTenOn"] == nil) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"vibrateTenOn"];
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"soundOn"] == nil) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"soundOn"];
    }

    if([[NSUserDefaults standardUserDefaults] objectForKey:@"leftLanguageCode"] == nil) {
        [[NSUserDefaults standardUserDefaults] setValue:@"en-US" forKey:@"leftLanguageCode"];
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"leftLanguageName"] == nil) {
        [[NSUserDefaults standardUserDefaults] setValue:@"English (United States)" forKey:@"leftLanguageName"];
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"rightLanguageCode"] == nil) {
        [[NSUserDefaults standardUserDefaults] setValue:@"en-GB" forKey:@"rightLanguageCode"];
    }
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"rightLanguageName"] == nil) {
        [[NSUserDefaults standardUserDefaults] setValue:@"English (United Kingdom)" forKey:@"rightLanguageName"];
    }

    if([[NSUserDefaults standardUserDefaults] objectForKey:@"leftPitch"] == nil) {
        [[NSUserDefaults standardUserDefaults] setFloat:1.0 forKey:@"leftPitch"];
    }

    if([[NSUserDefaults standardUserDefaults] objectForKey:@"rightPitch"] == nil) {
        [[NSUserDefaults standardUserDefaults] setFloat:1.0 forKey:@"rightPitch"];
    }


    /* -- initial defaults will always initialize --
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
     
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:initialDefaults];
}
*/
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    SettingsViewController *svc = [self.tabBarController.viewControllers objectAtIndex:2];
    svc.delegate = self;
    
    self.allSettings = [[Settings alloc]init];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    self.allSettings.leftLanguageCode = [defaults objectForKey:@"leftLanguageCode"];
    self.allSettings.rightLanguageCode = [defaults objectForKey:@"rightLanguageCode"];
    NSLog(@"***Language Codes in ViewDidLoad: Left=%@, Right=%@", self.allSettings.leftLanguageCode, self.allSettings.rightLanguageCode);
    
    self.allSettings.speechOn = [defaults boolForKey:@"speechOn"];
    NSLog(@"***SpeechOn setting in ViewDidLoad:%i", self.allSettings.speechOn);
    
    self.allSettings.vibrateOn = [defaults boolForKey:@"vibrateOn"];
    NSLog(@"***VibrateOn setting in ViewDidLoad:%i", self.allSettings.vibrateOn);
    
    self.allSettings.vibrateTenOn = [defaults boolForKey:@"vibrateTenOn"];
    NSLog(@"***VibrateTenOn setting in ViewDidLoad:%i", self.allSettings.vibrateOn);
    
    self.allSettings.soundOn = [defaults boolForKey:@"soundOn"];
    NSLog(@"***SoundOn setting in ViewDidLoad:%i", self.allSettings.soundOn);
    
    self.allSettings.leftSliderValue = [defaults floatForKey:@"leftPitch"];
    NSLog(@"***Left Pitch setting in ViewDidLoad:%f", self.allSettings.leftSliderValue);
    
    self.allSettings.rightSliderValue = [defaults floatForKey:@"rightPitch"];
    NSLog(@"***Right Pitch setting in ViewDidLoad:%f", self.allSettings.rightSliderValue);
    
    
    _speechSynthesizer = [[AVSpeechSynthesizer alloc]init];
    _speechSynthesizerTwo = [[AVSpeechSynthesizer alloc]init];
    
    if (self.allSettings.speechOn == YES) {
    AVSpeechUtterance *utteranceTwo = [[AVSpeechUtterance alloc]initWithString:@"Ready"];
    // [_speechSynthesizer speakUtterance:utterance];
    [_speechSynthesizerTwo speakUtterance:utteranceTwo];
    }
    
    [self loadSoundEffectIncrementLeft];
    [self loadSoundEffectIncrementRight];
    [self loadSoundEffectDecrementLeft];
    [self loadSoundEffectDecrementRight];

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
    
    if (self.allSettings.speechOn == YES) {
        static AVSpeechUtterance *utterance;
        utterance = [[AVSpeechUtterance alloc]initWithString:count];
    
        // *** class method alternative ***
        //[_speechSynthesizer speakUtterance:[AVSpeechUtterance speechUtteranceWithString:count]];
    
        utterance.rate = AVSpeechUtteranceMinimumSpeechRate + ((AVSpeechUtteranceMaximumSpeechRate - AVSpeechUtteranceMinimumSpeechRate) * 0.5f);
        utterance.volume = 1.0f;
        utterance.pitchMultiplier = self.allSettings.leftSliderValue;
        //utterance.postUtteranceDelay = 0.0;
        utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:self.allSettings.leftLanguageCode];
    
        [_speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    
        [_speechSynthesizer speakUtterance:utterance];
    }
    
    if (self.allSettings.vibrateTenOn == YES) {
       
        int a;
        a = total;
        int b;
        b = 10;
        
     
        if ( a % b == 0){
            AudioServicesPlayAlertSound (kSystemSoundID_Vibrate);
  
        }
    }
    
    
    if (self.allSettings.vibrateOn == YES) {
        AudioServicesPlayAlertSound (kSystemSoundID_Vibrate);
    }
    
    if (self.allSettings.speechOn == NO && self.allSettings.soundOn == YES) {
        [self playSoundEffectIncrementLeft];
    }
    
}

-(IBAction)incrementTwo:(id)sender
{
    totalTwo++;
    [screenTwo setText:[NSString stringWithFormat:@"%ld", (long)totalTwo]];
    
    [self updateTextWithAnimation];
    
    NSString *count = [NSString stringWithFormat:@"%ld",(long)totalTwo];
    
    if (self.allSettings.speechOn == YES) {
        
        static AVSpeechUtterance *utterance;
        utterance = [[AVSpeechUtterance alloc]initWithString:count];
        utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:self.allSettings.rightLanguageCode];
        utterance.volume = 1.0f;
        utterance.pitchMultiplier = self.allSettings.rightSliderValue;
        
        [_speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
        [_speechSynthesizer speakUtterance:utterance];
        
    }
    
    if (self.allSettings.vibrateTenOn == YES) {
        
        int a;
        a = totalTwo;
        int b;
        b = 10;
        
        
        if ( a % b == 0){
            AudioServicesPlayAlertSound (kSystemSoundID_Vibrate);
            
        }
    }
    
    
    if (self.allSettings.vibrateOn == YES) {
        AudioServicesPlayAlertSound (kSystemSoundID_Vibrate);
    }
    
    if (self.allSettings.speechOn == NO && self.allSettings.soundOn == YES) {
        [self playSoundEffectIncrementRight];
    }
    
}

-(IBAction)decrement:(id)sender
{
    total--;
    [screen setText:[NSString stringWithFormat:@"%ld", (long)total]];
    

    if (self.allSettings.soundOn == YES) {
        [self playSoundEffectDecrementLeft];
    }
    
   
}

-(IBAction)decrementTwo:(id)sender
{
    totalTwo--;
    [screenTwo setText:[NSString stringWithFormat:@"%ld", (long)totalTwo]];
   
    if (self.allSettings.soundOn == YES) {
        [self playSoundEffectDecrementRight];
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

- (void)loadSoundEffectIncrementLeft
{
   
    NSString *path = [[NSBundle mainBundle]pathForResource:@"crisp.caf" ofType:nil];
    
    NSURL *fileURL = [NSURL fileURLWithPath:path isDirectory:NO];
    if (fileURL == nil) {
        NSLog(@"NSURL is nil");
        return;
    }
    OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &_soundIDIncrementLeft);
    
    if (error != kAudioServicesNoError) {
       // NSLog(@"Error code %ld loading sound at path: %@", error, path);
        
        return;
    }
}

- (void)loadSoundEffectIncrementRight
{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"professional.caf" ofType:nil];
    
    NSURL *fileURL = [NSURL fileURLWithPath:path isDirectory:NO];
    if (fileURL == nil) {
        NSLog(@"NSURL is nil");
        return;
    }
    OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &_soundIDIncrementRight);
    
    if (error != kAudioServicesNoError) {
        // NSLog(@"Error code %ld loading sound at path: %@", error, path);
        
        return;
    }
}

- (void)loadSoundEffectDecrementLeft
{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"scissors.caf" ofType:nil];
    
    NSURL *fileURL = [NSURL fileURLWithPath:path isDirectory:NO];
    if (fileURL == nil) {
        NSLog(@"NSURL is nil");
        return;
    }
    OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &_soundIDDecrementLeft);
    
    if (error != kAudioServicesNoError) {
        // NSLog(@"Error code %ld loading sound at path: %@", error, path);
        
        return;
    }
}

- (void)loadSoundEffectDecrementRight
{
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"network.caf" ofType:nil];
    
    NSURL *fileURL = [NSURL fileURLWithPath:path isDirectory:NO];
    if (fileURL == nil) {
        NSLog(@"NSURL is nil");
        return;
    }
    OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &_soundIDDecrementRight);
    
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

- (void)playSoundEffectIncrementLeft
{
    AudioServicesPlaySystemSound(_soundIDIncrementLeft);
}

- (void)playSoundEffectIncrementRight
{
    AudioServicesPlaySystemSound(_soundIDIncrementRight);

}


- (void)playSoundEffectDecrementLeft
{
    AudioServicesPlaySystemSound(_soundIDDecrementLeft);
}

- (void)playSoundEffectDecrementRight
{
    AudioServicesPlaySystemSound(_soundIDDecrementRight);
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


@end
