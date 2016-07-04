//
//  XHVoiceRecordHelper.m
//  MessageDisplayExample
//
//  Created by HUAJIE-1 on 14-5-13.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHVoiceRecordHelper.h"
#import "XHMacro.h"

#import "amrFileCodec.h"

@interface XHVoiceRecordHelper () <AVAudioRecorderDelegate> {
    NSTimer *_timer;
    
    BOOL _isPause;
    
#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
    UIBackgroundTaskIdentifier _backgroundIdentifier;
#endif
}

@property (nonatomic, copy) NSString *recordPath;
@property (nonatomic, readwrite) NSTimeInterval currentTimeInterval;



@end

@implementation XHVoiceRecordHelper

- (id)init {
    self = [super init];
    if (self) {
        self.maxRecordTime = kVoiceRecorderTotalTime;
        self.recordDuration = @"0";
#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
        _backgroundIdentifier = UIBackgroundTaskInvalid;
#endif
    }
    return self;
}

- (void)dealloc {
    [self stopRecord];
    self.recordPath = nil;
    [self stopBackgroundTask];
}

- (void)startBackgroundTask {
    [self stopBackgroundTask];
    
#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
    _backgroundIdentifier = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [self stopBackgroundTask];
    }];
#endif
}

- (void)stopBackgroundTask {
#if TARGET_IPHONE_SIMULATOR || TARGET_OS_IPHONE
    if (_backgroundIdentifier != UIBackgroundTaskInvalid) {
        [[UIApplication sharedApplication] endBackgroundTask:_backgroundIdentifier];
        _backgroundIdentifier = UIBackgroundTaskInvalid;
    }
#endif
}

- (void)resetTimer {
    if (!_timer)
        return;
    
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
    
}

- (void)cancelRecording {
    if (!_recorder)
        return;
    
    if (self.recorder.isRecording) {
        [self.recorder stop];
    }
    
    self.recorder = nil;
}

- (void)stopRecord {
    [self cancelRecording];
    [self resetTimer];
}

- (NSData *)convertAmrToCaf:(NSData *)audioData
{
    return DecodeAMRToWAVE(audioData);
}

- (NSData *)convertCafToAmr:(NSData *)audioData
{
    return EncodeWAVEToAMR(audioData,1,16);
}


- (void)prepareRecordingWithPath:(NSString *)path prepareRecorderCompletion:(XHPrepareRecorderCompletion)prepareRecorderCompletion {
    
    AVAudioSession *avSession = [AVAudioSession sharedInstance];
    if ([avSession respondsToSelector:@selector(requestRecordPermission:)]) {
        [avSession requestRecordPermission:^(BOOL available) {
            if (!available) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[[UIAlertView alloc] initWithTitle:@"无法录音" message:@"请在“设置-隐私-麦克风”选项中允许访问你的麦克风" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
                });
            }else{
                WEAKSELF
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    _isPause = NO;
                    
                    NSError *error = nil;
                    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
                    [audioSession setCategory :AVAudioSessionCategoryPlayAndRecord error:&error];
                    if(error) {
                        DLog(@"audioSession: %@ %ld %@", [error domain], (long)[error code], [[error userInfo] description]);
                        return;
                    }
                    
                    error = nil;
                    [audioSession setActive:YES error:&error];
                    if(error) {
                        DLog(@"audioSession: %@ %ld %@", [error domain], (long)[error code], [[error userInfo] description]);
                        return;
                    }
                    
                    NSDictionary *recordSettings = [NSDictionary dictionaryWithObjectsAndKeys:
                                                    [NSNumber numberWithInt:kAudioFormatLinearPCM], AVFormatIDKey,     //PCM格式
                                                    [NSNumber numberWithFloat:8000.00], AVSampleRateKey,               //采样率8000khz
                                                    [NSNumber numberWithInt:1], AVNumberOfChannelsKey,
                                                    [NSNumber numberWithInt:16], AVLinearPCMBitDepthKey,               //16位深度
                                                    [NSNumber numberWithBool:NO], AVLinearPCMIsNonInterleaved,
                                                    [NSNumber numberWithBool:NO],AVLinearPCMIsFloatKey,
                                                    [NSNumber numberWithBool:NO], AVLinearPCMIsBigEndianKey,
                                                    nil];
                    
                    if (weakSelf) {
                        STRONGSELF
                        strongSelf.recordPath = path;
                        error = nil;
                        
                        if (strongSelf.recorder) {
                            [strongSelf cancelRecording];
                        } else {
                            strongSelf.recorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:strongSelf.recordPath] settings:recordSettings error:&error];
                            
                            
                            
                            strongSelf.recorder.delegate = strongSelf;
                            [strongSelf.recorder prepareToRecord];
                            strongSelf.recorder.meteringEnabled = YES;
                            [strongSelf.recorder recordForDuration:(NSTimeInterval) kVoiceRecorderTotalTime];
                            [strongSelf startBackgroundTask];
                        }
                        
                        if(error) {
                            DLog(@"audioSession: %@ %ld %@", [error domain], (long)[error code], [[error userInfo] description]);
                            return;
                        }
                        
                        dispatch_async(dispatch_get_main_queue(), ^{
                            
                            //上層如果傳會來說已經取消了, 那這邊就做原先取消的動作
                            if (!prepareRecorderCompletion()) {
                                [strongSelf cancelledDeleteWithCompletion:^{
                                }];
                            }
                        });
                    }
                });
            }
        }];
    }
    
    
}

