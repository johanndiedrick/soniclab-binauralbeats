# Binaural Beats on iOS Workshop

### Sonic Lab
### Friday March 6, 2015 | 7:30pm - 9:30pm EST
### Interactive Telecommunications Program, 721 Broadway, New York, NY

## Description

In this 2-hour iOS workshop, we will create a simple application for creating binaural beats. There will be a super quick introduction to binaural beats, followed by an introduction to iOS development and Core Audio, the foundational framework for digital audio on iOS and OS X. We will touch on creating interfaces and classes, as well as walk through some fundamental concepts for generating digital audio. Having taken ICM should be more than enough to keep up. Having a iOS Developer Account is required to build the application on your phone. You should be able to build in the iOS Simulator without an iOS developer account however.

## Setting up you iOS Developer account

1) Send Marlon (<me42@nyu.edu>) or T.K. (<tkbroderick@gmail.com>) your email address.

2) In the email, tell them what kind of device you have (iPhone, iPod or iPad), and the device's UDID. Instructions on finding your devices UDID can be found here:

http://www.macworld.co.uk/how-to/iphone/how-find-out-your-iphone-or-ipad-udid-3530239/

## Instructions:

During the workshop, we're going to work from a template project, where you can "fill in the blanks" as we we walk through building the application. The instructions below outline what we will be doing.

1) Download/clone repo

* Add CoreAudio Framework

2) Create our SLAudioController Class

* Based on NSObject

3) Import AudioUnit Headers

* Two things we are responsible for setting up:

	a) How we render our sound (via sine waves)

	b) Describe and create out AudioUnit

	c) Creating a synthesizer class

	d) Setting up a simple UI

### Order of tasks 

* Create our AudioUnit

* Create our oscillator class

* Render our sound

* Create our UI and other niceties

## To Do

* Comment every line of code

* Make a "finished" branch for reference and an "unfinished" branch to be used at the workshop

## References

* https://github.com/zebpedersen/CAController

* http://www.cocoawithlove.com/2010/10/ios-tone-generator-introduction-to.html

* https://github.com/jdiedrick/transmission-ios

* http://stackoverflow.com/questions/12353033/ios-audio-unit-creating-stereo-sine-waves

* http://stackoverflow.com/questions/25844415/ios-audio-unit-how-to-create-stereo-sine-waves

* http://stackoverflow.com/questions/14466371/ios-generate-and-play-indefinite-simple-audio-sine-wave

* http://stackoverflow.com/questions/10823322/control-mono-playback-output-with-core-audio

* http://en.wikipedia.org/wiki/Binaural_beats

* http://lists.apple.com/archives/coreaudio-api/2011/Feb/msg00069.html

* http://stackoverflow.com/questions/14391398/ios-core-audio-render-callback-works-on-simulator-not-on-device

* http://stackoverflow.com/questions/6143107/compiler-error-initializer-element-is-not-a-compile-time-constant

* http://stackoverflow.com/questions/22221948/use-of-undeclared-identifier-objective-c-code

* http://publications.gbdirect.co.uk/c_book/chapter5/sizeof_and_malloc.html
