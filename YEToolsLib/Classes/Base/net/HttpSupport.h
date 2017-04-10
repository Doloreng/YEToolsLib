//
//  HttpSupport.h
//  healthManagement
//
//  Created by Eason on 2017/3/13.
//  Copyright © 2017年 eason. All rights reserved.
//

#import <Foundation/Foundation.h>
#define ERRER_CODE_NOTNETWORK -250
#define ERRER_MESSAGE_NOTNETWORK @"没有网络"
typedef void(^SUCCESS)(id result);
typedef void(^ERROR)(NSError *error);

@interface HttpSupport : NSObject
/**
 设置请求时间
 
 @param timeout 时间
 */
-(void)setTimeout:(NSTimeInterval)timeout;

/**
 设置header
 
 @param value 值
 @param field key
 */
-(void)setHeadParam:(NSString*)value Field:(NSString*)field;

/**
 Get请求
 
 @param host host
 @param dict 参数
 @param success 成功回调
 @param errorC 失败回调
 */
-(void)getOriginal:(NSString*)host param:(NSDictionary*)dict success:(SUCCESS)success error:(ERROR)errorC;

/**
 Post请求
 
 @param host host
 @param dict 参数
 @param success 成功回调
 @param errorC 失败回调
 */
-(void)postOriginal:(NSString*)host param:(NSDictionary*)dict success:(SUCCESS)success error:(ERROR)errorC;

/**
 附带文件的POST请求

 @param host host
 @param dict 参数
 @param aFileData 文件
 @param aFileName 文件名称
 @param aType 文件类型
 @param success 成功回调
 @param errorC 失败回调
 */
-(void)postOriginalFile:(NSString*)host param:(NSDictionary*)dict fileData:(NSData*)aFileData fileName:(NSString*)aFileName type:(NSString*)aType success:(SUCCESS)success error:(ERROR)errorC;
@end
