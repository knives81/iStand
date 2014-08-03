//
//  AddEventoViewController.h
//  iStand
//
//  Created by Maurizio Pinzi on 20/02/12.
//  Copyright (c) 2012 Almawave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddEventoViewCell.h"
#import "MyTextView.h"
#import "MyTextField.h"
#import "CommonViewController.h"


@interface AddEventoViewController : CommonViewController <UIPickerViewDelegate,UITableViewDelegate, UITableViewDataSource, UITextViewDelegate>
{
    NSInteger ord;
    NSString *labelSelected;
    
    UIScrollView *myScrollView;
    
    MyTextField *textTitoloEvento;
    MyTextField *textOrganizzazioneEvento;
    UILabel *labelDataEventoDal;
    UILabel *labelDataEventoAl;
    UIDatePicker *datePickerDataEvento;
    UISegmentedControl *segmentedTipoCampi;
    
    MyTextView *textFlag;
    UIButton *buttonAddFlag;
    
    MyTextView *textNote;
    UIButton *buttonAddNote;
    
    MyTextView *textMultiple;
    UIButton *buttonAddMultiple;
    MyTextField *textOpzione1;
    MyTextField *textOpzione2;
    MyTextField *textOpzione3;
    MyTextField *textOpzione4;
    MyTextField *textOpzione5;
    
    NSMutableArray *arrayCampiDinamici;
    UITableView *tableCampiDinamici;
}

@property (nonatomic, retain) IBOutlet UIScrollView *myScrollView;

@property (nonatomic, retain) IBOutlet MyTextField *textTitoloEvento;
@property (nonatomic, retain) IBOutlet MyTextField *textOrganizzazioneEvento;
@property (nonatomic, retain) IBOutlet UILabel *labelDataEventoDal;
@property (nonatomic, retain) IBOutlet UILabel *labelDataEventoAl;
@property (nonatomic, retain) IBOutlet UILabel *labelDataEventoDalAl;
@property (nonatomic, retain) IBOutlet UIDatePicker *datePickerDataEvento;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentedTipoCampi;

@property (nonatomic, retain) IBOutlet MyTextView *textFlag;
@property (nonatomic, retain) IBOutlet UIButton *buttonAddFlag;

@property (nonatomic, retain) IBOutlet MyTextView *textNote;
@property (nonatomic, retain) IBOutlet UIButton *buttonAddNote;

@property (nonatomic, retain) IBOutlet MyTextView *textMultiple;
@property (nonatomic, retain) IBOutlet UIButton *buttonAddMultiple;
@property (nonatomic, retain) IBOutlet MyTextField *textOpzione1;
@property (nonatomic, retain) IBOutlet MyTextField *textOpzione2;
@property (nonatomic, retain) IBOutlet MyTextField *textOpzione3;
@property (nonatomic, retain) IBOutlet MyTextField *textOpzione4;
@property (nonatomic, retain) IBOutlet MyTextField *textOpzione5;

@property (nonatomic, retain) IBOutlet UITableView *tableCampiDinamici;

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;

- (IBAction)addCampoFlag:(id)sender;
- (IBAction)addCampoNota:(id)sender;
- (IBAction)addCampoMultiple:(id)sender;
- (IBAction)saveEvento:(id)sender;


@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
