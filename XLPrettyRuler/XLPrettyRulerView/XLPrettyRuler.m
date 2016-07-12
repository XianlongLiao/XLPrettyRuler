//
//  TXHRrettyRuler.m
//  PrettyRuler
//
//  Created by GXY on 15/12/11.
//  Copyright © 2015年 Tangxianhai. All rights reserved.
//  withCount:(NSUInteger)count average:(NSUInteger)average

#import "XLPrettyRuler.h"

#define SHEIGHT 8 // 中间指示器顶部闭合三角形高度
#define INDICATORCOLOR [UIColor redColor].CGColor // 中间指示器颜色

@interface XLPrettyRuler ()

@property (nonatomic, strong) XLRulerScrollView *rulerScrollView;

@end

@implementation XLPrettyRuler

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.rulerScrollView.rulerHeight = frame.size.height;
        self.rulerScrollView.rulerWidth = frame.size.width;
    }
    return self;
}

- (void)showRulerScrollViewWithStartCount:(NSInteger)startCount
                                 endCount:(NSInteger)endCount
                                  average:(NSNumber *)average
                             currentValue:(CGFloat)currentValue
                             averageStyle:(RulerAverageStyle)averageStyle
{
    [self showRulerScrollViewWithStartCount:startCount
                                   endCount:endCount
                                    average:average
                               currentValue:currentValue
                              distanceValue:0
                  distanceLeftAndRightSpace:0
                               averageStyle:averageStyle];
}

- (void)showRulerScrollViewWithStartCount:(NSInteger)startCount
                                 endCount:(NSInteger)endCount
                                  average:(NSNumber *)average
                             currentValue:(CGFloat)currentValue
                            distanceValue:(CGFloat)distanceValue
                distanceLeftAndRightSpace:(CGFloat)distanceLeftAndRightSpace
                             averageStyle:(RulerAverageStyle)averageStyle
{
    self.rulerScrollView.averageStyle = averageStyle;
    self.rulerScrollView.rulerAverage = average;
    self.rulerScrollView.rulerStartCount = startCount;
    self.rulerScrollView.rulerEndCount = endCount;
    self.rulerScrollView.rulerValue = currentValue;
    if (distanceValue > self.rulerScrollView.distanceValue) {
        self.rulerScrollView.distanceValue = distanceValue;
    }
    if (distanceLeftAndRightSpace > self.rulerScrollView.distanceLeftAndRightSpace) {
        self.rulerScrollView.distanceLeftAndRightSpace = distanceLeftAndRightSpace;
    }
    [self.rulerScrollView drawRuler];
    [self addSubview:self.rulerScrollView];
    [self drawRacAndLine];
    //绘制完成之后再设置delegate，否则骑士4设置会和delegate冲突
    self.rulerScrollView.delegate = self;
}


- (XLRulerScrollView *)rulerScrollView {
    if (!_rulerScrollView) {
        _rulerScrollView = [[XLRulerScrollView alloc] init];
        _rulerScrollView.showsHorizontalScrollIndicator = NO;
    }
    return _rulerScrollView;
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(XLRulerScrollView *)scrollView {
    CGFloat offSetX = scrollView.contentOffset.x + self.frame.size.width / 2 - self.rulerScrollView.distanceLeftAndRightSpace;
    CGFloat ruleValue = scrollView.rulerStartCount + (offSetX / self.rulerScrollView.distanceValue) * [scrollView.rulerAverage floatValue];
    if (ruleValue < scrollView.rulerStartCount) {
        return;
    } else if (ruleValue > scrollView.rulerEndCount) {
        return;
    }
    if ([self valueIsInteger:scrollView.rulerAverage]) {
        ruleValue = [self notRounding:ruleValue afterPoint:0];
    }else {
        ruleValue = [self notRounding:ruleValue afterPoint:1];
    }
    if (self.rulerDeletate && [self.rulerDeletate respondsToSelector:@selector(txhRrettyRuler:prettyRulerView:)]) {
        scrollView.rulerValue = ruleValue;
        [self.rulerDeletate txhRrettyRuler:scrollView prettyRulerView:self];
    }
}

- (void)scrollViewDidEndDecelerating:(XLRulerScrollView *)scrollView {
    [self animationRebound:scrollView];
}

- (void)scrollViewDidEndDragging:(XLRulerScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self animationRebound:scrollView];
}

- (void)animationRebound:(XLRulerScrollView *)scrollView {
    CGFloat offSetX = scrollView.contentOffset.x + self.frame.size.width / 2 - self.rulerScrollView.distanceLeftAndRightSpace;
    CGFloat oX = (offSetX / self.rulerScrollView.distanceValue) * [scrollView.rulerAverage floatValue];
#ifdef DEBUG
    NSLog(@"ago*****************ago:oX:%f",oX);
#endif
    if ([self valueIsInteger:scrollView.rulerAverage]) {
        oX = [self notRounding:oX afterPoint:0];
    }
    else {
        oX = [self notRounding:oX afterPoint:1];
    }
#ifdef DEBUG
    NSLog(@"after*****************after:oX:%.1f",oX);
#endif
    CGFloat offX = (oX / ([scrollView.rulerAverage floatValue])) * self.rulerScrollView.distanceValue + self.rulerScrollView.distanceLeftAndRightSpace - self.frame.size.width / 2;
    [UIView animateWithDuration:.2f animations:^{
        scrollView.contentOffset = CGPointMake(offX, 0);
    }];
}

