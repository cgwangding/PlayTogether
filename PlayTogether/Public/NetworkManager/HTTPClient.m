//
//  HTTPClient.m
//  DuoLiFarm
//
//  Created by AD-iOS on 15/5/18.
//  Copyright (c) 2015年 wangding. All rights reserved.
//

#import "HTTPClient.h"
#import "InCommonUse.h"


@interface HTTPClient ()

@property (nonatomic, strong) AFHTTPRequestOperation *currentOpration;

@end

@implementation HTTPClient

+ (instancetype)sharedClient
{
    static dispatch_once_t onceToken;
    static HTTPClient *client = nil;
    dispatch_once(&onceToken, ^{
        client = [[HTTPClient alloc]init];
    });
    return client;
}

- (NSString*)wipeOffBlankWithURLString:(NSString*)string
{
    NSRange range = [string rangeOfString:@" "];
    if (range.length <=  0) {
        return string;
    }
    NSString *preString = [string substringToIndex:range.location];
    NSString *tailString = [string substringFromIndex:range.location + range.length];
    NSString *result = [NSString stringWithFormat:@"%@%@",preString,tailString];
    return [self wipeOffBlankWithURLString:result];
}

- (NSString *)appendRequestString:(NSString*)urlString
{
    return [self wipeOffBlankWithURLString:[NSString stringWithFormat:@"%@%@",BaseInterfaceURL,urlString]];
}

+ (void)post:(NSString*)urlString params:(id)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [[self sharedClient]post:urlString params:params success:success dataError:error failure:failure];
}

- (void)post:(NSString*)urlString params:(id)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 10.0f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
    
    NSString *requestString = [self appendRequestString:urlString];
    // DDLog(@"请求的接口是：%@\n请求的参数是:%@",requestString,params);
    self.currentOpration =  [manager POST:requestString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLHideLoadAnimation;
        NSDictionary *dict = (NSDictionary*)responseObject;
        
        //  NSLog(@"成功返回的JSON数据是：%@", [self dictionaryToJson:dict]);
        
        if ([dict[@"Success"] boolValue] == true || [dict[@"Code"] integerValue] == 200) {
            
            success(dict);
        }else{
            error([dict[@"Code"] integerValue],dict[@"Msg"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLHideLoadAnimation;
        
        DDLog(@"%@",error);
        failure(error);
    }];
}
- (NSString*)dictionaryToJson:(NSDictionary *)dic
{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}
+ (void)post:(NSString*)urlString bodyParams:(id<NSCopying, NSObject>)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [[self sharedClient]post:urlString bodyParams:params success:success dataError:error failure:failure];
}


- (void)post:(NSString*)urlString bodyParams:(id<NSCopying, NSObject>)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    NSString *requestString = [self appendRequestString:urlString];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 10.0f;
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain",@"application/javascript", nil];
    
    
    DDLog(@"请求的接口是：%@\n请求的参数是:%@",requestString,params);
    
    self.currentOpration =  [manager POST:requestString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DDLog(@"接口请求成功");
        
        DLHideLoadAnimation;
        
        NSDictionary *dict = nil;
        if ([responseObject isKindOfClass:[NSData class]]) {
            
            dict = (NSDictionary*)[responseObject objectFromJSONData];
            if (dict == nil) {
                dict = [responseObject objectFromJSONDataWithParseOptions:JKParseOptionNone];
            }
            if (dict == nil) {
                dict = [responseObject objectFromJSONDataWithParseOptions:JKParseOptionStrict];
            }
            if (dict == nil) {
                dict = [responseObject objectFromJSONDataWithParseOptions:JKParseOptionComments];
            }
            if (dict == nil) {
                dict = [responseObject objectFromJSONDataWithParseOptions:JKParseOptionUnicodeNewlines];
            }
            if (dict == nil) {
                dict = [responseObject objectFromJSONDataWithParseOptions:JKParseOptionLooseUnicode];
            }
            if (dict == nil) {
                dict = [responseObject objectFromJSONDataWithParseOptions:JKParseOptionPermitTextAfterValidJSON];
            }
            if (dict == nil) {
                dict = [responseObject objectFromJSONDataWithParseOptions:JKParseOptionValidFlags];
            }
            
        }else{
            dict = (NSDictionary*)responseObject;
        }
        
        if (dict != nil && ([dict[@"IsSuccess"] boolValue] == true || [dict[@"Code"] integerValue] == 200)) {
            success(dict);
        }else{
            DLHideLoadAnimation;
            DDLog(@"数据错误时：%@",dict);
            
            error([dict[@"Code"] integerValue],dict[@"Msg"]);
            
            if ([dict[@"Code"] integerValue] == 407 || [dict[@"Code"] integerValue] == 408) {
                [self performSelector:@selector(delayPostNotification) withObject:nil afterDelay:0.75];
            }
            //如果是430
            if ([dict[@"Code"] integerValue] == 430) {
                //弹出登录
                UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"下线通知" message:@"您的账号在另一地点登录，您已被迫下线" delegate:self cancelButtonTitle:@"退出" otherButtonTitles:@"重新登录", nil];
                [alertView show];
            }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLHideLoadAnimation;
        DDLog(@"%@",error);
        failure(error);
    }];
}

