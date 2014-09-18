//
//  ReportDetailViewController.m
//  TapCount
//
//  Created by Charles Grier on 9/13/14.
//  Copyright (c) 2014 Grier Mobile Development. All rights reserved.
//

#import "ReportDetailViewController.h"

@interface ReportDetailViewController () <UITextViewDelegate>

@end

@implementation ReportDetailViewController
{
    NSString *_reportTitle;
}

// give instance variable _reportTitle an initial value
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if ((self = [super initWithCoder:aDecoder])) {
        _reportTitle = @"";
    }
    
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.reportNameField becomeFirstResponder];
    self.reportNameField.text = _reportTitle;
    self.dateLabel.text = [self formatDate:[NSDate date]];
    self.countOneLabel.text = [NSString stringWithFormat:@"Blast Count: %ld", (long) _countTotalOne];
    self.countTwoLabel.text = [NSString stringWithFormat:@"Other Count: %ld", (long) _countTotalTwo];
    
    
    // dismiss keyboard when click outside of cell
    UIGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    //
    gestureRecognizer.cancelsTouchesInView = NO;

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
    [self closeScreen];
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
    if (indexPath.section == 0) {
        [self.reportNameField becomeFirstResponder];
    }
}





// UITextViewDelegate

#pragma mark UITextViewDelegate

// add characters to _reportTitle instance variable when typing in textfield
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    _reportTitle = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    _reportTitle = textView.text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}




@end
