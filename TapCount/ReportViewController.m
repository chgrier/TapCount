//
//  ReportViewController.m
//  TapCount
//
//  Created by Charles Grier on 9/19/14.
//  Copyright (c) 2014 Grier Mobile Development. All rights reserved.
//

#import "ReportViewController.h"
#import "Report.h"

@interface ReportViewController ()


@end

@implementation ReportViewController

{
    NSArray *_reports;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"test");
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Report" inManagedObjectContext:self.managedObjectContext];
    
    //+ (NSFetchRequest*)fetchRequestWithEntityName:(NSString*)entityName
    [fetchRequest setEntity:entity];
    
    /*
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    */
    NSError *error;
    NSArray *foundObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    //if (foundObjects == nil);{
        //FATAL_CORE_DATA_ERROR
        return;
    //}
    
    _reports = foundObjects;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    //return 2;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return [_reports count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Report"];
    
    Report *report = _reports[indexPath.row];
    
    // Configure the cell...
    UILabel *reportNameLabel = (UILabel *)[cell viewWithTag:100 ];
    //reportNameLabel.text = report.reportName;
    
    reportNameLabel.text = @"Report working!";

    
    
    //UILabel *dateLabel = (UILabel *)[cell viewWithTag:101];
    //dateLabel.text = [self formatDate:report.date];
    
    UILabel *dateLabel = (UILabel *)[cell viewWithTag:101];
    dateLabel.text = @"Test label";
    return cell;
}


- (NSString *)formatDate:(NSDate *)theDate
{
    static NSDateFormatter *formatter = nil;
    if (formatter == nil) {
        formatter = [[NSDateFormatter alloc]init];
        [formatter setDateStyle:NSDateFormatterShortStyle];
        [formatter setTimeStyle:NSDateFormatterShortStyle];
    }
    
    return [formatter stringFromDate:theDate];
    
    
    
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
