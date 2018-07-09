# HanVideo
小视频
初次看见有声读物感觉很神奇，就自己琢磨了一下，发现苹果已经给出了相关的接口。还是那句话，我们不是代码的创造者，我们是代码的搬运工。
避免多个播放器重复，建立单例，具体实现如下：

_synth = [[AVSpeechSynthesizer alloc] init];//创建AVSpeechSynthesizer
_voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];//汉语 -->默认不支持汉语
_utterance.rate = 0.5;//语速
文字转语音

//通过传递的文字进行播放
-(void)playTextWithText:(NSString *)text
{
[_synth stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];//停止播放
_utterance = [AVSpeechUtterance speechUtteranceWithString:text];//播放语
_utterance.voice = _voice;
[_synth speakUtterance:_utterance];//播放
}
各种设置

//开始播放
-(void)continuePlayText
{
[_synth continueSpeaking];
}
//停止播放
-(void)stopPlayText
{
[_synth stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];//停止播放
}
//暂停播放
-(void)pausePlayText
{
[_synth pauseSpeakingAtBoundary:AVSpeechBoundaryImmediate];//暂停播放
}
简单音乐播放

pragma mark 通过音乐名称和类型播放音乐
-(void)playMusicWithMusicName:(NSString *)musicName withwithExtension:(NSString *)ext
{
// 获取对应音乐资源
NSURL *fileUrl = [[NSBundle mainBundle] URLForResource:musicName withExtension:@"mp3"];
if (fileUrl == nil) return;
// 创建对应的播放器
_player = [[AVAudioPlayer alloc] initWithContentsOfURL:fileUrl error:nil];
// 准备播放
[_player prepareToPlay];
//播放音乐
[_player play];
}

各种设置

//开始播放
-(void)playMusic
{
[_player play];
}
//停止播放
-(void)stopMusic
{
[_player stop];
}
//暂停播放
-(void)pauseMusic
{
[_player pause];
}
https://www.jianshu.com/p/709ede9f8bc7
