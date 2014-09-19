//
//  ReportDetailViewController.h
//  TapCount
//
//  Created by Charles Grier on 9/13/14.
//  Copyright (c) 2014 Grier Mobile Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HudView.h"
#import <CoreData/CoreData.h>

@interface ReportDetailViewController : UITableViewController

@property (nonatomic, weak) IBOutlet UITextField *reportNameField;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UILabel *countOneLabel;
@property (nonatomic, weak) IBOutlet UILabel *countTwoLabel;
@property (weak, nonatomic) IBOutlet UILabel *notesLabel;

@property (nonatomic, assign) NSInteger countTotalOne;
@property (nonatomic, assign) NSInteger countTotalTwo;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;


@end
