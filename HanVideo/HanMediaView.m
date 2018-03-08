//
//  HanMediaView.m
//  HanVideo
//
//  Created by 123 on 2018/3/7.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "HanMediaView.h"
#import "JoyMediaRecordPlay.h"
#import "HanCenterView.h"
#define ScreenWidth  [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface HanMediaView()<ReCordPlayProtoCol,HanCenterViewDelegate>
@property (nonatomic, strong) JoyMediaRecordPlay *recorder;
@property (nonatomic, strong) UIButton *switchCameraBtn;
@property (nonatomic, strong) UIButton *finshBtn;
@property (nonatomic, strong) UIButton *cancleBtn;
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) UIImageView *videoImage;
@property (nonatomic, assign) CGFloat btnWidth;
@property (nonatomic, copy)   NSString *videoPath;
@property (nonatomic, strong) HanCenterView *hanCenterView;
@property (nonatomic, strong) AVPlayer *player;
@end

@implementation HanMediaView


- (instancetype)init
{
    if (self = [super init])
    {
        self.btnWidth= 70;
        [self initRecorder];
        [self addSub];
    }
    return self;

}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.btnWidth= 70;
        [self initRecorder];
        [self addSub];
        
    }
    return self;
}
-(void)initRecorder{
    if (!_recorder) {
        _recorder = [[JoyMediaRecordPlay alloc]init];
        [self.layer addSublayer:self.recorder.preViewLayer];
        _recorder.preViewLayer.frame = self.frame;
        [self.recorder preareReCord];
        _recorder.delegate = self;
    }
}
- (void)addSub
{
    [self addSubview:self.videoImage];
    [self addSubview:self.switchCameraBtn];
    [self addSubview:self.hanCenterView];
    [self addSubview:self.cancleBtn];
    [self addSubview:self.finshBtn];
    [self addSubview:self.backBtn];
   
    
}
- (UIButton *)switchCameraBtn
{
    if (!_switchCameraBtn) {
        _switchCameraBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _switchCameraBtn.frame = CGRectMake(ScreenWidth - 70, 30, 40, 30);
        [_switchCameraBtn setImage:[UIImage imageNamed:@"LW_SwitchCamera"] forState:UIControlStateNormal];
        [_switchCameraBtn addTarget:self action:@selector(switchCameraBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _switchCameraBtn;
}

-(UIButton *)cancleBtn{
    if (!_cancleBtn) {
        _cancleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleBtn.backgroundColor = [UIColor whiteColor];
        _cancleBtn.hidden = YES;
        _cancleBtn.frame = CGRectMake(0, 0, self.btnWidth, self.btnWidth);
        _cancleBtn.center = CGPointMake(self.frame.size.width * 0.2, CGRectGetHeight(self.frame) - 90);
        _cancleBtn.layer.masksToBounds = YES;
        _cancleBtn.layer.cornerRadius = _cancleBtn.frame.size.height/2;
        [_cancleBtn setImage:[UIImage imageNamed:@"trends_ preview_video_back"] forState:UIControlStateNormal];
        [_cancleBtn addTarget:self action:@selector(cancleBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleBtn;
}
-(UIButton *)finshBtn{
    if (!_finshBtn) {
        _finshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _finshBtn.backgroundColor = [UIColor whiteColor];
        _finshBtn.hidden = YES;
        _finshBtn.frame = CGRectMake(0, 0, self.btnWidth, self.btnWidth);
        _finshBtn.center = CGPointMake(self.frame.size.width * 0.8, CGRectGetHeight(self.frame) - 90);
        _finshBtn.layer.masksToBounds = YES;
        _finshBtn.layer.cornerRadius = _finshBtn.frame.size.height/2;
        [_finshBtn setImage:[UIImage imageNamed:@"trends_preview_video_done"] forState:UIControlStateNormal];
        [_finshBtn addTarget:self action:@selector(finshBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _finshBtn;
}
-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _backBtn.frame = CGRectMake(0, 0, self.btnWidth, self.btnWidth);
        _backBtn.backgroundColor = [UIColor whiteColor];
        _backBtn.center = CGPointMake(self.frame.size.width * 0.2, CGRectGetHeight(self.frame) - 90);
        _backBtn.layer.masksToBounds = YES;
        _backBtn.layer.cornerRadius = _backBtn.frame.size.height/2;
        [_backBtn setImage:[UIImage imageNamed:@"video_back"] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(backBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
- (UIImageView *)videoImage
{
    if (!_videoImage)
    {
        _videoImage = [[UIImageView alloc] initWithFrame:self.frame];
        _videoImage.hidden = YES;
    }
    return _videoImage;
}

- (HanCenterView *)hanCenterView
{
    if (!_hanCenterView)
    {
        _hanCenterView = [[HanCenterView alloc] initWithFrame:CGRectMake(0, 0, self.btnWidth * 2, self.btnWidth * 2)];
        _hanCenterView.center = CGPointMake(self.center.x, CGRectGetHeight(self.frame) - 90);
        _hanCenterView.image = [UIImage imageNamed:@"LW_StartRecordVideo"];
        _hanCenterView.delegate = self;
    }
    return _hanCenterView;
}
- (NSString *)videoPath
{
    if (!_videoPath)
    {
        _videoPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"bbb.mp4"];
    }
    return _videoPath;
}

- (void)switchCameraBtnClicked:(UIButton *)sender
{
    [self.recorder switchCamera];
}

- (void)cancleBtnClicked:(UIButton *)sender
{
    _cancleBtn.hidden = YES;
    _finshBtn.hidden = YES;
    _backBtn.hidden = NO;
    _videoImage.hidden = YES;
    _hanCenterView.hidden = NO;
    _switchCameraBtn.hidden = NO;
    [self.player pause];
    self.player = nil;
}
- (void)finshBtnClicked:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(hanMediaView:selectType:withVideoUrl:)])
    {
        [self.delegate hanMediaView:self selectType:HanMediaSelectFinsh withVideoUrl:self.videoPath];
    }
}
- (void)backBtnClicked:(UIButton *)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(hanMediaView:selectType:withVideoUrl:)])
    {
        [self.delegate hanMediaView:self selectType:HanMediaSelectBack withVideoUrl:self.videoPath];
    }
}
- (void)hanCenterView:(HanCenterView *)view touchesType:(HanTouchesType)type
{
    switch (type)
    {
        case HanTouchesBegan:
        {
            _backBtn.hidden = YES;
            _cancleBtn.hidden = YES;
            _finshBtn.hidden = YES;
            _videoImage.hidden = YES;
            _switchCameraBtn.hidden = YES;
            NSString *outputFielPath=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"aaa.mp4"];
            // 路径转换成 URL 要用这个方法，用 NSBundle 方法转换成 URL 的话可能会出现读取不到路径的错误
            NSURL *fileUrl=[NSURL fileURLWithPath:outputFielPath];
            [self.recorder startRecordToFile:fileUrl];
        }
            break;
        case HanTouchesEnded:
        {
            _cancleBtn.hidden = NO;
            _finshBtn.hidden = NO;
            _videoImage.hidden = NO;
            view.hidden = YES;
            [self.recorder stopCurrentVideoRecording];
        }
            break;
            
        default:
            break;
    }
}
- (void)joyCaptureOutput:(AVCaptureOutput *)captureOutput didFinishRecordingToOutputFileAtURL:(NSURL *)outputFileURL fromConnections:(NSArray *)connections error:(NSError *)error recordResult:(ERecordResult)recordResult
{
    [JoyMediaRecordPlay getfileSize:outputFileURL.path];
    NSString *outputFielPath=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"aaa.mp4"];
    NSString *outputFielPath1=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"bbb.mp4"];
    // 路径转换成 URL 要用这个方法，用 NSBundle 方法转换成 URL 的话可能会出现读取不到路径的错误
    NSURL *fileUrl=[NSURL fileURLWithPath:outputFielPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:outputFielPath1])
    {

        BOOL isOK = [fileManager removeItemAtPath:outputFielPath1 error:nil];
        if (isOK)
        {
            [JoyMediaRecordPlay mergeAndExportVideosAtFileURLs:fileUrl newUrl:outputFielPath1 widthHeightScale:[UIScreen mainScreen].bounds.size.width/[UIScreen mainScreen].bounds.size.height presetName:nil mergeSucess:^{
                
                if ([fileManager fileExistsAtPath:outputFielPath1])
                {
                     [self playVideo];
                }
                else
                {
                    NSLog(@"播放错误");
                }
                
            }];
        }
    }
    else
    {
        [JoyMediaRecordPlay mergeAndExportVideosAtFileURLs:fileUrl newUrl:outputFielPath1 widthHeightScale:[UIScreen mainScreen].bounds.size.width/[UIScreen mainScreen].bounds.size.height presetName:nil mergeSucess:^{
            
            if ([fileManager fileExistsAtPath:outputFielPath1])
            {
                [self playVideo];
            }
            else
            {
                NSLog(@"播放错误");
            }
            
        }];
    }
}
- (void)playVideo
{
    self.videoImage.image =  [JoyMediaRecordPlay thumbnailImageForVideo:[NSURL fileURLWithPath:self.videoPath] atTime:0];;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *outputFielPath1=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"bbb.mp4"];
    if ([fileManager fileExistsAtPath:outputFielPath1])
    {
        // 创建 AVPlayer 播放器
        AVPlayer *player = [AVPlayer playerWithURL:[NSURL fileURLWithPath:outputFielPath1]];
        
        // 将 AVPlayer 添加到 AVPlayerLayer 上
        AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
        
        // 设置播放页面大小
        playerLayer.frame = self.frame;
        
        // 设置画面缩放模式
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        
        // 在视图上添加播放器
        [self.videoImage.layer addSublayer:playerLayer];
        
        // 开始播放
        [player play];
        
        
        
        self.player = player;
    }
    else
    {
        NSLog(@"播放失败");
    }
    
    
    
    
}
@end
