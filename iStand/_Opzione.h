// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Opzione.h instead.

#import <CoreData/CoreData.h>


extern const struct OpzioneAttributes {
	__unsafe_unretained NSString *ordinamento;
	__unsafe_unretained NSString *valore;
} OpzioneAttributes;

extern const struct OpzioneRelationships {
	__unsafe_unretained NSString *opzione_campod;
	__unsafe_unretained NSString *opzione_scelta_inv;
} OpzioneRelationships;

extern const struct OpzioneFetchedProperties {
} OpzioneFetchedProperties;

@class CampoDinamico;
@class Scelta;




@interface OpzioneID : NSManagedObjectID {}
@end

@interface _Opzione : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (OpzioneID*)objectID;




@property (nonatomic, strong) NSNumber* ordinamento;


@property int16_t ordinamentoValue;
- (int16_t)ordinamentoValue;
- (void)setOrdinamentoValue:(int16_t)value_;

//- (BOOL)validateOrdinamento:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* valore;


//- (BOOL)validateValore:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) CampoDinamico* opzione_campod;

//- (BOOL)validateOpzione_campod:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* opzione_scelta_inv;

- (NSMutableSet*)opzione_scelta_invSet;





@end

@interface _Opzione (CoreDataGeneratedAccessors)

- (void)addOpzione_scelta_inv:(NSSet*)value_;
- (void)removeOpzione_scelta_inv:(NSSet*)value_;
- (void)addOpzione_scelta_invObject:(Scelta*)value_;
- (void)removeOpzione_scelta_invObject:(Scelta*)value_;

@end

@interface _Opzione (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveOrdinamento;
- (void)setPrimitiveOrdinamento:(NSNumber*)value;

- (int16_t)primitiveOrdinamentoValue;
- (void)setPrimitiveOrdinamentoValue:(int16_t)value_;




- (NSString*)primitiveValore;
- (void)setPrimitiveValore:(NSString*)value;





- (CampoDinamico*)primitiveOpzione_campod;
- (void)setPrimitiveOpzione_campod:(CampoDinamico*)value;



- (NSMutableSet*)primitiveOpzione_scelta_inv;
- (void)setPrimitiveOpzione_scelta_inv:(NSMutableSet*)value;


@end
