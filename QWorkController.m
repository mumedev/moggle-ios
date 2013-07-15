//
//  QWorkController.m
//  Moggle
//
//  Created by student on 11/12/12.
//  Copyright (c) 2012 mume12. All rights reserved.
//

#import "QWorkController.h"
#import "QMoodController.h"

@interface QWorkController ()

@property (nonatomic, weak) NSNumber * workQuantityValue;
@property (nonatomic, weak) NSNumber * workQualityValue;

@end

@implementation QWorkController

@synthesize quantityValueLabel;
@synthesize workQuantityValue;
@synthesize workQualityValue;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.workQualityValue   = [NSNumber numberWithInteger:0];
    self.workQuantityValue  = [NSNumber numberWithInteger:0];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

// Note that segmented control's actions also require an event for value changed.
- (IBAction)setWorkQuality:(UISegmentedControl *)sender forEvent:(UIEvent *)event {
    
    self.workQualityValue = [NSNumber numberWithInteger: sender.selectedSegmentIndex];
}

- (IBAction)stepperAction:(UIStepper *)sender {
    
    quantityValueLabel.text = [NSString stringWithFormat:@"%g", sender.value];
    
    self.workQuantityValue = [NSNumber numberWithInteger:sender.value];
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    QMoodController *destination = [segue destinationViewController];
    
    NSLog(@"prepareForSegue#work_quantity : %d", self.workQuantityValue.integerValue);
    NSLog(@"prepareForSegue#work_quality : %d", self.workQualityValue.integerValue);    
    
    
    destination.wQuantityValue  = self.workQuantityValue;
    destination.wQualityValue   = self.workQualityValue;
}

@end
