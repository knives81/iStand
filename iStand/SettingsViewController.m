//
//  SettingsViewController.m
//  iStand
//
//  Created by Maurizio Pinzi on 20/02/12.
//  Copyright (c) 2012 Almawave. All rights reserved.
//

#import "SettingsViewController.h"
#import "AddEventoViewController.h"
#import "Evento.h"

@implementation SettingsViewController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;
@synthesize tableEventi;
@synthesize textUrlWsdl;
@synthesize myView;
@synthesize switchAcqRapida;



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
    [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tableEventi.backgroundColor = [UIColor clearColor];
    
    self.tableEventi.delegate = self;    
    self.tableEventi.dataSource = self;
    
    self.textUrlWsdl.delegate = self;
    
    //bottoni su navigation bar
    UIToolbar* tools = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 120, 44.01)];
    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:3];
    UIBarButtonItem* bi = [[UIBarButtonItem alloc]
                           initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(tapDelete:)];
    bi.style = UIBarButtonItemStyleBordered;
    [buttons addObject:bi];
    bi = [[UIBarButtonItem alloc]
          initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [buttons addObject:bi];
    bi = [[UIBarButtonItem alloc]
          initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(tapAddEvento:)];
    bi.style = UIBarButtonItemStyleBordered;
    [buttons addObject:bi];
    [tools setItems:buttons animated:NO];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tools];
    self.navigationItem.title = NSLocalizedString(@"SETTINGS", @"");
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *uriData = [prefs objectForKey:@"eventoSelected"];
    
    //Al primo avvio non ci sono informazioni
    if(uriData!=nil)
    {
        //Carico ultimo evento selezionato
        NSURL *uri = (NSURL *)[NSKeyedUnarchiver unarchiveObjectWithData:uriData];
        NSManagedObjectID *eventoID = [self.persistentStoreCoordinator managedObjectIDForURIRepresentation:uri];
        Evento *eventoFromPlist = (Evento*)[self.managedObjectContext objectWithID:eventoID];
        
        //Carico tutti gli Eventi memorizzati
        NSError *error;
        NSManagedObjectContext *context = self.managedObjectContext;
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription 
                                       entityForName:@"Evento" inManagedObjectContext:context];
        NSSortDescriptor *sortByDate = [[NSSortDescriptor alloc] initWithKey:@"data_creazione" ascending:NO];
        [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortByDate]];       
        [fetchRequest setEntity:entity];
        [fetchRequest setIncludesSubentities:NO];        
        eventi = [context executeFetchRequest:fetchRequest error:&error];
        [self.tableEventi reloadData];       
        
        int i =0;
        int rowSelected = 0;
        for(Evento *eventoTmp in eventi)
        {
            if ([[[eventoTmp objectID] URIRepresentation] isEqual: [[eventoFromPlist objectID] URIRepresentation]]) {
                rowSelected = i;
            }
            i++;
        }
        
        if(lastIndexPath!= nil)
        {
            UITableViewCell *oldCell = [self.tableEventi cellForRowAtIndexPath:lastIndexPath];
            oldCell.accessoryType = UITableViewCellAccessoryNone;
        }
        NSIndexPath *indexPath=[NSIndexPath indexPathForRow:rowSelected inSection:0];
        UITableViewCell *newCell = [self.tableEventi cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        lastIndexPath = indexPath;
    }
    
    
    
    //Carico l'url del Wsdl non appena accedo alla vista
    NSString *urlWsdl = [[NSUserDefaults standardUserDefaults]
                         stringForKey:@"urlWsdl"];
    //se l'url è nil vuol dire che è il primo avvio
    if(urlWsdl == nil)
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:@"" forKey:@"urlWsdl"];
        [prefs synchronize];
        urlWsdl = @"";
    }
    self.textUrlWsdl.text = urlWsdl;
    //Carico la scelta dell'acquisizione rapida
    BOOL isAcqRapida = [[NSUserDefaults standardUserDefaults]
                        boolForKey:@"acqRapida"];
    /*if(isAcqRapida == nil)
    {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setBool:FALSE forKey:@"acqRapida1"];
        [prefs synchronize];
    }*/
    
    self.switchAcqRapida.on = isAcqRapida;
    
    
    
    //UIInterfaceOrientation currentOrientation =   [[UIDevice currentDevice] orientation];
    UIInterfaceOrientation currentOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    [self printOrientation:currentOrientation method:@"viewLoad"];
    [self actionsBasedOnOrientation:currentOrientation forView:self.myView];
    //[self correctBug:currentOrientation withMainView:self.view onView:self.myView];
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [eventi count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
	}
    
    Evento *evento = [eventi objectAtIndex:indexPath.row];
    
    
    NSUInteger row = [indexPath row];
    NSUInteger oldRow = [lastIndexPath row];
    
    cell.accessoryType = (row == oldRow && lastIndexPath != nil) ? 
    UITableViewCellAccessoryCheckmark : UITableViewCellAccessoryNone;	
	cell.textLabel.text =  evento.titolo;
    


    
    return cell;
}
- (void) tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath
{
    int row = [indexPath row];
    int oldRow = [lastIndexPath row];
    if (row != oldRow)
    {
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        
        UITableViewCell *oldCell = [tableView cellForRowAtIndexPath: lastIndexPath]; 
        oldCell.accessoryType = UITableViewCellAccessoryNone;
        
        lastIndexPath = indexPath;
        
        //Salva l'evento che è stato selezionato
        Evento *evento = [eventi objectAtIndex:indexPath.row];
        NSURL *uri = [[evento objectID] URIRepresentation];
        NSData *uriData = [NSKeyedArchiver archivedDataWithRootObject:uri];
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        [prefs setObject:uriData forKey:@"eventoSelected"];
        [prefs synchronize];
    }
    //dececco quello che prima era selezionato
    else
    {
        UITableViewCell *newCell = [tableView cellForRowAtIndexPath:indexPath];
        newCell.accessoryType = UITableViewCellAccessoryCheckmark;
        lastIndexPath = indexPath;
    }
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"settings_addevento"])
    {
        AddEventoViewController *upcomingViewController = [segue destinationViewController];
        upcomingViewController.managedObjectContext = self.managedObjectContext;
        
    }
}
- (void) viewWillDisappear:(BOOL) animated {
    [super viewWillDisappear:animated];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:textUrlWsdl.text forKey:@"urlWsdl"];
    BOOL isAcqRapida =[self.switchAcqRapida isOn] ;
    
    [prefs setBool:isAcqRapida forKey:@"acqRapida"];
    [prefs synchronize];
    
}


