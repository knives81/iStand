//
//  SearchViewController.m
//  iStand
//
//  Created by Maurizio Pinzi on 13/03/12.
//  Copyright (c) 2012 Almawave. All rights reserved.
//

#import "SearchViewController.h"
#import "Evento.h"
#import "Partecipante.h"
#import "DettPartecipanteViewController.h"

@implementation SearchViewController
@synthesize eventoScelto;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize tableViewPartecipanti;
@synthesize searchBarPartecipanti;



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
    
    isSearch = NO;
    
    
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
	
    HUD.delegate = self;
    HUD.labelText = NSLocalizedString(@"LOADING", @"");;
	
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
    
    
    // create a toolbar to have two buttons in the right
    UIToolbar* tools = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 60, 44.01)];
    
    // create the array to hold the buttons, which then gets added to the toolbar
    NSMutableArray* buttons = [[NSMutableArray alloc] initWithCapacity:1];
    
    
    
    // create a standard "Refresh" button
    bi1 = [[UIBarButtonItem alloc]
           initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
           target:self 
           action:@selector(tapUpdate:)];
    bi1.style = UIBarButtonItemStyleBordered;
    bi1.tag = 11;
    [buttons addObject:bi1];
    
    
    
    // stick the buttons in the toolbar
    [tools setItems:buttons animated:NO];
    // and put the toolbar in the nav bar
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:tools];  
    self.navigationItem.title = NSLocalizedString(@"SEARCH", @"");
}
- (void)myTask {
    NSArray *partecipanti = [self.eventoScelto.evento_partec_inv allObjects];
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"cognome"
                                                 ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    arrPartecipantiSorted = [partecipanti sortedArrayUsingDescriptors:sortDescriptors];
    
    letterePartecipanti = [[NSMutableArray alloc]init];
    arrPartecipantiGrouped = [[NSMutableArray alloc] init];   
    arrPartecipantiFound = [[NSMutableArray alloc] init];    
    
    ISDEBUG ?NSLog(@"num: %d e %@",[arrPartecipanti count],self.eventoScelto.titolo):nil;
    
	NSMutableDictionary *section = [[NSMutableDictionary alloc] init];
	NSMutableArray *partecipantiOfSection = [[NSMutableArray alloc] init];	
	NSMutableString *firstSurnameletterOld = [[NSMutableString alloc] initWithString:@"Z"];
    BOOL isFirst = true;
    
    NSMutableString *firstSurnameletter = [[NSMutableString alloc] init];
	
	for(Partecipante *partec in arrPartecipantiSorted)	
	{
        if ([partec.cognome length]==0) {
            firstSurnameletter = [NSMutableString stringWithString:@"#"];
        }
        else {
            ISDEBUG ? NSLog(@"Partecipante:%@ %@",partec.codice,partec.cognome):nil;
            firstSurnameletter = [NSMutableString stringWithString:[[partec.cognome uppercaseString] substringWithRange:NSMakeRange(0, 1)]];
            
        }   
        
        if([firstSurnameletter rangeOfString:firstSurnameletterOld].location ==0 || isFirst)
        {
            [partecipantiOfSection addObject:partec];
            isFirst = false;
        }
        else
        {
            //aggiungo il gruppo di partecipanti per quella lettera
            section = [NSDictionary dictionaryWithObject:partecipantiOfSection forKey:@"partecipanti"];
            [arrPartecipantiGrouped addObject:section];
            
            section = [[NSMutableDictionary alloc] init];
            partecipantiOfSection = [[NSMutableArray alloc] init];
            
            [partecipantiOfSection addObject:partec];
            [letterePartecipanti addObject:firstSurnameletterOld];
            NSLog(@"Lettera aggiunta %@",firstSurnameletterOld);
            
        }
        firstSurnameletterOld = [NSMutableString stringWithString:firstSurnameletter];
        
        
        
        
    }
    //aggiungo il gruppo di partecipanti per l'ultima lettera trovata
    section = [NSDictionary dictionaryWithObject:partecipantiOfSection forKey:@"partecipanti"];
    [arrPartecipantiGrouped addObject:section];
    
    arrPartecipanti = arrPartecipantiGrouped;
    [letterePartecipanti addObject:firstSurnameletterOld];
    [self.tableViewPartecipanti reloadData];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //UIInterfaceOrientation currentOrientation =   [[UIDevice currentDevice] orientation];
    UIInterfaceOrientation currentOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    [self printOrientation:currentOrientation method:@"viewLoad"];
    
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
    
    return [arrPartecipanti count];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	NSDictionary *dictionary = [arrPartecipanti objectAtIndex:section];
	NSArray *array = [dictionary objectForKey:@"partecipanti"];
	return [array count];
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	
	if(!isSearch)
    {
        ISDEBUG ?NSLog(@"Ci sono %d lettere e la sezione %d",letterePartecipanti.count,section):nil;
        NSString *letter = [letterePartecipanti objectAtIndex:section];
        return letter;
    }
    else
    {
        return NSLocalizedString(@"SEARCHRESULT", @"");
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"CellSearch";
    
    SearchViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];   
	
    NSDictionary *dictionary = [arrPartecipanti objectAtIndex:indexPath.section];
	NSArray *array = [dictionary objectForKey:@"partecipanti"];
	Partecipante *partec = [array objectAtIndex:indexPath.row];
    
    NSMutableString *nomeCognome = [[NSMutableString alloc] init];
    [nomeCognome appendFormat:@"%@ %@", partec.cognome, partec.nome];
    
    cell.lblNomeCognome.text = nomeCognome;
    cell.lblEmail.text = partec.email;
    cell.lblCodice.text = partec.codice;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    
	return cell;
}



