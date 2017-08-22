//
//  HttpManagerPort.h
//  TianLiSenProject
//
//  Created by fyaex001 on 2017/2/28.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MySingleton.h"
@interface HttpManagerPort : NSObject
DEFINE_SINGLETON_FOR_HEADER(HttpManagerPort)

/**获取验证码**/
-(void)getVerficode:(NSString *)mobile Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**注册**/
-(void)toRegist:(NSString *)mobile password:(NSString *)password chkcode:(NSString *)chkcode username:(NSString *)username Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**登录**/
-(void)getLogin:(NSString *)username password:(NSString *)password Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**忘记密码**/
-(void)forgetPassword:(NSString *)mobile chkcode:(NSString *)chkcode password:(NSString *)password repassword:(NSString *)repassword Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**修改密码**/
-(void)changePassword:(NSString *)uid password:(NSString *)password  new_password:(NSString *)new_password Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**获取首页数据**/
-(void)getHomeData:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**获取搜索数据**/
-(void)getSearchData:(NSString *)key Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**获取个人信息数据**/
-(void)getUserIndexData:(NSString *)uid Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**上传头像**/
-(void)changeUserIcon:(NSString *)uid imgstr:(NSString *)imgstr Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**采摘计划**/
-(void)getCaizhaiPlanData:(NSString *)order Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**采摘通告**/
-(void)getCaizhaiNotiData:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**品种荟萃**/
-(void)pinzhongData:(NSString *)order Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**订购需求**/
-(void)dinggouData:(NSString *)order uid:(NSString *)uid Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**角色变更**/
-(void)roleChange:(NSString *)group_id uid:(NSString *)uid Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**修改个人信息**/
-(void)changeUserInfo:(NSString *)uid imgstr:(NSString *)imgstr username:(NSString *)username sex:(NSString *)sex mobile:(NSString *)mobile Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**获取版本号数据**/
-(void)getbanben:(NSString *)version type:(NSString *)type Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;

/**test**/
-(void)test:(NSString *)nfcCode page:(NSString *)page pageSize:(NSString *)pageSize Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**获取h5元素**/
-(void)getH5Detail:(NSString *)news_id Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**吃法大全数据**/
-(void)getEatingData:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**大会活动数据**/
-(void)getMeetingData:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**种植技术**/
-(void)PlantData:(NSString *)cat Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**旅游列表**/
-(void)getTourData:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
/**提交评论**/
-(void)submitComent:(NSString *)user_id  news_id:(NSString *)news_id  content:(NSString *)content Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure;
@end