-(void)tapAddEvento:(id)sender
{
    [self performSegueWithIdentifier:@"settings_addevento" sender:self];
}
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 0){
        // È stato premuto il bottone Cancel
    } else if (buttonIndex == 1){
        //Carico l'evento selezionato
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSData *uriData = [prefs objectForKey:@"eventoSelected"];
        NSURL *uri = (NSURL *)[NSKeyedUnarchiver unarchiveObjectWithData:uriData];
        NSManagedObjectID *eventoID = [self.persistentStoreCoordinator managedObjectIDForURIRepresentation:uri];
        Evento *eventoFromPlist = (Evento*)[self.managedObjectContext objectWithID:eventoID];
        [self.managedObjectContext deleteObject:eventoFromPlist];
        [self.managedObjectContext save:nil];
        
        //Carico tutti gli Eventi memorizzati
        NSError *error;
        NSManagedObjectContext *context = self.managedObjectContext;
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        NSEntityDescription *entity = [NSEntityDescription 
                                       entityForName:@"Evento" inManagedObjectContext:context];
        NSSortDescriptor *sortByDate = [[NSSortDescriptor alloc] initWithKey:@"data_creazione" ascending:NO];
        [fetchRequest setSortDescriptors:[NSArray arrayWithObject:sortByDate]];       
        [fetchRequest setEntity:entity];
        [fetchRequest setIncludesSubentities:NO];        
        eventi = [context executeFetchRequest:fetchRequest error:&error];
        [self.tableEventi reloadData];       
        
        if([eventi count]>0)
        {
            //Salva l'evento che è stato selezionato
            Evento *evento = [eventi objectAtIndex:0];
            NSURL *uri = [[evento objectID] URIRepresentation];
            NSData *uriData = [NSKeyedArchiver archivedDataWithRootObject:uri];
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            [prefs setObject:uriData forKey:@"eventoSelected"];
            [prefs synchronize];
            
            NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
            UITableViewCell *newCell = [self.tableEventi cellForRowAtIndexPath:indexPath];
            newCell.accessoryType = UITableViewCellAccessoryCheckmark;
            lastIndexPath = indexPath;
        }
        else
        {
            //ho cancellato tutti gli eventi
            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
            [prefs setObject:nil forKey:@"eventoSelected"];
            [prefs synchronize];
        }
    }
}

