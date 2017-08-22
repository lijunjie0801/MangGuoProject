//
//  SencondDetailViewController.h
//  MangGuoProject
//
//  Created by lijunjie on 2017/6/15.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol HomeViewCellDelegate<NSObject>
-(void)toweb:(NSString *)weburl:(NSMutableDictionary *)dic;
@end
@interface SencondDetailViewController : UIViewController

@property(nonatomic,strong)NSString *type;
@property(nonatomic,strong)NSString *caizhaiType;
@property(nonatomic, weak)id<HomeViewCellDelegate>delegate;
@end
