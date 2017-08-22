//
//  ThirdViewCell.h
//  MangGuoProject
//
//  Created by lijunjie on 2017/6/15.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThirdModel.h"
@interface ThirdViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *contLabel;
@property(nonatomic,strong)UILabel *topTitle;
@property(nonatomic,strong)UIImageView *cellImgview;
-(void)updatawithModel:(ThirdModel *)model;
@end
