//
//  HttpManagerPort.m
//  TianLiSenProject
//
//  Created by fyaex001 on 2017/2/28.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import "HttpManagerPort.h"
#import "ZZLProgressHUD.h"
#import "HttpManagers.h"
@implementation HttpManagerPort
DEFINE_SINGLETON_FOR_CLASS(HttpManagerPort)


/**获取验证码**/
-(void)getVerficode:(NSString *)mobile Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api59464a51a95bf",kBaseUrl] parameters:@{@"mobile":mobile} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        
        failure(error);
    }];
    
}

/**获取h5元素**/
-(void)getH5Detail:(NSString *)news_id Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]GET:@"http://mgsl.zilankeji.com/H5/detail/meettings" parameters:@{@"id":news_id} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        
        failure(error);
    }];
    
}
/**注册**/
-(void)toRegist:(NSString *)mobile password:(NSString *)password chkcode:(NSString *)chkcode username:(NSString *)username Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api59472408ef5fc",kBaseUrl] parameters:@{@"mobile":mobile,@"password":password,@"chkcode":chkcode,@"username":username} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

/**登录**/
-(void)getLogin:(NSString *)username password:(NSString *)password Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api594754a63f101",kBaseUrl] parameters:@{@"username":username,@"password":password} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**忘记密码**/
-(void)forgetPassword:(NSString *)mobile chkcode:(NSString *)chkcode password:(NSString *)password repassword:(NSString *)repassword Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api5947aa5956b4d",kBaseUrl] parameters:@{@"mobile":mobile,@"chkcode":chkcode,@"password":password,@"repassword":repassword} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**修改密码**/
-(void)changePassword:(NSString *)uid password:(NSString *)password  new_password:(NSString *)new_password Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api594b5621a8523",kBaseUrl] parameters:@{@"uid":uid,@"password":password,@"new_password":new_password} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];

}
/**获取首页数据**/
-(void)getHomeData:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api594873bf1ed1d",kBaseUrl] parameters:nil IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
    
}
/**吃法大全数据**/
-(void)getEatingData:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/home/goods/eatwayai",BaseUrl] parameters:nil IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
    
}
/**大会活动数据**/
-(void)getMeetingData:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/home/goods/meetingai",BaseUrl] parameters:nil IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
    
}
/**获取版本号数据**/
-(void)getbanben:(NSString *)version type:(NSString *)type Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api59463429c1ea9",kBaseUrl] parameters:@{@"version":version,@"type":type} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**获取个人信息数据**/
-(void)getUserIndexData:(NSString *)uid Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api59464a28a4a2d",kBaseUrl] parameters:@{@"uid":uid} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}




/**上传头像**/
-(void)changeUserIcon:(NSString *)uid imgstr:(NSString *)imgstr Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api594635e5c2034",kBaseUrl] parameters:@{@"uid":uid,@"imgstr":imgstr} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

/**采摘计划**/
-(void)getCaizhaiPlanData:(NSString *)order Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api594638d6a382a",kBaseUrl] parameters:@{@"order":order} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

/**采摘通告**/
-(void)getCaizhaiNotiData:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api59463a5cba0c2",kBaseUrl] parameters:nil IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
    
}
/**品种荟萃**/
-(void)pinzhongData:(NSString *)order Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api59463abcc94e1",kBaseUrl] parameters:@{@"order":order} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**获取搜索数据**/
-(void)getSearchData:(NSString *)key Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]GET:[NSString stringWithFormat:@"%@/goods/searchs",BaseUrl] parameters:@{@"key":key} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**种植技术**/
-(void)PlantData:(NSString *)cat Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]GET:[NSString stringWithFormat:@"%@/home/goods/plan_technologyai",BaseUrl] parameters:@{@"cat":cat} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**旅游列表**/
-(void)getTourData:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/home/goods/around_playai",BaseUrl] parameters:nil IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
    
}

/**订购需求**/
-(void)dinggouData:(NSString *)order uid:(NSString *)uid Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api5946443a3e9f4",kBaseUrl] parameters:@{@"order":order,@"uid":uid} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}
/**角色变更**/
-(void)roleChange:(NSString *)group_id uid:(NSString *)uid Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api5947aee0e618a",kBaseUrl] parameters:@{@"group_id":group_id,@"uid":uid} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
}

/**修改个人信息**/
-(void)changeUserInfo:(NSString *)uid imgstr:(NSString *)imgstr username:(NSString *)username sex:(NSString *)sex mobile:(NSString *)mobile Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/api594635e5c2034",kBaseUrl] parameters:@{@"uid":uid,@"imgstr":imgstr,@"username":username,@"sex":sex,@"mobile":mobile,} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
    
}
/**test**/
//-(void)test:(NSString *)nfcCode page:(NSString *)page pageSize:(NSString *)pageSize Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
//    [[HttpManagers sharedNetManager]POST:@"http://www.eifire.net:9010/EIFIRE_Interface.asmx" parameters:@{@"nfcCode":nfcCode,@"page":page,@"pageSize":pageSize} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
//        success(responseObject);
//    } failure:^(NSError * _Nonnull error) {
//        failure(error);
//    }];
//    
//}
/**提交评论**/
-(void)submitComent:(NSString *)user_id  news_id:(NSString *)news_id  content:(NSString *)content Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/goods/comment",BaseUrl] parameters:@{@"user_id":user_id,@"news_id":news_id,@"content":content} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
    
}
/**回复评论**/
-(void)replyComment:(NSString *)user_id  news_id:(NSString *)news_id  content:(NSString *)content f_id:(NSString *)f_id Success:(void(^)(id responseObject))success Failure:(void(^)(NSError *error))failure{
    [[HttpManagers sharedNetManager]POST:[NSString stringWithFormat:@"%@/goods/comment",BaseUrl] parameters:@{@"user_id":user_id,@"news_id":news_id,@"content":content,@"f_id":f_id} IsCache:NO ShowMsg:nil success:^(id  _Nonnull responseObject) {
        success(responseObject);
    } failure:^(NSError * _Nonnull error) {
        failure(error);
    }];
    
}

@end
