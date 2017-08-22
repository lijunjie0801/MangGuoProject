//
//  YcKeyBoardView.h
//  KeyBoardAndTextView
//
//  Created by zzy on 14-5-28.
//  Copyright (c) 2014年 zzy. All rights reserved.
//
#define kStartLocation 20
#import <UIKit/UIKit.h>

@class YcKeyBoardView;
@protocol YcKeyBoardViewDelegate <NSObject>

-(void)keyBoardViewHide:(YcKeyBoardView *)keyBoardView textView:(UITextView *)contentView;

-(void)sendClassComment;
@end

@interface YcKeyBoardView : UIView
@property (nonatomic,strong) UITextView *textView;
@property (nonatomic,strong) UILabel *label;
@property (nonatomic,assign) id<YcKeyBoardViewDelegate> delegate;
@end
