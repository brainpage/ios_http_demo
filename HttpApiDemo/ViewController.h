//
//  ViewController.h
//  HttpApiDemo
//
//  Created by Jonathan Palley on 5/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrainpageHTTP.h"

@interface ViewController : UIViewController
{
    IBOutlet UITextField *feature1;
    IBOutlet UITextField *feature2;
    BrainpageHTTP *bpServer;
}

-(IBAction)doPostButton;
@end
