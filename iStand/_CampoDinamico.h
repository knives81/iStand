// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CampoDinamico.h instead.

#import <CoreData/CoreData.h>


extern const struct CampoDinamicoAttributes {
	__unsafe_unretained NSString *nome;
	__unsafe_unretained NSString *ordinamento;
	__unsafe_unretained NSString *tipo;
} CampoDinamicoAttributes;

extern const struct CampoDinamicoRelationships {
	__unsafe_unretained NSString *campod_evento;
	__unsafe_unretained NSString *campod_opzione_inv;
	__unsafe_unretained NSString *campod_scelta_inv;
} CampoDinamicoRelationships;

extern const struct CampoDinamicoFetchedProperties {
} CampoDinamicoFetchedProperties;

@class Evento;
@class Opzione;
@class Scelta;





@interface CampoDinamicoID : NSManagedObjectID {}
@end

@interface _CampoDinamico : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (CampoDinamicoID*)objectID;




@property (nonatomic, strong) NSString* nome;


//- (BOOL)validateNome:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* ordinamento;


@property int16_t ordinamentoValue;
- (int16_t)ordinamentoValue;
- (void)setOrdinamentoValue:(int16_t)value_;

//- (BOOL)validateOrdinamento:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* tipo;


@property int16_t tipoValue;
- (int16_t)tipoValue;
- (void)setTipoValue:(int16_t)value_;

//- (BOOL)validateTipo:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Evento* campod_evento;

//- (BOOL)validateCampod_evento:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* campod_opzione_inv;

- (NSMutableSet*)campod_opzione_invSet;




@property (nonatomic, strong) NSSet* campod_scelta_inv;

- (NSMutableSet*)campod_scelta_invSet;





@end

@interface _CampoDinamico (CoreDataGeneratedAccessors)

- (void)addCampod_opzione_inv:(NSSet*)value_;
- (void)removeCampod_opzione_inv:(NSSet*)value_;
- (void)addCampod_opzione_invObject:(Opzione*)value_;
- (void)removeCampod_opzione_invObject:(Opzione*)value_;

- (void)addCampod_scelta_inv:(NSSet*)value_;
- (void)removeCampod_scelta_inv:(NSSet*)value_;
- (void)addCampod_scelta_invObject:(Scelta*)value_;
- (void)removeCampod_scelta_invObject:(Scelta*)value_;

@end

@interface _CampoDinamico (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveNome;
- (void)setPrimitiveNome:(NSString*)value;




- (NSNumber*)primitiveOrdinamento;
- (void)setPrimitiveOrdinamento:(NSNumber*)value;

- (int16_t)primitiveOrdinamentoValue;
- (void)setPrimitiveOrdinamentoValue:(int16_t)value_;




- (NSNumber*)primitiveTipo;
- (void)setPrimitiveTipo:(NSNumber*)value;

- (int16_t)primitiveTipoValue;
- (void)setPrimitiveTipoValue:(int16_t)value_;





- (Evento*)primitiveCampod_evento;
- (void)setPrimitiveCampod_evento:(Evento*)value;



- (NSMutableSet*)primitiveCampod_opzione_inv;
- (void)setPrimitiveCampod_opzione_inv:(NSMutableSet*)value;



- (NSMutableSet*)primitiveCampod_scelta_inv;
- (void)setPrimitiveCampod_scelta_inv:(NSMutableSet*)value;


@end
