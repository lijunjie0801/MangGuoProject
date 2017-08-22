//
//  SendOtherViewController.h
//  MangGuoProject
//
//  Created by lijunjie on 2017/6/21.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol sendOtherDelegate<NSObject>
-(void)towebview:(NSString *)weburl:(NSMutableDictionary *)dic;
@end
@interface SendOtherViewController : UIViewController
@property(nonatomic, weak)id<sendOtherDelegate>delegate;
@end
