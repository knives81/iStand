//
//  StatisticsViewController.m
//  iStand
//
//  Created by Maurizio Pinzi on 08/06/12.
//  Copyright (c) 2012 Almawave. All rights reserved.
//

#import "StatisticsViewController.h"
#import "ADVPercentProgressBar.h"
#import "Evento.h"
#import "CampoDinamico.h"
#import "Scelta.h"
#import "Opzione.h"
#import "Constants.h"



@interface StatisticsViewController ()

@end

@implementation StatisticsViewController
@synthesize eventoScelto;
@synthesize managedObjectContext = _managedObjectContext;

@synthesize scrollView;

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
    
    self.navigationItem.title = NSLocalizedString(@"EVENTSTATISTICS", @"");
    int offset = 0;
    int heightBarcharts = 0;
    
    ADVProgressBarColor coloriBar[7] = {ADVProgressBarGray,ADVProgressBarBlue,ADVProgressBarGreen,ADVProgressBarPink,ADVProgressBarRed,ADVProgressBarWater,ADVProgressBarYellow};
    
    
    NSSet *campiDinamici = eventoScelto.evento_campod_inv;
    NSSortDescriptor *sortByOrdinamento = [[NSSortDescriptor alloc] initWithKey:@"ordinamento" ascending:YES];
    NSArray *campiDinamiciSortati = [[campiDinamici allObjects]sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortByOrdinamento]];
    
    
    
    for(CampoDinamico *campo in campiDinamiciSortati)
    {
        NSSet *scelte = campo.campod_scelta_inv;
        float total = scelte.count;
        offset += OFFSET_SCELTE;
        
        
        
        if(campo.tipo==[NSNumber numberWithInt:0])
        {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"valore_flag == %@",@"true"];
            int  num = [scelte filteredSetUsingPredicate:predicate].count;
            if (num>0) {
                ADVPercentProgressBar *greenProgressBar = [[ADVPercentProgressBar alloc] initWithFrame:CGRectMake(WIDTH_CONTR_2+GAP_LBL_BAR, offset,WIDTH_BARCHART,HEIGHT_BARCHART) andProgressBarColor:ADVProgressBarGreen withText:NSLocalizedString(@"YES", @"") withProgress:num/total];                
                [self.scrollView addSubview:greenProgressBar];                
                offset += OFFSET_BARCHART+HEIGHT_BARCHART; 
                heightBarcharts += HEIGHT_BARCHART+OFFSET_BARCHART;
                
            }
            
            
            predicate = [NSPredicate predicateWithFormat:@"valore_flag == %@",@"false"];
            num = [scelte filteredSetUsingPredicate:predicate].count;
            if (num>0) {
                ADVPercentProgressBar *redProgressBar = [[ADVPercentProgressBar alloc] initWithFrame:CGRectMake(WIDTH_CONTR_2+GAP_LBL_BAR, offset,WIDTH_BARCHART,HEIGHT_BARCHART) andProgressBarColor:ADVProgressBarRed withText:NSLocalizedString(@"NO", @"") withProgress:num/total];                
                [self.scrollView addSubview:redProgressBar];                
                offset += OFFSET_BARCHART+HEIGHT_BARCHART; 
                heightBarcharts += HEIGHT_BARCHART+OFFSET_BARCHART;
            }
            
            
            predicate = [NSPredicate predicateWithFormat:@"valore_flag == %@",@"nochoice"];
            num = [scelte filteredSetUsingPredicate:predicate].count;
            if (num>0) {     
                ADVPercentProgressBar *grayProgressBar = [[ADVPercentProgressBar alloc] initWithFrame:CGRectMake(WIDTH_CONTR_2+GAP_LBL_BAR, offset,WIDTH_BARCHART,HEIGHT_BARCHART) andProgressBarColor:ADVProgressBarGray withText:NSLocalizedString(@"NOCHOICE", @"") withProgress:num/total];                
                [self.scrollView addSubview:grayProgressBar];                
                offset += OFFSET_BARCHART+HEIGHT_BARCHART; 
                heightBarcharts += HEIGHT_BARCHART+OFFSET_BARCHART;
            }
            
            
            
            offset -= OFFSET_BARCHART;
            heightBarcharts -= OFFSET_BARCHART;
            
            
            
            UILabel *labelCampo = [[UILabel alloc] initWithFrame:CGRectMake(OFFSET_X,offset-(heightBarcharts/2)-(HEIGHT_CONTR/2),WIDTH_CONTR_2,HEIGHT_CONTR)];
            [labelCampo setText:campo.nome];
            labelCampo.numberOfLines = 3;
            labelCampo.backgroundColor = [UIColor clearColor];
            [self.scrollView addSubview:labelCampo];
            
            heightBarcharts = 0;
            
        }
        else if (campo.tipo==[NSNumber numberWithInt:2]) 
        {
            NSSet *opzioni = campo.campod_opzione_inv;
            NSSortDescriptor *sortByOrdinamento = [[NSSortDescriptor alloc] initWithKey:@"ordinamento" ascending:YES];
            NSArray *opzioniSortate = [[opzioni allObjects]sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortByOrdinamento]];
            
            int i=0;
            
            for(Opzione *opzione in opzioniSortate)
            {
                NSPredicate *predicate = [NSPredicate predicateWithFormat:@"valore_multiple == %@",opzione];
                int  num = [scelte filteredSetUsingPredicate:predicate].count;
                
                
                predicate = [NSPredicate predicateWithFormat:@"valore_multiple == %@",opzione.valore];
                num = [scelte filteredSetUsingPredicate:predicate].count;
                
                if (num>0) {
                    
                    ADVPercentProgressBar *progressBar = [[ADVPercentProgressBar alloc] initWithFrame:CGRectMake(WIDTH_CONTR_2+GAP_LBL_BAR, offset,WIDTH_BARCHART,HEIGHT_BARCHART) andProgressBarColor:coloriBar[i] withText:opzione.valore withProgress:num/total]; 
                    [self.scrollView addSubview:progressBar]; 
                    
                    offset += OFFSET_BARCHART+HEIGHT_BARCHART; 
                    heightBarcharts += HEIGHT_BARCHART+OFFSET_BARCHART;
                }
                i++;
                
            }
            offset -= OFFSET_BARCHART;
            heightBarcharts -= OFFSET_BARCHART;
            
            UILabel *labelCampo = [[UILabel alloc] initWithFrame:CGRectMake(OFFSET_X,offset-(heightBarcharts/2)-(HEIGHT_CONTR/2),WIDTH_CONTR_2,HEIGHT_CONTR)];
            [labelCampo setText:campo.nome];
            labelCampo.backgroundColor = [UIColor clearColor];
            labelCampo.numberOfLines = 3;
            [self.scrollView addSubview:labelCampo];
            
            heightBarcharts = 0;
            
        }
        
        scrollView.contentSize = CGSizeMake(768,offset);
        
        for (Scelta *a in scelte)
        {
            NSLog(@"%@",a.valore_flag);
        }
        
        
    }
    //UIInterfaceOrientation currentOrientation =   [[UIDevice currentDevice] orientation];
    UIInterfaceOrientation currentOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    [self printOrientation:currentOrientation method:@"viewLoad"];
    [self actionsBasedOnOrientation:currentOrientation forView:self.view];
     self.scrollView.backgroundColor = [UIColor clearColor]; 

    
    
    
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
-(void)willRotateToInterfaceOrientation: (UIInterfaceOrientation)orientation duration:(NSTimeInterval)duration {
    [self actionsBasedOnOrientation:orientation forView:self.view];
    self.scrollView.backgroundColor = [UIColor clearColor]; 
    
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}






@end
