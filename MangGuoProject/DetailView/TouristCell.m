//
//  TouristCell.m
//  MangGuoProject
//
//  Created by lijunjie on 2017/8/14.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "TouristCell.h"
@interface TouristCell ()

@property (nonatomic, strong) UIImageView *imageV,*freeImgview;
@property (nonatomic, strong) UILabel *mieLabel;
@property (nonatomic, strong) UILabel *openTimeLb;
@property (nonatomic, strong) UILabel *positionLabel;
@property (nonatomic, strong) UILabel *numLabel;
@end
@implementation TouristCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configureUI];
    }
    return self;
}

- (void)configureUI
{
    self.contentView.backgroundColor=[UIColor whiteColor];
    _imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width/1.5)];
    [self.contentView addSubview:_imageV];
    
    _mieLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, self.bounds.size.width/1.5, self.bounds.size.width-10-40, 40)];
    [self.contentView addSubview:_mieLabel];
    
    
    _freeImgview=[[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width-40, self.bounds.size.width/1.5, 32, 32*1.2)];
     [self.contentView addSubview:_freeImgview];
    UIImageView *opentime=[[UIImageView alloc] initWithFrame:CGRectMake(10, self.bounds.size.width/1.5+50, 21, 20)];
    
    opentime.image=[UIImage imageNamed:@"opentime"];
    [self.contentView addSubview:opentime];
    
    _openTimeLb=[[UILabel alloc]initWithFrame:CGRectMake(40,self.bounds.size.width/1.5+50, self.bounds.size.width-40,20)];
    [self.contentView addSubview:_openTimeLb];
    
    _mieLabel.font=[UIFont systemFontOfSize:18];
    _openTimeLb.textColor=[UIColor grayColor];
    
}

-(void)updateWithModel:(TourModel *)model{
    [_imageV sd_setImageWithURL:[NSURL URLWithString:model.logo_image]];
    _mieLabel.text=model.scenic_name;
    if ([model.isfree integerValue]==1) {
        _freeImgview.hidden=NO;
    }else{
        _freeImgview.hidden=YES;
    }
    _freeImgview.image=[UIImage imageNamed:@"freeOpen"];
    _openTimeLb.text=model.open_time;
    
//    _positionLabel.text=[NSString stringWithFormat:@"位置:%@",model.position];
//    _numLabel.text=[NSString stri
}
@end
