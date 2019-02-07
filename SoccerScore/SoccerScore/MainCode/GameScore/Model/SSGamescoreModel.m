//
//  SSGamescoreModel.m
//  SoccerScore
//
//  Created by 大雄 on 2018/6/27.
//  Copyright © 2018年 大雄. All rights reserved.
//

#import "SSGamescoreModel.h"
#import <objc/runtime.h>

@implementation SSGamescoreModel

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned int count = 0;
    Ivar *ivar = class_copyIvarList([self class], &count);
    for (int i=0; i<count; i++) {
        Ivar iva = ivar[i];
        const char *name = ivar_getName(iva);
        NSString *ivaName = [NSString stringWithUTF8String:name];
        id value = [self valueForKey:ivaName];
        [aCoder encodeObject:value forKey:ivaName];
    }
    free(ivar);
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        unsigned int count = 0;
        Ivar *ivar = class_copyIvarList([self class], &count);
        for (int i=0; i<count; i++) {
            Ivar iva = ivar[i];
            const char *name = ivar_getName(iva);
            NSString *ivaName = [NSString stringWithUTF8String:name];
            id value = [aDecoder decodeObjectForKey:ivaName];
            [self setValue:value forKey:ivaName];
        }
        free(ivar);
    }
    return self;
}

@end
