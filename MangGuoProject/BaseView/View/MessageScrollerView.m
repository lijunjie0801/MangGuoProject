//
//  MessageScrollerView.m
//  GoodCard
//
//  Created by fyaex001 on 16/8/9.
//  Copyright © 2016年 fyaex. All rights reserved.
//

#import "MessageScrollerView.h"
//#import "MessageScrollerModel.h"
//#import "SwitchViewController.h"

@interface MessageScrollerView()

@property (nonatomic,strong) UIScrollView * scrollView;
@property (nonatomic,strong) NSArray *array;
@property (nonatomic,assign)int num;
@property (nonatomic,assign)int num1;

@end


@implementation MessageScrollerView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initUI];
    }
    return self;
}


-(void)initUI
{
    self.backgroundColor = [UIColor whiteColor];
    self.num1 = 0;
    self.array = [[NSMutableArray alloc] init];
}


-(void)setDataMessageArray:(NSArray *)dataMessageArray
{
    _array = dataMessageArray;
    
    _num = 0;
    CGFloat btnwidth=(kScreen_Width-80)/5;
    CGFloat marginWH = (kScreen_Width-80)/5;
    CGFloat withHeight = btnwidth/2;
    
    //移除所有的视图
    [_scrollView removeFromSuperview];
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, marginWH)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_scrollView];
    
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.pagingEnabled = NO;
    _scrollView.scrollEnabled = NO;
    _scrollView.contentSize = CGSizeMake(kScreen_Width-50-20, marginWH*(_array.count+1));
    
    
    if (self.array.count !=0) {
        
        int num = self.array.count%2 ==0 ?self.array.count/2 : self.array.count/2+1;
        
        
        for (int i = 0; i<num; i++) {
            UILabel * titlelbl = [[UILabel alloc]initWithFrame:CGRectMake(0, marginWH*i+2.5, self.frame.size.width*0.2, withHeight-5)];
            titlelbl.font =[UIFont systemFontOfSize:12];
            titlelbl.text =@"订购需求";
            titlelbl.layer.borderColor=[UIColor redColor].CGColor;
            titlelbl.layer.cornerRadius=3;
            titlelbl.textAlignment=NSTextAlignmentCenter;
            titlelbl.layer.borderWidth=1.0;
        //    titlelbl.textAlignment = NSTextAlignmentLeft;
            [_scrollView addSubview:titlelbl];
            
            titlelbl.userInteractionEnabled = YES;
            titlelbl.tag = i;
            UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(UesrClicked:)];
            [titlelbl addGestureRecognizer:tag];
            
            UILabel * titlelbl1 = [[UILabel alloc]initWithFrame:CGRectMake(0, marginWH*i+withHeight+2.5, self.frame.size.width*0.2, withHeight-5)];
            titlelbl1.font = [UIFont systemFontOfSize:12];
            titlelbl1.text = @"种植技术";
            titlelbl1.layer.cornerRadius=3;
            titlelbl1.textAlignment=NSTextAlignmentCenter;
            //titlelbl1.textAlignment = NSTextAlignmentLeft;
            titlelbl1.layer.borderColor=[UIColor redColor].CGColor;
            titlelbl1.layer.borderWidth=1.0;
            [_scrollView addSubview:titlelbl1];
            
            titlelbl1.userInteractionEnabled = YES;
            titlelbl1.tag = i+1;
            UITapGestureRecognizer *tag1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(UesrClicked:)];
            [titlelbl1 addGestureRecognizer:tag1];
            

            UILabel * titlelbl3 = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width*0.2+10, marginWH*i, self.frame.size.width*0.8-10, withHeight)];
            titlelbl3.font =[UIFont systemFontOfSize:12];
            titlelbl3.text =_array[i*2];
            titlelbl3.textAlignment = NSTextAlignmentLeft;
            [_scrollView addSubview:titlelbl3];
            
//            titlelbl3.userInteractionEnabled = YES;
//            titlelbl3.tag = i;
//            UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(UesrClicked:)];
//            [titlelbl3 addGestureRecognizer:tag];
            
            UILabel * titlelbl4 = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width*0.2+10, marginWH*i+withHeight, self.frame.size.width*0.8-10, withHeight)];
            titlelbl4.font = [UIFont systemFontOfSize:12];
            titlelbl4.text = _array[i*2+1];
            titlelbl4.textAlignment = NSTextAlignmentLeft;
            [_scrollView addSubview:titlelbl4];
            
//            titlelbl1.userInteractionEnabled = YES;
//            titlelbl1.tag = i+1;
//            UITapGestureRecognizer *tag1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(UesrClicked:)];
//            [titlelbl1 addGestureRecognizer:tag1];
            

            
            
        }
        
        
        UILabel * titlelbl = [[UILabel alloc]initWithFrame:CGRectMake(0, marginWH*_array.count, self.frame.size.width, withHeight)];
        
      
        titlelbl.font = [UIFont systemFontOfSize:12];
        titlelbl.text =@"lijunjie";
        titlelbl.textAlignment = NSTextAlignmentLeft;
        [_scrollView addSubview:titlelbl];
        
        titlelbl.userInteractionEnabled = YES;
        titlelbl.tag = 0;
        UITapGestureRecognizer *tag = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(UesrClicked:)];
        [titlelbl addGestureRecognizer:tag];
        
        
//        MessageScrollerModel * model2 = [MessageScrollerModel new];
        
//        if (self.array.count>=2) {
//            
//            model2 = (MessageScrollerModel *)self.array[1];
//            
//        }else{
//        
//            model2 = (MessageScrollerModel *)self.array[0];
//        }
        
        
        UILabel * titlelbl1 = [[UILabel alloc]initWithFrame:CGRectMake(0,  marginWH*_array.count+withHeight, self.frame.size.width, withHeight)];
        titlelbl1.font = [UIFont systemFontOfSize:12];
        titlelbl1.text =@",./";
        titlelbl1.textAlignment = NSTextAlignmentLeft;
        [_scrollView addSubview:titlelbl1];
        
        titlelbl1.userInteractionEnabled = YES;
        titlelbl1.tag = 1;
        UITapGestureRecognizer *tag1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(UesrClicked:)];
        [titlelbl1 addGestureRecognizer:tag1];
        
        
        
    }
    
    
    if (_num1 == 0) {
        [NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(time) userInfo:nil repeats:YES];
    }
    _num1++;
    
}

- (void)UesrClicked:(UITapGestureRecognizer *)recognizer
{
//    MessageScrollerModel * model = (MessageScrollerModel *)self.array[recognizer.view.tag];
//    
//     [[SwitchViewController sharedSVC] pushViewController:[SwitchViewController sharedSVC].baseWebViewViewController withObjects:@{@"url":[NSString stringWithFormat:@"%@%@%@",KBaseURL,KURLHomeNewsDetail,model.titId]}];
    
   
}





- (void)time
{
    _num++;
    

    int nums = self.array.count%2 ==0 ?self.array.count/2 : self.array.count/2+1;
    
    
        CGFloat btnwidth=(kScreen_Width-80)/5;
    
    if (_num == nums) {
        [_scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        _num = 0;
    }else{
        [_scrollView setContentOffset:(CGPointMake(0, _num * btnwidth)) animated:YES];
    }
}



@end
