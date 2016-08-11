//
//  ProgressWebView.h
//  ProgressWebView_Demo
//
//  Created by admin on 16/8/11.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressWebView : UIView
/**
 *  进度条的颜色
 */
@property (strong, nonatomic) UIColor *progressColor;

- (instancetype)initWithUrl:(NSURL *)url;

@end
