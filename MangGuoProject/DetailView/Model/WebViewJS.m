//
//  WebViewJS.m
//  TianLiSenProject
//
//  Created by fyaex001 on 2017/3/1.
//  Copyright © 2017年 fyaex. All rights reserved.
//

#import "WebViewJS.h"

@implementation WebViewJS

-(void)cancel{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(cancelJS)]) {
            [self.delegate cancelJS];
        }
    });
}
-(void)goback{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(gobackJS)]) {
            [self.delegate gobackJS];
        }
    });
}
-(void)subok:(NSString *)result{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(subokJS:)]) {
            [self.delegate subokJS:result];
        }
    });

}
-(void)share:(NSString *)param1 andParem2:(NSString *)param2 andParam3:(NSString *)param3 andParam4:(NSString *)param4
{
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([self.delegate respondsToSelector:@selector(shareJS:andParem2:andParam3:andParam4:)]) {
            [self.delegate shareJS:param1 andParem2:param2 andParam3:param3 andParam4:param4];
        }

        
        
    });
}

@end

