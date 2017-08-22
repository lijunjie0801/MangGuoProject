//
//  HomeTableViewCell.h
//  MangGuoProject
//
//  Created by lijunjie on 2017/6/15.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
#import "SecondModel.h"
#import "SencondOtherModel.h"
@interface HomeTableViewCell : UITableViewCell
@property(nonatomic,strong)UILabel *topTitle;
@property(nonatomic,strong)UILabel *contLabel;
@property(nonatomic,strong)UILabel *biaoLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UIImageView *cellImgview;
-(void)updatawithModel:(HomeModel *)model;
-(void)updatawithSeModel:(SecondModel *)model;
-(void)updatawithSeOtherModel:(SencondOtherModel *)model;
@end
