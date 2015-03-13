//
//  SLOscillator.m
//  soniclab-binauralbeats
//
//  Created by Johann Diedrick on 2/28/15.
//  Copyright (c) 2015 Johann Diedrick. All rights reserved.
//

#import "SLOscillator.h"

@implementation SLOscillator

-(void) setup:(int)newSampleRate{
    //...

}

-(void) setVolume:(float)vol{
    //...
}

-(void)setFrequency:(float)freq{
    //...
}


-(float*)getSine{
    
    //...
    
    return render_output;    
}

-(void)updateWaveform:(int)waveFormResolution{
    //...

}

-(float*)getWavetableSample{
    //...

    return render_output;
}

-(float)getFrequency{
    //...

    return 0.0;
}

-(double)map:(double)value inputMin:(double)inputMin inputMax:(double)inputMax outputMin:(double)outputMin outputMax:(double)outputMax{
    //implementation borrowed from openframeworks. thx for being open source! ;)
    if (fabs(inputMin - inputMax) < FLT_EPSILON){
        return outputMin;
    } else {
        return ((value - inputMin) / (inputMax - inputMin) * (outputMax - outputMin) + outputMin);
        
    }
}


@end
