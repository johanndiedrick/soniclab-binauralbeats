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
    sampleRate = newSampleRate;
    type = sineWave;
    render_output = (float*) malloc(sizeof(float*[2]));
    osc_output = 0.0f;
}

-(void) setVolume:(float)vol{
    volume = vol;
}

-(void)setFrequency:(float)freq{
    frequency = freq;
    phaseAdder = 2.0 * M_PI * frequency / sampleRate;
}

-(void) setType:(int)oscType{
    type = oscType;
}

-(float*)getSine{
    
    render_output[0] = 0.0f;
    render_output[1] = 0.0f;
    
    osc_output = sin(phase*(2.0 * M_PI));
    
    if (phase>=2.0) {
        phase-=2.0;
    }
    
    phase += (2.0/(sampleRate/frequency));
    
    render_output[0] = render_output[1] = osc_output;
    
    return render_output;    
}

-(void)updateWaveform:(int)waveFormResolution{
    _waveform = [[NSMutableArray alloc] init];
    
    for (int i =0; i<waveFormResolution; i++) {
        [_waveform addObject:[NSNumber numberWithFloat:0.0]];
    }
    
    float waveformStep = (M_PI * 2.) / (float)[_waveform count];
    for (int i=0; i<[_waveform count]; i++ ){
        [_waveform setObject:[NSNumber numberWithFloat:(float)sin(i*waveformStep)] atIndexedSubscript:i];
    }
}

-(float*)getWavetableSample{
    render_output[0] = 0.0f;
    render_output[1] = 0.0f;

    int waveformIndex = (int)(phase * [_waveform count]) % [_waveform count];

    osc_output = [[_waveform objectAtIndex:waveformIndex] floatValue];
    
    
    if (phase>=2.0) {
        phase-=2.0;
    }
    
    phase += (2.0/(sampleRate/frequency));

    
    render_output[0] = render_output[1] = osc_output;

    return render_output;
}

-(float)getFrequency{
    return frequency;
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
