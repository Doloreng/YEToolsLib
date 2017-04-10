//
//  NSObject+PropertyToDict.m
//  healthManagement
//
//  Created by Eason on 2017/3/21.
//  Copyright © 2017年 eason. All rights reserved.
//

#import "NSObject+PropertyToDict.h"
#import <objc/runtime.h>
@implementation NSObject (PropertyToDict)

-(NSDictionary *)objectToDict
{
    NSMutableDictionary *userDic = [NSMutableDictionary dictionary];
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        const char *name = property_getName(properties[i]);
        
        NSString *propertyName = [NSString stringWithUTF8String:name];
        id propertyValue = [self valueForKey:propertyName];
        if (propertyValue) {
            [userDic setObject:propertyValue forKey:propertyName];
        }
        
    }
    free(properties);
    
    return [userDic copy];
}
-(NSDictionary *)objectToDictIncludeNullValue{
    NSMutableDictionary *userDic = [NSMutableDictionary dictionary];
    unsigned int count = 0;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for (int i = 0; i < count; i++) {
        const char *name = property_getName(properties[i]);
        
        NSString *propertyName = [NSString stringWithUTF8String:name];
        id propertyValue = [self valueForKey:propertyName];
        if (propertyValue) {
            [userDic setObject:propertyValue forKey:propertyName];
        }else{
            [userDic setObject:@"" forKey:propertyName];
        }
        
    }
    free(properties);
    
    return [userDic copy];
}
@end
