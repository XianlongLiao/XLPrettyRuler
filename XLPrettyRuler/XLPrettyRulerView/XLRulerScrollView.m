//
//  TXHRulerScrollView.m
//  PrettyRuler
//
//  Created by GXY on 15/12/11.
//  Copyright © 2015年 Tangxianhai. All rights reserved.
//

#import "XLRulerScrollView.h"

@implementation XLRulerScrollView

- (id)init
{
    self = [super init];
    if (self) {
        self.distanceValue = 8.f;
        self.distanceLeftAndRightSpace = 8.f;
    }
    return self;
}

- (void)setRulerValue:(CGFloat)rulerValue {
    _rulerValue = rulerValue;
}

- (void)drawRuler {
    
    CGMutablePathRef pathRef1 = CGPathCreateMutable();
    CGMutablePathRef pathRef2 = CGPathCreateMutable();
    
    CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
    shapeLayer1.strokeColor = [UIColor lightGrayColor].CGColor;
    shapeLayer1.fillColor = [UIColor clearColor].CGColor;
    shapeLayer1.lineWidth = 1.f;
    shapeLayer1.lineCap = kCALineCapButt;
    
    CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
    shapeLayer2.strokeColor = [UIColor grayColor].CGColor;
    shapeLayer2.fillColor = [UIColor clearColor].CGColor;
    shapeLayer2.lineWidth = 1.f;
    shapeLayer2.lineCap = kCALineCapButt;
    
    NSInteger offsetNumber = self.bigRulerMode ? DISTANCE_OFFSET_NUMBER_BIG : DISTANCE_OFFSET_NUMBER_SMALL;
    NSInteger count = (self.rulerEndCount - self.rulerStartCount) / [self.rulerAverage floatValue];
    for (NSInteger i = -offsetNumber; i <= count + offsetNumber; i++) {
        
        if (self.bigRulerMode) {
            if (i % 2 == 0) {
                CGPathMoveToPoint(pathRef2, NULL, self.distanceLeftAndRightSpace + self.distanceValue * i , 0);
                CGPathAddLineToPoint(pathRef2, NULL, self.distanceLeftAndRightSpace + self.distanceValue * i, self.rulerHeight - DISTANCE_TEXT_HEIGHT);
                
                //文字
                if (i >= 0 && i <= count) {
                    UILabel *rule = [[UILabel alloc] init];
                    rule.textColor = [UIColor blackColor];
                    rule.text = [NSString stringWithFormat:@"%.0f", self.rulerStartCount + i * [self.rulerAverage floatValue]];
                    CGSize textSize = [rule.text sizeWithAttributes:@{ NSFontAttributeName : rule.font}];
                    rule.frame = CGRectMake(self.distanceLeftAndRightSpace + self.distanceValue * i - textSize.width / 2, self.rulerHeight - textSize.height, 0, 0);
                    [rule sizeToFit];
                    [self addSubview:rule];
                }
            }else {
                CGPathMoveToPoint(pathRef1, NULL, self.distanceLeftAndRightSpace + self.distanceValue * i , 0);
                CGPathAddLineToPoint(pathRef1, NULL, self.distanceLeftAndRightSpace + self.distanceValue * i, self.rulerHeight - DISTANCE_TEXT_HEIGHT - 5);
            }
        }else {
            if (i % 10 == 0) {
                CGPathMoveToPoint(pathRef2, NULL, self.distanceLeftAndRightSpace + self.distanceValue * i , 0);
                CGPathAddLineToPoint(pathRef2, NULL, self.distanceLeftAndRightSpace + self.distanceValue * i, self.rulerHeight - DISTANCE_TEXT_HEIGHT);
                
                //文字
                if (i >= 0 && i <= count) {
                    UILabel *rule = [[UILabel alloc] init];
                    rule.textColor = [UIColor blackColor];
                    rule.text = [NSString stringWithFormat:@"%.0f", self.rulerStartCount + i * [self.rulerAverage floatValue]];
                    CGSize textSize = [rule.text sizeWithAttributes:@{ NSFontAttributeName : rule.font}];
                    rule.frame = CGRectMake(self.distanceLeftAndRightSpace + self.distanceValue * i - textSize.width / 2, self.rulerHeight - textSize.height, 0, 0);
                    [rule sizeToFit];
                    [self addSubview:rule];
                    NSLog(@"frame:%@", NSStringFromCGRect(rule.frame));
                }
            }
            else if (i % 5 == 0) {
                CGPathMoveToPoint(pathRef1, NULL, self.distanceLeftAndRightSpace + self.distanceValue * i , 0);
                CGPathAddLineToPoint(pathRef1, NULL, self.distanceLeftAndRightSpace + self.distanceValue * i, self.rulerHeight - DISTANCE_TEXT_HEIGHT - 5);
            }
            else
            {
                CGPathMoveToPoint(pathRef1, NULL, self.distanceLeftAndRightSpace + self.distanceValue * i , 0);
                CGPathAddLineToPoint(pathRef1, NULL, self.distanceLeftAndRightSpace + self.distanceValue * i, self.rulerHeight - DISTANCE_TEXT_HEIGHT - 10);
            }
        }
    }
    
    shapeLayer1.path = pathRef1;
    shapeLayer2.path = pathRef2;
    
    [self.layer addSublayer:shapeLayer1];
    [self.layer addSublayer:shapeLayer2];
    
    self.frame = CGRectMake(0, 0, self.rulerWidth, self.rulerHeight);
    
    UIEdgeInsets edge = UIEdgeInsetsMake(0, self.rulerWidth / 2.f - self.distanceLeftAndRightSpace, 0, self.rulerWidth / 2.f - self.distanceLeftAndRightSpace);
    self.contentInset = edge;
    self.contentOffset = CGPointMake(self.distanceValue * ((self.rulerValue - self.rulerStartCount) / [self.rulerAverage floatValue]) - self.rulerWidth + (self.rulerWidth / 2.f + self.distanceLeftAndRightSpace), 0);
    
    self.contentSize = CGSizeMake(count * self.distanceValue + self.distanceLeftAndRightSpace * 2.f, self.rulerHeight);
}

@end
