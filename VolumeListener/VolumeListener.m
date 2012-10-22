//
//  VolumeListener.m
//  Aroundly
//
//  Created by Riccardo Raneri on 22/10/12.
//
//

#import "VolumeListener.h"

@implementation VolumeListener

@synthesize systemVolume, runningVolumeNotification;

- (id) init{
    runningVolumeNotification = FALSE;
    
    // these 4 lines of code tell the system that "this app needs to play sound/music"
    MPMusicPlayerController *musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
    systemVolume = musicPlayer.volume;
    
    NSString *myExamplePath = [[NSBundle mainBundle] pathForResource:@"silence" ofType:@"mp3"];
    AVAudioPlayer* p = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:myExamplePath] error:NULL];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
    [p prepareToPlay];
    [p stop];
    
   return self;
}


- (UIView*) dummyVolume {
    // tell the system that "this window has an volume view inside it, so there is no need to show a system overlay"
    MPVolumeView* vv = [[MPVolumeView alloc] initWithFrame:CGRectMake(-1000, -1000, 100, 100)];
    vv.tag = 54870149;
    return vv;
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
}

@end