-(void)tapDelete:(id)sender
{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSData *uriData = [prefs objectForKey:@"eventoSelected"];
    if(uriData!=nil)
    {
        UIAlertView *alertDelete;
        alertDelete = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"DELETE", @"") 
                                                 message:NSLocalizedString(@"DELETEMSG", @"") 
                                                delegate:self cancelButtonTitle:NSLocalizedString(@"CANCEL", @"") otherButtonTitles:NSLocalizedString(@"OK", @""), nil];
        [alertDelete show];
    }
    else {
        UIAlertView * alertNoEventi;
        alertNoEventi = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"NOEVENTTODELETE", @"") message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:NSLocalizedString(@"OK",@""), nil];                                                                                                                                                                                         [alertNoEventi show];
    }
}

-(IBAction)tapCheck:(id)sender
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    HUD.delegate = self;
    HUD.labelText = NSLocalizedString(@"TESTING", @"");
    
    [HUD showWhileExecuting:@selector(checkWs) onTarget:self withObject:nil animated:YES];
    
    
}
- (void)myTask 
{
    //BOOL isWorkingUrl = [self checkWs:self.textUrlWsdl.text];
    /*if(isWorkingUrl)
    {
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"accepted_37.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.labelText = NSLocalizedString(@"TESTYESWS", @"");
        
    }
    else {
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cancel_37.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.labelText = NSLocalizedString(@"TESTNOWS", @"");
    }
     */
    
    
    //sleep(2);
    
    
}
-(void) checkWs
{
    
    BOOL isWorkingUrl = NO;
    NSMutableString *soapMessage = [[NSMutableString alloc]init];
    [soapMessage appendFormat:@"<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:tem=\"http://tempuri.org/\"><soapenv:Header/><soapenv:Body><tem:ConfigInfo/>     </soapenv:Body></soapenv:Envelope>"];
    
    NSURL *url = [NSURL URLWithString:self.textUrlWsdl.text];
    NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    ASIHTTPRequest *request = [[ASIHTTPRequest alloc] initWithURL:url];
    [request setTimeOutSeconds:5];
    [request addRequestHeader: @"Content-Type" value:@"text/xml; charset=utf-8"];
    [request addRequestHeader: @"SOAPAction" value:@"http://tempuri.org/IEStand/ConfigInfo"];
    [request addRequestHeader: @"Content-Length" value:msgLength];
    [request setRequestMethod: @"POST"];
    NSMutableData *data = (NSMutableData*)[soapMessage dataUsingEncoding:NSUTF8StringEncoding];
    [request setPostBody:data];
    [request setDelegate:self];
    [request setDidFinishSelector:@selector(requestDone:)];
    [request setDidFailSelector:@selector(requestWentWrong:)];
    
    [request startSynchronous];
    
    NSData *dataReturn = [request responseData];
    NSString *rawXML = [[NSString alloc] initWithData:dataReturn encoding:NSUTF8StringEncoding];
    NSRange range = [rawXML rangeOfString:@"Bad Request"];
    NSLog(@"%@",rawXML);
    
    
    //errore ws non raggiungibile o host invalido
    if (range.length >0 || [dataReturn length] == 0)
    {       
        //return NO;
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cancel_37.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.labelText = NSLocalizedString(@"TESTNOWS", @"");
    }    
    else
    {
        NSLog(@"rawXML:%@",rawXML);
        
        rawXML = [rawXML stringByReplacingOccurrencesOfString:@"xmlns:s=\"http://schemas.xmlsoap.org/soap/envelope/\"" withString:@""];
        rawXML = [rawXML stringByReplacingOccurrencesOfString:@"xmlns=\"http://tempuri.org/\"" withString:@""];
        rawXML = [rawXML stringByReplacingOccurrencesOfString:@"xmlns:a=\"http://schemas.datacontract.org/2004/07/EStand.ServiceLibrary\"" withString:@""];
        rawXML = [rawXML stringByReplacingOccurrencesOfString: @"xmlns:i=\"http://www.w3.org/2001/XMLSchema-instance\"" withString:@""];
        rawXML = [rawXML stringByReplacingOccurrencesOfString: @"i:" withString:@""];
        rawXML = [rawXML stringByReplacingOccurrencesOfString: @"s:" withString:@""];
        rawXML = [rawXML stringByReplacingOccurrencesOfString: @"a:" withString:@""];
        
        CXMLDocument *doc = [[CXMLDocument alloc] initWithXMLString:rawXML options:0 error:nil];        
        NSArray *nodes = [doc nodesForXPath:@"//ConfigInfoResult" error:nil];
        
        //devo prendere solo il primo
        for (CXMLElement *node in nodes) 
        {
            
            NSMutableDictionary *item = [[NSMutableDictionary alloc] init];
            int counter;
            for(counter = 0; counter < [node childCount]; counter++) 
            {
                NSString *valore = [[node childAtIndex:counter] stringValue];
                NSString *nomeCampo = [[node childAtIndex:counter] name];
                [item setObject:valore forKey:nomeCampo];
                
            }
            
            NSString *version = [item objectForKey:@"text"];
            //NSRange range = [version rangeOfString:@"1.0.0"];
            //NSString *isError = [item objectForKey:@"Error"];
            //NSRange range = [isError rangeOfString:@"true"];
            if([version isEqualToString:@"1.0.0" ])
            {        
                
                isWorkingUrl= YES;
            }
            else {				
                isWorkingUrl= NO;               
            }
        }
        //isWorkingUrl= NO;
    }
    if(isWorkingUrl)
    {
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"accepted_37.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.labelText = NSLocalizedString(@"TESTYESWS", @"");
        
    }
    else {
        HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cancel_37.png"]];
        HUD.mode = MBProgressHUDModeCustomView;
        HUD.labelText = NSLocalizedString(@"TESTNOWS", @"");
    }
    sleep(2);
    
}
- (void)requestDone:(ASIHTTPRequest *)request
{
    request.userInfo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"OK", @"info", nil];
    NSLog(@"ws finito");
    
    
}
- (void)requestWentWrong:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"Error Descr %@",error.localizedDescription);
    request.userInfo = [[NSMutableDictionary alloc] initWithObjectsAndKeys:error.localizedDescription, @"info", nil];
    
}
                                                                                                                                                                                   
                                                                                                                                                                                         
-(void)willRotateToInterfaceOrientation: (UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration 
{
    [self actionsBasedOnOrientation:orientation forView:self.myView];
}
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.navigationController.view layoutSubviews];
}
@end
