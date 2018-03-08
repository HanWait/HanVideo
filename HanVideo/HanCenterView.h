//
//  HanCenterView.h
//  HanVideo
//
//  Created by 123 on 2018/3/8.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    HanTouchesBegan,
    HanTouchesEnded,
} HanTouchesType;

@class HanCenterView;
@protocol HanCenterViewDelegate <NSObject>

@optional
- (void)hanCenterView:(HanCenterView *)view touchesType:(HanTouchesType)type;

@end

@interface HanCenterView : UIView

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, weak)    id<HanCenterViewDelegate> delegate;
@end
