//
//  QMoodController.m
//  Moggle
//
//  Created by student on 11/12/12.
//  Copyright (c) 2012 mume12. All rights reserved.
//
// https://developer.apple.com/library/mac/#documentation/Cocoa/Conceptual/Strings/Articles/formatSpecifiers.html

#import "QMoodController.h"
#import "ViewController.h"

@interface QMoodController ()

@end

@implementation QMoodController

// UI
@synthesize moodValue;
@synthesize statusDB;
@synthesize moodSlider;

// Model
@synthesize wQuantityValue;
@synthesize wQualityValue;
@synthesize moodQuantified;


// Database
@synthesize databasePath = _databasePath;
@synthesize moggleDB = _moggleDB;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.moodQuantified   = [NSNumber numberWithInteger:5];
    
    NSLog(@"viewDidLoad#work_quantity : %d", self.wQuantityValue.integerValue);
    NSLog(@"viewDidLoad#work_quality : %d", self.wQualityValue.integerValue);
    NSLog(@"viewDidLoad#mood_quantified %d", self.moodQuantified.integerValue);
    
    // CREATE DB
    // =========
    NSString *docsDir;
    NSArray *dirPaths;
    
    // Get the documents directory
    dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    docsDir = dirPaths[0];
    
    // Build the path to the database file
    _databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: @"moggle.db"]];
    
    NSFileManager *filemgr = [NSFileManager defaultManager];
    
    if ([filemgr fileExistsAtPath: _databasePath ] == NO)
    {
        const char *dbpath = [_databasePath UTF8String];
        
        if (sqlite3_open(dbpath, &_moggleDB) == SQLITE_OK)
        {
            char *errMsg;
            const char *sql_stmt =
            "CREATE TABLE IF NOT EXISTS qdat (ID INTEGER PRIMARY KEY AUTOINCREMENT, work_quantity INTEGER, work_quality INTEGER, mood_quantified INTEGER)";
            
            if (sqlite3_exec(_moggleDB, sql_stmt, NULL, NULL, &errMsg) != SQLITE_OK)
            {
                NSLog(@"Failed to create table");
            }
            sqlite3_close(_moggleDB);
        } else {
            NSLog(@"Failed to open/create database");
        }
    }

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (IBAction)moodSlider:(UISlider *)sender {

    self.moodQuantified = [NSNumber numberWithInteger:sender.value];
    moodValue.text = [NSString stringWithFormat:@"%d", self.moodQuantified.integerValue];
    
    //NSLog(@"moodSlider#value");
    //NSLog(@"%f", self.wQuantityValue.doubleValue);
}

    
- (IBAction)saveData:(id)sender {
    
    NSLog(@"MOGGLE#Write to database.");
    
    sqlite3_stmt *statement;
    const char *dbpath = [_databasePath UTF8String];
        
    if (sqlite3_open(dbpath, &_moggleDB) == SQLITE_OK)
    {
        NSLog(@"work_quantity : %d", self.wQuantityValue.integerValue);
        NSLog(@"work_quality : %d", self.wQualityValue.integerValue);
        NSLog(@"mood_quantified %d", self.moodQuantified.integerValue);
        
        // %f : double, %d integer, % String
        NSString * insertSQL = [NSString stringWithFormat: @"INSERT INTO qdat (work_quantity, work_quality, mood_quantified) VALUES (\"%d\", \"%d\", \"%d\")", self.wQuantityValue.integerValue, self.wQualityValue.integerValue, self.moodQuantified.integerValue];
        
        const char *insert_stmt = [insertSQL UTF8String];
        sqlite3_prepare_v2(_moggleDB, insert_stmt, -1, &statement, NULL);
        
        if (sqlite3_step(statement) == SQLITE_DONE)
        {
            NSLog(@"New record added.");
        } else {
            NSLog(@"Failed to add new record; SQLITE_DONE == false.");
        }
        
        sqlite3_finalize(statement);
        sqlite3_close(_moggleDB);
    } else {
        NSLog(@"Failed to add new record; SQLITE_OK == false.");
    }
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ViewController *destination = [segue destinationViewController];
    
    destination.navigationItem.hidesBackButton = YES;
}

@end
