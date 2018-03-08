//
//  HanCenterView.m
//  HanVideo
//
//  Created by 123 on 2018/3/8.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "HanCenterView.h"
#import "HanCircleProgress.h"
@interface HanCenterView()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) HanCircleProgress *hanProgress;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger recordTime;
@end
@implementation HanCenterView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self addSubview:self.hanProgress];
        [self addSubview:self.imageView];
    }
    return self;
}
- (UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(0, 0, self.frame.size.width/2, self.frame.size.height/2);
        _imageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        _imageView.backgroundColor = [UIColor whiteColor];
        _imageView.layer.masksToBounds = YES;
        _imageView.layer.cornerRadius = _imageView.frame.size.width/2;
    }
    return _imageView;
}
- (HanCircleProgress *)hanProgress
{
    if (!_hanProgress)
    {
        _hanProgress = [[HanCircleProgress alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _hanProgress.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);;
        _hanProgress.hidden = YES;
    }
    return _hanProgress;
}
- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = image;
}
#pragma mark 录制时间累计
- (void)startTime:(NSTimer *)timer
{
    self.recordTime =  self.recordTime + 1;
    self.hanProgress.progress =  self.recordTime * 0.001;
    if (self.recordTime>1000)
    {
        self.recordTime = 0;
        _hanProgress.progress = 0.0;
        _hanProgress.hidden = YES;
        [_timer invalidate];
        _timer = nil;
        if (self.delegate && [self.delegate respondsToSelector:@selector(hanCenterView:touchesType:)])
        {
            [self.delegate hanCenterView:self touchesType:HanTouchesEnded];
        }
    }
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _hanProgress.hidden = NO;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(startTime:) userInfo:nil repeats:YES];
    if (self.delegate && [self.delegate respondsToSelector:@selector(hanCenterView:touchesType:)])
    {
        [self.delegate hanCenterView:self touchesType:HanTouchesBegan];
    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.recordTime = 0;
    _hanProgress.progress = 0.0;
    _hanProgress.hidden = YES;
    [_timer invalidate];
    _timer = nil;
    if (self.delegate && [self.delegate respondsToSelector:@selector(hanCenterView:touchesType:)])
    {
        [self.delegate hanCenterView:self touchesType:HanTouchesEnded];
    }
}

@end