- (NSInteger)realRowNumberForIndexPath:(NSIndexPath *)indexPath inTableView:(UITableView *)tableView
{
	NSInteger retInt = 0;
	if (!indexPath.section)
	{
		return indexPath.row;
	}
	for (int i=0;i<indexPath.section;i++)
	{
		retInt += [tableView numberOfRowsInSection:i];
	}
    
	return retInt + indexPath.row;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSInteger realRow = [self realRowNumberForIndexPath:indexPath inTableView:tableView];
	cell.backgroundColor = (realRow%2)?[UIColor lightGrayColor]:[UIColor clearColor];
}



#pragma mark UISearchBarDelegate

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar

{
	searchBar.showsCancelButton = YES;
	searchBar.autocorrectionType = UITextAutocorrectionTypeNo;    
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
	self.searchBarPartecipanti.showsCancelButton = NO;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	[arrPartecipantiFound removeAllObjects];// remove all data that belongs to previous search
	if([searchText isEqualToString:@""] || searchText==nil)
	{
        arrPartecipanti = arrPartecipantiGrouped;
        isSearch = NO;
		[self.tableViewPartecipanti reloadData];
		return;
	}
    NSMutableDictionary *section = [[NSMutableDictionary alloc] init];
    NSMutableArray *partecipantiOfSection = [[NSMutableArray alloc] init];    
    
	for(Partecipante *partec in arrPartecipantiSorted)
	{
        
		NSRange ricCognome = [[partec.cognome uppercaseString] rangeOfString:[searchText uppercaseString]];
        NSRange ricNome = [[partec.nome uppercaseString] rangeOfString:[searchText uppercaseString]];
        NSRange ricCodice = [[partec.codice uppercaseString] rangeOfString:[searchText uppercaseString]];
		if(ricCognome.location != NSNotFound || ricNome.location != NSNotFound || ricCodice.location != NSNotFound)
		{
            [partecipantiOfSection addObject:partec];			
		}
        
	}
    section = [NSDictionary dictionaryWithObject:partecipantiOfSection forKey:@"partecipanti"];
    [arrPartecipantiFound addObject:section];
    isSearch = YES;
    arrPartecipanti = arrPartecipantiFound;
    [self.tableViewPartecipanti reloadData];
    
}



- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    arrPartecipanti = arrPartecipantiGrouped;
    isSearch = NO;
	[self.searchBarPartecipanti resignFirstResponder];
	self.searchBarPartecipanti.text = @"";
    [self.tableViewPartecipanti reloadData];
}


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
	[self.searchBarPartecipanti resignFirstResponder];
}
- (void) tableView:(UITableView *) tableView didSelectRowAtIndexPath:(NSIndexPath *) indexPath
{
    NSDictionary *dictionary = [arrPartecipanti objectAtIndex:indexPath.section];
	NSArray *array = [dictionary objectForKey:@"partecipanti"];
	partecipante = [array objectAtIndex:indexPath.row];
    
    
    [self performSegueWithIdentifier:@"search_partecipante" sender:self];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if([[segue identifier] isEqualToString:@"search_partecipante"])
    {
        DettPartecipanteViewController *upcomingViewController = [segue destinationViewController];
        upcomingViewController.managedObjectContext = self.managedObjectContext;
        upcomingViewController.eventoScelto = self.eventoScelto;
        upcomingViewController.partecipanteFromVC = partecipante;
        
    }
    
}

