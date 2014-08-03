//
//  AddEventoViewController.m
//  iStand
//
//  Created by Maurizio Pinzi on 20/02/12.
//  Copyright (c) 2012 Almawave. All rights reserved.
//

#import "AddEventoViewController.h"
#import "RowCampoDinamico.h"
#import "Evento.h"
#import "Opzione.h"
#import "CampoDinamico.h"
#import "Constants.h"

@implementation AddEventoViewController

@synthesize managedObjectContext = _managedObjectContext;

@synthesize myScrollView;

@synthesize textTitoloEvento;
@synthesize textOrganizzazioneEvento;

@synthesize labelDataEventoDal;
@synthesize labelDataEventoAl;
@synthesize labelDataEventoDalAl;
@synthesize datePickerDataEvento;
@synthesize segmentedTipoCampi;

@synthesize textFlag;
@synthesize buttonAddFlag;

@synthesize textNote;
@synthesize buttonAddNote;

@synthesize textMultiple;
@synthesize buttonAddMultiple;
@synthesize textOpzione1;
@synthesize textOpzione2;
@synthesize textOpzione3;
@synthesize textOpzione4;
@synthesize textOpzione5;

@synthesize tableCampiDinamici;

@synthesize scrollView;



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

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    tableCampiDinamici.backgroundColor = [UIColor clearColor];
    
    self.myScrollView.showsVerticalScrollIndicator = NO;
    ord=10;
    
    //label di quale data si modifica
    labelDataEventoDalAl.text = NSLocalizedString(@"STARTDATE", @"");
    
    //gestione della date nei label
    labelSelected = @"datadal";
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy"];
    
	self.labelDataEventoDal.text = [NSString stringWithFormat:@"%@",[df stringFromDate:[NSDate date]]];
    self.labelDataEventoAl.text = [NSString stringWithFormat:@"%@",[df stringFromDate:[NSDate date]]];
	
    self.datePickerDataEvento.date = [NSDate date];
	[self.datePickerDataEvento addTarget:self action:@selector(changeDateInLabel:) forControlEvents:UIControlEventValueChanged];    
    
    self.labelDataEventoDal.userInteractionEnabled = YES;
    self.labelDataEventoAl.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture1 =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap1:)];
    UITapGestureRecognizer *tapGesture2 =
    [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(labelTap2:)];
    [self.labelDataEventoDal addGestureRecognizer:tapGesture1];
    [self.labelDataEventoAl addGestureRecognizer:tapGesture2];
    
    
    [self.segmentedTipoCampi addTarget:self
                                action:@selector(pickOne:)
                      forControlEvents:UIControlEventValueChanged];
    
    
    self.textFlag.hidden = NO;
    self.buttonAddFlag.hidden = NO;
    
    self.textNote.hidden = YES;
    self.buttonAddNote.hidden = YES;
    
    self.textMultiple.hidden = YES;
    self.buttonAddMultiple.hidden = YES;
    
    self.textOpzione1.hidden = YES;
    self.textOpzione2.hidden = YES;
    self.textOpzione3.hidden = YES;
    self.textOpzione4.hidden = YES;
    self.textOpzione5.hidden = YES;
    
    arrayCampiDinamici = [[NSMutableArray alloc] initWithObjects:nil];
    
    self.tableCampiDinamici.delegate = self;    
    self.tableCampiDinamici.dataSource = self; 
    
    
    ISDEBUG ? NSLog(@"Posizione view x=%f y=%f",self.view.frame.origin.x,self.view.frame.origin.y):nil;
    self.navigationItem.title = NSLocalizedString(@"EVENTCREATION", @"");
    
    //UIInterfaceOrientation currentOrientation =   [[UIDevice currentDevice] orientation];
    UIInterfaceOrientation currentOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    [self printOrientation:currentOrientation method:@"viewLoad"];
    [self actionsBasedOnOrientation:currentOrientation forView:self.myScrollView];
    //[self correctBug:currentOrientation withMainView:self.view onView:self.myScrollView];
    
}

- (void)changeDateInLabel:(id)sender{
	
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy"];
    if([labelSelected isEqualToString:@"datadal"])
    {
        self.labelDataEventoDal.text = [NSString stringWithFormat:@"%@",
                                        [df stringFromDate:self.datePickerDataEvento.date]];
        
        
    }
    else if([labelSelected isEqualToString:@"dataal"])
    {
        self.labelDataEventoAl.text = [NSString stringWithFormat:@"%@",
                                       [df stringFromDate:self.datePickerDataEvento.date]];
        
    }
    
    
}

