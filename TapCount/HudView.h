//
//  HudView.h
//  TapCount
//
//  Created by Charles Grier on 9/18/14.
//  Copyright (c) 2014 Grier Mobile Development. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h> 

@interface HudView : UIView

+ (instancetype)hudInView:(UIView *)view animated:(BOOL)animated;

@property (nonatomic, strong) NSString *text;


@end
