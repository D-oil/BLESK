
//
//  LxxSoundPlay.m
//  soundPlay
//
//  Created by 简学 on 16/3/30.
//  Copyright © 2016年 李鑫鑫. All rights reserved.
//



#import "LxxSoundPlay.h"

@interface LxxSoundPlay ()

@property (nonatomic,strong)NSTimer *playerTimer;

@end

@implementation LxxSoundPlay
- (NSTimer *)playerTimer {
    if (_playerTimer == nil) {
        _playerTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(playwarning) userInfo:nil repeats:YES];
    }
    return _playerTimer;
}

-(id)initForPlayingVibrate
{
    self = [super init];
    if (self) {
        soundID = kSystemSoundID_Vibrate;
    }
    return self;
}


-(id)initForPlayingSystemSoundEffectWith:(NSString *)resourceName ofType:(NSString *)type
{
    self = [super init];
    if (self) {
        NSString *path = [[NSBundle bundleWithIdentifier:@"com.apple.UIKit"] pathForResource:resourceName ofType:type];
        
        if (path) {
            
            SystemSoundID theSoundID;
            OSStatus error =  AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &theSoundID);
            if (error == kAudioServicesNoError) {
                
                soundID = theSoundID;
            }else {
                
                NSLog(@"Failed to create sound ");
            }
        }
    }
    return self;
}



-(id)initForPlayingSoundEffectWith:(NSString *)filename
{
    self = [super init];
    if (self) {
        
        NSURL *fileURL = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        if (fileURL != nil)
        {
            SystemSoundID theSoundID;
            OSStatus error = AudioServicesCreateSystemSoundID((__bridge CFURLRef)fileURL, &theSoundID);
            if (error == kAudioServicesNoError){
                soundID = theSoundID;
            }else {
                NSLog(@"Failed to create sound ");
            }
        }
    }
    return self;
}

-(void)play
{
    AudioServicesPlaySystemSound(soundID);
}

-(void)dealloc
{
    AudioServicesDisposeSystemSoundID(soundID);
}


-(void)playwarning
{
    AppDelegate *sharedelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    if (sharedelegate.ringType == ringTypeRing) {
        [LxxSoundPlay playSound];
    } else if (sharedelegate.ringType == ringTypeVibration){
        [LxxSoundPlay playVibrate];
    } else if (sharedelegate.ringType == ringTypeRingAndVibration) {
        [LxxSoundPlay playVibrate];
        [LxxSoundPlay playSound];
    }
    
}
+(void)playSound
{
    SystemSoundID soundId;
    NSString *path = [[NSBundle mainBundle]pathForResource:@"alarm" ofType:@"caf"];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path], &soundId);
    AudioServicesPlaySystemSound(soundId);
}

+ (void)playVibrate {
    LxxSoundPlay *playSound =[[LxxSoundPlay alloc]initForPlayingVibrate];
    [playSound play];
}

- (void)startWarning {
    [self.playerTimer fire];
}
- (void)stopWarning
{
    [self.playerTimer invalidate];
    self.playerTimer = nil;
}
@end
