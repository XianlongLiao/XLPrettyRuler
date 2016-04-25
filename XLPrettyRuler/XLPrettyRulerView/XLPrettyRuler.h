//
//  TXHRrettyRuler.h
//  PrettyRuler
//
//  Created by GXY on 15/12/11.
//  Copyright © 2015年 Tangxianhai. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLRulerScrollView.h"

@class XLPrettyRuler;
@protocol XLPrettyRulerDelegate <NSObject>

- (void)txhRrettyRuler:(XLRulerScrollView *)rulerScrollView prettyRulerView:(XLPrettyRuler *)prettyRuler;

@end

@interface XLPrettyRuler : UIView <UIScrollViewDelegate>

@property (nonatomic, assign) id <XLPrettyRulerDelegate> rulerDeletate;



/**
 *  显示尺子
 *
 *  @param startCount    起始值
 *  @param endCount      结束值
 *  @param average       每个尺度的单位
 *  @param currentValue  当前默认值
 *  @param distanceValue 尺度距离间隔  最小为8  默认为8
 *  @param distanceValue 左右边距  最小为8  默认为8
 */
- (void)showRulerScrollViewWithStartCount:(NSInteger)startCount
                                 endCount:(NSInteger)endCount
                                  average:(NSNumber *)average
                             currentValue:(CGFloat)currentValue
                             bigRulerMode:(BOOL)bigRulerMode;


- (void)showRulerScrollViewWithStartCount:(NSInteger)startCount
                                 endCount:(NSInteger)endCount
                                  average:(NSNumber *)average
                             currentValue:(CGFloat)currentValue
                            distanceValue:(CGFloat)distanceValue
                distanceLeftAndRightSpace:(CGFloat)distanceLeftAndRightSpace
                             bigRulerMode:(BOOL)bigRulerMode;
@end
