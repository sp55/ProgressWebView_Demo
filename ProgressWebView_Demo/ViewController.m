//
//  ViewController.m
//  ProgressWebView_Demo
//
//  Created by admin on 16/8/11.
//  Copyright © 2016年 AlezJi. All rights reserved.
//http://www.jianshu.com/p/dd227d4d78c7
//封装一个WKWebView(带进度条)

#import "ViewController.h"
#import "ProgressWebView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    ProgressWebView *webView = [[ProgressWebView alloc] initWithUrl:[NSURL URLWithString:@"http://wap.baidu.com"]];
    webView.progressColor = [UIColor orangeColor];
    [self.view addSubview:webView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
