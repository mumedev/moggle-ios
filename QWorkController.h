//
//  QWorkController.h
//  Moggle
//
//  Created by student on 11/12/12.
//  Copyright (c) 2012 mume12. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QWorkController : UIViewController

@property (nonatomic,strong) NSManagedObjectContext* managedObjectContext;

@property (weak, nonatomic) IBOutlet UILabel *quantityValueLabel;


@end
