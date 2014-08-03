//
//  SettingsViewController.h
//  iStand
//
//  Created by Maurizio Pinzi on 20/02/12.
//  Copyright (c) 2012 Almawave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommonViewController.h"
#import "ASIHTTPRequest.h"
#import "TouchXML.h"
#import "MBProgressHUD.h"

@interface SettingsViewController : CommonViewController <UITableViewDelegate, UITableViewDataSource>
{
    
    MBProgressHUD *HUD;
    NSArray *eventi;
    NSIndexPath *lastIndexPath;
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, weak) IBOutlet UITableView *tableEventi;
@property (nonatomic, weak) IBOutlet UITextField *textUrlWsdl;
@property (nonatomic, weak) IBOutlet UISwitch *switchAcqRapida;
@property (nonatomic, weak) IBOutlet UIView *myView;

-(IBAction)tapCheck:(id)sender;

@end
