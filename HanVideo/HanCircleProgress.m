//
//  HanCircleProgress.m
//  HanVideo
//
//  Created by 123 on 2018/3/8.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "HanCircleProgress.h"

@implementation HanCircleProgress

-(instancetype)init{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = frame.size.width/2;
        
        UIView *bgView = [[UIView alloc] initWithFrame:frame];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.alpha = 0.5;
        [self addSubview:bgView];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    //1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextBeginPath(ctx);
    CGContextSetLineWidth(ctx, 6);
    [[UIColor greenColor] set];
    CGContextSetLineCap(ctx, kCGLineCapRound);
    //2.设置路径
    
    CGFloat end = -M_PI_2 + 2 * M_PI * _progress;
    
    CGContextAddArc(ctx, rect.size.width/2, rect.size.width/2, rect.size.width/2 - 3 , -M_PI_2, end, 0);
    //3.绘制
    CGContextStrokePath(ctx);
}

-(void)setProgress:(CGFloat)progress{
    _progress = progress;
    [self setNeedsDisplay];
}


@end
