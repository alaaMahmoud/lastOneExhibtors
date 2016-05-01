//
//  JETSSessionModel.m
//  Database1
//
//  Created by JETS on 4/9/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import "JETSSessionModel.h"

@implementation JETSSessionModel

- (id)init {
    
    self = [super init];
    
    if (self) {
        
        connection=[JETSDBConnectionFactory getInstance];
        
    }
    
    return self;
    
}

-(void)createBean:(id)bean{
    
    JETSSession *session=(JETSSession *) bean;
    
    NSString *insertSQL = [NSString stringWithFormat:
                           @"INSERT INTO Session (id, name, size, color, location, description, status, sessionType, liked, sessionTags, date, startDate, endDate) VALUES (%ld, \"%@\", \"%@\", \"%@\", \"%@\", \"%@\", %d, \"%@\", \"%@\", \"%@\", %ld, %ld, %ld)",
                           session.id, session.name, session.size, session.color, session.location, session.description, session.status, session.sessionType, session.liked, [session.sessionTags componentsJoinedByString:@","], session.date, session.startDate, session.endDate];
    
    [connection excuteUpdate:insertSQL];
    
    for (int i=0;i<[session.speakers count];i++)
    {
    
        NSString *subInsertSQL = [NSString stringWithFormat:
                               @"INSERT INTO Speaker_Session (speaker_id, session_id) VALUES (%ld, %ld)",
                               session.id, (long)[session.speakers objectAtIndex:i]];
        
        [connection excuteUpdate:subInsertSQL];
    
    }
    
}

-(void)removeBean:(id)bean{
    
    JETSSession *session=(JETSSession *) bean;
    
    NSString *deleteSQL = [NSString stringWithFormat:@"Delete FROM Session WHERE id=%ld",session.id];
    
    [connection excuteUpdate:deleteSQL];
    
    NSString *subDeleteSQL = [NSString stringWithFormat:@"Delete FROM Speaker_Session WHERE session_id=%ld",session.id];
    
    [connection excuteUpdate:subDeleteSQL];
    
}

-(id)findById:(id)id_{
    
    long myId=(long)id_;
    
    NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM Session WHERE id=%ld",myId];
    
    FMResultSet *rs=[connection excuteQuery:querySQL];
    
    JETSSession *session=[JETSSession new];
    
    while ([rs next]) {
        
        session.id = [rs longForColumn:@"id"];
        session.name = [rs stringForColumn:@"name"];
        session.size = [rs stringForColumn:@"size"];
        session.color = [rs stringForColumn:@"color"];
        session.location = [rs stringForColumn:@"location"];
        session.desc = [rs stringForColumn:@"description"];
        session.status = [rs intForColumn:@"status"];
        session.sessionType = [rs stringForColumn:@"sessionType"];
        session.liked = [rs stringForColumn:@"liked"];
        session.date = [rs longForColumn:@"date"];
        session.startDate = [rs longForColumn:@"startDate"];
        session.endDate = [rs longForColumn:@"endDate"];
        
        //mutable array can be init with normal array
        NSMutableArray *sessionTagsArray =[NSMutableArray arrayWithArray:[[rs stringForColumn:@"sessionTags"] componentsSeparatedByString:@","]];
        
        session.sessionTags = [sessionTagsArray mutableCopy];
        
    }
    
    NSString *subQuerySQL = [NSString stringWithFormat:@"SELECT speaker_id FROM Speaker_Session WHERE session_id=%ld",myId];
    
    FMResultSet *rs1=[connection excuteQuery:subQuerySQL];
    
    NSMutableArray *speakers=[NSMutableArray new];
    
    while ([rs1 next]) {
        
        long mySpeaker=[rs longForColumn:@"speaker_id"];
        
        NSNumber* xWrapped = [NSNumber numberWithLong:mySpeaker];
        
        [speakers addObject:xWrapped];
        
    }
    
    session.speakers = [speakers mutableCopy];
    
    return session;
    
}

