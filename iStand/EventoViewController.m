//
//  EventoViewController.m
//  iStand
//
//  Created by Maurizio Pinzi on 20/02/12.
//  Copyright (c) 2012 Almawave. All rights reserved.
//

#import "EventoViewController.h"
#import "SettingsViewController.h"
#import "DettPartecipanteViewController.h"
#import "StatisticsViewController.h"
#import "SearchViewController.h"
#import "Evento.h"
#import "Partecipante.h"
#import "Scelta.h"
#import "CampoDinamico.h"
#import "Registrazione.h"
#import "Reachability.h"

@implementation EventoViewController

@synthesize managedObjectContext;
@synthesize persistentStoreCoordinator;


@synthesize viewDati;
@synthesize lblDataDalEvento;
@synthesize lblDataAlEvento;
@synthesize lblTitoloEvento;
@synthesize lblOrganEvento;
@synthesize textCodicePartecipante;
@synthesize lblNumeroPartecipanti;
@synthesize spinner;
@synthesize buttonPartecipante;

Evento *eventoFromPlist;
NSString *codiceBarre;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
/*- (void)loadView
 {
 
 }*/



- (void) checkNetworkStatus:(NSNotification *)notice     {       
    
    // called after network status changes      
    
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    switch (internetStatus){
        case NotReachable:
        {
            NSLog(@"The internet is down.");
            //self.internetActive = NO;
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"The internet is working via WIFI.");
            //self.internetActive = YES;
            break;
        }
        case ReachableViaWWAN:
        {
            NSLog(@"The internet is working via WWAN.");
            //self.internetActive = YES;
            break;
        }
    }
    NetworkStatus hostStatus = [hostReachable currentReachabilityStatus];
    switch (hostStatus)
    {
        case NotReachable:
        {
            NSLog(@"A gateway to the host server is down.");
            //self.hostActive = NO;
            break;
        }
        case ReachableViaWiFi:
        {
            NSLog(@"A gateway to the host server is working via WIFI.");
            //self.hostActive = YES;
            break;
        }
        case ReachableViaWWAN:
        {
            NSLog(@"A gateway to the host server is working via WWAN.");
            //self.hostActive = YES;
            break;
        }
    }
}
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.



