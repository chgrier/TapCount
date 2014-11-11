//
//  ReportViewController.m
//  TapCount
//
//  Created by Charles Grier on 9/19/14.
//  Copyright (c) 2014 Grier Mobile Development. All rights reserved.
//

#import "ReportViewController.h"
#import "Report.h"
#import <MessageUI/MessageUI.h>

@interface ReportViewController () <MFMailComposeViewControllerDelegate, NSFetchedResultsControllerDelegate>


@end

@implementation ReportViewController

{
    //NSArray *_reports;
    NSFetchedResultsController *_fetchedResultsController;
}

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController == nil) {
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Report" inManagedObjectContext:self.managedObjectContext];
        
        [fetchRequest setEntity:entity];
        
        NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
        [fetchRequest setSortDescriptors:@[sortDescriptor]];
        
        [fetchRequest setFetchBatchSize:20];
        
        _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Report"];
        
        _fetchedResultsController.delegate = self;
    }
    return _fetchedResultsController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self performFetch];
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    /*
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc]init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Report" inManagedObjectContext:self.managedObjectContext];
    
    //+ (NSFetchRequest*)fetchRequestWithEntityName:(NSString*)entityName
    [fetchRequest setEntity:entity];
    
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    NSError *error;
    NSArray *foundObjects = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    //if (foundObjects == nil);{
        //FATAL_CORE_DATA_ERROR(error);
    //    return;
    //}
    
    _reports = foundObjects;
    
    [self.tableView reloadData];
     */
}

-(void)performFetch
{
    NSError *error;
    if (![self.fetchedResultsController performFetch:&error]) {
        return;
    }
}

-(void)dealloc
{
    _fetchedResultsController.delegate = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
        //return 1;
    
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    
    return [sectionInfo numberOfObjects];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Report"];
    
    //Report *report = _reports[indexPath.row];
    
    Report *report = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Configure the cell...
    UILabel *reportNameLabel = (UILabel *)[cell viewWithTag:100 ];
    
    if ([report.reportName length] > 0) {
        reportNameLabel.text = report.reportName;

    } else {
        reportNameLabel.text = @"(Untitled Report)";
    }
    
    //reportNameLabel.text = @"Report working!";

    UILabel *dateLabel = (UILabel *)[cell viewWithTag:101];
    dateLabel.text = [self formatDate:report.date] ;
    
    UILabel *blastCountLabel = (UILabel *)[cell viewWithTag:102];
    blastCountLabel.text = report.blastCount;
    
    UILabel *otherCountLabel = (UILabel *)[cell viewWithTag:103];
    otherCountLabel.text = report.otherCount;
    
   
    return cell;
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Report *report = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        [self.managedObjectContext deleteObject:report];
        
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            return;
        }
    }
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MFMailComposeViewController *controller = [[MFMailComposeViewController alloc]init];
    
    controller.modalPresentationStyle = UIModalPresentationPopover;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //Report *report = _reports[indexPath.row];
     Report *report = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    
    controller.mailComposeDelegate = self;
    
        if (controller != nil) {
            //[controller setSubject:@"Email test from PathCounter"];
            //[controller setToRecipients:@[@"chgrier@mac.com"]];
            
            if ([report.reportName length] > 0) {
                [controller setSubject:report.reportName];
                
            } else {
                [controller setSubject:@"Untitled Report"];            }
            
            NSString *date = [self formatDate:report.date] ;
            NSString *reportBody = [NSString stringWithFormat:@"%@  \n %@  \n Date: %@ \n \n Sent using Path Counter for iOS", report.blastCount, report.otherCount, date];
            [controller setMessageBody:reportBody isHTML:NO];
           
            
            [self presentViewController:controller animated:YES completion:nil];
            
            
        }
    }
    
    //[self sendEmail];




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}



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

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

#pragma mark MFMailComposeViewControllerDelegate

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error

{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - NSFetchedResultsController Delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeMove:
            [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        
            break;
    }
}

-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
        
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
        
            break;
    }
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}
@end
