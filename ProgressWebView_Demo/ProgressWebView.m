
//
//  ProgressWebView.m
//  ProgressWebView_Demo
//
//  Created by admin on 16/8/11.
//  Copyright © 2016年 AlezJi. All rights reserved.
//

#import "ProgressWebView.h"
#import <WebKit/WebKit.h>
#import <objc/runtime.h>
NSString *const progressColorKey = @"progressColorKey";


@interface ProgressWebView ()
@property (strong, nonatomic) CALayer *progresslayer;
@end

@implementation ProgressWebView

- (void)initWithDefault{
    self.progressColor = [UIColor colorWithRed:22.f / 255.f green:126.f / 255.f blue:251.f / 255.f alpha:.8];;
}

- (void)initWithProgressView{
    UIView *progress = [[UIView alloc]initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.frame), 3)];
    progress.backgroundColor = [UIColor clearColor];
    [self addSubview:progress];
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 3);
    layer.backgroundColor = self.progressColor.CGColor;
    [progress.layer addSublayer:layer];
    self.progresslayer = layer;
}

- (UIColor *)progressColor{
    return objc_getAssociatedObject(self, &progressColorKey);
}

- (void)setProgressColor:(UIColor *)progressColor{
    objc_setAssociatedObject(self, &progressColorKey, progressColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self initWithProgressView];
}

- (instancetype)initWithUrl:(NSURL *)url{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        WKWebView *webView = [[WKWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        //添加观察者,观察wkwebview的estimatedProgress属性
        [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        [self addSubview:webView];
        [webView loadRequest:[NSURLRequest requestWithURL:url]];
        [self initWithDefault];
        [self initWithProgressView];
    }
    return self;
}

- (void)dealloc{
    [(WKWebView *)self removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progresslayer.opacity = 1;
        //不要让进度条倒着走...有时候goback会出现这种情况
        if ([change[@"new"] floatValue] < [change[@"old"] floatValue]) {
            return;
        }
        self.progresslayer.frame = CGRectMake(0, 0, self.bounds.size.width * [change[@"new"] floatValue], 3);
        if ([change[@"new"] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

@end
