//
//  SearchViewController.h
//  MangGuoProject
//
//  Created by lijunjie on 2017/8/12.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SearchViewDelegate<NSObject>
-(void)pushview:(NSString *)uid;
@end
@interface SearchViewController : UIViewController
@property(nonatomic, weak)id<SearchViewDelegate>delegate;

@end
