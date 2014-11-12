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
#import "ReportViewController.h"
#import "Settings.h"
#import "SettingsViewController.h"
#import "SelectLanguageTableTableViewController.h"

NSInteger total;
NSInteger totalTwo;



@interface ViewController : UIViewController <UIAlertViewDelegate, SettingsViewControllerDelegate>
{
    
    IBOutlet UILabel *screen;
    IBOutlet UILabel *screenTwo;
}

- (IBAction)increment:(id)sender;
- (IBAction)decrement:(id)sender;

- (IBAction)incrementTwo:(id)sender;
- (IBAction)decrementTwo:(id)sender;



- (IBAction)sayTotal:(id)sender;





@property (weak, nonatomic) AVSpeechSynthesisVoice *britishVoice;

@property (assign) SystemSoundID pewPewSound;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong) AVSpeechUtterance *utterancePropertyTwo;
@property (nonatomic, strong) AVSpeechUtterance *utterancePropertyOne;

@property Settings *allSettings;


@end
