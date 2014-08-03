//
//  RowCampoDinamico.h
//  iStand
//
//  Created by Maurizio Pinzi on 22/02/12.
//  Copyright (c) 2012 Almawave. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RowCampoDinamico : NSObject

@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSString * strTipo;
@property int intTipo;
@property int ordinamento;
@property (nonatomic, retain) NSMutableArray *arrayOpzioni;

@end