- (void)drawRacAndLine {
    // 圆弧
    //    CAShapeLayer *shapeLayerArc = [CAShapeLayer layer];
    //    shapeLayerArc.strokeColor = [UIColor lightGrayColor].CGColor;
    //    shapeLayerArc.fillColor = [UIColor clearColor].CGColor;
    //    shapeLayerArc.lineWidth = 1.f;
    //    shapeLayerArc.lineCap = kCALineCapButt;
    //    shapeLayerArc.frame = self.bounds;
    
    // 渐变
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    
    gradient.colors = @[(id)[[UIColor whiteColor] colorWithAlphaComponent:1.f].CGColor,
                        (id)[[UIColor whiteColor] colorWithAlphaComponent:0.0f].CGColor,
                        (id)[[UIColor whiteColor] colorWithAlphaComponent:1.f].CGColor];
    
    gradient.locations = @[[NSNumber numberWithFloat:0.0f],
                           [NSNumber numberWithFloat:0.6f]];
    
    gradient.startPoint = CGPointMake(0, .5);
    gradient.endPoint = CGPointMake(1, .5);
    
    CGMutablePathRef pathArc = CGPathCreateMutable();
    
    CGPathMoveToPoint(pathArc, NULL, 0, 0);
    CGPathAddQuadCurveToPoint(pathArc, NULL, self.frame.size.width / 2, - 20, self.frame.size.width, 0);
    
    //    shapeLayerArc.path = pathArc;
    //    [self.layer addSublayer:shapeLayerArc];
    [self.layer addSublayer:gradient];
    
    // 红色指示器
    CAShapeLayer *shapeLayerLine = [CAShapeLayer layer];
    shapeLayerLine.strokeColor = [UIColor redColor].CGColor;
    shapeLayerLine.fillColor = INDICATORCOLOR;
    shapeLayerLine.lineWidth = 3.f;
    shapeLayerLine.lineCap = kCALineCapSquare;
    
    NSUInteger ruleHeight = 20; // 文字高度
    CGMutablePathRef pathLine = CGPathCreateMutable();
    CGPathMoveToPoint(pathLine, NULL, self.frame.size.width / 2, self.frame.size.height - ruleHeight);
    CGPathAddLineToPoint(pathLine, NULL, self.frame.size.width / 2, SHEIGHT);
    
    CGPathAddLineToPoint(pathLine, NULL, self.frame.size.width / 2 - SHEIGHT / 2, 0);
    CGPathAddLineToPoint(pathLine, NULL, self.frame.size.width / 2 + SHEIGHT / 2, 0);
    CGPathAddLineToPoint(pathLine, NULL, self.frame.size.width / 2, SHEIGHT);
    
    shapeLayerLine.path = pathLine;
    [self.layer addSublayer:shapeLayerLine];
}

#pragma mark - tool method

- (CGFloat)notRounding:(CGFloat)price afterPoint:(NSInteger)position {
    NSDecimalNumberHandler *roundingBehavior = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:position raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    NSDecimalNumber*ouncesDecimal;
    NSDecimalNumber*roundedOunces;
    ouncesDecimal = [[NSDecimalNumber alloc] initWithFloat:price];
    roundedOunces = [ouncesDecimal decimalNumberByRoundingAccordingToBehavior:roundingBehavior];
    CGFloat resultValue = [roundedOunces floatValue];
    if (self.rulerScrollView.averageStyle == RulerAverageStyleTwo && ![self valueIsInteger:self.rulerScrollView.rulerAverage]) {
        CGFloat decimal = resultValue - (int)resultValue;
        int decimalValue = decimal / ([self.rulerScrollView.rulerAverage floatValue] / 2);
        if (decimalValue < 1) {
            resultValue = (int)resultValue;
        }else if (decimalValue >= 1 && decimalValue < 3) {
            resultValue = (int)resultValue + [self.rulerScrollView.rulerAverage floatValue];
        }else if (decimalValue >= 3) {
            resultValue = (int)resultValue + [self.rulerScrollView.rulerAverage floatValue] * 2;
        }
    }
    return resultValue;
}

- (BOOL)valueIsInteger:(NSNumber *)number {
    NSString *value = [NSString stringWithFormat:@"%f",[number floatValue]];
    if (value != nil) {
        NSString *valueEnd = [[value componentsSeparatedByString:@"."] objectAtIndex:1];
        NSString *temp = nil;
        for(int i =0; i < [valueEnd length]; i++)
        {
            temp = [valueEnd substringWithRange:NSMakeRange(i, 1)];
            if (![temp isEqualToString:@"0"]) {
                return NO;
            }
        }
    }
    return YES;
}

@end
