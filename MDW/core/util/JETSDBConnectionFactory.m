//
//  JETSDBConnectionFactory.m
//  Database1
//
//  Created by Mahmoud Amin on 4/5/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import "JETSDBConnectionFactory.h"

static JETSDBConnectionFactory *sharedInstance = nil;
static FMDatabaseQueue *queue =nil;
static FMDatabase *adb=nil;

@implementation JETSDBConnectionFactory
/*
 *create database tables you must cal it on time at least
 */
-(void)intializeDB{
    [adb  executeUpdate: @"CREATE TABLE IF NOT EXISTS Exhibitor (id INTEGER PRIMARY KEY, imageURL TEXT, companyAddress TEXT, companyAbout TEXT, fax TEXT, contactName TEXT, contactTitle TEXT, companyUrl TEXT, email TEXT, countryName TEXT, cityName TEXT, companyName TEXT, phones TEXT, mobiles TEXT)"];
    [adb  executeUpdate: @"CREATE TABLE IF NOT EXISTS Speaker (id INTEGER PRIMARY KEY, gender TEXT, imageURL TEXT, middleName TEXT, biography TEXT, firstName TEXT, lastName TEXT, companyName TEXT, title TEXT, phones TEXT, mobiles TEXT)"];
    [adb  executeUpdate: @"CREATE TABLE IF NOT EXISTS Session (id INTEGER PRIMARY KEY, name TEXT, size TEXT, color TEXT, location TEXT, description TEXT, status INTEGER, sessionType TEXT, liked TEXT, sessionTags TEXT, date INTEGER, startDate INTEGER, endDate INTEGER)"];
    [adb  executeUpdate: @"CREATE TABLE IF NOT EXISTS Speaker_Session (id INTEGER PRIMARY KEY AUTOINCREMENT, Speaker_id INTEGER, Session_id INTEGER)"];
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"JETSFirstinit"];
    NSLog(@"Is SQLite compiled with it's thread safe options turned on? %@!", [FMDatabase isSQLiteThreadSafe] ? @"Yes" : @"No");
}
+(JETSDBConnectionFactory*)getInstance{
    static dispatch_once_t onceToken;
    //create the database structure and initialize fmdb object for use
    //database name saved in plist file
    dispatch_once(&onceToken, ^{
        NSString *path = [[NSBundle mainBundle] pathForResource: @"Database1-Info" ofType: @"plist"];
        NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile: path];
        NSString*dbPath= [dict objectForKey: @"JETS DBNAME"];
        
        sharedInstance = [[JETSDBConnectionFactory alloc] init];
        adb = [FMDatabase databaseWithPath:dbPath];
        [adb open];
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"JETSFirstinit"]) {
            [sharedInstance intializeDB];
        }
        queue = [FMDatabaseQueue databaseQueueWithPath:dbPath];
        
    });
    return sharedInstance;
}

-(Boolean)excuteUpdate:(NSString*)query{
     Boolean rs=[adb  executeUpdate:query];
     return rs;
}
-(FMResultSet*)excuteQuery:(NSString*)query{
    [adb open];
    FMResultSet *rs=[adb executeQuery:query];
    return rs;
}

-(void)dealloc{
    [adb close];
    [queue close];
}
@end