-(id)findByDate:(id)date_{

    long myDate=(long)date_;
    
    long mySessionId=0;
    
    NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM Session WHERE date=%ld",myDate];
    
    FMResultSet *rs=[connection excuteQuery:querySQL];
    
    JETSSession *session=[JETSSession new];
    
    while ([rs next]) {
        
        session.id = [rs longForColumn:@"id"];
        mySessionId=session.id;
        session.name = [rs stringForColumn:@"name"];
        session.size = [rs stringForColumn:@"size"];
        session.color = [rs stringForColumn:@"color"];
        session.location = [rs stringForColumn:@"location"];
        session.desc = [rs stringForColumn:@"description"];
        session.status = [rs intForColumn:@"status"];
        session.sessionType = [rs stringForColumn:@"sessionType"];
        session.liked = [rs stringForColumn:@"liked"];
        session.date = [rs longForColumn:@"date"];
        session.startDate = [rs longForColumn:@"startDate"];
        session.endDate = [rs longForColumn:@"endDate"];
        
        //mutable array can be init with normal array
        NSMutableArray *sessionTagsArray =[NSMutableArray arrayWithArray:[[rs stringForColumn:@"sessionTags"] componentsSeparatedByString:@","]];
        
        session.sessionTags = [sessionTagsArray mutableCopy];
        
    }
    
    NSString *subQuerySQL = [NSString stringWithFormat:@"SELECT speaker_id FROM Speaker_Session WHERE session_id=%ld",mySessionId];
    
    FMResultSet *rs1=[connection excuteQuery:subQuerySQL];
    
    NSMutableArray *speakers=[NSMutableArray new];
    
    while ([rs1 next]) {
        
        long mySpeaker=[rs longForColumn:@"speaker_id"];
        
        NSNumber* xWrapped = [NSNumber numberWithLong:mySpeaker];
        
        [speakers addObject:xWrapped];
        
    }
    
    session.speakers = [speakers mutableCopy];
    
    return session;
}

-(NSMutableArray*)findAll{
    
    NSString *querySQL = [NSString stringWithFormat:@"SELECT * FROM Session ORDER BY date ASC"];
    
    FMResultSet *rs=[connection excuteQuery:querySQL];
    
    NSMutableArray *result=[NSMutableArray new];
    
    while ([rs next]) {
        
        JETSSession *session=[JETSSession new];
        
        session.id = [rs longForColumn:@"id"];
        session.name = [rs stringForColumn:@"name"];
        session.size = [rs stringForColumn:@"size"];
        session.color = [rs stringForColumn:@"color"];
        session.location = [rs stringForColumn:@"location"];
        session.desc = [rs stringForColumn:@"description"];
        session.status = [rs intForColumn:@"status"];
        session.sessionType = [rs stringForColumn:@"sessionType"];
        session.liked = [rs stringForColumn:@"liked"];
        session.date = [rs longForColumn:@"date"];
        session.startDate = [rs longForColumn:@"startDate"];
        session.endDate = [rs longForColumn:@"endDate"];
        
        //mutable array can be init with normal array
        NSMutableArray *sessionTagsArray =[NSMutableArray arrayWithArray:[[rs stringForColumn:@"sessionTags"] componentsSeparatedByString:@","]];
        
        session.sessionTags = [sessionTagsArray mutableCopy];
        
        NSString *subQuerySQL = [NSString stringWithFormat:@"SELECT speaker_id FROM Speaker_Session WHERE session_id=%ld",session.id];
        
        FMResultSet *rs1=[connection excuteQuery:subQuerySQL];
        
        NSMutableArray *speakers=[NSMutableArray new];
        
        while ([rs1 next]) {
            
            long mySpeaker=[rs longForColumn:@"speaker_id"];
            
            NSNumber* xWrapped = [NSNumber numberWithLong:mySpeaker];
            
            [speakers addObject:xWrapped];
            
        }
        
        session.speakers = [speakers mutableCopy];
        
        [result addObject:session];
        
    }
    
    return result;
    
}

-(int)count{
    
    //prefered with agregate function to give the column alias
    NSString *querySQL = [NSString stringWithFormat:@"SELECT COUNT(*) as count_ FROM Session"];
    
    FMResultSet *rs = [connection excuteQuery:querySQL];
    
    int count=0;
    
    while ([rs next]) {
        count = [rs intForColumn:@"count_"];
    }
    
    return count;
    
}

-(void)removeALL{
    
    NSString *deleteSQL = [NSString stringWithFormat:@"Delete FROM Session"];
    
    [connection excuteUpdate:deleteSQL];
    
    NSString *subDeleteSQL = [NSString stringWithFormat:@"Delete FROM Speaker_Session"];
    
    [connection excuteUpdate:subDeleteSQL];
    
}

@end
