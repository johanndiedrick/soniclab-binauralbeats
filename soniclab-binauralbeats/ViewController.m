//
//  ViewController.m
//  soniclab-binauralbeats
//
//  Created by Johann Diedrick on 2/24/15.
//  Copyright (c) 2015 Johann Diedrick. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    audioController = [[SLAudioController alloc] init]; // setup our audio controller
    [audioController createOscillators]; // create our oscillators
    [audioController initAudioController]; // initialize our audio controller
    [audioController startAudioUnit]; // start our audio unit
    
    //  Add a button to the main view to toggle playback
    UIButton* playbackToggleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [playbackToggleButton setFrame:CGRectMake(20, 20, 280, 80)];
    [playbackToggleButton setTitle:@"Toggle Playback" forState:UIControlStateNormal];
    [playbackToggleButton addTarget:self action:@selector(togglePlayback) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playbackToggleButton];
    
    // Add a slider to adjust left oscillator frequency
    _channelLSlider = [[UISlider alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width-10, 20)];
    [_channelLSlider addTarget:self action:@selector(channelLSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_channelLSlider setMinimumValue:60];
    [_channelLSlider setMaximumValue:1000];
    [_channelLSlider setContinuous:YES];
    [self.view addSubview:_channelLSlider];
    
    // Add label to display our left oscillator's frequency
    _channelLLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 120, 100, 30)];
    [_channelLLabel setText:[NSString stringWithFormat:@"%i hz", (int)[audioController getOscillatorLeftFrequency]]];
    [self.view addSubview:_channelLLabel];
    
    
    // Add a slider to adjust left oscillator frequency
    _channelRSlider = [[UISlider alloc] initWithFrame:CGRectMake(10, 200, self.view.frame.size.width-10, 20)];
    [_channelRSlider addTarget:self action:@selector(channelRSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_channelRSlider setMinimumValue:60];
    [_channelRSlider setMaximumValue:1000];
    [_channelRSlider setContinuous:YES];
    [self.view addSubview:_channelRSlider];
    
    // Add label to display our right oscillator's frequency
    _channelRLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 220, 100, 30)];
    [_channelRLabel setText:[NSString stringWithFormat:@"%i hz", (int)[audioController getOscillatorRightFrequency]]];
    [self.view addSubview:_channelRLabel];
    
    // Add label to display our binaural beat's frequency
    _binauralBeatFrequency = [[UILabel alloc] initWithFrame:CGRectMake(10, 260, self.view.frame.size.width, 30)];
    [_binauralBeatFrequency setText:[NSString stringWithFormat:@" Binaural Beat Frequency: %i hz", abs((int)[audioController getOscillatorRightFrequency] - (int)[audioController getOscillatorLeftFrequency] )]];    [self.view addSubview:_binauralBeatFrequency];
    
    //  Add a button to generate a random binaural range
    UIButton* randomBinauralButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [randomBinauralButton setFrame:CGRectMake(20, 300, 280, 80)];
    [randomBinauralButton setTitle:@"Random Binaural" forState:UIControlStateNormal];
    [randomBinauralButton addTarget:self action:@selector(getRandomBinaural:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:randomBinauralButton];
}

#pragma mark - Adjusting Oscillators

-(void)togglePlayback   {
    //turn play back on or off
    [audioController togglePlayback];
}

-(void)channelLSliderValueChanged:(id)sender{
    UISlider *slider = (UISlider*)sender;
    float value = slider.value;
    [audioController changeChannelLFrequency:value]; // change the frequency of our left oscillator depending on slider value
    
    [_channelLLabel setText:[NSString stringWithFormat:@"%i hz", (int)[audioController getOscillatorLeftFrequency]]]; // update the text
    [_binauralBeatFrequency setText:[NSString stringWithFormat:@" Binaural Beat Frequency: %i hz", abs((int)[audioController getOscillatorRightFrequency] - (int)[audioController getOscillatorLeftFrequency] )]];

}

-(void)channelRSliderValueChanged:(id)sender{
    UISlider *slider = (UISlider*)sender;
    float value = slider.value;
    [audioController changeChannelRFrequency:value]; // change the frequency of our right oscillator depending on slider value
    
    [_channelRLabel setText:[NSString stringWithFormat:@"%i hz", (int)[audioController getOscillatorRightFrequency]]]; // update the text
    [_binauralBeatFrequency setText:[NSString stringWithFormat:@" Binaural Beat Frequency: %i hz", abs((int)[audioController getOscillatorRightFrequency] - (int)[audioController getOscillatorLeftFrequency] )]];
    
}

-(void)getRandomBinaural:(id)sender{
    [audioController randomBinaural]; // generate a random binaural frequency range
    [_channelLLabel setText:[NSString stringWithFormat:@"%i hz", (int)[audioController getOscillatorLeftFrequency]]]; // update the text
    [_channelRLabel setText:[NSString stringWithFormat:@"%i hz", (int)[audioController getOscillatorRightFrequency]]]; // update the text
    [_channelLSlider setValue:[audioController getOscillatorLeftFrequency] animated:YES]; // update our slider
    [_channelRSlider setValue:[audioController getOscillatorRightFrequency] animated:YES]; // update our slider
    [_binauralBeatFrequency setText:[NSString stringWithFormat:@" Binaural Beat Frequency: %i hz", abs((int)[audioController getOscillatorRightFrequency] - (int)[audioController getOscillatorLeftFrequency] )]];

}



@end
