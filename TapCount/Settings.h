//
//  Settings.h
//  TapCount
//
//  Created by Charles Grier on 10/29/14.
//  Copyright (c) 2014 Grier Mobile Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Settings : NSObject

@property (nonatomic, assign) BOOL soundOn;
@property (nonatomic, assign) BOOL speechOn;
@property (nonatomic, assign) BOOL vibrateOn;
@property (nonatomic, assign) BOOL vibrateTenOn;
@property (nonatomic, assign) float leftSliderValue;
@property (nonatomic, assign) float rightSliderValue;

@property (nonatomic, assign) NSString *leftLanguageCode;
@property (nonatomic, assign) NSString *rightLanguageCode;

@property (nonatomic, assign) NSString *leftLanguageName;
@property (nonatomic, assign) NSString *rightLanguageName;

@end
