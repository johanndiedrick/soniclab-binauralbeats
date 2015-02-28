//
//  SLAudioController.m
//  soniclab-binauralbeats
//
//  Created by Johann Diedrick on 2/27/15.
//  Copyright (c) 2015 Johann Diedrick. All rights reserved.
//

#import "SLAudioController.h"

//setup some constants
const Float64 sampleRate = 44100.0;
double TWOPI = 2*M_PI;
float* bufferL;
float* bufferR;

//things for oscillators, will move into class later
float* preBufferOutputL = nil;
float* preBufferOutputR = nil;

bool playback;



//render our output
OSStatus renderAudioOutput(void *inRefCon, AudioUnitRenderActionFlags *ioActionFlags, const AudioTimeStamp *inTimeStamp, UInt32 inBusNumber, UInt32 inNumberFrames, AudioBufferList *ioData){
    
    const int l = 0;
    
    bufferL = (Float32*)ioData->mBuffers[l].mData;
    bufferR = (Float32*)ioData->mBuffers[l+1].mData;
    
    for (UInt32 i =0; i< inNumberFrames; i++) {
        if (playback) {
            
            preBufferOutputL = [oscillatorLeft getSine];
            preBufferOutputR = [oscillatorRight getSine];
        }
        
        bufferL[i] = preBufferOutputL[0];
        bufferR[i] = preBufferOutputR[0];
        
    }
    
    return noErr;

}

@implementation SLAudioController

-(void)initAudioController{
    
    //allocate memory for our prebuffers and render output
    preBufferOutputL = (float*) malloc(sizeof(float*[2]));
    preBufferOutputR = (float*) malloc(sizeof(float*[2]));
    
    //configure the search parameters to find the default playback output unit
    //kAudioUnitSubType_RemoteIO on iOS, kAudioUnitSubType_DefaultOutput on Mac OS X
    AudioComponentDescription defaultOutputDescription;
    
    defaultOutputDescription.componentType = kAudioUnitType_Output;
    defaultOutputDescription.componentSubType = kAudioUnitSubType_RemoteIO;
    defaultOutputDescription.componentManufacturer = kAudioUnitManufacturer_Apple;
    defaultOutputDescription.componentFlags = 0;
    defaultOutputDescription.componentFlagsMask = 0;

    
    AudioComponent defaultOutput = AudioComponentFindNext(NULL,
                                                          &defaultOutputDescription);
    NSAssert(defaultOutput, @"Can't find default output!");
    
    OSErr err = AudioComponentInstanceNew(defaultOutput, &outputUnit);
    NSAssert1(outputUnit, @"Error creating unit: %hd", err);
    
    AURenderCallbackStruct renderCallbackStruct;
    renderCallbackStruct.inputProc = renderAudioOutput; // our audio controller will use our render output function
    renderCallbackStruct.inputProcRefCon = (__bridge void*) self;
    
    err = AudioUnitSetProperty(outputUnit,
                               kAudioUnitProperty_SetRenderCallback,
                               kAudioUnitScope_Input,
                               0,
                               &renderCallbackStruct,
                               sizeof(renderCallbackStruct));
    
    NSAssert1(err == noErr, @"Error setting callback: %hd", err);
    
    const int four_bytes_per_float = 4;
    const int eight_bytes_per_float = 8;
    
    AudioStreamBasicDescription format;
    format.mSampleRate = sampleRate;
    format.mFormatID = kAudioFormatLinearPCM;
    format.mFormatFlags = kAudioFormatFlagsNativeFloatPacked | kAudioFormatFlagIsNonInterleaved;
    format.mBytesPerPacket = four_bytes_per_float;
    format.mFramesPerPacket = 2;
    format.mBytesPerFrame = four_bytes_per_float;
    format.mChannelsPerFrame = 2; //set up two channels for left and right
    format.mBitsPerChannel = (four_bytes_per_float * eight_bytes_per_float)*2;
    
    err = AudioUnitSetProperty(outputUnit, kAudioUnitProperty_StreamFormat, kAudioUnitScope_Input, 0, &format, sizeof(format));
    
    //NSAssert1(err == noErr, @"Error setting stream format: %hd", err); // = != == ...
    
}

-(void)startAudioUnit{
    OSErr err  = AudioUnitInitialize (outputUnit);
    err = AudioOutputUnitStart (outputUnit);
    playback = true;
}

-(void)togglePlayback{
    playback = !playback;
}

-(void)createOscillators{
    oscillatorLeft = [[SLOscillator alloc] init];
    [oscillatorLeft setup:sampleRate];
    [oscillatorLeft setFrequency:450.0];
    [oscillatorLeft setType:sineWave];
    [oscillatorLeft setVolume:0.25];

    oscillatorRight = [[SLOscillator alloc] init];
    [oscillatorRight setup:sampleRate];
    [oscillatorRight setFrequency:440.0];
    [oscillatorRight setType:sineWave];
    [oscillatorRight setVolume:0.25];
}


-(void)changeChannelLFrequency:(float)frequency{
    [oscillatorLeft setFrequency:frequency];
}

-(void)changeChannelRFrequency:(float)frequency{
    [oscillatorRight setFrequency:frequency];
}

-(void)randomBinaural{
    
    int leftFrequency = [self getRandomNumberBetween:60 to:600];
    int rightFrequency = leftFrequency - [self getRandomNumberBetween:1 to:30];
    
    [oscillatorLeft setFrequency:leftFrequency];
    [oscillatorRight setFrequency:rightFrequency];

}

-(int)getRandomNumberBetween:(int)from to:(int)to {
    
    return (int)from + arc4random() % (to-from+1);
}



@end
