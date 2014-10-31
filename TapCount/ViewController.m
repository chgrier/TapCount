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
    BOOL _vibrate;
    BOOL _soundOn;
    BOOL _speechOn;
    
    //Settings *_speechVibrate;
    
    
    SystemSoundID _soundID;
    
    AVSpeechSynthesizer *_speechSynthesizer;
    AVSpeechSynthesizer *_speechSynthesizerTwo;
    
}
- (void)viewWillAppear:(BOOL)animated
{
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
   // _vibrate = YES;
    
     _speechSynthesizer = [[AVSpeechSynthesizer alloc]init];
    _speechSynthesizerTwo = [[AVSpeechSynthesizer alloc]init];
    
    _vibrate = YES;
    _speechOn = YES;
    _soundOn = YES;
    
    
    
    
    
    //self.allSettings = [[Settings alloc]init];
    
    //self.allSettings.vibrateOn = YES;
   //self.allSettings.speechOn = YES;
    //self.allSettings.soundOn = YES;
    
    
   // AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:@"Ready"];
    AVSpeechUtterance *utteranceTwo = [[AVSpeechUtterance alloc]initWithString:@"Ready"];
    // [_speechSynthesizer speakUtterance:utterance];
    [_speechSynthesizerTwo speakUtterance:utteranceTwo];
    
    [self loadSoundEffect];
    
    _britishVoice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-gb"];
    
}

-(void) setSettings:(SettingsViewController *)controller didSelectSettings:(Settings *)settings {
    
    // set selected code passed from settings controls to code object
    
    //self.allSettings = [[Settings alloc]init];
    self.allSettings.vibrateOn = settings;
    
    
    
    
        
        
        
        
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
    
    // *** class method alternative ***
    //[_speechSynthesizer speakUtterance:[AVSpeechUtterance speechUtteranceWithString:count]];
    
    if (self.allSettings.speechOn == YES) {
       
        int a;
        a = total;
        int b;
        b = 10;
        
        
        if ( a % b == 0){
            AudioServicesPlayAlertSound (kSystemSoundID_Vibrate);
            
            NSString *count = [NSString stringWithFormat:@"%ld Blasts",(long)total];
            //NSString *count = [NSString stringWithFormat:@"Blasts"];
            
            
            AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:count];
            
            [_speechSynthesizer speakUtterance:utterance];
        } else {

    utterance.rate = AVSpeechUtteranceMinimumSpeechRate + ((AVSpeechUtteranceMaximumSpeechRate - AVSpeechUtteranceMinimumSpeechRate) * 0.5f);
    utterance.volume = 1.0f;
    utterance.pitchMultiplier = 1.2f;
    //utterance.postUtteranceDelay = 0.0;
    //utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-us"];
    
    [_speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    
    [_speechSynthesizer speakUtterance:utterance];
    
    }
    }
    
    if (self.allSettings.vibrateOn == YES) {
        AudioServicesPlayAlertSound (kSystemSoundID_Vibrate);
    }
    
    if (self.allSettings.soundOn == YES) {
           }
    
   
}

-(IBAction)incrementTwo:(id)sender
{
    totalTwo++;
    [screenTwo setText:[NSString stringWithFormat:@"%ld", (long)totalTwo]];
    
    [self updateTextWithAnimation];
    
    NSString *count = [NSString stringWithFormat:@"%ld",(long)totalTwo];
    
    static AVSpeechUtterance *utterance;
    utterance = [[AVSpeechUtterance alloc]initWithString:count];
    utterance.voice = nil;
    
    
    
    // *** class method alternative ***
    //[_speechSynthesizer speakUtterance:[AVSpeechUtterance speechUtteranceWithString:count]];
    
    if (self.allSettings.speechOn == YES) {
        
        int a;
        a = totalTwo;
        int b;
        b = 10;
        
        
        if ( a % b == 0){
            AudioServicesPlayAlertSound (kSystemSoundID_Vibrate);
            
            NSString *count = [NSString stringWithFormat:@"%ld Other",(long)totalTwo];
            //NSString *count = [NSString stringWithFormat:@"Blasts"];
            
            
            AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:count];

            
            [_speechSynthesizer speakUtterance:utterance];
            
        } else {
            
            
            utterance.rate = AVSpeechUtteranceMinimumSpeechRate + ((AVSpeechUtteranceMaximumSpeechRate - AVSpeechUtteranceMinimumSpeechRate) * 0.5f);
            utterance.volume = 1.0f;
            utterance.pitchMultiplier = 0.6f;
            //utterance.postUtteranceDelay = 0.0;
            utterance.voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"en-us"];
            
            [_speechSynthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
            
            [_speechSynthesizer speakUtterance:utterance];
            
            
            
            
            
            
            
        }
    }
    
    if (self.allSettings.vibrateOn == YES) {
        AudioServicesPlayAlertSound (kSystemSoundID_Vibrate);
    }
    
    if (self.allSettings.soundOn == YES) {
    }
    
    
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
    
    if (self.allSettings.soundOn == YES) {
    [_speechSynthesizer speakUtterance:[AVSpeechUtterance speechUtteranceWithString:@"Hey Path Guy, Do you really want to clear the total?"]];
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
        [_speechSynthesizer speakUtterance:[AVSpeechUtterance speechUtteranceWithString:@"Okay, you're the boss.  Just don't say I didn't warn you!"]];
    }

    
}


- (IBAction)sayTotal:(UIButton *)totalButton {
    if (self.allSettings.speechOn == YES) {
       
        if (totalButton.tag == 100) {
            NSString *count = [NSString stringWithFormat:@"Blasts TOTAL IS %ld",(long)total];
            AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:count];
        
            [_speechSynthesizer speakUtterance:utterance];
        }
        
        if (totalButton.tag == 101) {
                NSString *count = [NSString stringWithFormat:@"Other TOTAL IS %ld",(long)totalTwo];
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
   
    NSString *path = [[NSBundle mainBundle]pathForResource:@"Sound.caf" ofType:nil];
    
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

- (void) unloadSoundEffect
{
    AudioServicesDisposeSystemSoundID(_soundID);
    _soundID = 0;
}

- (void)playSoundEffect
{
    AudioServicesPlaySystemSound(_soundID);
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