- (void)viewDidLoad
{
    [super viewDidLoad];
    info = [UIButton buttonWithType:UIButtonTypeInfoLight]; 
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(checkNetworkStatus:)  name:kReachabilityChangedNotification object:nil];    
    internetReachable = [Reachability reachabilityForInternetConnection];         
    [internetReachable startNotifier];         
    // check if a pathway to a random host exists         
    hostReachable = [Reachability reachabilityWithHostName: @"www.apple.com"];
    [hostReachable startNotifier];         
    // now patiently wait for the notification
    
    
    //[Test testInsertEvento:self.managedObjectContext];
    
    
    textCodicePartecipante.delegate = self;
    
    
    
    
    // create a toolbar to have two buttons in the right
    UIToolbar* tools = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 220, 44.01)];
    
    // create the array to hold the buttons, which then gets added to the toolbar
    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:7];
    
    
    // create a standard "CSV" button
    bi1 = [[UIBarButtonItem alloc]
           initWithTitle:@"CSV" 
           style:UIBarButtonItemStylePlain 
           target:self 
           action:@selector(tapGenerateCsv:)];
    bi1.style = UIBarButtonItemStyleBordered;
    bi1.tag = 11;
    [buttons addObject:bi1];
    
    
    
    
    // create a spacer
    UIBarButtonItem* bi = [[UIBarButtonItem alloc]
                           initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [buttons addObject:bi];
    
    // create a standard "CSV" button
    bi0 = [[UIBarButtonItem alloc]
           initWithImage:[UIImage imageNamed:@"barchart_1.png"] 
           style:UIBarButtonItemStylePlain 
           target:self 
           action:@selector(tapStatistics:)];
    bi0.style = UIBarButtonItemStyleBordered;
    bi0.tag = 10;
    [buttons addObject:bi0];
    
    
    
    // create a spacer
    bi = [[UIBarButtonItem alloc]
          initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [buttons addObject:bi];
    
    // create a standard "Search" button
    bi2 = [[UIBarButtonItem alloc]
           initWithBarButtonSystemItem:UIBarButtonSystemItemSearch 
           target:self 
           action:@selector(tapSearch:)];
    bi2.style = UIBarButtonItemStyleBordered;
    bi2.tag = 12;
    [buttons addObject:bi2];
    
    // create a spacer
    bi = [[UIBarButtonItem alloc]
          initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [buttons addObject:bi];
    
    // create a standard "Settings" button
    bi3 = [[UIBarButtonItem alloc]
           initWithImage:[UIImage imageNamed:@"settingsIcon.png"] 
           style:UIBarButtonItemStylePlain 
           target:self 
           action:@selector(tapSettings:)];    
    bi3.style = UIBarButtonItemStyleBordered;
    [buttons addObject:bi3];
    
    // stick the buttons in the toolbar
    [tools setItems:buttons animated:NO];
    // and put the toolbar in the nav bar
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tools];   
}


- (void)viewDidUnload
{
    [super viewDidUnload];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLanguage = [languages objectAtIndex:0];
    
    NSLog(@"Current Locale: %@", [[NSLocale currentLocale] localeIdentifier]);
    NSLog(@"Current language: %@", currentLanguage);
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *uriData = [prefs objectForKey:@"eventoSelected"];
    
    if(uriData!=nil)
    {
        //Carico ultimo evento selezionato
        NSURL *uri = (NSURL *)[NSKeyedUnarchiver unarchiveObjectWithData:uriData];
        NSManagedObjectID *eventoID = [self.persistentStoreCoordinator managedObjectIDForURIRepresentation:uri];
        eventoFromPlist = (Evento*)[self.managedObjectContext objectWithID:eventoID];
        self.navigationItem.title = eventoFromPlist.titolo;
        
        
        self.lblTitoloEvento.text = eventoFromPlist.titolo;
        self.lblOrganEvento.text = eventoFromPlist.organizzazione;
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"dd/MM/yyy"];
        
        self.lblDataDalEvento.text = [NSString stringWithFormat:@"%@",
                                      [df stringFromDate:eventoFromPlist.data_dal]];
        self.lblDataAlEvento.text = [NSString stringWithFormat:@"%@",
                                     [df stringFromDate:eventoFromPlist.data_al]];
        self.viewDati.hidden = NO;
        
        
        int numPart = [eventoFromPlist countPartecipanti];
        NSString *strNumPart = @"";
        strNumPart= [strNumPart stringByAppendingFormat:@"%@: %d",NSLocalizedString(@"REGISTRATEDPAR", @""),numPart];
        self.lblNumeroPartecipanti.text = strNumPart;
        
        if(numPart == 0)
        {
            bi0.enabled = false;
            bi1.enabled = false;
            bi2.enabled = false;
        }
        else {
            bi0.enabled = true;
            bi1.enabled = true;
            bi2.enabled = true;
            
        }
        
        
        [textCodicePartecipante becomeFirstResponder];
         self.viewDati.backgroundColor = [UIColor clearColor]; 
    }
    else
    {       
        self.navigationItem.title = NSLocalizedString(@"CREATEEVENT", @"");
        self.viewDati.hidden = YES;
        bi1.enabled = false;
        bi2.enabled = false;
        bi0.enabled = false;
        
    }
    self.textCodicePartecipante.text = @"";
    self.buttonPartecipante.hidden = TRUE;
    
    //UIInterfaceOrientation currentOrientation =   [[UIDevice currentDevice] orientation];
    UIInterfaceOrientation currentOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    [self printOrientation:currentOrientation method:@"viewLoad"];
    [self actionsBasedOnOrientation:currentOrientation forView:self.view];
   
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.navigationItem.title = NSLocalizedString(@"BACK", @"");
    if ([[segue identifier] isEqualToString:@"evento_settings"])
    {
        
        SettingsViewController *upcomingViewController = [segue destinationViewController];
        upcomingViewController.managedObjectContext = self.managedObjectContext;
        upcomingViewController.persistentStoreCoordinator = self.persistentStoreCoordinator;
        
    }
    else if([[segue identifier] isEqualToString:@"evento_partecipante"])
    {
        self.navigationItem.title = NSLocalizedString(@"CANCEL", @"");
        DettPartecipanteViewController *upcomingViewController = [segue destinationViewController];
        upcomingViewController.managedObjectContext = self.managedObjectContext;
        upcomingViewController.eventoScelto = eventoFromPlist;
        upcomingViewController.codice = codiceBarre;
        upcomingViewController.partecipanteFromVC = partecipante;
        
    }
    else if([[segue identifier] isEqualToString:@"evento_search"])
    {
        SearchViewController *upcomingViewController = [segue destinationViewController];
        upcomingViewController.managedObjectContext = self.managedObjectContext;
        upcomingViewController.eventoScelto = eventoFromPlist;
        
    }
    else if([[segue identifier] isEqualToString:@"evento_statistics"])
    {
        StatisticsViewController *upcomingViewController = [segue destinationViewController];
        upcomingViewController.managedObjectContext = self.managedObjectContext;
        upcomingViewController.eventoScelto = eventoFromPlist;
        
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    codiceBarre = [textField.text stringByReplacingCharactersInRange: range withString: string];
    ISDEBUG ? NSLog(@"Codice: %@", string):nil;
    
    if([string isEqualToString:@"\n"])
    {
        
        codiceBarre = [codiceBarre stringByReplacingOccurrencesOfString:@"\n" withString:@""];
		
        [spinner startAnimating]; 
        self.buttonPartecipante.hidden = TRUE;
        [self performSelector:@selector(getPartecipante) withObject:nil afterDelay:0.01]; 
        
        
    }
    return true;
}
-(void)getPartecipante
{
    NSManagedObjectContext *context = self.managedObjectContext;
    NSString *urlWsdl = [[NSUserDefaults standardUserDefaults] stringForKey:@"urlWsdl"];
    partecipante = [eventoFromPlist insertPartecipanteInContext:context withCodice:codiceBarre withWsUrl:urlWsdl];
    
    NSError *error;
    if (![context save:&error]) 
    {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    
    NSString *strCodNomCogn = @"";
    strCodNomCogn= [strCodNomCogn stringByAppendingFormat:@"%@ %@ %@", partecipante.codice, partecipante.nome, partecipante.cognome];
    self.buttonPartecipante.hidden = FALSE;
    [self.buttonPartecipante setTitle:strCodNomCogn forState:UIControlStateNormal];
    self.textCodicePartecipante.text = @"";
    
    int numPart = [eventoFromPlist countPartecipanti];
    if(numPart == 0)
    {
        bi0.enabled = false;
        bi1.enabled = false;
        bi2.enabled = false;
    }
    else {
        bi0.enabled = true;
        bi1.enabled = true;
        bi2.enabled = true;
        
    }
    
    
    NSString *strNumPart = @"";
    strNumPart= [strNumPart stringByAppendingFormat:@"%@: %d",NSLocalizedString(@"REGISTRATEDPAR", @""),numPart];
    self.lblNumeroPartecipanti.text = strNumPart;
    
    //lo metto qui cosi posso far funzionare lo spinner
    BOOL isAcqRapida = [[NSUserDefaults standardUserDefaults] boolForKey:@"acqRapida"];
    if(!isAcqRapida)
    {
        [self performSegueWithIdentifier:@"evento_partecipante" sender:self];
    }
    
    
    [spinner stopAnimating];
}


- (IBAction)dettPartecipante:(id)sender
{
	[self performSegueWithIdentifier:@"evento_partecipante" sender:self];
}

-(void)tapSettings:(id)sender
{
    [self performSegueWithIdentifier:@"evento_settings" sender:self];
}
-(void)tapStatistics:(id)sender
{
    [self performSegueWithIdentifier:@"evento_statistics" sender:self];
}
-(void)tapSearch:(id)sender
{
    [self performSegueWithIdentifier:@"evento_search" sender:self];
}
-(void)tapGenerateCsv:(id)sender
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
	HUD.minSize = CGSizeMake(135.f, 135.f);
	[HUD showWhileExecuting:@selector(generateCsv) onTarget:self withObject:nil animated:YES];
}
- (void)generateCsv {         
    
	HUD.mode = MBProgressHUDModeDeterminate;
    HUD.labelText = @"progress";
	
    NSSet *campiDinamici = eventoFromPlist.evento_campod_inv;    
    NSSortDescriptor *sortByOrdinamento = [[NSSortDescriptor alloc] initWithKey:@"ordinamento" ascending:YES];    
    NSArray *campiDinamiciSortati = [[campiDinamici allObjects]sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortByOrdinamento]];
    
    NSMutableString *csv = [[NSMutableString alloc] init];    
    NSMutableString *intestazione = [[NSMutableString alloc] init];
    
   
   


    
    
    
    [intestazione appendFormat:@"%@;%@;%@;", NSLocalizedString(@"ID", @""), NSLocalizedString(@"NAME", @""), NSLocalizedString(@"SURNAME", @"")];
	[intestazione appendFormat:@"%@;%@;%@;", NSLocalizedString(@"ADDRESS", @""), NSLocalizedString(@"CITY", @""), NSLocalizedString(@"COUNTRY", @"")];
	[intestazione appendFormat:@"%@;%@;%@;", NSLocalizedString(@"ZIP", @""), NSLocalizedString(@"EMAIL", @""), NSLocalizedString(@"MOBILE", @"")];
	[intestazione appendFormat:@"%@;%@;%@;", NSLocalizedString(@"TELEPHONE", @""), NSLocalizedString(@"DEPARTMENT", @""), NSLocalizedString(@"POSITION", @"")];
	[intestazione appendFormat:@"%@;",  NSLocalizedString(@"INSTITUTE", @"")];
    [intestazione appendFormat:@"%@;%@;%@;", NSLocalizedString(@"ADDEMAIL", @""), NSLocalizedString(@"ADDMOBILE", @""), NSLocalizedString(@"ADDTELEPHONE", @"")];
    for(CampoDinamico *cd in campiDinamiciSortati)
    {
        [intestazione appendFormat:@"%@;",cd.nome];    
	}     
    [csv appendFormat:@"%@\n",intestazione];    
    
    NSSet *partecipanti = eventoFromPlist.evento_partec_inv;
    float step = 0.9f/[partecipanti count];
	float progress = 0.0f;
    
    for(Partecipante *partec in partecipanti)
    {
        NSMutableString *datiPartec = [[NSMutableString alloc]init ];
		[datiPartec appendFormat:@"%@;%@;%@;", partec.codice, partec.nome, partec.cognome];
		[datiPartec appendFormat:@"%@;%@;%@;", partec.indirizzo, partec.citta, partec.paese];
		[datiPartec appendFormat:@"%@;%@;%@;", partec.cap, partec.email, partec.cellulare];
		[datiPartec appendFormat:@"%@;%@;%@;", partec.telefono, partec.dipartimento, partec.posizione];
		[datiPartec appendFormat:@"%@;", partec.istituto];
		[datiPartec appendFormat:@"%@;%@;%@;", partec.email_add, partec.cellulare_add, partec.telefono_add];
        
        NSSet *setScelte = partec.partec_scelta_inv;        
        NSSortDescriptor *sortByOrdinamento = [[NSSortDescriptor alloc] initWithKey:@"ordinamento" ascending:YES];        
        NSArray *scelteSortate = [[setScelte allObjects]sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortByOrdinamento]]; 
        
        for(Scelta *scelt in scelteSortate)
        {
            CampoDinamico *cd = scelt.scelta_campod;
            if(cd.tipo==[NSNumber numberWithInt:0])
            {
                [datiPartec appendFormat:@"%@;",scelt.valore_flag];
            }
            else if(cd.tipo==[NSNumber numberWithInt:1])
            {
                [datiPartec appendFormat:@"%@;",scelt.valore_nota];
            }
            else if(cd.tipo==[NSNumber numberWithInt:2])
            {
                [datiPartec appendFormat:@"%@;",scelt.valore_multiple];
            }            
        }
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd HH:mm"];       
        NSArray *arrRegistrazioni = [partec.partec_regist_inv allObjects];
        for(Registrazione *regist in arrRegistrazioni)
        {
            NSString *str = [NSString stringWithFormat:@"%@",
                             [df stringFromDate:regist.data_entrata]];
            [datiPartec appendFormat:@"%@;",str];            
        }
        [csv appendFormat:@"%@\n",datiPartec];
        
		progress += step;		
        HUD.progress = progress;
		NSLog(@"%f - %@ %@",progress,partec.nome,partec.cognome);
    }   
    
    NSData *dataNoSpecial = [csv dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *csvNoSpecial = [[NSString alloc] initWithData:dataNoSpecial encoding:NSASCIIStringEncoding];
    
    NSLog(@"%@\n File Csv da scrivere",csvNoSpecial);
    
    
    NSFileManager *fileMgr = [NSFileManager defaultManager];
    NSError *error = nil;
    
    NSMutableString *fileName = [[NSMutableString alloc]init];
    [fileName appendFormat:@"%@.csv",eventoFromPlist.titolo];    
    NSArray *myPathList = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *path = [myPathList  objectAtIndex:0];
    NSArray *directoryContents = [fileMgr contentsOfDirectoryAtPath:path error:&error];
    if (error == nil) {
        for (NSString *file in directoryContents) 
        {
            NSString *fullPath = [path stringByAppendingPathComponent:file];
            NSLog(@"file %@",fullPath);
            NSRange range = [fullPath rangeOfString:@".iStand.sqlite"];
            if (range.location == NSNotFound)
            {
                NSLog(@"file %@ rimosso",fullPath);
                BOOL removeSuccess = [fileMgr removeItemAtPath:fullPath error:&error];
                if (!removeSuccess) {
                    
                }
                
            }
        }
    } 
    else 
    {
        
    }   
    
    path = [path stringByAppendingPathComponent:fileName];   
    NSData* data=[csvNoSpecial dataUsingEncoding:NSUTF8StringEncoding];
    [fileMgr createFileAtPath:path contents:nil attributes:nil];        
    [data writeToFile:path atomically:YES];
    NSLog(@"OK file scritto");
    
	HUD.progress = 1.0f;
	HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
	HUD.mode = MBProgressHUDModeCustomView;
	HUD.labelText = NSLocalizedString(@"CSVCREATED", @"");
	sleep(2);
}
-(void)willRotateToInterfaceOrientation: (UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration {
    [self actionsBasedOnOrientation:orientation forView:self.view];
    
}
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.navigationController.view layoutSubviews];
}


@end
