//
//  HomeTableViewCell.m
//  MangGuoProject
//
//  Created by lijunjie on 2017/6/15.
//  Copyright © 2017年 dev. All rights reserved.
//

#import "HomeTableViewCell.h"

@implementation HomeTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UIView *sepView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreen_Width, 0.7)];
        sepView.backgroundColor=[UIColor colorWithHexString:@"0xf0eff4"];
        [self.contentView addSubview:sepView];
        
        UIImageView *cellImgview=[[UIImageView alloc]initWithFrame:CGRectMake(20, 20, 100, 100)];
        self.cellImgview=cellImgview;
       // cellImgview.image=[UIImage imageNamed:@"mg"];
        [self.contentView addSubview:cellImgview];
        
        UILabel *topTitle=[[UILabel alloc]initWithFrame:CGRectMake(140, 20, kScreen_Width-150, 20)];
        self.topTitle=topTitle;
        topTitle.font=[UIFont systemFontOfSize:19];
        topTitle.text=@"重要的宣传推广";
        [self.contentView addSubview:topTitle];
        
        UILabel *contLabel=[[UILabel alloc]init];
        self.contLabel=contLabel;
        contLabel.font=[UIFont systemFontOfSize:14];
        contLabel.frame=CGRectMake(140, 45, kScreen_Width-150,40);
        contLabel.text=@"芒果为著名热带水果之一，芒果果实含有糖、蛋白质、粗纤维，芒果所含有的维生素A";
        contLabel.textColor=[UIColor grayColor];
        contLabel.numberOfLines=0;
        [self.contentView addSubview:contLabel];
        
        UILabel *biaoLab=[[UILabel alloc]init];
        biaoLab.textAlignment=NSTextAlignmentCenter;
        biaoLab.text=@"种植技术";
        self.biaoLab=biaoLab;
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:14]};
        CGSize size=[biaoLab.text sizeWithAttributes:attrs];
        biaoLab.frame=CGRectMake(140, 100, size.width+10, 20);
        biaoLab.font=[UIFont systemFontOfSize:14];
        biaoLab.textColor=[UIColor grayColor];
        biaoLab.backgroundColor=[UIColor colorWithHexString:@"0xf0eff4"];
        [self.contentView addSubview:biaoLab];
        
        UILabel *timeLab=[[UILabel alloc]init];
        self.timeLab=timeLab;
        timeLab.font=[UIFont systemFontOfSize:14];
        timeLab.textColor=[UIColor grayColor];
        timeLab.text=@"2015/06/07";
        timeLab.textAlignment=NSTextAlignmentRight;
        [self.contentView addSubview:timeLab];
        [timeLab autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:20];
        [timeLab autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:100];
        [timeLab autoSetDimensionsToSize:CGSizeMake(100, 20)];
        
    }
    return self;
}
-(void)updatawithModel:(HomeModel *)model{
    [self.cellImgview sd_setImageWithURL:[NSURL URLWithString:model.logo_image] placeholderImage:[UIImage imageNamed:@"defautLogo"]];
    self.topTitle.text=model.news_name;
    self.contLabel.text=model.excerpt;
    self.biaoLab.text=model.cat_name;
    self.timeLab.text=model.add_time;
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:14]};
    CGSize size;
    if (self.biaoLab.text.length>6) {
        size=[@"田东县芒果的哈" sizeWithAttributes:attrs];
    }else{
        size=[self.biaoLab.text sizeWithAttributes:attrs];
    }
   
    self.biaoLab.frame=CGRectMake(140, 100, size.width+10, 20);

}
-(void)updatawithSeModel:(SecondModel *)model{
    [self.cellImgview sd_setImageWithURL:[NSURL URLWithString:model.logo_image] placeholderImage:[UIImage imageNamed:@"defautLogo"]];
    self.topTitle.text=[NSString stringWithFormat:@"%@-采摘计划",model.name] ;
    self.contLabel.text=model.except;
    self.biaoLab.text=model.name;
    self.timeLab.text=model.add_time;
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:14]};
    CGSize size;
    if (self.biaoLab.text.length>6) {
        size=[@"田东县芒果的哈" sizeWithAttributes:attrs];
    }else{
        size=[self.biaoLab.text sizeWithAttributes:attrs];
    }

    self.biaoLab.frame=CGRectMake(140, 100, size.width+10, 20);

}
-(void)updatawithSeOtherModel:(SencondOtherModel *)model{
    [self.cellImgview sd_setImageWithURL:[NSURL URLWithString:model.logo_image] placeholderImage:[UIImage imageNamed:@"defautLogo"]];
    self.topTitle.text=model.news_name;
    self.contLabel.text=model.excerpt;
    self.biaoLab.text=model.author;
    self.timeLab.text=model.add_time;
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont boldSystemFontOfSize:14]};
    CGSize size;
    if (self.biaoLab.text.length>6) {
        size=[@"田东县芒果的哈" sizeWithAttributes:attrs];
    }else{
        size=[self.biaoLab.text sizeWithAttributes:attrs];
    }

    self.biaoLab.frame=CGRectMake(140, 100, size.width+10, 20);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
