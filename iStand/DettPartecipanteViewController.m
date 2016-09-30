//
//  DettPartecipanteViewController.m
//  iStand
//
//  Created by Maurizio Pinzi on 27/02/12.
//  Copyright (c) 2012 Almawave. All rights reserved.
//

#import "DettPartecipanteViewController.h"
#import "Evento.h"
#import "Partecipante.h"
#import "Registrazione.h"
#import "CampoDinamico.h"
#import "Scelta.h"
#import "Opzione.h"

#import "CoreDataUtility.h"
#import "Constants.h"
#import "MyTextView.h"
#import <QuartzCore/QuartzCore.h>
#include <stdlib.h>


@implementation DettPartecipanteViewController

@synthesize segmentedInfo;

@synthesize viewGenerali;
@synthesize viewIstituto;
@synthesize viewAggiuntive;

@synthesize lblCodice;
@synthesize lblNome;
@synthesize lblCognome;
@synthesize lblIndirizzo;
@synthesize lblCitta;
@synthesize lblCap;
@synthesize lblProvincia;
@synthesize lblPaese;
@synthesize lblEmail;
@synthesize lblTelefono;
@synthesize lblFax;
@synthesize lblCelluare;
@synthesize lblSpecialita;
@synthesize lblPosizione;
@synthesize lblDipartimento;
@synthesize lblIstituto;
@synthesize lblIndirizzoIst;
@synthesize lblCittaIst;
@synthesize lblCapIst;
@synthesize lblProvinciaIst;
@synthesize lblPaeseIst;
@synthesize txtEmailAdd;
@synthesize txtTelefonoAdd;
@synthesize txtFaxAdd;
@synthesize txtCelluareAdd;

@synthesize managedObjectContext;
@synthesize eventoScelto;
@synthesize codice;
@synthesize scrollView;
@synthesize tableRegistrazioni;
@synthesize partecipanteFromVC;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    UIInterfaceOrientation currentOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    [self actionsBasedOnOrientation:currentOrientation forView:self.view];
    self.scrollView.backgroundColor = [UIColor clearColor]; 
    
    
    self.viewGenerali.hidden = NO;
    self.viewIstituto.hidden = YES;
    self.viewAggiuntive.hidden = YES;
    
    /*[self.viewGenerali setBackgroundColor:[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0]];
    [self.viewIstituto setBackgroundColor:[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0]];
    [self.viewAggiuntive setBackgroundColor:[UIColor colorWithRed:220.0/255.0 green:220.0/255.0 blue:220.0/255.0 alpha:1.0]];*/
    //[self.viewGenerali.layer setOpaque:NO];
    //self.viewGenerali.opaque = NO;
    self.viewGenerali.backgroundColor = [UIColor clearColor]; 
    self.viewIstituto.backgroundColor = [UIColor clearColor]; 
    self.viewAggiuntive.backgroundColor = [UIColor clearColor]; 
    self.tableRegistrazioni.backgroundColor = [UIColor clearColor];

    
  
    self.viewGenerali.frame = CGRectMake( 20, 71, self.viewGenerali.frame.size.width, self.viewGenerali.frame.size.height );
    self.viewIstituto.frame = CGRectMake( 20, 71, self.viewIstituto.frame.size.width, self.viewIstituto.frame.size.height ); 
    self.viewAggiuntive.frame = CGRectMake( 20, 71, self.viewAggiuntive.frame.size.width, self.viewAggiuntive.frame.size.height ); 
    
    
    self.lblEmail.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap:)];
    [self.lblEmail addGestureRecognizer:tapGesture];
    
    
    ISDEBUG ? NSLog(@"%@",[eventoScelto toString]):nil;
	
	int offsetCampoDinamico = OFFSET_Y;
	dictOpzioni = [[ NSMutableDictionary alloc] init];
    partecipante = self.partecipanteFromVC;        
	
    offsetCampoDinamico = [self showDettagliPartecipante:partecipante offset:offsetCampoDinamico];
	[self mappingCampiPartecipante:partecipante];	
	
    
	ISDEBUG ? NSLog(@"Scroll view: %d",offsetCampoDinamico+1500): nil;
    scrollView.contentSize = CGSizeMake(768,offsetCampoDinamico+1350);
    registrazioni = [partecipante.partec_regist_inv allObjects];
    tableRegistrazioni.delegate = self;
    tableRegistrazioni.dataSource = self;
    
    NSMutableString *nomeCognome = [[NSMutableString alloc]init ];
    [nomeCognome appendFormat:@"%@ %@ %@",partecipante.codice,partecipante.nome, partecipante.cognome];
    self.navigationItem.title = nomeCognome;
    
    
    
}



- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}


/********PICKER*********/

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
	return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    NSArray *opzioniSortate = (NSArray*)[dictOpzioni objectForKey:[NSNumber numberWithInt:pickerView.tag]];
    return [opzioniSortate count];
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    NSArray *opzioniSortate = (NSArray*)[dictOpzioni objectForKey:[NSNumber numberWithInt:pickerView.tag]];
    NSString *opzione = ((Opzione*)[opzioniSortate objectAtIndex:row]).valore;
    return opzione;
}

/*******************************/

- (IBAction)salva:(id)sender
{
    
    NSManagedObjectContext *context = self.managedObjectContext;
    
    partecipante.telefono_add = self.txtTelefonoAdd.text;
    partecipante.cellulare_add = self.txtCelluareAdd.text;
    partecipante.fax_add = self.txtFaxAdd.text;
    partecipante.email_add = self.txtEmailAdd.text;
    
    
    NSSet *setScelte = partecipante.partec_scelta_inv;
    for(Scelta *scelta in setScelte)
    {
        int tag = [scelta.scelta_campod.ordinamento intValue];
        if(scelta.scelta_campod.tipo==[NSNumber numberWithInt:0])
        {
            UISegmentedControl *segmentedControl = (UISegmentedControl *)[self.scrollView viewWithTag:tag];
            if(segmentedControl.selectedSegmentIndex==0)
            {
                scelta.valore_flag = @"true";
            }
            else if(segmentedControl.selectedSegmentIndex==1)
            {
                scelta.valore_flag = @"false";
            }
        }
        else if(scelta.scelta_campod.tipo==[NSNumber numberWithInt:1])
        {
            MyTextView *text = (MyTextView *)[self.scrollView viewWithTag:tag];
            scelta.valore_nota = text.text;
        }
        else if(scelta.scelta_campod.tipo==[NSNumber numberWithInt:2])
        {
            UIPickerView *pickerView = (UIPickerView *)[self.scrollView viewWithTag:tag];
            NSInteger row = [pickerView selectedRowInComponent:0];
            
            NSArray *opzioniSortate = (NSArray*)[dictOpzioni objectForKey:[NSNumber numberWithInt:pickerView.tag]];
            
            scelta.valore_multiple = ((Opzione*)[opzioniSortate objectAtIndex:row]).valore;
            scelta.posizione_multiple = [NSNumber numberWithInt:row];
        }
    }
	BOOL withHud = [self save:context errorMsg:NSLocalizedString(@"ERRORSAVE", @"")];
    if(withHud)
    {
        [self showHud:NSLocalizedString(@"SAVED", @"")];
        [self.navigationController popViewControllerAnimated:YES];
        
    }   
    
}
-(void) showHud:(NSString*)message
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.delegate = self;
    HUD.labelText = message;
    HUD.dimBackground = YES;
	
    [HUD show:YES];
	[HUD hide:YES afterDelay:1];
    
    
}

/********TABLEVIEW*********/
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [registrazioni count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
	}
    
    Registrazione *registrazione = [registrazioni objectAtIndex:indexPath.row];
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    
	cell.textLabel.text = [NSString stringWithFormat:@"%@",
                           [df stringFromDate:registrazione.data_entrata]];
    
    
    
    return cell;
}
/**************************************************/
-(IBAction)mailTap:(id)sender
{
    NSArray *to = [NSArray arrayWithObjects:self.txtEmailAdd.text, nil];
    
    MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    [controller setToRecipients:to];
    [controller setMessageBody:@"" isHTML:YES]; 
    [self presentModalViewController:controller animated:YES];
}


-(void)labelTap:(id)sender
{
    UITapGestureRecognizer *a = (UITapGestureRecognizer*)sender;
    UILabel *b = (UILabel*)a.view;
    NSLog(@"Tap email %@",b.text);
    NSArray *to = [NSArray arrayWithObjects:b.text, nil];
    
    
    MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
    [controller setToRecipients:to];
    [controller setMessageBody:@"" isHTML:YES]; 
    [self presentModalViewController:controller animated:YES];
    
}
- (void)mailComposeController:(MFMailComposeViewController*)controller  
          didFinishWithResult:(MFMailComposeResult)result 
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
        NSLog(@"It's away!");
    }
    [self dismissModalViewControllerAnimated:YES];
}

