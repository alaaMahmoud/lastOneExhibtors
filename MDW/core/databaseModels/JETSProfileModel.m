//
//  JETSProfileModel.m
//  Database1
//
//  Created by Mahmoud Amin on 4/8/16.
//  Copyright (c) 2016 JETS. All rights reserved.
//

#import "JETSProfileModel.h"

@implementation JETSProfileModel
-(void)createProfile:(JETSProfile*)profile{
    [[NSUserDefaults standardUserDefaults] setObject:profile forKey:@"JETSUserProfile"];
}
-(JETSProfile*)getProfile{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"JETSUserProfile"];
}
-(void)removeProfile{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"JETSUserProfile"];
}
@end
