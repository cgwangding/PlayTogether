//
//  FEUserData.m
//  FinanceExamination
//
//  Created by AD-iOS on 15/7/29.
//  Copyright (c) 2015年 Adinnet. All rights reserved.
//

#import "APUserData.h"

@implementation APUserData
@synthesize online = _online,headerURL = _headerURL,tokenID = _tokenID,userID = _userID,userName = _userName, userPassword = _userPassword, telephone = _telephone, sex = _sex, realName = _realName, idCard = _idCard, address = _address, alias = _alias,longitude = _longitude,latitude = _latitude;

- (void)configData:(NSDictionary *)dict
{
    if ([dict[@"address"] isBlankString]) {
        self.address  = @"";
    }else{
        self.address  = dict[@"address"];
    }
    
    if ([dict[@"alias"] isBlankString]) {
        self.alias = @"";
    }else{
        self.alias = dict[@"alias"];
    }
    
    if ([dict[@"idCard"] isBlankString]) {
        self.idCard = @"";
    }else{
        self.idCard = dict[@"idCard"];
    }
    if ([dict[@"realName"] isBlankString]) {
        self.realName = @"";
    }else{
        self.realName = dict[@"realName"];
    }
    
    if ([dict[@"sex"] isBlankString]) {
        self.sex = @"";
    }else{
        self.sex = dict[@"sex"];
    }
    
    if ([dict[@"telephone"] isBlankString]) {
        self.telephone = @"";
    }else{
        self.telephone = dict[@"telephone"];
    }
    
    if ([dict[@"tokenID"] isBlankString]) {
        self.tokenID = @"";
    }else{
        self.tokenID = dict[@"tokenID"];
    }
    
    if ([dict[@"userID"] isBlankString]) {
        self.userID = @"";
    }else{
        self.userID = dict[@"userID"];
    }
    
    if ([dict[@"userName"] isBlankString]) {
        self.userName = @"";
    }else{
        self.userName = dict[@"userName"];
    }
    
    if ([dict[@"userPassword"] isBlankString]) {
        self.userPassword = @"";
    }else{
        self.userPassword = dict[@"userPassword"];
    }
    
    if ([dict[@"headImg"] isBlankString]) {
        self.headerURL = @"";
    }else{
        self.headerURL = dict[@"headImg"];

    }
}

+ (instancetype)sharedUserData
{
    static APUserData *user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[APUserData alloc]init];
    });
    return user;
}

- (void)setOnline:(BOOL)online
{
    _online = online;
    default_add_Bool(_online, @"online");
    default_synchronize;
    if (!online) {
        self.tokenID = @"";
        self.userPassword = @"";
        self.userID = @"";
        self.userName = @"";
        self.telephone = @"";
        self.sex  = @"";
        self.realName = @"";
        self.idCard = @"";
        self.alias = @"";
        self.address = @"";
        self.headerURL = @"";

    }
}

- (BOOL)isOnline
{
    return default_get_Bool(@"online");
}

- (NSString *)headerURL
{
    return default_get_Object(@"headerURL")?default_get_Object(@"headerURL"):@"";
}

- (void)setHeaderURL:(NSString *)headerURL
{
    _headerURL = [headerURL copy];
    default_add_Object(_headerURL?_headerURL:@"", @"headerURL");
    default_synchronize;
}

- (NSString *)tokenID
{
    return default_get_Object(@"tokenID")?default_get_Object(@"tokenID"):@"";
}

- (void)setTokenID:(NSString *)tokenID
{
    _tokenID = [tokenID copy];
    default_add_Object(_tokenID?_tokenID:@"", @"tokenID");
    default_synchronize;
}

- (NSString *)userID
{
    return default_get_Object(@"userID")?default_get_Object(@"userID"):@"";
}

- (void)setUserID:(NSString *)userID
{
    _userID = [userID copy];
    default_add_Object(_userID?_userID:@"", @"userID");
    default_synchronize;
}

- (NSString *)userName
{
    return default_get_Object(@"userName")?default_get_Object(@"userName"):@"";
}

- (void)setUserName:(NSString *)userName
{
    _userName = [userName copy];
    default_add_Object(_userName?_userName:@"", @"userName");
    default_synchronize;
}

- (NSString *)userPassword
{
    return  default_get_Object(@"userPassword")?default_get_Object(@"userPassword"):@"";
}

- (void)setUserPassword:(NSString *)userPassword
{
    _userPassword = [userPassword copy];
    default_add_Object(_userPassword?_userPassword:@"", @"userPassword");
    default_synchronize;
}

- (NSString *)telephone
{
    return default_get_Object(@"telephone")?default_get_Object(@"telephone"):@"";
}

- (void)setTelephone:(NSString *)telephone
{
    _telephone = [telephone copy];
    default_add_Object(_telephone?_telephone:@"", @"telephone");
    default_synchronize;
}

- (NSString *)sex
{
    return default_get_Object(@"sex")?default_get_Object(@"sex"):@"";
}

- (void)setSex:(NSString *)sex
{
    _sex = [sex copy];
    default_add_Object(_sex?_sex:@"", @"sex");
    default_synchronize;
}

- (NSString *)realName
{
    return default_get_Object(@"realName")?default_get_Object(@"realName"):@"";
}

- (void)setRealName:(NSString *)realName
{
    _realName = [realName copy];
    default_add_Object(_realName?_realName:@"", @"realName");
    default_synchronize;
}

- (NSString *)idCard
{
    return default_get_Object(@"idCard")?default_get_Object(@"idCard"):@"";
}

- (void)setIdCard:(NSString *)idCard
{
    _idCard = [idCard copy];
    default_add_Object(_idCard?_idCard:@"",@"idCard");
    default_synchronize;
}

-(NSString *)address{
    return default_get_Object(@"address")?default_get_Object(@"address"):@"";
}

- (void)setAddress:(NSString *)address
{
    _address = [address copy];
    default_add_Object(_address?_address:@"", @"address");
    default_synchronize;
}

- (NSString *)alias
{
    return default_get_Object(@"alias")?default_get_Object(@"alias"):@"";
}

- (void)setAlias:(NSString *)alias
{
    _alias = [alias copy];
    default_add_Object(_alias?_alias:@"", @"alias");
    default_synchronize;
}

@end
