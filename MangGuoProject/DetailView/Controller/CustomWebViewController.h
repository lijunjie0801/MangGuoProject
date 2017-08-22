//
//  CustomWebViewController.h
//  MangGuoProject
//
//  Created by lijunjie on 2017/6/22.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol webdelegate<NSObject>
-(void)pubresult:(NSString *)weburl;
@end
@interface CustomWebViewController : UIViewController
@property(nonatomic,strong)NSString *webUrl;
@property(nonatomic,strong)NSString *shareImg;
@property(nonatomic,strong)NSString *shareTitle;
@property(nonatomic,strong)NSString *shareContent;
@property(nonatomic,strong)NSString *shareURL;
@property(nonatomic, weak)id<webdelegate>delegate;
@end
