//
//  ViewController.m
//  XLPrettyRuler
//
//  Created by 先龙 廖 on 16/4/25.
//  Copyright © 2016年 先龙 廖. All rights reserved.
//

#import "ViewController.h"
#import "XLPrettyRuler.h"

@interface ViewController () <XLPrettyRulerDelegate>
{
    UILabel *showLabel;
    UILabel *showLabel2;
    UILabel *showLabel3;

    XLPrettyRuler *ruler;
    XLPrettyRuler *ruler2;
    XLPrettyRuler *ruler3;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //10
    showLabel = [[UILabel alloc] init];
    showLabel.font = [UIFont systemFontOfSize:20.f];
    showLabel.text = @"当前刻度值:20";
    showLabel.frame = CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width - 20 * 2, 40);
    showLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:showLabel];
    
    ruler = [[XLPrettyRuler alloc] initWithFrame:CGRectMake(20, 220, [UIScreen mainScreen].bounds.size.width - 20 * 2, 50)];
    ruler.rulerDeletate = self;
    [ruler showRulerScrollViewWithStartCount:30 endCount:300 average:@(1) currentValue:60 averageStyle:RulerAverageStyleTen];
    [self.view addSubview:ruler];
    
    //2
    showLabel2 = [[UILabel alloc] init];
    showLabel2.font = [UIFont systemFontOfSize:20.f];
    showLabel2.text = @"当前刻度值:1个";
    showLabel2.frame = CGRectMake(20, CGRectGetMaxY(ruler.frame) + 30, [UIScreen mainScreen].bounds.size.width - 20 * 2, 40);
    showLabel2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:showLabel2];
    
    ruler2 = [[XLPrettyRuler alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(showLabel2.frame) + 30, [UIScreen mainScreen].bounds.size.width - 20 * 2, 50)];
    ruler2.rulerDeletate = self;
    [ruler2 showRulerScrollViewWithStartCount:0.5 endCount:10 average:@(.5) currentValue:1 averageStyle:RulerAverageStyleTwo];
    [self.view addSubview:ruler2];
    
    //5
    showLabel3 = [[UILabel alloc] init];
    showLabel3.font = [UIFont systemFontOfSize:20.f];
    showLabel3.text = @"当前刻度值:1个";
    showLabel3.frame = CGRectMake(20, CGRectGetMaxY(ruler2.frame) + 30, [UIScreen mainScreen].bounds.size.width - 20 * 2, 40);
    showLabel3.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:showLabel3];
    
    ruler3 = [[XLPrettyRuler alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(showLabel3.frame) + 30, [UIScreen mainScreen].bounds.size.width - 20 * 2, 50)];
    ruler3.rulerDeletate = self;
    [ruler3 showRulerScrollViewWithStartCount:1930 endCount:2016 average:@(1) currentValue:1991 averageStyle:RulerAverageStyleFive];
    [self.view addSubview:ruler3];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)txhRrettyRuler:(XLRulerScrollView *)rulerScrollView prettyRulerView:(XLPrettyRuler *)prettyRuler
{
    if (prettyRuler == ruler) {
        showLabel.text = [NSString stringWithFormat:@"当前刻度值: %.0f",rulerScrollView.rulerValue];
    }else if (prettyRuler == ruler2) {
        NSInteger value = [rulerScrollView.rulerAverage floatValue] * 10;
        if ((int)(rulerScrollView.rulerValue * 10) % value == 0) {
            showLabel2.text = [NSString stringWithFormat:@"当前刻度值: %.1f",rulerScrollView.rulerValue];
        }
    }else {
        showLabel3.text = [NSString stringWithFormat:@"当前刻度值: %.0f",rulerScrollView.rulerValue];
    }
}


@end
