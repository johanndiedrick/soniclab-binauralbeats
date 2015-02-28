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
    
    audioController = [[SLAudioController alloc] init];
    [audioController createOscillators];
    [audioController initAudioController];
    [audioController startAudioUnit];
    
    //  Add a button to the main view to toggle playback
    UIButton* playbackToggleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [playbackToggleButton setFrame:CGRectMake(20, 20, 280, 80)];
    [playbackToggleButton setTitle:@"Toggle Playback" forState:UIControlStateNormal];
    [playbackToggleButton addTarget:self action:@selector(togglePlayback) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playbackToggleButton];
    
    // Add a slider to adjust left oscillator frequency
    UISlider* channelLSlider = [[UISlider alloc] initWithFrame:CGRectMake(10, 60, self.view.frame.size.width, 20)];
    [channelLSlider addTarget:self action:@selector(channelLSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [channelLSlider setMinimumValue:60];
    [channelLSlider setMaximumValue:600];
    [channelLSlider setContinuous:YES];
    [self.view addSubview:channelLSlider];
    
    // Add a slider to adjust left oscillator frequency
    UISlider* channelRSlider = [[UISlider alloc] initWithFrame:CGRectMake(10, 90, self.view.frame.size.width, 20)];
    [channelRSlider addTarget:self action:@selector(channelRSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [channelRSlider setMinimumValue:60];
    [channelRSlider setMaximumValue:600];
    [channelRSlider setContinuous:YES];
    [self.view addSubview:channelRSlider];
    
    //  Add a button to generate a random binaural range
    UIButton* randomBinauralButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [randomBinauralButton setFrame:CGRectMake(20, 200, 280, 80)];
    [randomBinauralButton setTitle:@"Random Binaural" forState:UIControlStateNormal];
    [randomBinauralButton addTarget:self action:@selector(getRandomBinaural:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:randomBinauralButton];
}

#pragma mark - Adjusting Oscillators

-(void)togglePlayback   {
    [audioController togglePlayback];
}

-(void)channelLSliderValueChanged:(id)sender{
    UISlider *slider = (UISlider*)sender;
    float value = slider.value;
    [audioController changeChannelLFrequency:value];
}

-(void)channelRSliderValueChanged:(id)sender{
    UISlider *slider = (UISlider*)sender;
    float value = slider.value;
    [audioController changeChannelRFrequency:value];
    
}

-(void)getRandomBinaural:(id)sender{
    [audioController randomBinaural];
    
}



@end
