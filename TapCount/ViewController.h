//
//  ViewController.h
//  TapCount
//
//  Created by Charles Grier on 9/10/14.
//  Copyright (c) 2014 Grier Mobile Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import "ReportDetailViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <CoreData/CoreData.h>
NSInteger total;
NSInteger totalTwo;



@interface ViewController : UIViewController <UIAlertViewDelegate>
{
    
    IBOutlet UILabel *screen;
    IBOutlet UILabel *screenTwo;
}

- (IBAction)increment:(id)sender;
- (IBAction)decrement:(id)sender;

- (IBAction)incrementTwo:(id)sender;
- (IBAction)decrementTwo:(id)sender;

- (IBAction)vibrateSwitch:(id)sender;
- (IBAction)speechSwitch:(id)sender;
- (IBAction)soundsOff:(id)sender;

- (IBAction)sayTotal:(id)sender;



@property (weak, nonatomic) IBOutlet UISwitch *speechSwitchToggle;
@property (weak, nonatomic) IBOutlet UISwitch *vibrateSwithToggle;
@property (weak, nonatomic) IBOutlet UISwitch *soundsSwitchToggle;

@property (weak, nonatomic) AVSpeechSynthesisVoice *britishVoice;

@property (assign) SystemSoundID pewPewSound;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@end
