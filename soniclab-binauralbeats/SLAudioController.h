//
//  SLAudioController.h
//  soniclab-binauralbeats
//
//  Created by Johann Diedrick on 2/27/15.
//  Copyright (c) 2015 Johann Diedrick. All rights reserved.
//
// Referenced from https://github.com/zebpedersen/CAController
//

#import <Foundation/Foundation.h>

//import core audio headers
#import <AudioToolbox/AudioToolbox.h>
#import <AudioUnit/AudioUnit.h>

OSStatus renderAudioOutput (void *inRefCon,AudioUnitRenderActionFlags *ioActionFlags,  const AudioTimeStamp *inTimeStamp,  UInt32 inBusNumber, UInt32 inNumberFrames,  AudioBufferList *ioData);

@interface SLAudioController : NSObject{
    AudioComponentInstance outputUnit;
}

//helper functions
-(void)initAudioController;
-(void)startAudioUnit;
-(void)togglePlayback;

@end
