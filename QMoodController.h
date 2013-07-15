//
//  QMoodController.h
//  Moggle
//
//  Created by student on 11/12/12.
//  Copyright (c) 2012 mume12. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface QMoodController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *moodValue;
@property (weak, nonatomic) NSNumber *wQuantityValue;
@property (weak, nonatomic) NSNumber * wQualityValue;
@property (weak, nonatomic) NSNumber * moodQuantified;

@property (strong, nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 * moggleDB;
@property (weak, nonatomic) IBOutlet UISlider *moodSlider;

@property (weak, nonatomic) IBOutlet UILabel *statusDB;

@end
