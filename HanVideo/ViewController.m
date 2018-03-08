//
//  ViewController.m
//  HanVideo
//
//  Created by 123 on 2018/3/7.
//  Copyright © 2018年 Han. All rights reserved.
//

#import "ViewController.h"
#import "HanMediaView.h"
@interface ViewController ()<HanMediaViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    HanMediaView *mediaView = [[HanMediaView alloc] initWithFrame:self.view.bounds];
    mediaView.delegate = self;
    [self.view addSubview:mediaView];
    
}

- (void)hanMediaView:(HanMediaView *)view selectType:(HanMediaSelectType)type withVideoUrl:(NSString *)urlString
{
    NSLog(@"--->%lu  ---->%@",(unsigned long)type,urlString);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
