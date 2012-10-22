//
//  VolumeListener.h
//  Aroundly
//
//  Created by Riccardo Raneri on 22/10/12.
//
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MediaPlayer/MediaPlayer.h>

@interface VolumeListener : NSObject{
    CGFloat systemVolume;
    bool runningVolumeNotification;
}

- (UIView*) dummyVolume;

@property CGFloat systemVolume;
@property bool runningVolumeNotification;

@end
