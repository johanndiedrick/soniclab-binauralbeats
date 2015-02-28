//
//  SLOscillator.h
//  soniclab-binauralbeats
//
//  Created by Johann Diedrick on 2/28/15.
//  Copyright (c) 2015 Johann Diedrick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SLOscillator : NSObject{

@public
enum{
    sineWave, squareWave, triangleWave, sawWave, inverseSawWave
} waveType;

int type;
int sampleRate;
float frequency;
float volume;
float phase;
float phaseAdder;

//maybe not needed? consider refactoring
float* render_output;
double osc_output;

}

-(void)setup:(int)sampRate;
-(void)setFrequency: (float) freq;
-(void)setVolume: (float) vol;
-(void)setType:(int)oscType;
-(float*)getSine;
-(double)getWaveTableSample;

@end
