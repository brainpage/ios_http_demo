//
//  ViewController.m
//  HttpApiDemo
//
//  Created by Jonathan Palley on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#define UUID @"1cc32a1ae063af9b70583bd56f9bcaa6dcbe5873"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    //Initialize server object
     bpServer = [[BrainpageHTTP alloc] init];
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
   
}

- (void)viewDidUnload
{
    NSLog(@"unload");
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

-(IBAction)doPostButton
{
   //Create an NSDictionary with the data we want to post
    NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:feature1.text, @"feature1", feature2.text, @"feature2", nil];

    [bpServer postData:data for:UUID buffer:2];
 
}
@end