/*- (void) manageOrientation
 {
 UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
 NSLog(@"currentDevice: %d", (int)orientation);
 
 
 //dritto
 if (orientation == 1 || orientation == 2) {  
 
 self.myScrollView.contentSize = CGSizeMake(768,960);
 self.myScrollView.frame = CGRectMake(0, 0, 768,960);
 self.view.frame = CGRectMake(0, 0, 768,960);  
 }
 //orizzontale
 else if(orientation == 4 || orientation == 3)
 {
 self.myScrollView.contentSize = CGSizeMake(1024,1030);
 self.myScrollView.frame = CGRectMake(0, 0, 1024,916);
 self.view.frame = CGRectMake(0, 0, 1024,768); 
 
 }
 //NSLog(@"Posizione view x=%f y=%f",self.view.frame.origin.x,self.view.frame.origin.y);
 //NSLog(@"Posizione scroll x=%f y=%f",self.myScrollView.frame.origin.x,self.myScrollView.frame.origin.y);
 }*/


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
-(void)labelTap1:(id)sender
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy"];
    UITapGestureRecognizer *a = (UITapGestureRecognizer*)sender;
    UILabel *b = (UILabel*)a.view;
    if(b.tag==111)
    {
        labelSelected = @"datadal";
        NSString *strDataDal = self.labelDataEventoDal.text;
        self.datePickerDataEvento.date = [df dateFromString:strDataDal];
        //label di quale data si modifica
        labelDataEventoDalAl.text = NSLocalizedString(@"STARTDATE", @"");
        
    }
}
-(void)labelTap2:(id)sender
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"dd/MM/yyyy"];
    UITapGestureRecognizer *a = (UITapGestureRecognizer*)sender;
    UILabel *b = (UILabel*)a.view;
    if(b.tag==222)
    {
        labelSelected = @"dataal";
        NSString *strDataAl = self.labelDataEventoAl.text;
        self.datePickerDataEvento.date = [df dateFromString:strDataAl];
        //label di quale data si modifica
        labelDataEventoDalAl.text = NSLocalizedString(@"ENDDATE", @"");
        
    }
}

