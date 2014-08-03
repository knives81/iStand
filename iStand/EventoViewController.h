//
//  EventoViewController.h
//  iStand
//
//  Created by Maurizio Pinzi on 20/02/12.
//  Copyright (c) 2012 Almawave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "CommonViewController.h"
@class Partecipante;
@class Reachability;

@interface EventoViewController : CommonViewController <UITextFieldDelegate,MBProgressHUDDelegate>
{
    MBProgressHUD *HUD;
    UIBarButtonItem* bi0;
    UIBarButtonItem* bi1;
    UIBarButtonItem* bi2;
    UIBarButtonItem* bi3;
    
    Reachability* internetReachable;
    Reachability* hostReachable;
	
	Partecipante *partecipante;
    
    UIBarButtonItem *info;
    
}
@property (nonatomic, weak) IBOutlet UIButton *buttonPartecipante;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *spinner;
@property (nonatomic, weak) IBOutlet UILabel *lblNumeroPartecipanti;
@property (nonatomic, weak) IBOutlet UIView *viewDati;
@property (nonatomic, weak) IBOutlet UILabel *lblDataDalEvento;
@property (nonatomic, weak) IBOutlet UILabel *lblDataAlEvento;
@property (nonatomic, weak) IBOutlet UILabel *lblOrganEvento;
@property (nonatomic, weak) IBOutlet UILabel *lblTitoloEvento;
@property (nonatomic, weak) IBOutlet UITextField *textCodicePartecipante;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *info;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void) checkNetworkStatus:(NSNotification *)notice;

@end