//Creal l'alfabeto sulla colonna a destra
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    
    if(isSearch)
        return nil;
    else
    {
        return [[NSArray alloc] initWithArray:letterePartecipanti];
    }   
}
-(void)tapUpdate:(id)sender
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
	[self.navigationController.view addSubview:HUD];
    HUD.delegate = self;
	HUD.minSize = CGSizeMake(135.f, 135.f);
	[HUD showWhileExecuting:@selector(updatePartecipante) onTarget:self withObject:nil animated:YES];
}

-(void)updatePartecipante
{
    
	NSManagedObjectContext *context = self.managedObjectContext;
	NSString *urlWsdl = [[NSUserDefaults standardUserDefaults] stringForKey:@"urlWsdl"];
	NSSet *setPartecipanti = self.eventoScelto.evento_partec_inv;
	NSPredicate *predicate = [NSPredicate predicateWithFormat:@"da_aggiornare == 1"];
	NSSet *setPartecipantiIndividuati = [setPartecipanti filteredSetUsingPredicate:predicate];
    
    
    NSString *numDaAgg = [NSString stringWithFormat: @"%@: %d",NSLocalizedString(@"PARTOUPDATE", @""),[setPartecipantiIndividuati count] ];
    
    HUD.mode = MBProgressHUDModeDeterminate; 
    HUD.labelText = numDaAgg;
    sleep(1);
    
    float step = 0.9f/[setPartecipantiIndividuati count];
	float progress = 0.0f;
    
    int numPartecipantiAggiornati =0;
	for(Partecipante *part in setPartecipantiIndividuati)
	{
		int ret = [part getFromWs:urlWsdl barCode:part.codice];
        if(ret==0)
        {
            numPartecipantiAggiornati++;
        }
        
        NSString *strCodice = [NSString stringWithFormat:@"%@",part.codice];
        HUD.labelText = strCodice;
        progress += step;		
        HUD.progress = progress;
        
	}
	NSError *error;
    if (![context save:&error]) 
    {
        NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
    }
    
    HUD.progress = 1.0f;
	HUD.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"37x-Checkmark.png"]];
	HUD.mode = MBProgressHUDModeCustomView;
    
    NSString *numAggiornati = [NSString stringWithFormat: @"%@: %d",NSLocalizedString(@"PARUPDATED", @""),numPartecipantiAggiornati ];
	HUD.labelText = numAggiornati;
	sleep(3);
    
    [self.navigationController.view addSubview:HUD];
    [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
    
}
-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{
    [self.navigationController.view layoutSubviews];
}


/*-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
 {
 
 float h = self.view.bounds.size.height;
 
 if (fromInterfaceOrientation == UIInterfaceOrientationPortrait || fromInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
 CGRect b = self.view.bounds;
 ISDEBUG ?NSLog(@"Did1 Vertic: X=%f Y=%f w=%f h=%f",b.origin.x,b.origin.y,b.size.width,b.size.height):nil;
 
 if (h==748 || h==1024 || h==1004) {
 CGRect f = self.view.frame;
 f.origin.x = 0; // new x
 f.origin.y = 44; // new y
 self.view.frame = f;
 }
 else if (h==704 || h==960) {
 CGRect f = self.view.frame;
 f.origin.x = 0; // new x
 f.origin.y = 0; // new y
 self.view.frame = f;
 }
 
 
 b = self.view.bounds;
 ISDEBUG ?NSLog(@"Did2 Vertic: X=%f Y=%f w=%f h=%f",b.origin.x,b.origin.y,b.size.width,b.size.height):nil;
 
 
 } else {
 
 CGRect b = self.view.bounds;
 ISDEBUG ?NSLog(@"Did1 Orizz: X=%f Y=%f w=%f h=%f",b.origin.x,b.origin.y,b.size.width,b.size.height):nil;
 if (h==748 || h==1024 || h==1004) {
 CGRect f = self.view.frame;
 f.origin.x = 0; // new x
 f.origin.y = 44; // new y
 self.view.frame = f;
 }
 else if (h==704 || h==960) {
 CGRect f = self.view.frame;
 f.origin.x = 0; // new x
 f.origin.y = 0; // new y
 self.view.frame = f;
 }
 
 b = self.view.bounds;
 ISDEBUG ?NSLog(@"Did2 Orizz: X=%f Y=%f w=%f h=%f",b.origin.x,b.origin.y,b.size.width,b.size.height):nil;
 }
 
 }*/


@end
