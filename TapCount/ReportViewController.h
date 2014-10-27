//
//  ReportViewController.h
//  TapCount
//
//  Created by Charles Grier on 9/19/14.
//  Copyright (c) 2014 Grier Mobile Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface ReportViewController : UITableViewController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
//@property (weak, nonatomic) IBOutlet UILabel *reportName;
//- (IBAction)cancel:(id)sender;


@end
