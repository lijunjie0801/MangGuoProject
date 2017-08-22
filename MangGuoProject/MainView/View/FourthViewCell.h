//
//  FourthViewCell.h
//  MangGuoProject
//
//  Created by lijunjie on 2017/6/15.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FourthModel.h"
@interface FourthViewCell : UITableViewCell
@property(nonatomic,strong)UIImageView *cellImgview;
@property(nonatomic,strong)UILabel *topTitle;
@property(nonatomic,strong)UILabel *contLabel;
@property(nonatomic,strong)UILabel *biaoLab;
@property(nonatomic,strong)UILabel *timeLab;
-(void)updatawithModel:(FourthModel *)model;
@end