- (IBAction)addCampoFlag:(id)sender{
    NSLog(@"Flag");
    NSString *value = [self.textFlag.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([value length]>0)
    {
        RowCampoDinamico *tmpRow = [[RowCampoDinamico alloc] init];
        tmpRow.nome = value;
        tmpRow.strTipo = @"Flag";
        tmpRow.intTipo = 0;
        tmpRow.ordinamento = ord++;
        
        [arrayCampiDinamici addObject:tmpRow];
        [self.tableCampiDinamici reloadData];
        self.textFlag.text = @"";
    }
    else
    {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ALERTFLAG", @"") message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
    }
}
- (IBAction)addCampoNota:(id)sender{
    NSLog(@"Nota");
    NSString *value = [self.textNote.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if([value length]>0)
    {
        RowCampoDinamico *tmpRow = [[RowCampoDinamico alloc] init];
        tmpRow.nome = value;
        tmpRow.strTipo = @"Nota";
        tmpRow.intTipo = 1;
        tmpRow.ordinamento = ord++;
        
        [arrayCampiDinamici addObject:tmpRow];
        [self.tableCampiDinamici reloadData]; 
        self.textNote.text = @"";
        
    }
    else
    {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ALERTNOTE", @"") message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
    }
}
- (IBAction)addCampoMultiple:(id)sender{
    NSLog(@"Multiple");
    NSString *value = [self.textMultiple.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *opzione1 = [self.textOpzione1.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *opzione2 = [self.textOpzione2.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    
    if([value length]>0 && [opzione1 length]>0 && [opzione2 length]>0)
    {
        NSString *opzione3 = [self.textOpzione3.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *opzione4 = [self.textOpzione4.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSString *opzione5 = [self.textOpzione5.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        
        RowCampoDinamico *tmpRow = [[RowCampoDinamico alloc] init];
        tmpRow.nome = value;
        tmpRow.strTipo = @"Multiple";
        tmpRow.intTipo = 2;
        tmpRow.ordinamento = ord++;
        tmpRow.arrayOpzioni = [[NSMutableArray alloc] initWithObjects:nil];
        
        [tmpRow.arrayOpzioni addObject:NSLocalizedString(@"SELECT", @"")];
        [tmpRow.arrayOpzioni addObject:opzione1];
        [tmpRow.arrayOpzioni addObject:opzione2];
        if([opzione3 length]>0)
        {
            [tmpRow.arrayOpzioni addObject:opzione3];
        }
        if([opzione4 length]>0)
        {
            [tmpRow.arrayOpzioni addObject:opzione4];
        }
        if([opzione5 length]>0)
        {
            [tmpRow.arrayOpzioni addObject:opzione5];
        }
        
        [arrayCampiDinamici addObject:tmpRow];
        [self.tableCampiDinamici reloadData];
        self.textMultiple.text = @"";
        self.textOpzione1.text = @"";
        self.textOpzione2.text = @"";
        self.textOpzione3.text = @"";
        self.textOpzione4.text = @"";
        self.textOpzione5.text = @"";
        
    }
    else
    {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ALERTMULTIPLE", @"") message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
    }
}
- (IBAction)saveEvento:(id)sender
{
    NSString *titoloEventoTrim = [self.textTitoloEvento.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([titoloEventoTrim length]>0) {
        
        NSString *organizzazioneEventoTrim = [self.textOrganizzazioneEvento.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        NSManagedObjectContext *context = self.managedObjectContext;
        Evento *evento = [NSEntityDescription insertNewObjectForEntityForName:@"Evento" inManagedObjectContext:context];
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd/MM/yyyy"];
        NSDate *dateDalFromString = [[NSDate alloc] init];
        dateDalFromString = [df dateFromString:self.labelDataEventoDal.text];
        
        NSDate *dateAlFromString = [[NSDate alloc] init];
        dateAlFromString = [df dateFromString:self.labelDataEventoAl.text];
        
        evento.data_dal = dateDalFromString;
        evento.data_al = dateAlFromString;
        evento.titolo = titoloEventoTrim;
        evento.organizzazione = organizzazioneEventoTrim;
        evento.data_creazione = [NSDate date];
        
        for(RowCampoDinamico *rCD in arrayCampiDinamici)
        {
            CampoDinamico *campoDinamicoTmp = [NSEntityDescription
                                               insertNewObjectForEntityForName:@"CampoDinamico" 
                                               inManagedObjectContext:context];
            campoDinamicoTmp.nome = rCD.nome;
            campoDinamicoTmp.tipo = [NSNumber numberWithInt:rCD.intTipo];
            campoDinamicoTmp.ordinamento = [NSNumber numberWithInt:rCD.ordinamento];
            
            if(rCD.intTipo==2)
            {
                NSInteger ordOpzione = 0;
                for(NSString *str in rCD.arrayOpzioni)
                {
                    Opzione *opzioneTmp = [NSEntityDescription
                                           insertNewObjectForEntityForName:@"Opzione" 
                                           inManagedObjectContext:context];
                    opzioneTmp.valore = str;
                    opzioneTmp.opzione_campod = campoDinamicoTmp;
                    opzioneTmp.ordinamento = [NSNumber numberWithInt:ordOpzione];
                    ordOpzione++;
                    
                    
                }
            } 
            campoDinamicoTmp.campod_evento = evento;
        }
        NSError *error;
        if (![context save:&error]) {
            NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ERRORSAVEEVENT", @"") message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
            [alertView show];
        }
        
        
        //L'Evento appena creato è automaticamente selezionato
        NSURL *uri = [[evento objectID] URIRepresentation];
        NSData *uriData = [NSKeyedArchiver archivedDataWithRootObject:uri];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:uriData forKey:@"eventoSelected"];
        [prefs synchronize];
        
        NSLog(@"%@",[evento toString2]);
        
        
        [self.navigationController popViewControllerAnimated:YES]; 
        
    }
    else
    {
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"ALERTEVENTTITLE", @"") message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
    }
}




- (void) pickOne:(id)sender{
    
    NSLog(@"Segmented %d",[self.segmentedTipoCampi selectedSegmentIndex]);
    int id = [self.segmentedTipoCampi selectedSegmentIndex];
    if(id==0)
    {
        self.textFlag.hidden = NO;
        self.buttonAddFlag.hidden = NO;
        self.textNote.hidden = YES;
        
        self.buttonAddNote.hidden = YES;
        
        self.textMultiple.hidden = YES;
        self.buttonAddMultiple.hidden = YES;
        self.textOpzione1.hidden = YES;
        self.textOpzione2.hidden = YES;
        self.textOpzione3.hidden = YES;
        self.textOpzione4.hidden = YES;
        self.textOpzione5.hidden = YES;
        
        [self.textFlag becomeFirstResponder];
    }
    else if(id==1)
    {
        self.textFlag.hidden = YES;
        self.buttonAddFlag.hidden = YES;
        self.textNote.hidden = NO;
        
        self.buttonAddNote.hidden = NO;
        
        self.textMultiple.hidden = YES;
        self.buttonAddMultiple.hidden = YES;
        self.textOpzione1.hidden = YES;
        self.textOpzione2.hidden = YES;
        self.textOpzione3.hidden = YES;
        self.textOpzione4.hidden = YES;
        self.textOpzione5.hidden = YES;
        
        [self.textNote becomeFirstResponder];
    }
    else if(id==2)
    {
        self.textFlag.hidden = YES;
        self.buttonAddFlag.hidden = YES;
        
        self.textNote.hidden = YES;
        self.buttonAddNote.hidden = YES;
        
        self.textMultiple.hidden = NO;
        self.buttonAddMultiple.hidden = NO;
        self.textOpzione1.hidden = NO;
        self.textOpzione2.hidden = NO;
        self.textOpzione3.hidden = NO;
        self.textOpzione4.hidden = NO;
        self.textOpzione5.hidden = NO;
        
        [self.textMultiple becomeFirstResponder];
    }
} 


- (void)viewDidUnload
{
    [super viewDidUnload];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [arrayCampiDinamici count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    static NSString *CellIdentifier = @"CellAddEvento";
    AddEventoViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];    
    RowCampoDinamico *riga = [arrayCampiDinamici objectAtIndex:indexPath.row];
	cell.lblDescrCampo.text = riga.nome;
    if(riga.intTipo == 0)
    {
        cell.imgTipoCampo.image = [UIImage imageNamed:@"segmented.png"]; 
    }
    else if(riga.intTipo == 1)
    {
        cell.imgTipoCampo.image = [UIImage imageNamed:@"textView.png"]; 
    }
    else if(riga.intTipo == 2)
    {
        cell.imgTipoCampo.image = [UIImage imageNamed:@"pickerView.png"];
    }
    
    
    
    
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [arrayCampiDinamici removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }    
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    /* CGRect b = self.view.bounds;
     if (toInterfaceOrientation == UIInterfaceOrientationPortrait || toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) 
     {
     NSLog(@"Will Portrait: X=%f Y=%f w=%f h=%f",b.origin.x,b.origin.y,b.size.width,b.size.height);
     self.myScrollView.contentSize = CGSizeMake(768,1024);
     //self.myScrollView.frame = CGRectMake(0, 0, 1024,768);//dimensione di quello visibile al contrario
     
     
     }
     else {
     NSLog(@"Will Landscape: X=%f Y=%f w=%f h=%f",b.origin.x,b.origin.y,b.size.width,b.size.height);
     self.myScrollView.contentSize = CGSizeMake(1024,870);//per poter scendere aumento l'altezza
     //self.myScrollView.frame = CGRectMake(0, 0, 768,1024); 
     }
     */
    
    [self actionsBasedOnOrientation:toInterfaceOrientation forView:self.myScrollView];
    
    
}

/*-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self correctBug:fromInterfaceOrientation withMainView:self.view onView:self.myScrollView];
    
}
-(void)correctBug:(UIInterfaceOrientation)fromInterfaceOrientation
     withMainView:(UIView*)mainView
           onView:(UIView*)myView
{
    float h = self.view.bounds.size.height;
    
    if (fromInterfaceOrientation == UIInterfaceOrientationPortrait || fromInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        CGRect b = self.view.bounds;
        NSLog(@"Did1 Vertic: X=%f Y=%f w=%f h=%f",b.origin.x,b.origin.y,b.size.width,b.size.height);
        
        CGRect rect = CGRectMake(0, 0, 1024,768);
        if (h==748 || h==1024 || h==1004) {
            
            rect.origin.y = 44;
            self.myScrollView.frame = rect;
        }
        else if (h==704 || h==960) {
            
            self.myScrollView.frame = rect;
        }
        self.myScrollView.contentSize = CGSizeMake(1024,900);
        
        
        b = self.view.bounds;
        NSLog(@"Did2 Vertic: X=%f Y=%f w=%f h=%f",b.origin.x,b.origin.y,b.size.width,b.size.height);
        
        
    } else {
        
        CGRect b = self.view.bounds;
        NSLog(@"Did1 Orizz: X=%f Y=%f w=%f h=%f",b.origin.x,b.origin.y,b.size.width,b.size.height);
        
        CGRect rect = CGRectMake(0, 0, 768,1024);
        if (h==748 || h==1024 || h==1004) {
            rect.origin.y = 44;
            self.myScrollView.frame = rect;
        }
        else if (h==704 || h==960) {
            
            self.myScrollView.frame = rect;       
        }
        self.myScrollView.contentSize = CGSizeMake(768,1024);
        
        
        b = self.view.bounds;
        NSLog(@"Did2 Orizz: X=%f Y=%f w=%f h=%f",b.origin.x,b.origin.y,b.size.width,b.size.height);
    }
}
*/
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.navigationController.view layoutSubviews];
}




@end
