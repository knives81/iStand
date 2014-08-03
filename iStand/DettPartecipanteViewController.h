//
//  DettPartecipanteViewController.h
//  iStand
//
//  Created by Maurizio Pinzi on 27/02/12.
//  Copyright (c) 2012 Almawave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "MBProgressHUD.h"
#import "MyTextView.h"
#import "CommonViewController.h"

@class Evento;
@class Partecipante;

@interface DettPartecipanteViewController : CommonViewController <UIPickerViewDelegate, UIPickerViewDataSource,UITableViewDelegate, UITableViewDataSource, MFMessageComposeViewControllerDelegate>

{
    MBProgressHUD *HUD;
    
    
    
    Evento *eventoScelto;
    NSString *codice;
    
	Partecipante *partecipanteFromVC;
    Partecipante *partecipante;
    
    NSArray *registrazioni;
    NSMutableDictionary *dictOpzioni;
    
    
}
@property (nonatomic, weak) IBOutlet UISegmentedControl *segmentedInfo;

@property (nonatomic, weak) IBOutlet UIView *viewGenerali;
@property (nonatomic, weak) IBOutlet UIView *viewIstituto;
@property (nonatomic, weak) IBOutlet UIView *viewAggiuntive;

@property (nonatomic, weak) IBOutlet UILabel *lblCodice;
@property (nonatomic, weak) IBOutlet UILabel *lblNome;
@property (nonatomic, weak) IBOutlet UILabel *lblCognome;
@property (nonatomic, weak) IBOutlet UILabel *lblIndirizzo;
@property (nonatomic, weak) IBOutlet UILabel *lblCitta;
@property (nonatomic, weak) IBOutlet UILabel *lblCap;
@property (nonatomic, weak) IBOutlet UILabel *lblProvincia;
@property (nonatomic, weak) IBOutlet UILabel *lblPaese;
@property (nonatomic, weak) IBOutlet UILabel *lblEmail;
@property (nonatomic, weak) IBOutlet UILabel *lblTelefono;
@property (nonatomic, weak) IBOutlet UILabel *lblFax;
@property (nonatomic, weak) IBOutlet UILabel *lblCelluare;
@property (nonatomic, weak) IBOutlet UILabel *lblSpecialita;
@property (nonatomic, weak) IBOutlet UILabel *lblPosizione;
@property (nonatomic, weak) IBOutlet UILabel *lblDipartimento;
@property (nonatomic, weak) IBOutlet UILabel *lblIstituto;
@property (nonatomic, weak) IBOutlet UILabel *lblIndirizzoIst;
@property (nonatomic, weak) IBOutlet UILabel *lblCittaIst;
@property (nonatomic, weak) IBOutlet UILabel *lblCapIst;
@property (nonatomic, weak) IBOutlet UILabel *lblProvinciaIst;
@property (nonatomic, weak) IBOutlet UILabel *lblPaeseIst;
@property (nonatomic, weak) IBOutlet UITextField *txtEmailAdd;
@property (nonatomic, weak) IBOutlet UITextField *txtTelefonoAdd;
@property (nonatomic, weak) IBOutlet UITextField *txtFaxAdd;
@property (nonatomic, weak) IBOutlet UITextField *txtCelluareAdd;

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet  UITableView *tableRegistrazioni;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Evento *eventoScelto;
@property (strong, nonatomic) NSString *codice;
@property (strong, nonatomic) Partecipante *partecipanteFromVC;

-(IBAction)salva:(id)sender;
-(IBAction)mailTap:(id)sender;
-(IBAction)tapSegmentedInfo:(id)sender;


@end
