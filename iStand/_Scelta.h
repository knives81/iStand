// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Scelta.h instead.

#import <CoreData/CoreData.h>


extern const struct SceltaAttributes {
	__unsafe_unretained NSString *ordinamento;
	__unsafe_unretained NSString *posizione_multiple;
	__unsafe_unretained NSString *valore_flag;
	__unsafe_unretained NSString *valore_multiple;
	__unsafe_unretained NSString *valore_nota;
} SceltaAttributes;

extern const struct SceltaRelationships {
	__unsafe_unretained NSString *scelta_campod;
	__unsafe_unretained NSString *scelta_opzione;
	__unsafe_unretained NSString *scelta_partec;
} SceltaRelationships;

extern const struct SceltaFetchedProperties {
} SceltaFetchedProperties;

@class CampoDinamico;
@class Opzione;
@class Partecipante;







@interface SceltaID : NSManagedObjectID {}
@end

@interface _Scelta : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (SceltaID*)objectID;




@property (nonatomic, strong) NSNumber* ordinamento;


@property int16_t ordinamentoValue;
- (int16_t)ordinamentoValue;
- (void)setOrdinamentoValue:(int16_t)value_;

//- (BOOL)validateOrdinamento:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* posizione_multiple;


@property int16_t posizione_multipleValue;
- (int16_t)posizione_multipleValue;
- (void)setPosizione_multipleValue:(int16_t)value_;

//- (BOOL)validatePosizione_multiple:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* valore_flag;


//- (BOOL)validateValore_flag:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* valore_multiple;


//- (BOOL)validateValore_multiple:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* valore_nota;


//- (BOOL)validateValore_nota:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) CampoDinamico* scelta_campod;

//- (BOOL)validateScelta_campod:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) Opzione* scelta_opzione;

//- (BOOL)validateScelta_opzione:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) Partecipante* scelta_partec;

//- (BOOL)validateScelta_partec:(id*)value_ error:(NSError**)error_;





@end

@interface _Scelta (CoreDataGeneratedAccessors)

@end

@interface _Scelta (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveOrdinamento;
- (void)setPrimitiveOrdinamento:(NSNumber*)value;

- (int16_t)primitiveOrdinamentoValue;
- (void)setPrimitiveOrdinamentoValue:(int16_t)value_;




- (NSNumber*)primitivePosizione_multiple;
- (void)setPrimitivePosizione_multiple:(NSNumber*)value;

- (int16_t)primitivePosizione_multipleValue;
- (void)setPrimitivePosizione_multipleValue:(int16_t)value_;




- (NSString*)primitiveValore_flag;
- (void)setPrimitiveValore_flag:(NSString*)value;




- (NSString*)primitiveValore_multiple;
- (void)setPrimitiveValore_multiple:(NSString*)value;




- (NSString*)primitiveValore_nota;
- (void)setPrimitiveValore_nota:(NSString*)value;





- (CampoDinamico*)primitiveScelta_campod;
- (void)setPrimitiveScelta_campod:(CampoDinamico*)value;



- (Opzione*)primitiveScelta_opzione;
- (void)setPrimitiveScelta_opzione:(Opzione*)value;



- (Partecipante*)primitiveScelta_partec;
- (void)setPrimitiveScelta_partec:(Partecipante*)value;


@end
