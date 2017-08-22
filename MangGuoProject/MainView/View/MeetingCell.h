//
//  MeetingCell.h
//  MangGuoProject
//
//  Created by lijunjie on 2017/8/12.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MeetingModel.h"
#import "EatModel.h"
#import "PlantModel.h"
#import "SearchModel.h"
@interface MeetingCell : UITableViewCell
@property(nonatomic,strong)UILabel *topTitle;
@property(nonatomic,strong)UILabel *contLabel;
@property(nonatomic,strong)UILabel *biaoLab;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UIImageView *cellImgview;
-(void)updatawithModel:(MeetingModel *)model;
-(void)updatawithEatModel:(EatModel *)model;
-(void)updatawithPlantModel:(PlantModel *)model;
-(void)updatawithSearchModel:(SearchModel *)model;

@end
