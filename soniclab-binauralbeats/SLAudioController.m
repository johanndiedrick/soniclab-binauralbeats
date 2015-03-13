//
//  SLAudioController.m
//  soniclab-binauralbeats
//
//  Created by Johann Diedrick on 2/27/15.
//  Copyright (c) 2015 Johann Diedrick. All rights reserved.
//

#import "SLAudioController.h"


//render our output
OSStatus renderAudioOutput(void *inRefCon, AudioUnitRenderActionFlags *ioActionFlags, const AudioTimeStamp *inTimeStamp, UInt32 inBusNumber, UInt32 inNumberFrames, AudioBufferList *ioData){
    
    //...
    return noErr;

}

@implementation SLAudioController

-(void)initAudioController{
    
    //...

    
}

-(void)startAudioUnit{
    //...

}

-(void)togglePlayback{
    //...
}

-(void)createOscillators{
    //...

}


-(void)changeChannelLFrequency:(float)frequency{
    //...
}

-(void)changeChannelRFrequency:(float)frequency{
    //...
}

-(void)randomBinaural{
    //...


}

-(int)getRandomNumberBetween:(int)from to:(int)to {
    
    //...
    return 0;

}

-(float)getOscillatorLeftFrequency{
    //...
    return 0.0;

}

-(float)getOscillatorRightFrequency{
    //...
    return 0.0;
}


@end
