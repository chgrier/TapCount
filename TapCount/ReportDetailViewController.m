//
//  ReportDetailViewController.m
//  TapCount
//
//  Created by Charles Grier on 9/13/14.
//  Copyright (c) 2014 Grier Mobile Development. All rights reserved.
//

#import "ReportDetailViewController.h"
#import "Report.h"
#import "ReportViewController.h"

@interface ReportDetailViewController () <UITextViewDelegate, UITextFieldDelegate>

@end

@implementation ReportDetailViewController
{
    NSString *_reportTitle;
    NSString *_notes;
    
    NSDate *_date;
}

// give instance variable _reportTitle an initial value
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        _reportTitle = @"";
        _date = [NSDate date];
    }
    
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [_reportNameField setDelegate:self];
    
    
    [self.reportNameField becomeFirstResponder];
    self.reportNameField.text = _reportTitle;
    self.dateLabel.text = [self formatDate:_date];
    self.countOneLabel.text = [NSString stringWithFormat:@"Left Counter: %ld", (long) _countTotalOne];
    self.countTwoLabel.text = [NSString stringWithFormat:@"Right Counter: %ld", (long) _countTotalTwo];
    
    
    // dismiss keyboard when click outside of cell
    UIGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard:)];
    
    gestureRecognizer.cancelsTouchesInView = NO;
    
    [self.tableView addGestureRecognizer:gestureRecognizer];

}

- (void)hideKeyboard:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint point = [gestureRecognizer locationInView:self.tableView];
    
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:point];
    
    if (indexPath != nil && indexPath.section == 0 && indexPath.row == 0) {
        return;
    }
    [self.reportNameField resignFirstResponder];
}


// example of lazy loading  -- static variable keeps instance after method stops
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
-(IBAction)done:(id)sender
{
    //[self closeScreen];
    HudView *hudView = [HudView hudInView:self.navigationController.view animated:YES];
    
    hudView.text = @"Report Saved!";
    
    Report *report = [NSEntityDescription insertNewObjectForEntityForName:@"Report" inManagedObjectContext:self.managedObjectContext];
    
    report.reportName = _reportNameField.text;
    report.date = _date;
    report.blastCount = _countOneLabel.text;
    report.otherCount = _countTwoLabel.text;

    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"ERROR: %@", error);
        abort();
    }
    
    [self performSelector:@selector(closeScreen) withObject:nil afterDelay:0.8f];
}



-(IBAction)cancel:(id)sender
{
    [self closeScreen];

}

-(IBAction)email:(id)sender
{
    
}

-(void) closeScreen
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark UITableViewDelegate

// provide an indexPath if click in sections
-(NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // allows taps on first and third section only
    if (indexPath.section == 0 || indexPath.section == 2) {
        return indexPath;
    } else {
        return nil;
    }
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2 || (indexPath.section == 0 && indexPath.row == 0)) {
        [self.reportNameField becomeFirstResponder];
    }
}


// UITextViewDelegate

#pragma mark UITextViewDelegate

// add characters to _reportTitle instance variable when typing in textfield
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //_reportTitle = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    //_reportTitle = textView.text;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.reportNameField resignFirstResponder];
    
    return YES;
}





@end