- (void) tapSegmentedInfo:(id)sender
{
    NSLog(@"Segmented %d",[self.segmentedInfo selectedSegmentIndex]);
    int id = [self.segmentedInfo selectedSegmentIndex];
    if(id==0)
    {
        self.viewGenerali.hidden = NO;
        self.viewIstituto.hidden = YES;
        self.viewAggiuntive.hidden = YES;
        
    }
    else if(id==1)
    {
        self.viewGenerali.hidden = YES;
        self.viewIstituto.hidden = NO;
        self.viewAggiuntive.hidden = YES;
    }
    else if(id==2)
    {
        self.viewGenerali.hidden = YES;
        self.viewIstituto.hidden = YES;
        self.viewAggiuntive.hidden = NO;
    }
}
-(int)showDettagliPartecipante:(Partecipante*)partec offset:(int)offsetCampoDinamico
{
	int offset = offsetCampoDinamico;
	NSSet *setScelte = partec.partec_scelta_inv;        
	NSSortDescriptor *sortByOrdinamento = [[NSSortDescriptor alloc] initWithKey:@"ordinamento" ascending:YES];        
	NSArray *scelteSortate = [[setScelte allObjects]sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortByOrdinamento]];       
	
	for(Scelta *scelta in scelteSortate)
	{
		CampoDinamico *campo = scelta.scelta_campod;
		
		offset = [self showCampoDinamico:campo
                        sceltaEffettuata:scelta
                               offsetXcd:OFFSET_X
                               offsetYcd:offset
                            widthControl:WIDTH_CONTR
                           heightControl:HEIGHT_CONTR
                         heightSegmented:HEIGHT_SEGMENTED
                              heightText:HEIGHT_TEXT
                      gapYBetweenControl:GAP_Y
                      gapXBetweenControl:GAP_X];
		
	}
    return offset;
}
- (int) showCampoDinamico:(CampoDinamico*)campoDinamico
         sceltaEffettuata:(Scelta*)scelta
                offsetXcd:(int)offsetX
                offsetYcd:(int)offsetY
             widthControl:(int)widthContr
            heightControl:(int)heightContr
          heightSegmented:(int)heightSegm
               heightText:(int)heightText
       gapYBetweenControl:(int)gapY
       gapXBetweenControl:(int)gapX
{
	int offsetDinamico = offsetY;
    
	UILabel *labelCampo = [[UILabel alloc] initWithFrame:CGRectMake(offsetX,offsetY,widthContr,heightContr)];
    [labelCampo setText:campoDinamico.nome];
    labelCampo.numberOfLines = 3;
    labelCampo.backgroundColor = [UIColor clearColor];
    [self.scrollView addSubview:labelCampo];
	
	if(campoDinamico.tipo==[NSNumber numberWithInt:0])
    {
		NSArray *item = [NSArray arrayWithObjects:NSLocalizedString(@"YES", @""), NSLocalizedString(@"NO", @""), nil];
        UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:item];
        segmentedControl.frame = CGRectMake(offsetX+widthContr+gapX,offsetY+(heightContr/2)-(heightSegm/2),widthContr,heightSegm);
        segmentedControl.tag = [campoDinamico.ordinamento intValue];
        segmentedControl.tintColor = [UIColor blackColor];
        
		if ([scelta.valore_flag isEqualToString:@"true"]) 
		{
			segmentedControl.selectedSegmentIndex = 0;
		}
		else if ([scelta.valore_flag isEqualToString:@"false"]) 
		{
			segmentedControl.selectedSegmentIndex = 1;
		}
		
		[self.scrollView addSubview:segmentedControl];
	}
	else if(campoDinamico.tipo==[NSNumber numberWithInt:1])
    {
        
        MyTextView *textView = [[MyTextView alloc] initWithFrame:CGRectMake(offsetX+widthContr+gapX,offsetY+(heightContr/2)-(heightText/2),widthContr,heightText)];
        textView.tag = [campoDinamico.ordinamento intValue];
		[textView setFont:[UIFont fontWithName:@"ArialMT" size:15]];
        
        
        textView.text = scelta.valore_nota;
		[self.scrollView addSubview:textView];
	}
	else if(campoDinamico.tipo==[NSNumber numberWithInt:2])
    {
        
		NSSet *setOpzioni = campoDinamico.campod_opzione_inv;        
        NSSortDescriptor *sortByOrdinamento = [[NSSortDescriptor alloc] initWithKey:@"ordinamento" ascending:YES];
        NSArray *opzioniSortate = [[setOpzioni allObjects]sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortByOrdinamento]];
        
        UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(offsetX+widthContr+gapX,offsetY,widthContr,heightContr)];
        pickerView.tag = [campoDinamico.ordinamento intValue];
        [dictOpzioni setObject:opzioniSortate forKey:campoDinamico.ordinamento];
        
		pickerView.showsSelectionIndicator = YES;
		pickerView.delegate = self;
		pickerView.dataSource = self;
		
        
		NSInteger row = [scelta.posizione_multiple intValue];
		[pickerView selectRow:row inComponent:0 animated:NO];
		
        [pickerView reloadAllComponents];
		[self.scrollView addSubview:pickerView];
	}
	offsetDinamico += heightContr + gapY;
	return offsetDinamico;
}

