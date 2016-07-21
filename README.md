---
#XLPrettyRuler
-------------
刻度尺自定义控件
实现了滑尺功能
可以自定义刻度标准，以及初始值

####示例:  

 ![image](http://github.com/XianlongLiao/XLPrettyRuler/raw/master/F9E6BF9C-9A13-46D5-AA59-0E5CD2637B70.png)

``` xml
###使用方法
//10个小刻度为一个大单位
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

//2刻度为一个大单位
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

//5个刻度为一个大单位
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

