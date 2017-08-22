//
//  WebViewJS.h
//  TianLiSenProject
//
//  Created by fyaex001 on 2017/3/1.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>


@protocol WebViewJSObjectProtocol <JSExport>


-(void)cancel;


-(void)goback;

-(void)subok:(NSString *)result;

JSExportAs(share, -(void)share:(NSString *)param1 andParem2:(NSString *)param2 andParam3:(NSString *)param3 andParam4:(NSString *)param4);
@end



@protocol WebViewJSDelegate <NSObject>


-(void)gobackJS;

-(void)cancelJS;

-(void)shareJS:(NSString *)shareImg andParem2:(NSString *)shareTitle andParam3:(NSString *)shareContent andParam4:(NSString *)shareUrl;


-(void)subokJS:(NSString *)result;
@end


    

@interface WebViewJS : NSObject<WebViewJSObjectProtocol>

@property(nonatomic, weak) id<WebViewJSDelegate> delegate;


@end
