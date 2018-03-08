//
//  HanMediaView.h
//  HanVideo
//
//  Created by 123 on 2018/3/7.
//  Copyright © 2018年 Han. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSUInteger {
    HanMediaSelectBack,
    HanMediaSelectFinsh,
} HanMediaSelectType;

@class HanMediaView;
@protocol HanMediaViewDelegate <NSObject>

@optional
- (void)hanMediaView:(HanMediaView *)view selectType:(HanMediaSelectType)type withVideoUrl:(NSString *)urlString;

@end

@interface HanMediaView : UIView
@property (nonatomic, weak)    id<HanMediaViewDelegate> delegate;
@end
