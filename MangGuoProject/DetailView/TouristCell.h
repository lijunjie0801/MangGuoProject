//
//  TouristCell.h
//  MangGuoProject
//
//  Created by lijunjie on 2017/8/14.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TourModel.h"
@interface TouristCell : UICollectionViewCell
@property (nonatomic, strong) TourModel *model;
-(void)updateWithModel:(TourModel *)model;
@property(nonatomic, strong) NSString *indexRow;
@end
