// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Partecipante.h instead.

#import <CoreData/CoreData.h>


extern const struct PartecipanteAttributes {
	__unsafe_unretained NSString *cap;
	__unsafe_unretained NSString *cap_ist;
	__unsafe_unretained NSString *cellulare;
	__unsafe_unretained NSString *cellulare_add;
	__unsafe_unretained NSString *citta;
	__unsafe_unretained NSString *citta_ist;
	__unsafe_unretained NSString *codice;
	__unsafe_unretained NSString *cognome;
	__unsafe_unretained NSString *da_aggiornare;
	__unsafe_unretained NSString *dipartimento;
	__unsafe_unretained NSString *email;
	__unsafe_unretained NSString *email_add;
	__unsafe_unretained NSString *fax;
	__unsafe_unretained NSString *fax_add;
	__unsafe_unretained NSString *id;
	__unsafe_unretained NSString *indirizzo;
	__unsafe_unretained NSString *indirizzo_ist;
	__unsafe_unretained NSString *istituto;
	__unsafe_unretained NSString *nome;
	__unsafe_unretained NSString *note;
	__unsafe_unretained NSString *paese;
	__unsafe_unretained NSString *paese_ist;
	__unsafe_unretained NSString *posizione;
	__unsafe_unretained NSString *presente;
	__unsafe_unretained NSString *provincia;
	__unsafe_unretained NSString *provincia_ist;
	__unsafe_unretained NSString *specialita;
	__unsafe_unretained NSString *telefono;
	__unsafe_unretained NSString *telefono_add;
} PartecipanteAttributes;

extern const struct PartecipanteRelationships {
	__unsafe_unretained NSString *partec_evento;
	__unsafe_unretained NSString *partec_regist_inv;
	__unsafe_unretained NSString *partec_scelta_inv;
} PartecipanteRelationships;

extern const struct PartecipanteFetchedProperties {
} PartecipanteFetchedProperties;

@class Evento;
@class Registrazione;
@class Scelta;































@interface PartecipanteID : NSManagedObjectID {}
@end

@interface _Partecipante : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PartecipanteID*)objectID;




@property (nonatomic, strong) NSString* cap;


//- (BOOL)validateCap:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* cap_ist;


//- (BOOL)validateCap_ist:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* cellulare;


//- (BOOL)validateCellulare:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* cellulare_add;


//- (BOOL)validateCellulare_add:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* citta;


//- (BOOL)validateCitta:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* citta_ist;


//- (BOOL)validateCitta_ist:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* codice;


//- (BOOL)validateCodice:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* cognome;


//- (BOOL)validateCognome:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* da_aggiornare;


@property BOOL da_aggiornareValue;
- (BOOL)da_aggiornareValue;
- (void)setDa_aggiornareValue:(BOOL)value_;

//- (BOOL)validateDa_aggiornare:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* dipartimento;


//- (BOOL)validateDipartimento:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* email;


//- (BOOL)validateEmail:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* email_add;


//- (BOOL)validateEmail_add:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* fax;


//- (BOOL)validateFax:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* fax_add;


//- (BOOL)validateFax_add:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* id;


@property int16_t idValue;
- (int16_t)idValue;
- (void)setIdValue:(int16_t)value_;

//- (BOOL)validateId:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* indirizzo;


//- (BOOL)validateIndirizzo:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* indirizzo_ist;


//- (BOOL)validateIndirizzo_ist:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* istituto;


//- (BOOL)validateIstituto:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* nome;


//- (BOOL)validateNome:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* note;


//- (BOOL)validateNote:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* paese;


//- (BOOL)validatePaese:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* paese_ist;


//- (BOOL)validatePaese_ist:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* posizione;


//- (BOOL)validatePosizione:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSNumber* presente;


@property BOOL presenteValue;
- (BOOL)presenteValue;
- (void)setPresenteValue:(BOOL)value_;

//- (BOOL)validatePresente:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* provincia;


//- (BOOL)validateProvincia:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* provincia_ist;


//- (BOOL)validateProvincia_ist:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* specialita;


//- (BOOL)validateSpecialita:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* telefono;


//- (BOOL)validateTelefono:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSString* telefono_add;


//- (BOOL)validateTelefono_add:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) Evento* partec_evento;

//- (BOOL)validatePartec_evento:(id*)value_ error:(NSError**)error_;




@property (nonatomic, strong) NSSet* partec_regist_inv;

- (NSMutableSet*)partec_regist_invSet;




