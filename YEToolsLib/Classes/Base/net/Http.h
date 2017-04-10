//
//  Http.h
//  healthManagement
//
//  Created by Eason on 2017/3/10.
//  Copyright © 2017年 eason. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+PropertyToDict.h"     //对象转换为字典的扩展类
#import <MJExtension/MJExtension.h>                 //字典和对象互相转换的第三方库
typedef void(^RESULT)(NSDictionary*result);
typedef void(^ERROR_H)(NSError *errorH);
@interface Http : NSObject

/**
 Get请求解析json

 @param host host
 @param dict 参数
 @param success 成功回调
 @param errorH 失败回调
 */
-(void)get:(NSString*)host param:(NSDictionary*)dict success:(RESULT)success error:(ERROR_H)errorH;

/**
 Post请求解析json

 @param host host
 @param dict 参数
 @param success 成功回调
 @param errorH 失败回调
 */
-(void)post:(NSString*)host param:(NSDictionary*)dict success:(RESULT)success error:(ERROR_H)errorH;

/**
 附带文件的POST请求解析返回的json

 @param host host
 @param dict 参数
 @param aFileData 文件数据
 @param aFileName 文件名称 例如"image/jpg"、"image/png"
 @param aType 文件类型
 @param success 成功
 @param errorH 失败
 */
-(void)postFile:(NSString*)host param:(NSDictionary*)dict fileData:(NSData*)aFileData fileName:(NSString*)aFileName type:(NSString*)aType success:(RESULT)success error:(ERROR_H)errorH;
@end