-(BOOL)	save:(NSManagedObjectContext*)context errorMsg:(NSString*)msg
{
	NSError *error;
    if (![context save:&error]) 
    {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:msg message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        return false;
    }
    else {
        return true;
    }
    
}


-(void)mappingCampiPartecipante:(Partecipante*)partec
{
    self.txtTelefonoAdd.text = partec.telefono_add;
    self.txtCelluareAdd.text = partec.cellulare_add;
    self.txtFaxAdd.text = partec.fax_add;
    self.txtEmailAdd.text = partec.email_add;
    
    self.lblCodice.text = partec.codice;
    self.lblNome.text = partec.nome;
    self.lblCognome.text = partec.cognome;
    
    self.lblCitta.text = partec.citta;
    self.lblIndirizzo.text = partec.indirizzo;
    
    self.lblProvincia.text = partec.provincia;
    self.lblPaese.text = partec.paese;
    self.lblCap.text = partec.cap;
    
    self.lblEmail.text = partec.email;
    self.lblTelefono.text = partec.telefono;
    self.lblCelluare.text = partec.cellulare;
    
    self.lblPosizione.text = partec.posizione;
    self.lblSpecialita.text = partec.specialita;
    
    self.lblDipartimento.text = partec.dipartimento;
    self.lblIstituto.text = partec.istituto;
    
    self.lblCittaIst.text = partec.citta_ist;
    self.lblIndirizzoIst.text = partec.indirizzo_ist;
    
    self.lblProvinciaIst.text = partec.provincia_ist;
    self.lblPaeseIst.text = partec.paese_ist;
    self.lblCapIst.text = partec.cap_ist;
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    /*float h = self.view.bounds.size.height;
    
    if (fromInterfaceOrientation == UIInterfaceOrientationPortrait || fromInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        CGRect b = self.view.bounds;
        //NSLog(@"Did1 Vertic: X=%f Y=%f w=%f h=%f",b.origin.x,b.origin.y,b.size.width,b.size.height);
        
        if (h==748 || h==1024 || h==1004) {
            CGRect f = scrollView.frame;
            f.origin.x = 0; // new x
            f.origin.y = 44; // new y
            scrollView.frame = f;
        }
        else if (h==704 || h==960) {
            CGRect f = scrollView.frame;
            f.origin.x = 0; // new x
            f.origin.y = 0; // new y
            scrollView.frame = f;
        }
        
        
        b = self.view.bounds;
        //NSLog(@"Did2 Vertic: X=%f Y=%f w=%f h=%f",b.origin.x,b.origin.y,b.size.width,b.size.height);
        
        
    } else {
        
        CGRect b = self.view.bounds;
        //NSLog(@"Did1 Orizz: X=%f Y=%f w=%f h=%f",b.origin.x,b.origin.y,b.size.width,b.size.height);
        if (h==748 || h==1024 || h==1004) {
            CGRect f = scrollView.frame;
            f.origin.x = 0; // new x
            f.origin.y = 44; // new y
            scrollView.frame = f;
        }
        else if (h==704 || h==960) {
            CGRect f = scrollView.frame;
            f.origin.x = 0; // new x
            f.origin.y = 0; // new y
            scrollView.frame = f;
        }
        
        b = self.view.bounds;
        //NSLog(@"Did2 Orizz: X=%f Y=%f w=%f h=%f",b.origin.x,b.origin.y,b.size.width,b.size.height);
    }*/
    
    [self.navigationController.view layoutSubviews];
    
    
}
-(void)willRotateToInterfaceOrientation: (UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration {
    [self actionsBasedOnOrientation:orientation forView:self.view];
    
    
}



@end
