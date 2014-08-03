//
//  SearchViewController.h
//  iStand
//
//  Created by Maurizio Pinzi on 13/03/12.
//  Copyright (c) 2012 Almawave. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchViewCell.h"
#import "CommonViewController.h"
#import "MBProgressHUD.h"
@class Evento;
@class Partecipante;

@interface SearchViewController : CommonViewController <UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    
	NSMutableArray *tableData;//will be storing data that will be displayed in table
	NSMutableArray *searchedData;//will be storing data matching with the search string
    
    NSArray *arrPartecipantiSorted;
    NSMutableArray *arrPartecipanti; //partecipanti che vengono visualizzati
    NSMutableArray *arrPartecipantiGrouped;
    NSMutableArray *arrPartecipantiFound;
    
    //NSArray *partecipanti;
    Partecipante *partecipante;
    Evento *eventoScelto;
    NSMutableArray *letterePartecipanti;
    bool isSearch;
    MBProgressHUD *HUD;
    
    UIBarButtonItem* bi1;
}
@property(nonatomic,weak) UITableView *tableViewPartecipanti;
@property(nonatomic,weak) UISearchBar *searchBarPartecipanti;
@property (strong, nonatomic) Evento *eventoScelto;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
