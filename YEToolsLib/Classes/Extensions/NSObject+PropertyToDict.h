//
//  NSObject+PropertyToDict.h
//  healthManagement
//
//  Created by Eason on 2017/3/21.
//  Copyright © 2017年 eason. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (PropertyToDict)

/**
 将对象的属性转为字典

 @return Dictionary
 */
-(NSDictionary *)objectToDict;

/**
 包含空属性的对象转为字典

 @return Dictionary
 */
-(NSDictionary *)objectToDictIncludeNullValue;
@end
