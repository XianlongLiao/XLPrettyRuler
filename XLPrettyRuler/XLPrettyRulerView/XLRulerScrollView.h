//
//  TXHRulerScrollView.h
//  PrettyRuler
//
//  Created by GXY on 15/12/11.
//  Copyright © 2015年 Tangxianhai. All rights reserved.
//

#import <UIKit/UIKit.h>

#define DISTANCE_TEXT_HEIGHT 20 //文字高度
#define DISTANCE_OFFSET_NUMBER_SMALL 50  //前后多余尺度个数 小尺度
#define DISTANCE_OFFSET_NUMBER_BIG   10 //前后多余尺个数 大尺度

@interface XLRulerScrollView : UIScrollView

@property (nonatomic) NSInteger rulerStartCount;  //起始数字

@property (nonatomic) NSInteger rulerEndCount;  //结束数字

@property (nonatomic) NSNumber * rulerAverage;   //尺度单位

@property (nonatomic) NSInteger rulerHeight;

@property (nonatomic) NSInteger rulerWidth;

@property (nonatomic) CGFloat rulerValue;  //滑到的值

@property (nonatomic) CGFloat distanceValue; //最小刻度的间距

@property (nonatomic) CGFloat distanceLeftAndRightSpace;

@property (nonatomic) BOOL bigRulerMode;

- (void)drawRuler;

@end