@property (nonatomic, strong) NSSet* partec_scelta_inv;

- (NSMutableSet*)partec_scelta_invSet;





@end

@interface _Partecipante (CoreDataGeneratedAccessors)

- (void)addPartec_regist_inv:(NSSet*)value_;
- (void)removePartec_regist_inv:(NSSet*)value_;
- (void)addPartec_regist_invObject:(Registrazione*)value_;
- (void)removePartec_regist_invObject:(Registrazione*)value_;

- (void)addPartec_scelta_inv:(NSSet*)value_;
- (void)removePartec_scelta_inv:(NSSet*)value_;
- (void)addPartec_scelta_invObject:(Scelta*)value_;
- (void)removePartec_scelta_invObject:(Scelta*)value_;

@end

@interface _Partecipante (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCap;
- (void)setPrimitiveCap:(NSString*)value;




- (NSString*)primitiveCap_ist;
- (void)setPrimitiveCap_ist:(NSString*)value;




- (NSString*)primitiveCellulare;
- (void)setPrimitiveCellulare:(NSString*)value;




- (NSString*)primitiveCellulare_add;
- (void)setPrimitiveCellulare_add:(NSString*)value;




- (NSString*)primitiveCitta;
- (void)setPrimitiveCitta:(NSString*)value;




- (NSString*)primitiveCitta_ist;
- (void)setPrimitiveCitta_ist:(NSString*)value;




- (NSString*)primitiveCodice;
- (void)setPrimitiveCodice:(NSString*)value;




- (NSString*)primitiveCognome;
- (void)setPrimitiveCognome:(NSString*)value;




- (NSNumber*)primitiveDa_aggiornare;
- (void)setPrimitiveDa_aggiornare:(NSNumber*)value;

- (BOOL)primitiveDa_aggiornareValue;
- (void)setPrimitiveDa_aggiornareValue:(BOOL)value_;




- (NSString*)primitiveDipartimento;
- (void)setPrimitiveDipartimento:(NSString*)value;




- (NSString*)primitiveEmail;
- (void)setPrimitiveEmail:(NSString*)value;




- (NSString*)primitiveEmail_add;
- (void)setPrimitiveEmail_add:(NSString*)value;




- (NSString*)primitiveFax;
- (void)setPrimitiveFax:(NSString*)value;




- (NSString*)primitiveFax_add;
- (void)setPrimitiveFax_add:(NSString*)value;




- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int16_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int16_t)value_;




- (NSString*)primitiveIndirizzo;
- (void)setPrimitiveIndirizzo:(NSString*)value;




- (NSString*)primitiveIndirizzo_ist;
- (void)setPrimitiveIndirizzo_ist:(NSString*)value;




- (NSString*)primitiveIstituto;
- (void)setPrimitiveIstituto:(NSString*)value;




- (NSString*)primitiveNome;
- (void)setPrimitiveNome:(NSString*)value;




- (NSString*)primitiveNote;
- (void)setPrimitiveNote:(NSString*)value;




- (NSString*)primitivePaese;
- (void)setPrimitivePaese:(NSString*)value;




- (NSString*)primitivePaese_ist;
- (void)setPrimitivePaese_ist:(NSString*)value;




- (NSString*)primitivePosizione;
- (void)setPrimitivePosizione:(NSString*)value;




- (NSNumber*)primitivePresente;
- (void)setPrimitivePresente:(NSNumber*)value;

- (BOOL)primitivePresenteValue;
- (void)setPrimitivePresenteValue:(BOOL)value_;




- (NSString*)primitiveProvincia;
- (void)setPrimitiveProvincia:(NSString*)value;




- (NSString*)primitiveProvincia_ist;
- (void)setPrimitiveProvincia_ist:(NSString*)value;




- (NSString*)primitiveSpecialita;
- (void)setPrimitiveSpecialita:(NSString*)value;




- (NSString*)primitiveTelefono;
- (void)setPrimitiveTelefono:(NSString*)value;




- (NSString*)primitiveTelefono_add;
- (void)setPrimitiveTelefono_add:(NSString*)value;





- (Evento*)primitivePartec_evento;
- (void)setPrimitivePartec_evento:(Evento*)value;



- (NSMutableSet*)primitivePartec_regist_inv;
- (void)setPrimitivePartec_regist_inv:(NSMutableSet*)value;



- (NSMutableSet*)primitivePartec_scelta_inv;
- (void)setPrimitivePartec_scelta_inv:(NSMutableSet*)value;


@end
