// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Evento.h instead.

#import <CoreData/CoreData.h>


extern const struct EventoAttributes {
	__unsafe_unretained NSString *data_al;
	__unsafe_unretained NSString *data_creazione;
	__unsafe_unretained NSString *data_dal;
	__unsafe_unretained NSString *organizzazione;
	__unsafe_unretained NSString *titolo;
} EventoAttributes;

extern const struct EventoRelationships {
	__unsafe_unretained NSString *evento_campod_inv;
	__unsafe_unretained NSString *evento_partec_inv;
	__unsafe_unretained NSString *evento_regist_inv;
} EventoRelationships;

extern const struct EventoFetchedProperties {
} EventoFetchedProperties;

@class CampoDinamico;
@class Partecipante;
@class Registrazione;







@interface EventoID : NSManagedObjectID {}
@end

@interface _Evento : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (EventoID*)objectID;




@property (nonatomic, strong) NSDate* data_al;


//- (BOOL)validateData_al:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* data_creazione;


//- (BOOL)validateData_creazione:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSDate* data_dal;


//- (BOOL)validateData_dal:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* organizzazione;


//- (BOOL)validateOrganizzazione:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* titolo;


//- (BOOL)validateTitolo:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet* evento_campod_inv;

- (NSMutableSet*)evento_campod_invSet;




@property (nonatomic, strong) NSSet* evento_partec_inv;

- (NSMutableSet*)evento_partec_invSet;




@property (nonatomic, strong) NSSet* evento_regist_inv;

- (NSMutableSet*)evento_regist_invSet;





@end

@interface _Evento (CoreDataGeneratedAccessors)

- (void)addEvento_campod_inv:(NSSet*)value_;
- (void)removeEvento_campod_inv:(NSSet*)value_;
- (void)addEvento_campod_invObject:(CampoDinamico*)value_;
- (void)removeEvento_campod_invObject:(CampoDinamico*)value_;

- (void)addEvento_partec_inv:(NSSet*)value_;
- (void)removeEvento_partec_inv:(NSSet*)value_;
- (void)addEvento_partec_invObject:(Partecipante*)value_;
- (void)removeEvento_partec_invObject:(Partecipante*)value_;

- (void)addEvento_regist_inv:(NSSet*)value_;
- (void)removeEvento_regist_inv:(NSSet*)value_;
- (void)addEvento_regist_invObject:(Registrazione*)value_;
- (void)removeEvento_regist_invObject:(Registrazione*)value_;

@end

@interface _Evento (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveData_al;
- (void)setPrimitiveData_al:(NSDate*)value;




- (NSDate*)primitiveData_creazione;
- (void)setPrimitiveData_creazione:(NSDate*)value;




- (NSDate*)primitiveData_dal;
- (void)setPrimitiveData_dal:(NSDate*)value;




- (NSString*)primitiveOrganizzazione;
- (void)setPrimitiveOrganizzazione:(NSString*)value;




- (NSString*)primitiveTitolo;
- (void)setPrimitiveTitolo:(NSString*)value;





- (NSMutableSet*)primitiveEvento_campod_inv;
- (void)setPrimitiveEvento_campod_inv:(NSMutableSet*)value;



- (NSMutableSet*)primitiveEvento_partec_inv;
- (void)setPrimitiveEvento_partec_inv:(NSMutableSet*)value;



- (NSMutableSet*)primitiveEvento_regist_inv;
- (void)setPrimitiveEvento_regist_inv:(NSMutableSet*)value;


@end