- (void)delayPostNotification
{
    [[NSNotificationCenter defaultCenter]postNotificationName:ShouldShowLoginNotification object:nil];
}

+ (void)get:(NSString*)urlString params:(id)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    [[self sharedClient]get:urlString params:params success:success dataError:error failure:failure];
}

- (void)get:(NSString *)urlString params:(id)params success:(void(^)(NSDictionary* dict))success dataError:(void (^)(NSInteger code, NSString *message))error failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 10.0f;
    NSString *requestString = [self appendRequestString:urlString];
    DDLog(@"请求的接口是：%@\n请求的参数是:%@",requestString,params);
    self.currentOpration =  [manager GET:requestString parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        DLHideLoadAnimation;
        NSDictionary *dict = (NSDictionary*)responseObject;
        NSLog(@"成功返回的JSON数据是：%@", [self dictionaryToJson:dict]);
        if ([dict[@"Success"] boolValue] == true || [dict[@"Code"] integerValue] == 200) {
            success(dict);
        }else{
            error([dict[@"Code"] integerValue],dict[@"Msg"]);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DLHideLoadAnimation;
        DDLog(@"%@",error);
        failure(error);
    }];
}


#pragma mark - 图片上传方法

+ (void)post:(NSString*)url imageName:(NSString*)name success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure
{
    [[self sharedClient]post:url imageName:name success:success failure:failure];
}

+ (void)post:(NSString*)url imageData:(NSData*)data success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure
{
    [[self sharedClient]post:url imageData:data success:success failure:failure];
}


- (void)post:(NSString*)url imageName:(NSString*)name success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 30.0f;
    
    [manager POST:[self appendRequestString:url] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        UIImage *image = [UIImage imageNamed:name];
        NSData *data = UIImagePNGRepresentation(image);
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png",str];
        
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        DDLog(@"图片上传成功");
        
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DDLog(@"图片上传失败>>%@",error);
        if (failure) {
            failure(error);
        }
    }];
}

- (void)post:(NSString*)url imageData:(NSData*)data success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer.timeoutInterval = 30.0f;
    
    [manager POST:[self appendRequestString:url] parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png",str];
        
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/png"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        DDLog(@"图片上传成功");
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DDLog(@"图片上传失败>>%@",error);
        if (failure) {
            failure(error);
        }
    }];
}

- (void)post:(NSString *)url constructingBodyWithBlock:(void (^)(id<AFMultipartFormData> formData))block success:(void (^)(id responseObj))success failure:(void (^)(NSError *error))failure
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 30.0f;
    DDLog(@"请求的接口是：%@",[self appendRequestString:url]);
    
    [manager POST:[self appendRequestString:url] parameters:nil constructingBodyWithBlock:block success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)cancel
{
    if (self.currentOpration.isExecuting) {
        [self.currentOpration cancel];
        DDLog(@"当前请求取消 %@",self.currentOpration);
        self.currentOpration =  nil;
    }
    
}


@end
