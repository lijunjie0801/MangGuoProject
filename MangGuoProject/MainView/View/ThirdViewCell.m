//
//  ThirdViewCell.m
//  MangGuoProject
//
//  Created by lijunjie on 2017/6/15.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "ThirdViewCell.h"

@implementation ThirdViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor=[UIColor colorWithHexString:@"0xf0eff4"];
        UIView *backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 110)];
        backView.backgroundColor=[UIColor whiteColor];
        [self.contentView addSubview:backView];
        
        UIImageView *cellImgview=[[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 80, 80)];
        self.cellImgview=cellImgview;
        cellImgview.image=[UIImage imageNamed:@"defautLogo"];
        cellImgview.clipsToBounds=YES;
        cellImgview.layer.cornerRadius=40;

        [backView addSubview:cellImgview];
        
        UILabel *topTitle=[[UILabel alloc]initWithFrame:CGRectMake(100, 15, kScreen_Width-110, 20)];
        self.topTitle=topTitle;
        topTitle.font=[UIFont systemFontOfSize:19];
        topTitle.text=@"重要的宣传推广";
        [backView addSubview:topTitle];
        
        UILabel *contLabel=[[UILabel alloc]init];
        contLabel.font=[UIFont systemFontOfSize:14];
        contLabel.frame=CGRectMake(100, 55, kScreen_Width-160,40);
        contLabel.text=@"芒果为著名热带水果之一，芒果果实含有糖、蛋白质、粗纤维，芒果所含有的维生素A";
        self.contLabel=contLabel;
        contLabel.textColor=[UIColor grayColor];
        contLabel.numberOfLines=0;
        [backView addSubview:contLabel];
        
        UIImageView *moreview=[[UIImageView alloc]initWithFrame:CGRectMake(kScreen_Width-20, 47.5, 10, 15)];
        moreview.image=[UIImage imageNamed:@"more"];
        [backView addSubview:moreview];

    }
    return self;
}

-(void)updatawithModel:(ThirdModel *)model{
    [self.cellImgview sd_setImageWithURL:[NSURL URLWithString:model.logo_image] placeholderImage:[UIImage imageNamed:@"defautLogo"]];
    self.contLabel.text=model.point;
    self.topTitle.text=model.name;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
