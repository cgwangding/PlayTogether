//
//  HTTPClient.h
//  DuoLiFarm
//
//  Created by AD-iOS on 15/5/18.
//  Copyright (c) 2015年 wangding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface HTTPClient : NSObject

+ (instancetype)sharedClient;

/**
 *  post请求时使用
 *
 *  @param urlString 请求的接口地址
 *  @param params    请求的参数
 *  @param success   请求成功且数据正确时的回调
 *  @param error     请求成功但是返回的状态为失败的回调
 *  @param failure   请求失败的回调
 */
+ (void)post:(NSString*)urlString params:(id)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

//参数放在body中时使用
+ (void)post:(NSString*)urlString bodyParams:(id)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

+ (void)post:(NSString*)url imageName:(NSString*)name success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

+ (void)post:(NSString*)url imageData:(NSData*)data success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;


- (void)post:(NSString*)urlString params:(id)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

- (void)post:(NSString*)url imageName:(NSString*)name success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

- (void)post:(NSString*)url imageData:(NSData*)data success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

- (void)post:(NSString *)url constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> formData))block success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure;

/**
 *  get请求方式使用这个方法
 *
 *  @param urlString 请求的接口地址
 *  @param params    请求的参数
 *  @param success   请求成功且数据正确时的回调
 *  @param error     请求成功但是返回的状态为失败的回调
 *  @param failure   请求失败的回调
 */
+ (void)get:(NSString*)urlString params:(id)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure;

- (void)cancel;

@end
