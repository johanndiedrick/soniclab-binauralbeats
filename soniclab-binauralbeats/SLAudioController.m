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

float* render_output_left = nil;
float* render_output_right = nil;

bool playback;

//osc left

double phaseL = 0.0f;
double frequencyL = 440.0f;
double osc_outputL = 0.0f;

//osc right
double phaseR = 0.0f;
double frequencyR = 450.0f;
double osc_outputR = 0.0f;

//temporary render functinons for our oscilators
float* outputL(){
    render_output_left[0] = 0.0f;
    render_output_left[1] = 0.0f;
    
    osc_outputL = sin(phaseL*(TWOPI));
    
    if (phaseL>=1.0) {
        phaseL-=1.0;
    }
    
    phaseL += (1.0/(sampleRate/frequencyL));
               
    render_output_left[0] = render_output_left[1] = osc_outputL;
    //NSLog(@"output");

    return render_output_left;
}

float* outputR(){
    render_output_right[0] = 0.0f;
    render_output_right[1] = 0.0f;
    
    osc_outputR = sin(phaseR*(TWOPI));
    
    if (phaseR>=1.0) {
        phaseR-=1.0;
    }
    
    phaseR += (1.0/(sampleRate/frequencyR));
    
    render_output_right[0] = render_output_right[1] = osc_outputR;
    
    return render_output_right;
}

//render our output
OSStatus renderAudioOutput(void *inRefCon, AudioUnitRenderActionFlags *ioActionFlags, const AudioTimeStamp *inTimeStamp, UInt32 inBusNumber, UInt32 inNumberFrames, AudioBufferList *ioData){
    
    const int l = 0;
    
    bufferL = (Float32*)ioData->mBuffers[l].mData;
    bufferR = (Float32*)ioData->mBuffers[l+1].mData;
    
    for (UInt32 i =0; i< inNumberFrames; i++) {
        if (playback) {
            preBufferOutputL = outputL();
            preBufferOutputR = outputR();
        }
        
        bufferL[i] = preBufferOutputL[0];
        bufferR[i] = preBufferOutputR[0];
        
        //NSLog(@"%f", bufferL[i]);

    }
    
    return noErr;
    
    
}

@implementation SLAudioController

-(void)initAudioController{
    
    //allocate memory for our prebuffers and render output
    preBufferOutputL = (float*) malloc(sizeof(float*[2]));
    preBufferOutputR = (float*) malloc(sizeof(float*[2]));
    render_output_left = (float*) malloc(sizeof(float*[2]));
    render_output_right = (float*) malloc(sizeof(float*[2]));
    
    
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
    //NSAssert1(outputUnit, @"Error creating unit: %hd", err);

    
    AURenderCallbackStruct renderCallbackStruct;
    renderCallbackStruct.inputProc = renderAudioOutput; // our audio controller will use our render output function
    renderCallbackStruct.inputProcRefCon = (__bridge void*) self;
    
    err = AudioUnitSetProperty(outputUnit,
                               kAudioUnitProperty_SetRenderCallback,
                               kAudioUnitScope_Input,
                               0,
                               &renderCallbackStruct,
                               sizeof(renderCallbackStruct));
    
    //NSAssert1(err == noErr, @"Error setting callback: %hd", err);

    
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
    NSLog(@"toggling playback");
}
@end
