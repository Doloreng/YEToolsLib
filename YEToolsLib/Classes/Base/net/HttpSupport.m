//
//  HttpSupport.m
//  healthManagement
//
//  Created by Eason on 2017/3/13.
//  Copyright © 2017年 eason. All rights reserved.
//

#import "HttpSupport.h"
#import "Reachability.h"
#import "AFNetworking.h"
@interface HttpSupport()
{
    Reachability *netState;
    AFHTTPSessionManager *manager;
}
@end
@implementation HttpSupport
-(id)init{
    self=[super init];
    if (self) {
        netState=[Reachability reachabilityForInternetConnection];
        manager=[AFHTTPSessionManager manager];
        manager.securityPolicy=[self customSecurityPolicy];
        
    }
    return self;
}
- (AFSecurityPolicy*)customSecurityPolicy {
    AFSecurityPolicy *securityPolicy;
    NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"https" ofType:@"cer"];
    if (cerPath) {
        NSData * certData =[NSData dataWithContentsOfFile:cerPath];
        securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModePublicKey];
        [securityPolicy setAllowInvalidCertificates:YES];
        NSSet * certSet = [[NSSet alloc] initWithObjects:certData, nil];
        [securityPolicy setPinnedCertificates:certSet];
    }else{
        securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    }
    return securityPolicy;
}

-(void)setTimeout:(NSTimeInterval)timeout{
    if (timeout&&manager) {
        manager.requestSerializer.timeoutInterval=timeout;
    }
}
-(void)setHeadParam:(NSString*)value Field:(NSString*)field{
    if (manager) {
        [manager.requestSerializer setValue:value forHTTPHeaderField:field];
    }
}
-(void)getOriginal:(NSString*)host param:(NSDictionary*)dict success:(SUCCESS)success error:(ERROR)errorC{
    if ([netState currentReachabilityStatus] == NotReachable) {
        NSError *er = [NSError errorWithDomain:ERRER_MESSAGE_NOTNETWORK code:ERRER_CODE_NOTNETWORK userInfo:@{}];
        if (errorC) {
            errorC(er);
        }
        return;
    }
    [manager GET:host parameters:dict progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error&&errorC) {
            errorC(error);
        }
    }];
    
}
-(void)postOriginal:(NSString*)host param:(NSDictionary*)dict success:(SUCCESS)success error:(ERROR)errorC{
    if ([netState currentReachabilityStatus] == NotReachable) {
        NSError *er = [NSError errorWithDomain:ERRER_MESSAGE_NOTNETWORK code:ERRER_CODE_NOTNETWORK userInfo:@{}];
        if (errorC) {
            errorC(er);
        }
        return;
    }
    
    [manager POST:host parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        if (error&&errorC) {
            errorC(error);
        }
    }];
}

-(void)postOriginalFile:(NSString*)host param:(NSDictionary*)dict fileData:(NSData*)aFileData fileName:(NSString*)aFileName  type:(NSString*)aType success:(SUCCESS)success error:(ERROR)errorC{
    if ([netState currentReachabilityStatus] == NotReachable) {
        NSError *er = [NSError errorWithDomain:ERRER_MESSAGE_NOTNETWORK code:ERRER_CODE_NOTNETWORK userInfo:@{}];
        if (errorC) {
            errorC(er);
        }
        return;
    }
    [manager POST:host parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //
        if (aFileData) {
            [formData appendPartWithFileData:aFileData name:aFileName fileName:aFileName mimeType:aType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        //
        if (error&&errorC) {
            errorC(error);
        }
    }];
}
-(void)cancelAll{
    if (manager) {
        [manager.operationQueue cancelAllOperations];
    }
}
@end
