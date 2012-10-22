//
//  VLViewController.m
//  VolumeListener
//
//  Created by Riccardo Raneri on 22/10/12.
//  Copyright (c) 2012 Riccardo Raneri. All rights reserved.
//

#import "VLViewController.h"

@interface VLViewController ()

@end

@implementation VLViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    UITextView *instructions = [[UITextView alloc] initWithFrame:CGRectMake(10, 10, self.view.frame.size.width, 100)];
    [instructions setFont: [UIFont boldSystemFontOfSize:20.0]];
    [instructions setText:@"Switch on the listener and then press the volume buttons to see a visual feedback."];
    [self.view addSubview:instructions];
    
    UISwitch *switcher = [[UISwitch alloc] init];
    switcher.center = self.view.center;
    [switcher addTarget: self action: @selector(volumeListener_onOff:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:switcher];
    
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) volumeListener_onOff:(id)sender
{
    UISwitch *onOff = (UISwitch *) sender;
    
    if(onOff.on){
    volumeListener = [[VolumeListener alloc] init];
    [[self.view viewWithTag:54870149] removeFromSuperview];
    [self.view addSubview: [volumeListener dummyVolume]];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(volumeChanged:) name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
    }
    else{
        [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AVSystemController_SystemVolumeDidChangeNotification" object:nil];
        [[self.view viewWithTag:54870149] removeFromSuperview];
    }
}

- (void)volumeChanged:(NSNotification *)notification{
    if(volumeListener.runningVolumeNotification==FALSE){
        dispatch_async(dispatch_get_main_queue(), ^{
            volumeListener.runningVolumeNotification = TRUE;
            MPMusicPlayerController *musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
            [musicPlayer setVolume:volumeListener.systemVolume];
            
            // do what you want to accomplish here
            [self.view setAlpha:0.0f];
            [UIView beginAnimations:@"flash screen" context:nil];
            [UIView setAnimationDuration:0.5f];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
            [self.view setAlpha:1.0f];
            [UIView commitAnimations];
            
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                volumeListener.runningVolumeNotification = FALSE;
            });
        });
    }
}

@end
