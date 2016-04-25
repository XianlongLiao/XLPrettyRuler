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
    XLPrettyRuler *ruler;
    XLPrettyRuler *ruler2;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.创建一个显示的标签
    showLabel = [[UILabel alloc] init];
    showLabel.font = [UIFont systemFontOfSize:20.f];
    showLabel.text = @"当前刻度值:20";
    showLabel.frame = CGRectMake(20, 100, [UIScreen mainScreen].bounds.size.width - 20 * 2, 40);
    showLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:showLabel];
    
    ruler = [[XLPrettyRuler alloc] initWithFrame:CGRectMake(20, 220, [UIScreen mainScreen].bounds.size.width - 20 * 2, 50)];
    ruler.rulerDeletate = self;
    [ruler showRulerScrollViewWithStartCount:1930 endCount:2016 average:@(1) currentValue:1991 bigRulerMode:NO];
    [self.view addSubview:ruler];
    
    showLabel2 = [[UILabel alloc] init];
    showLabel2.font = [UIFont systemFontOfSize:20.f];
    showLabel2.text = @"当前刻度值:1个";
    showLabel2.frame = CGRectMake(20, CGRectGetMaxY(ruler.frame) + 30, [UIScreen mainScreen].bounds.size.width - 20 * 2, 40);
    showLabel2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:showLabel2];
    
    ruler2 = [[XLPrettyRuler alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(showLabel2.frame) + 30, [UIScreen mainScreen].bounds.size.width - 20 * 2, 50)];
    ruler2.rulerDeletate = self;
    [ruler2 showRulerScrollViewWithStartCount:0.5 endCount:10 average:@(0.5) currentValue:1 bigRulerMode:YES];
    [self.view addSubview:ruler2];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)txhRrettyRuler:(XLRulerScrollView *)rulerScrollView prettyRulerView:(XLPrettyRuler *)prettyRuler
{
    if (prettyRuler == ruler) {
        showLabel.text = [NSString stringWithFormat:@"当前刻度值: %.0f",rulerScrollView.rulerValue];
    }else {
        NSInteger value = [rulerScrollView.rulerAverage floatValue] * 10;
        if ((int)(rulerScrollView.rulerValue * 10) % value == 0) {
            showLabel2.text = [NSString stringWithFormat:@"当前刻度值: %.1f",rulerScrollView.rulerValue];
        }
    }
}


@end
