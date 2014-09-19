//
//  Report.h
//  TapCount
//
//  Created by Charles Grier on 9/19/14.
//  Copyright (c) 2014 Grier Mobile Development. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Report : NSManagedObject

@property (nonatomic, retain) NSString * reportName;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * blastCount;
@property (nonatomic, retain) NSString * otherCount;
@property (nonatomic, retain) NSString * notes;

@end
