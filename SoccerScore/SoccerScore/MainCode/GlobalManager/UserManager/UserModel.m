//
//  UserModel.m
//  Nativer
//
//  Created by Lenhulk on 2018/5/18.
//  Copyright © 2018年 NITI. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

+ (instancetype)modelWithDict:(NSDictionary *)dict{
    //TODO: 判空？
    UserModel *mod = [[UserModel alloc] init];
    mod.fiction_username = dict[@"username"];
    mod.user_password = dict[@"password"];
    mod.user_mobile = dict[@"mobile"];
    mod.user_email = dict[@"email"];
    return mod;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.fiction_username forKey:@"name"];
    [aCoder encodeObject:self.user_password forKey:@"pwd"];
    [aCoder encodeObject:self.user_mobile forKey:@"mobile"];
    [aCoder encodeObject:self.user_email forKey:@"email"];
    [aCoder encodeObject:self.user_id forKey:@"id"];
    [aCoder encodeBool:self.isLogin forKey:@"isLogin"];
    [aCoder encodeObject:self.user_uuid forKey:@"uuid"];
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        self.fiction_username = [aDecoder decodeObjectForKey:@"name"];
        self.user_password = [aDecoder decodeObjectForKey:@"pwd"];
        self.user_mobile = [aDecoder decodeObjectForKey:@"mobile"];
        self.user_email = [aDecoder decodeObjectForKey:@"email"];
        self.user_id = [aDecoder decodeObjectForKey:@"id"];
        self.isLogin = [aDecoder decodeBoolForKey:@"isLogin"];
        self.user_uuid = [aDecoder decodeObjectForKey:@"uuid"];
    }
    return self;
}

@end