- (void)startRecordingWithStartRecorderCompletion:(XHStartRecorderCompletion)startRecorderCompletion {
    if ([_recorder record]) {
        [self resetTimer];
        _timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(updateMeters) userInfo:nil repeats:YES];
        if (startRecorderCompletion)
            dispatch_async(dispatch_get_main_queue(), ^{
                startRecorderCompletion();
            });
    }
}

- (void)resumeRecordingWithResumeRecorderCompletion:(XHResumeRecorderCompletion)resumeRecorderCompletion {
    _isPause = NO;
    if (_recorder) {
        if ([_recorder record]) {
            dispatch_async(dispatch_get_main_queue(), resumeRecorderCompletion);
        }
    }
}

- (void)pauseRecordingWithPauseRecorderCompletion:(XHPauseRecorderCompletion)pauseRecorderCompletion {
    _isPause = YES;
    if (_recorder) {
        [_recorder pause];
    }
    if (!_recorder.isRecording)
        dispatch_async(dispatch_get_main_queue(), pauseRecorderCompletion);
}

- (void)stopRecordingWithStopRecorderCompletion:(XHStopRecorderCompletion)stopRecorderCompletion {
    _isPause = NO;
    [self stopBackgroundTask];
    [self stopRecord];
    [self getVoiceDuration:_recordPath];
    dispatch_async(dispatch_get_main_queue(), stopRecorderCompletion);
}

- (void)cancelledDeleteWithCompletion:(XHCancellRecorderDeleteFileCompletion)cancelledDeleteCompletion {
    
    _isPause = NO;
    [self stopBackgroundTask];
    [self stopRecord];
    
    if (self.recordPath) {
        // 删除目录下的文件
        NSFileManager *fileManeger = [NSFileManager defaultManager];
        if ([fileManeger fileExistsAtPath:self.recordPath]) {
            NSError *error = nil;
            [fileManeger removeItemAtPath:self.recordPath error:&error];
            if (error) {
                DLog(@"error :%@", error.description);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                cancelledDeleteCompletion(error);
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                cancelledDeleteCompletion(nil);
            });
        }
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            cancelledDeleteCompletion(nil);
        });
    }
}

- (void)updateMeters {
    if (!_recorder)
        return;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [_recorder updateMeters];
        
        self.currentTimeInterval = _recorder.currentTime;
        
        if (!_isPause) {
            //IM录音进度,每个0.05秒更新一次
            float progress = self.currentTimeInterval / self.maxRecordTime * 1.0;
            dispatch_async(dispatch_get_main_queue(), ^{
                if (_recordProgress) {
                    _recordProgress(progress);
                }
            });
        }
        
        //音量计算公式0 - 1.0之间变化
        float peakPower = [_recorder averagePowerForChannel:0];
        double ALPHA = 0.015;
        double peakPowerForChannel = pow(10, (ALPHA * peakPower));
        
        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新扬声器
            if (_peakPowerForChannel) {
                //HUD更新音量大小
                _peakPowerForChannel(peakPowerForChannel,self.maxRecordTime - self.currentTimeInterval);
            }
        });
        
        if (self.currentTimeInterval > self.maxRecordTime) {
            //最大60秒,超过之后强制中断,进入maxTimeStop回调
            [self stopRecord];
            dispatch_async(dispatch_get_main_queue(), ^{
                _maxTimeStopRecorderCompletion();
            });
        }
    });
}

- (void)getVoiceDuration:(NSString*)recordPath {
    NSError *error = nil;
    AVAudioPlayer *play = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:recordPath] error:&error];
    if (error) {
        DLog(@"recordPath：%@ error：%@", recordPath, error);
        self.recordDuration = @"";
    } else {
        DLog(@"时长:%f", play.duration);
        self.recordDuration = [NSString stringWithFormat:@"%.1f", play.duration];
    }
}

@end
