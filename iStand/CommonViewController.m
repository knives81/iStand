//
//  CommonViewController.m
//  iStand
//
//  Created by Maurizio Pinzi on 24/06/12.
//  Copyright (c) 2012 Almawave. All rights reserved.
//

#import "CommonViewController.h"

@interface CommonViewController ()

@end

@implementation CommonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}
-(void)actionsBasedOnOrientation:(UIInterfaceOrientation)or forView:(UIView*)myview
{
    if(or == UIInterfaceOrientationPortrait || or == UIInterfaceOrientationPortraitUpsideDown)
    {
        UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"backPortrait.jpg"]];
        myview.backgroundColor = background;
    }
    else {
        UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"backLandscape.jpg"]];
        myview.backgroundColor = background;
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    UINavigationController* navController = self.navigationController;
    navController.navigationBar.barStyle = UIBarStyleDefault;
    //navController.navigationBar.tintColor = [UIColor redColor];
    //navController.toolbar.tintColor = [UIColor redColor];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}


/*-(void)correctBug:(UIInterfaceOrientation)fromInterfaceOrientation
     withMainView:(UIView*)mainView
           onView:(UIView*)myView
{
    float h = mainView.bounds.size.height;
    
    if (fromInterfaceOrientation == UIInterfaceOrientationPortrait || fromInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        CGRect b = self.view.bounds;
        NSLog(@"Portrait1: X=%f Y=%f w=%f h=%f",b.origin.x,b.origin.y,b.size.width,b.size.height);
        
        if (h==748 || h==1024) {
            CGRect f = myView.frame;
            f.origin.x = 0; // new x
            f.origin.y = 44; // new y
            myView.frame = f;
        }
        else if (h==704 || h==1004) {
            CGRect f = myView.frame;
            f.origin.x = 0; // new x
            f.origin.y = 0; // new y
            myView.frame = f;
        }
        
        
        b = mainView.bounds;
        NSLog(@"Portrait2: X=%f Y=%f w=%f h=%f",b.origin.x,b.origin.y,b.size.width,b.size.height);
        
        
    } else {
        
        CGRect b = mainView.bounds;
        NSLog(@"Landscape1: X=%f Y=%f w=%f h=%f",b.origin.x,b.origin.y,b.size.width,b.size.height);
        if (h==748 || h==1024 || h==1004) {
            CGRect f = myView.frame;
            f.origin.x = 0; // new x
            f.origin.y = 44; // new y
            myView.frame = f;
        }
        else if (h==704 || h==960) {
            CGRect f = myView.frame;
            f.origin.x = 0; // new x
            f.origin.y = 0; // new y
            myView.frame = f;
        }
        
        b = mainView.bounds;
        NSLog(@"Landscape2: X=%f Y=%f w=%f h=%f",b.origin.x,b.origin.y,b.size.width,b.size.height);
    }
    
}*/
-(void)printOrientation:(UIInterfaceOrientation)orient
method:(NSString*)nameMethod
{
    if(orient == UIInterfaceOrientationPortrait || orient == UIInterfaceOrientationPortraitUpsideDown)
    {
        NSLog(@"OrientamentoVerticale-%@",nameMethod);
    }else 
    {
        NSLog(@"OrientamentoOrizzontale-%@",nameMethod);
    }
}


@end
