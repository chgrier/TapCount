//
//  Language.h
//  TapCount
//
//  Created by Charles Grier on 11/12/14.
//  Copyright (c) 2014 Grier Mobile Development. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Language : NSObject

@property (nonatomic, assign) NSString *leftLanguageCode;
@property (nonatomic, assign) NSString *rightLanguageCode;

@property (nonatomic, assign) NSString *leftFullName;
@property (nonatomic, assign) NSString *rightFullName;


@end
