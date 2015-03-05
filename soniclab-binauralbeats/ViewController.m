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
    _channelLSlider = [[UISlider alloc] initWithFrame:CGRectMake(10, 100, self.view.frame.size.width-10, 20)];
    [_channelLSlider addTarget:self action:@selector(channelLSliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_channelLSlider setMinimumValue:60];
    [_channelLSlider setMaximumValue:1000];
    [_channelLSlider setContinuous:YES];
    [self.view addSubview:_channelLSlider];
    
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
    
    _channelRLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 220, 100, 30)];
    [_channelRLabel setText:[NSString stringWithFormat:@"%i hz", (int)[audioController getOscillatorRightFrequency]]];
    [self.view addSubview:_channelRLabel];
    
    //  Add a button to generate a random binaural range
    UIButton* randomBinauralButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [randomBinauralButton setFrame:CGRectMake(20, 300, 280, 80)];
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
    
    [_channelLLabel setText:[NSString stringWithFormat:@"%i hz", (int)[audioController getOscillatorLeftFrequency]]];

}

-(void)channelRSliderValueChanged:(id)sender{
    UISlider *slider = (UISlider*)sender;
    float value = slider.value;
    [audioController changeChannelRFrequency:value];
    
    [_channelRLabel setText:[NSString stringWithFormat:@"%i hz", (int)[audioController getOscillatorRightFrequency]]];
    
}

-(void)getRandomBinaural:(id)sender{
    [audioController randomBinaural];
    [_channelLLabel setText:[NSString stringWithFormat:@"%i hz", (int)[audioController getOscillatorLeftFrequency]]];
    [_channelRLabel setText:[NSString stringWithFormat:@"%i hz", (int)[audioController getOscillatorRightFrequency]]];
    [_channelLSlider setValue:[audioController getOscillatorLeftFrequency] animated:YES];
    [_channelRSlider setValue:[audioController getOscillatorRightFrequency] animated:YES];

}



@end
