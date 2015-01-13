//
//  SelectRightLanguageViewController.m
//  Lab Counter
//
//  Created by Charles Grier on 1/12/15.
//  Copyright (c) 2015 Grier Mobile Development. All rights reserved.
//

#import "SelectRightLanguageViewController.h"
#import <AVFoundation/AVFoundation.h>


@interface SelectRightLanguageViewController ()

@end

@implementation SelectRightLanguageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - Creating Dictionary For Language Codes
// Language codes used to create custom voices. Array is sorted based
// on the display names in the language dictionary
- (NSArray *)languageCodes
{
    if (!_languageCodes)
    {
        _languageCodes = [self.languageDictionary keysSortedByValueUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    }
    return _languageCodes;
}


// Map between language codes and locale specific display name
- (NSDictionary *)languageDictionary;

{
    if (!_languageDictionary)
    {
        NSArray *voices = [AVSpeechSynthesisVoice speechVoices];
        NSArray *languages = [voices valueForKey:@"language"];
        
        NSLocale *currentLocale = [NSLocale autoupdatingCurrentLocale];
        NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
        for (NSString *code in languages)
        {
            dictionary[code] = [currentLocale displayNameForKey:NSLocaleIdentifier value:code];
        }
        _languageDictionary = dictionary;
    }
    return _languageDictionary;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    // Return the number of rows in the section.
    return [self.languageCodes count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Language" forIndexPath:indexPath];
    // Configure the cell...use tag 1000 for label in cell
    
    NSString *languageCode = self.languageCodes[indexPath.row];
    NSString *languageName = self.languageDictionary[languageCode];
    //return languageName;
    
    UILabel *languageNameLabel = (UILabel *) [cell viewWithTag:1001];
    languageNameLabel.text = languageName;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *languageCode = self.languageCodes[indexPath.row];
    NSString *languageName = self.languageDictionary[languageCode];
    
    Language *languageCodeName = [[Language alloc]init];
    languageCodeName.rightLanguageCode = languageCode;
    languageCodeName.rightLanguageName = languageName;
    
    [self.delegate setRightLanguage:self didSelectLanguage:languageCodeName];
    
    NSLog(@"Language selected: %@ and %@ = %@", languageCode, languageCodeName.rightLanguageCode, languageName);
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
    
}


- (IBAction)cancel:(id)sender {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}
@end
