//
//  SearchModel.h
//  MangGuoProject
//
//  Created by lijunjie on 2017/8/15.
//  Copyright © 2017年 dev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SearchModel : NSObject
@property(nonatomic,strong)NSString *nid;
@property(nonatomic,strong)NSString *news_name;
@property(nonatomic,strong)NSString *logo_image;
@property(nonatomic,strong)NSString *add_time;
@property(nonatomic,strong)NSString *excerpt;
@property(nonatomic,strong)NSString *cat;
@property(nonatomic,strong)NSString *author;
@end
