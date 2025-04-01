*&---------------------------------------------------------------------*
*& Report ZAC22_XX_CREATE_DICTIONARY_OBJECTS
*&---------------------------------------------------------------------*
REPORT zac22_xx_create_dictionary_objects.

* 1. CREAZIONE DOMINI
*----------------------------------------------------------------------*
* ZAC22_XX_NOME - Nome
DATA: l_obj TYPE ddobjname VALUE 'ZAC22_XX_NOME',
      l_dd01v_wa TYPE dd01v,
      l_dd07v_tab TYPE STANDARD TABLE OF dd07v.

l_dd01v_wa-domname    = 'ZAC22_XX_NOME'.
l_dd01v_wa-ddlanguage = 'I'.
l_dd01v_wa-datatype   = 'CHAR'.
l_dd01v_wa-leng       = '40'.
l_dd01v_wa-lowercase  = 'X'.  " Deve accettare minuscole
l_dd01v_wa-ddtext     = 'Nome'.

CALL FUNCTION 'DDIF_DOMA_PUT'
  EXPORTING
    name              = l_obj
    dd01v_wa          = l_dd01v_wa
  TABLES
    dd07v_tab         = l_dd07v_tab
  EXCEPTIONS
    doma_not_found    = 1
    name_inconsistent = 2
    doma_inconsistent = 3
    put_failure       = 4
    put_refused       = 5
    OTHERS            = 6.

* ZAC22_XX_COGNOME - Cognome
CLEAR: l_dd01v_wa, l_dd07v_tab.
l_obj = 'ZAC22_XX_COGNOME'.
l_dd01v_wa-domname    = 'ZAC22_XX_COGNOME'.
l_dd01v_wa-ddlanguage = 'I'.
l_dd01v_wa-datatype   = 'CHAR'.
l_dd01v_wa-leng       = '40'.
l_dd01v_wa-lowercase  = 'X'.  " Deve accettare minuscole
l_dd01v_wa-ddtext     = 'Cognome'.

CALL FUNCTION 'DDIF_DOMA_PUT'
  EXPORTING
    name              = l_obj
    dd01v_wa          = l_dd01v_wa
  TABLES
    dd07v_tab         = l_dd07v_tab.

* ZAC22_XX_GENERE - Genere
CLEAR: l_dd01v_wa, l_dd07v_tab.
DATA: ls_dd07v TYPE dd07v.

l_obj = 'ZAC22_XX_GENERE'.
l_dd01v_wa-domname    = 'ZAC22_XX_GENERE'.
l_dd01v_wa-ddlanguage = 'I'.
l_dd01v_wa-datatype   = 'CHAR'.
l_dd01v_wa-leng       = '1'.
l_dd01v_wa-ddtext     = 'Genere'.

* Valori fissi per il genere
ls_dd07v-domname  = 'ZAC22_XX_GENERE'.
ls_dd07v-valpos   = '0001'.
ls_dd07v-ddlanguage = 'I'.
ls_dd07v-domvalue_l = 'M'.
ls_dd07v-ddtext   = 'Maschio'.
APPEND ls_dd07v TO l_dd07v_tab.

CLEAR ls_dd07v.
ls_dd07v-domname  = 'ZAC22_XX_GENERE'.
ls_dd07v-valpos   = '0002'.
ls_dd07v-ddlanguage = 'I'.
ls_dd07v-domvalue_l = 'F'.
ls_dd07v-ddtext   = 'Femmina'.
APPEND ls_dd07v TO l_dd07v_tab.

CLEAR ls_dd07v.
ls_dd07v-domname  = 'ZAC22_XX_GENERE'.
ls_dd07v-valpos   = '0003'.
ls_dd07v-ddlanguage = 'I'.
ls_dd07v-domvalue_l = 'N'.
ls_dd07v-ddtext   = 'Non specificato'.
APPEND ls_dd07v TO l_dd07v_tab.

CLEAR ls_dd07v.
ls_dd07v-domname  = 'ZAC22_XX_GENERE'.
ls_dd07v-valpos   = '0004'.
ls_dd07v-ddlanguage = 'I'.
ls_dd07v-domvalue_l = ''.
ls_dd07v-ddtext   = 'Non dichiarato'.
APPEND ls_dd07v TO l_dd07v_tab.

CALL FUNCTION 'DDIF_DOMA_PUT'
  EXPORTING
    name              = l_obj
    dd01v_wa          = l_dd01v_wa
  TABLES
    dd07v_tab         = l_dd07v_tab.

* ZAC22_XX_BIRTHPLACE - Luogo di nascita
CLEAR: l_dd01v_wa, l_dd07v_tab.
l_obj = 'ZAC22_XX_BIRTHPLACE'.
l_dd01v_wa-domname    = 'ZAC22_XX_BIRTHPLACE'.
l_dd01v_wa-ddlanguage = 'I'.
l_dd01v_wa-datatype   = 'CHAR'.
l_dd01v_wa-leng       = '80'.
l_dd01v_wa-ddtext     = 'Luogo di nascita'.

* Valori fissi per luogo di nascita
CLEAR ls_dd07v.
ls_dd07v-domname  = 'ZAC22_XX_BIRTHPLACE'.
ls_dd07v-valpos   = '0001'.
ls_dd07v-ddlanguage = 'I'.
ls_dd07v-domvalue_l = 'CAGLIARI'.
ls_dd07v-ddtext   = 'Cagliari'.
APPEND ls_dd07v TO l_dd07v_tab.

CLEAR ls_dd07v.
ls_dd07v-domname  = 'ZAC22_XX_BIRTHPLACE'.
ls_dd07v-valpos   = '0002'.
ls_dd07v-ddlanguage = 'I'.
ls_dd07v-domvalue_l = 'MILANO'.
ls_dd07v-ddtext   = 'Milano'.
APPEND ls_dd07v TO l_dd07v_tab.

CLEAR ls_dd07v.
ls_dd07v-domname  = 'ZAC22_XX_BIRTHPLACE'.
ls_dd07v-valpos   = '0003'.
ls_dd07v-ddlanguage = 'I'.
ls_dd07v-domvalue_l = 'NAPOLI'.
ls_dd07v-ddtext   = 'Napoli'.
APPEND ls_dd07v TO l_dd07v_tab.

CLEAR ls_dd07v.
ls_dd07v-domname  = 'ZAC22_XX_BIRTHPLACE'.
ls_dd07v-valpos   = '0004'.
ls_dd07v-ddlanguage = 'I'.
ls_dd07v-domvalue_l = 'PONTEDERA'.
ls_dd07v-ddtext   = 'Pontedera'.
APPEND ls_dd07v TO l_dd07v_tab.

CALL FUNCTION 'DDIF_DOMA_PUT'
  EXPORTING
    name              = l_obj
    dd01v_wa          = l_dd01v_wa
  TABLES
    dd07v_tab         = l_dd07v_tab.

* ZAC22_XX_PERFORMANCE - Variazione % performance
CLEAR: l_dd01v_wa, l_dd07v_tab.
l_obj = 'ZAC22_XX_PERFORMANCE'.
l_dd01v_wa-domname    = 'ZAC22_XX_PERFORMANCE'.
l_dd01v_wa-ddlanguage = 'I'.
l_dd01v_wa-datatype   = 'DEC'.
l_dd01v_wa-leng       = '3'.
l_dd01v_wa-decimals   = '2'.
l_dd01v_wa-signflag   = 'X'.  " Può essere negativo
l_dd01v_wa-ddtext     = 'Variazione % performance'.

CALL FUNCTION 'DDIF_DOMA_PUT'
  EXPORTING
    name              = l_obj
    dd01v_wa          = l_dd01v_wa
  TABLES
    dd07v_tab         = l_dd07v_tab.

* 2. CREAZIONE DATA ELEMENTS
*----------------------------------------------------------------------*
DATA: l_obj_de TYPE ddobjname,
      l_dd04v_wa TYPE dd04v.

* ZAC22_XX_NOME
l_obj_de = 'ZAC22_XX_NOME'.
l_dd04v_wa-rollname   = 'ZAC22_XX_NOME'.
l_dd04v_wa-domname    = 'ZAC22_XX_NOME'.
l_dd04v_wa-ddlanguage = 'I'.
l_dd04v_wa-reptext    = 'Nome'.
l_dd04v_wa-scrtext_s  = 'Nome'.
l_dd04v_wa-scrtext_m  = 'Nome'.
l_dd04v_wa-scrtext_l  = 'Nome dipendente'.
l_dd04v_wa-headlen    = '40'.

CALL FUNCTION 'DDIF_DTEL_PUT'
  EXPORTING
    name              = l_obj_de
    dd04v_wa          = l_dd04v_wa.

* ZAC22_XX_COGNOME
CLEAR l_dd04v_wa.
l_obj_de = 'ZAC22_XX_COGNOME'.
l_dd04v_wa-rollname   = 'ZAC22_XX_COGNOME'.
l_dd04v_wa-domname    = 'ZAC22_XX_COGNOME'.
l_dd04v_wa-ddlanguage = 'I'.
l_dd04v_wa-reptext    = 'Cognome'.
l_dd04v_wa-scrtext_s  = 'Cognome'.
l_dd04v_wa-scrtext_m  = 'Cognome'.
l_dd04v_wa-scrtext_l  = 'Cognome dipendente'.
l_dd04v_wa-headlen    = '40'.

CALL FUNCTION 'DDIF_DTEL_PUT'
  EXPORTING
    name              = l_obj_de
    dd04v_wa          = l_dd04v_wa.

* ZAC22_XX_GENERE
CLEAR l_dd04v_wa.
l_obj_de = 'ZAC22_XX_GENERE'.
l_dd04v_wa-rollname   = 'ZAC22_XX_GENERE'.
l_dd04v_wa-domname    = 'ZAC22_XX_GENERE'.
l_dd04v_wa-ddlanguage = 'I'.
l_dd04v_wa-reptext    = 'Genere'.
l_dd04v_wa-scrtext_s  = 'Genere'.
l_dd04v_wa-scrtext_m  = 'Genere'.
l_dd04v_wa-scrtext_l  = 'Genere dipendente'.
l_dd04v_wa-headlen    = '6'.

CALL FUNCTION 'DDIF_DTEL_PUT'
  EXPORTING
    name              = l_obj_de
    dd04v_wa          = l_dd04v_wa.

* ZAC22_XX_BIRTHPLACE
CLEAR l_dd04v_wa.
l_obj_de = 'ZAC22_XX_BIRTHPLACE'.
l_dd04v_wa-rollname   = 'ZAC22_XX_BIRTHPLACE'.
l_dd04v_wa-domname    = 'ZAC22_XX_BIRTHPLACE'.
l_dd04v_wa-ddlanguage = 'I'.
l_dd04v_wa-reptext    = 'Luogo nasc.'.
l_dd04v_wa-scrtext_s  = 'L. nasc.'.
l_dd04v_wa-scrtext_m  = 'Luogo nasc.'.
l_dd04v_wa-scrtext_l  = 'Luogo di nascita'.
l_dd04v_wa-headlen    = '13'.

CALL FUNCTION 'DDIF_DTEL_PUT'
  EXPORTING
    name              = l_obj_de
    dd04v_wa          = l_dd04v_wa.

* ZAC22_XX_PERFORMANCE
CLEAR l_dd04v_wa.
l_obj_de = 'ZAC22_XX_PERFORMANCE'.
l_dd04v_wa-rollname   = 'ZAC22_XX_PERFORMANCE'.
l_dd04v_wa-domname    = 'ZAC22_XX_PERFORMANCE'.
l_dd04v_wa-ddlanguage = 'I'.
l_dd04v_wa-reptext    = 'Performance'.
l_dd04v_wa-scrtext_s  = 'Perf.'.
l_dd04v_wa-scrtext_m  = 'Performance'.
l_dd04v_wa-scrtext_l  = 'Variazione % performance'.
l_dd04v_wa-headlen    = '15'.

CALL FUNCTION 'DDIF_DTEL_PUT'
  EXPORTING
    name              = l_obj_de
    dd04v_wa          = l_dd04v_wa.

* Data element con tipo predefinito
* ZAC22_XX_CF
CLEAR l_dd04v_wa.
l_obj_de = 'ZAC22_XX_CF'.
l_dd04v_wa-rollname   = 'ZAC22_XX_CF'.
l_dd04v_wa-datatype   = 'CHAR'.
l_dd04v_wa-leng       = '16'.
l_dd04v_wa-ddlanguage = 'I'.
l_dd04v_wa-reptext    = 'Cod.Fiscale'.
l_dd04v_wa-scrtext_s  = 'CF'.
l_dd04v_wa-scrtext_m  = 'Cod.Fiscale'.
l_dd04v_wa-scrtext_l  = 'Codice Fiscale'.
l_dd04v_wa-headlen    = '16'.

CALL FUNCTION 'DDIF_DTEL_PUT'
  EXPORTING
    name              = l_obj_de
    dd04v_wa          = l_dd04v_wa.

* ZAC22_XX_BIRTHDATE
CLEAR l_dd04v_wa.
l_obj_de = 'ZAC22_XX_BIRTHDATE'.
l_dd04v_wa-rollname   = 'ZAC22_XX_BIRTHDATE'.
l_dd04v_wa-datatype   = 'DATS'.
l_dd04v_wa-ddlanguage = 'I'.
l_dd04v_wa-reptext    = 'Data nasc.'.
l_dd04v_wa-scrtext_s  = 'D. nasc.'.
l_dd04v_wa-scrtext_m  = 'Data nasc.'.
l_dd04v_wa-scrtext_l  = 'Data di nascita'.
l_dd04v_wa-headlen    = '10'.

CALL FUNCTION 'DDIF_DTEL_PUT'
  EXPORTING
    name              = l_obj_de
    dd04v_wa          = l_dd04v_wa.

* ZAC22_XX_ALTEZZA
CLEAR l_dd04v_wa.
l_obj_de = 'ZAC22_XX_ALTEZZA'.
l_dd04v_wa-rollname   = 'ZAC22_XX_ALTEZZA'.
l_dd04v_wa-datatype   = 'QUAN'.
l_dd04v_wa-leng       = '6'.
l_dd04v_wa-decimals   = '2'.
l_dd04v_wa-ddlanguage = 'I'.
l_dd04v_wa-reptext    = 'Altezza'.
l_dd04v_wa-scrtext_s  = 'Altezza'.
l_dd04v_wa-scrtext_m  = 'Altezza'.
l_dd04v_wa-scrtext_l  = 'Altezza dipendente'.
l_dd04v_wa-headlen    = '7'.

CALL FUNCTION 'DDIF_DTEL_PUT'
  EXPORTING
    name              = l_obj_de
    dd04v_wa          = l_dd04v_wa.

* ZAC22_XX_STIPENDIO
CLEAR l_dd04v_wa.
l_obj_de = 'ZAC22_XX_STIPENDIO'.
l_dd04v_wa-rollname   = 'ZAC22_XX_STIPENDIO'.
l_dd04v_wa-datatype   = 'CURR'.
l_dd04v_wa-leng       = '10'.
l_dd04v_wa-decimals   = '2'.
l_dd04v_wa-ddlanguage = 'I'.
l_dd04v_wa-reptext    = 'Stipendio'.
l_dd04v_wa-scrtext_s  = 'Stip.'.
l_dd04v_wa-scrtext_m  = 'Stipendio'.
l_dd04v_wa-scrtext_l  = 'Stipendio dipendente'.
l_dd04v_wa-headlen    = '10'.

CALL FUNCTION 'DDIF_DTEL_PUT'
  EXPORTING
    name              = l_obj_de
    dd04v_wa          = l_dd04v_wa.

* 3. CREAZIONE STRUTTURA
*----------------------------------------------------------------------*
DATA: l_obj_str   TYPE ddobjname,
      l_dd02v_wa  TYPE dd02v,
      l_dd03p_tab TYPE STANDARD TABLE OF dd03p.

* ZAC22_XX_DIPENDENTI
l_obj_str = 'ZAC22_XX_DIPENDENTI'.
l_dd02v_wa-tabname    = 'ZAC22_XX_DIPENDENTI'.
l_dd02v_wa-ddlanguage = 'I'.
l_dd02v_wa-tabclass   = 'INTTAB'.
l_dd02v_wa-ddtext     = 'Struttura dipendenti'.

DATA: ls_dd03p TYPE dd03p.

* Campo CODICE_FISCALE
ls_dd03p-tabname   = 'ZAC22_XX_DIPENDENTI'.
ls_dd03p-fieldname = 'CODICE_FISCALE'.
ls_dd03p-position  = '0001'.
ls_dd03p-rollname  = 'ZAC22_XX_CF'.
APPEND ls_dd03p TO l_dd03p_tab.

* Campo NOME
CLEAR ls_dd03p.
ls_dd03p-tabname   = 'ZAC22_XX_DIPENDENTI'.
ls_dd03p-fieldname = 'NOME'.
ls_dd03p-position  = '0002'.
ls_dd03p-rollname  = 'ZAC22_XX_NOME'.
APPEND ls_dd03p TO l_dd03p_tab.

* Campo COGNOME
CLEAR ls_dd03p.
ls_dd03p-tabname   = 'ZAC22_XX_DIPENDENTI'.
ls_dd03p-fieldname = 'COGNOME'.
ls_dd03p-position  = '0003'.
ls_dd03p-rollname  = 'ZAC22_XX_COGNOME'.
APPEND ls_dd03p TO l_dd03p_tab.

* Campo GENERE
CLEAR ls_dd03p.
ls_dd03p-tabname   = 'ZAC22_XX_DIPENDENTI'.
ls_dd03p-fieldname = 'GENERE'.
ls_dd03p-position  = '0004'.
ls_dd03p-rollname  = 'ZAC22_XX_GENERE'.
APPEND ls_dd03p TO l_dd03p_tab.

* Campo DATA_NASCITA
CLEAR ls_dd03p.
ls_dd03p-tabname   = 'ZAC22_XX_DIPENDENTI'.
ls_dd03p-fieldname = 'DATA_NASCITA'.
ls_dd03p-position  = '0005'.
ls_dd03p-rollname  = 'ZAC22_XX_BIRTHDATE'.
APPEND ls_dd03p TO l_dd03p_tab.

* Campo LUOGO_NASCITA
CLEAR ls_dd03p.
ls_dd03p-tabname   = 'ZAC22_XX_DIPENDENTI'.
ls_dd03p-fieldname = 'LUOGO_NASCITA'.
ls_dd03p-position  = '0006'.
ls_dd03p-rollname  = 'ZAC22_XX_BIRTHPLACE'.
APPEND ls_dd03p TO l_dd03p_tab.

* Campo ALTEZZA
CLEAR ls_dd03p.
ls_dd03p-tabname   = 'ZAC22_XX_DIPENDENTI'.
ls_dd03p-fieldname = 'ALTEZZA'.
ls_dd03p-position  = '0007'.
ls_dd03p-rollname  = 'ZAC22_XX_ALTEZZA'.
APPEND ls_dd03p TO l_dd03p_tab.

* Campo ALTEZZA_UOM
CLEAR ls_dd03p.
ls_dd03p-tabname   = 'ZAC22_XX_DIPENDENTI'.
ls_dd03p-fieldname = 'ALTEZZA_UOM'.
ls_dd03p-position  = '0008'.
ls_dd03p-rollname  = 'UNIT'.
ls_dd03p-ddtext    = 'Unità di misura altezza'.
APPEND ls_dd03p TO l_dd03p_tab.

* Campo STIPENDIO
CLEAR ls_dd03p.
ls_dd03p-tabname   = 'ZAC22_XX_DIPENDENTI'.
ls_dd03p-fieldname = 'STIPENDIO'.
ls_dd03p-position  = '0009'.
ls_dd03p-rollname  = 'ZAC22_XX_STIPENDIO'.
APPEND ls_dd03p TO l_dd03p_tab.

* Campo STIPENDIO_UOM
CLEAR ls_dd03p.
ls_dd03p-tabname   = 'ZAC22_XX_DIPENDENTI'.
ls_dd03p-fieldname = 'STIPENDIO_UOM'.
ls_dd03p-position  = '0010'.
ls_dd03p-rollname  = 'CUKY'.
ls_dd03p-ddtext    = 'Valuta'.
APPEND ls_dd03p TO l_dd03p_tab.

* Campo PERFORMANCE
CLEAR ls_dd03p.
ls_dd03p-tabname   = 'ZAC22_XX_DIPENDENTI'.
ls_dd03p-fieldname = 'PERFORMANCE'.
ls_dd03p-position  = '0011'.
ls_dd03p-rollname  = 'ZAC22_XX_PERFORMANCE'.
APPEND ls_dd03p TO l_dd03p_tab.

* Campo TEMPO_PIENO
CLEAR ls_dd03p.
ls_dd03p-tabname   = 'ZAC22_XX_DIPENDENTI'.
ls_dd03p-fieldname = 'TEMPO_PIENO'.
ls_dd03p-position  = '0012'.
ls_dd03p-rollname  = 'BOOLE_D'.
APPEND ls_dd03p TO l_dd03p_tab.

* Campo UTENZA_CREAZIONE
CLEAR ls_dd03p.
ls_dd03p-tabname   = 'ZAC22_XX_DIPENDENTI'.
ls_dd03p-fieldname = 'UTENZA_CREAZIONE'.
ls_dd03p-position  = '0013'.
ls_dd03p-datatype  = 'CHAR'.
ls_dd03p-leng      = '12'.
ls_dd03p-ddtext    = 'Utenza creazione'.
APPEND ls_dd03p TO l_dd03p_tab.

* Campo DATA_CREAZIONE
CLEAR ls_dd03p.
ls_dd03p-tabname   = 'ZAC22_XX_DIPENDENTI'.
ls_dd03p-fieldname = 'DATA_CREAZIONE'.
ls_dd03p-position  = '0014'.
ls_dd03p-datatype  = 'DATS'.
ls_dd03p-ddtext    = 'Data creazione'.
APPEND ls_dd03p TO l_dd03p_tab.

CALL FUNCTION 'DDIF_TABL_PUT'
  EXPORTING
    name              = l_obj_str
    dd02v_wa          = l_dd02v_wa
  TABLES
    dd03p_tab         = l_dd03p_tab.

* 4. CREAZIONE TIPO TABELLA
*----------------------------------------------------------------------*
DATA: l_obj_ttyp  TYPE ddobjname,
      l_dd40v_wa  TYPE dd40v.

l_obj_ttyp = 'ZAC22_XX_DIPENDENTI_T'.
l_dd40v_wa-typename   = 'ZAC22_XX_DIPENDENTI_T'.
l_dd40v_wa-ddlanguage = 'I'.
l_dd40v_wa-rowtype    = 'ZAC22_XX_DIPENDENTI'.
l_dd40v_wa-rowkind    = 'S'.
l_dd40v_wa-datatype   = 'STRU'.
l_dd40v_wa-accessmode = 'T'.          " Standard Table
l_dd40v_wa-keydef     = 'D'.
l_dd40v_wa-ddtext     = 'Tabella standard dipendenti'.

CALL FUNCTION 'DDIF_TTYP_PUT'
  EXPORTING
    name              = l_obj_ttyp
    dd40v_wa          = l_dd40v_wa.

* 5. CREAZIONE TABELLA DB
*----------------------------------------------------------------------*
DATA: l_obj_tab   TYPE ddobjname,
      l_dd02v_tab TYPE dd02v,
      l_dd09l_tab TYPE dd09l.

l_obj_tab = 'ZAC22_XX_DIP'.
l_dd02v_tab-tabname    = 'ZAC22_XX_DIP'.
l_dd02v_tab-ddlanguage = 'I'.
l_dd02v_tab-tabclass   = 'TRANSP'.      " Tabella transparente
l_dd02v_tab-mainflag   = 'X'.
l_dd02v_tab-contflag   = 'C'.           " Solo per caratteri e numeri
l_dd02v_tab-exclass    = '1'.           " Dati modificabili
l_dd02v_tab-ddtext     = 'Tabella dipendenti'.

* Definizione campi tabella
CLEAR: l_dd03p_tab.

* Campo MANDT
ls_dd03p-tabname   = 'ZAC22_XX_DIP'.
ls_dd03p-fieldname = 'MANDT'.
ls_dd03p-position  = '0001'.
ls_dd03p-keyflag   = 'X'.               " Chiave primaria
ls_dd03p-datatype  = 'CLNT'.
ls_dd03p-leng      = '3'.
ls_dd03p-ddtext    = 'Cliente'.
ls_dd03p-checktable = 'T000'.           " Check Table per MANDT
APPEND ls_dd03p TO l_dd03p_tab.

* Campo CODICE_FISCALE
CLEAR ls_dd03p.
ls_dd03p-tabname   = 'ZAC22_XX_DIP'.
ls_dd03p-fieldname = 'CODICE_FISCALE'.
ls_dd03p-position  = '0002'.
ls_dd03p-keyflag   = 'X'.               " Chiave primaria
ls_dd03p-rollname  = 'ZAC22_XX_CF'.
APPEND ls_dd03p TO l_dd03p_tab.

* Campo NOME
CLEAR ls_dd03p.
ls_dd03p-tabname   = 'ZAC22_XX_DIP'.
ls_dd03p-fieldname = 'NOME'.
ls_dd03p-position  = '0003'.
ls_dd03p-rollname  = 'ZAC22_XX_NOME'.
APPEND ls_dd03p TO l_dd03p_tab.

* Campo COGNOME
CLEAR ls_dd03p.
ls_dd03p-tabname   = 'ZAC22_XX_DIP'.
ls_dd03p-fieldname = 'COGNOME'.
ls_dd03p-position  = '0004'.
ls_dd03p-rollname  = 'ZAC22_XX_COGNOME'.
APPEND ls_dd03p TO l_dd03p_tab.

* Campo GENERE
CLEAR ls_dd03p.
ls_dd03p-tabname   = 'ZAC22_XX_DIP'.
ls_dd03p-fieldname = 'GENERE'.
ls_dd03p-position  = '0005'.
ls_dd03p-rollname  = 'ZAC22_XX_GENERE'.
APPEND ls_dd03p TO l_dd03p_tab.

* Campo DATA_NASCITA
CLEAR ls_dd03p.
ls_dd03p-tabname   = 'ZAC22_XX_DIP'.
ls_dd03p-fieldname = 'DATA_NASCITA'.
ls_dd03p-position  = '0006'.
ls_dd03p-rollname  = 'ZAC22_XX_BIRTHDATE'.
APPEND ls_dd03p TO l_dd03p_tab.

* Campo LUOGO_NASCITA
CLEAR ls_dd03p.
ls_dd03p-tabname   = 'ZAC22_XX_DIP'.
ls_dd03p-fieldname = 'LUOGO_NASCITA'.
ls_dd03p-position  = '0007'.
ls_dd03p-rollname  = 'ZAC22_XX_BIRTHPLACE'.
APPEND ls_dd03p TO l_dd03p_tab.

* Campo ALTEZZA
CLEAR ls_dd03p.
ls_dd03p-tabname   = 'ZAC22_XX_DIP'.
ls_dd03p-fieldname = 'ALTEZZA'.
ls_dd03p-position  = '0008'.
ls_dd03p-rollname  = 'ZAC22_XX_ALTEZZA'.
APPEND ls_dd03p TO l_dd03p_tab.

* Campo ALTEZZA_UOM
CLEAR ls_dd03p.
ls_dd03p-tabname   = 'ZAC22_XX_DIP'.
ls_dd03p-fieldname = 'ALTEZZA_UOM'.
ls_dd03p-position  = '0009'.
ls_dd03p-rollname  = 'UNIT'.
ls_dd03p-ddtext    = 'Unità di misura altezza'.
APPEND ls_dd03p TO l_dd03p_tab.

* Campo STIPENDIO
CLEAR ls_dd03p.
ls_dd03p-tabname   = 'ZAC22_XX_DIP'.
ls_dd03p-fieldname = 'STIPENDIO'.
ls_dd03p-position  = '0010'.
ls_dd03p-rollname  = 'ZAC22_XX_STIPENDIO'.
APPEND ls_dd03p TO l_dd03p_tab.

* Campo STIPENDIO_UOM
CLEAR ls_dd03p.
ls_dd03p-tabname   = 'ZAC22_XX_DIP'.
ls_dd03p-fieldname = 'STIPENDIO_UOM'.
ls_dd03p-position  = '0011'.
ls_dd03p-rollname  = 'CUKY'.
ls_dd03p-ddtext    = 'Valuta'.
APPEND ls_dd03p TO l_dd03p_tab.

* Campo PERFORMANCE
CLEAR ls_dd03p.
ls_dd03p-tabname   = 'ZAC22_XX_DIP'.
ls_dd03p-fieldname = 'PERFORMANCE'.
ls_dd03p-position  = '0012'.
ls_dd03p-rollname  = 'ZAC22_XX_PERFORMANCE'.
APPEND ls_dd03p TO l_dd03p_tab.

* Campo TEMPO_PIENO
CLEAR ls_dd03p.
ls_dd03p-tabname   = 'ZAC22_XX_DIP'.
ls_dd03p-fieldname = 'TEMPO_PIENO'.
ls_dd03p-position  = '0013'.
ls_dd03p-rollname  = 'BOOLE_D'.
APPEND ls_dd03p TO l_dd03p_tab.

* Campo UTENZA_CREAZIONE
CLEAR ls_dd03p.
ls_dd03p-tabname   = 'ZAC22_XX_DIP'.
ls_dd03p-fieldname = 'UTENZA_CREAZIONE'.
ls_dd03p-position  = '0014'.
ls_dd03p-datatype  = 'CHAR'.
ls_dd03p-leng      = '12'.
ls_dd03p-ddtext    = 'Utenza creazione'.
APPEND ls_dd03p TO l_dd03p_tab.

* Campo DATA_CREAZIONE
CLEAR ls_dd03p.
ls_dd03p-tabname   = 'ZAC22_XX_DIP'.
ls_dd03p-fieldname = 'DATA_CREAZIONE'.
ls_dd03p-position  = '0015'.
ls_dd03p-datatype  = 'DATS'.
ls_dd03p-ddtext    = 'Data creazione'.
APPEND ls_dd03p TO l_dd03p_tab.

* Impostazione caratteristiche tecniche tabella
l_dd09l_tab-tabname  = 'ZAC22_XX_DIP'.
l_dd09l_tab-tabart   = 'APPL0'.
l_dd09l_tab-tabform  = 'T'.
l_dd09l_tab-clidep   = 'X'.           " Client dependent
l_dd09l_tab-buffered = 'X'.
l_dd09l_tab-rowinset = '5000'.        " Dimensione max 5000 righe
l_dd09l_tab-dataclass = 'APPL0'.      " Master Data

CALL FUNCTION 'DDIF_TABL_PUT'
  EXPORTING
    name              = l_obj_tab
    dd02v_wa          = l_dd02v_tab
    dd09l_wa          = l_dd09l_tab
  TABLES
    dd03p_tab         = l_dd03p_tab.

* Bonus: Creazione indice secondario per il campo COGNOME
DATA: l_dd12v_wa  TYPE dd12v,
      l_dd17v_tab TYPE STANDARD TABLE OF dd17v.

l_dd12v_wa-sqltab    = 'ZAC22_XX_DIP'.
l_dd12v_wa-indexname = 'ZAC22_XX_COGNOME_IDX'.
l_dd12v_wa-ddlanguage = 'I'.
l_dd12v_wa-ddtext    = 'Indice per cognome'.

DATA: ls_dd17v TYPE dd17v.
ls_dd17v-indexname = 'ZAC22_XX_COGNOME_IDX'.
ls_dd17v-position  = '0001'.
ls_dd17v-fieldname = 'COGNOME'.
APPEND ls_dd17v TO l_dd17v_tab.

CALL FUNCTION 'DDIF_INDX_PUT'
  EXPORTING
    name              = l_dd12v_wa-indexname
    dd12v_wa          = l_dd12v_wa
  TABLES
    dd17v_tab         = l_dd17v_tab.

* 6. CREAZIONE MAINTENANCE VIEW
*----------------------------------------------------------------------*
DATA: l_viewname TYPE ddobjname,
      l_dd25v_wa TYPE dd25v,
      l_dd26v_tab TYPE STANDARD TABLE OF dd26v,
      l_dd27p_tab TYPE STANDARD TABLE OF dd27p,
      l_dd28j_tab TYPE STANDARD TABLE OF dd28j,
      l_dd28v_tab TYPE STANDARD TABLE OF dd28v.

l_viewname = 'ZAC22_XX_DIP_VIEW'.
l_dd25v_wa-viewname    = 'ZAC22_XX_DIP_VIEW'.
l_dd25v_wa-ddlanguage  = 'I'.
l_dd25v_wa-aggtype     = 'E'.            " Elementary View
l_dd25v_wa-roottab     = 'ZAC22_XX_DIP'.
l_dd25v_wa-ddtext      = 'Maintenance View dipendenti'.
l_dd25v_wa-viewclass   = 'M'.            " Maintenance View
l_dd25v_wa-actflag     = 'A'.            " View attiva
l_dd25v_wa-authclass   = '&NC&'.         " Authorization group
l_dd25v_wa-maint_mode  = '1'.            " Maintenance Type: 1 step
l_dd25v_wa-auto_fix    = 'X'.

DATA: ls_dd26v TYPE dd26v.
ls_dd26v-viewname   = 'ZAC22_XX_DIP_VIEW'.
ls_dd26v-tabname    = 'ZAC22_XX_DIP'.
ls_dd26v-tabpos     = '0001'.
APPEND ls_dd26v TO l_dd26v_tab.

DATA: ls_dd27p TYPE dd27p.
ls_dd27p-viewname   = 'ZAC22_XX_DIP_VIEW'.
ls_dd27p-objpos     = '0001'.
ls_dd27p-viewfield  = 'ZAC22_XX_DIP-MANDT'.
ls_dd27p-keyflag    = 'X'.
APPEND ls_dd27p TO l_dd27p_tab.

CLEAR ls_dd27p.
ls_dd27p-viewname   = 'ZAC22_XX_DIP_VIEW'.
ls_dd27p-objpos     = '0002'.
ls_dd27p-viewfield  = 'ZAC22_XX_DIP-CODICE_FISCALE'.
ls_dd27p-keyflag    = 'X'.
APPEND ls_dd27p TO l_dd27p_tab.

CLEAR ls_dd27p.
ls_dd27p-viewname   = 'ZAC22_XX_DIP_VIEW'.
ls_dd27p-objpos     = '0003'.
ls_dd27p-viewfield  = 'ZAC22_XX_DIP-NOME'.
APPEND ls_dd27p TO l_dd27p_tab.

CLEAR ls_dd27p.
ls_dd27p-viewname   = 'ZAC22_XX_DIP_VIEW'.
ls_dd27p-objpos     = '0004'.
ls_dd27p-viewfield  = 'ZAC22_XX_DIP-COGNOME'.
APPEND ls_dd27p TO l_dd27p_tab.

CLEAR ls_dd27p.
ls_dd27p-viewname   = 'ZAC22_XX_DIP_VIEW'.
ls_dd27p-objpos     = '0005'.
ls_dd27p-viewfield  = 'ZAC22_XX_DIP-GENERE'.
APPEND ls_dd27p TO l_dd27p_tab.

CLEAR ls_dd27p.
ls_dd27p-viewname   = 'ZAC22_XX_DIP_VIEW'.
ls_dd27p-objpos     = '0006'.
ls_dd27p-viewfield  = 'ZAC22_XX_DIP-DATA_NASCITA'.
APPEND ls_dd27p TO l_dd27p_tab.

CLEAR ls_dd27p.
ls_dd27p-viewname   = 'ZAC22_XX_DIP_VIEW'.
ls_dd27p-objpos     = '0007'.
ls_dd27p-viewfield  = 'ZAC22_XX_DIP-LUOGO_NASCITA'.
APPEND ls_dd27p TO l_dd27p_tab.

CLEAR ls_dd27p.
ls_dd27p-viewname   = 'ZAC22_XX_DIP_VIEW'.
ls_dd27p-objpos     = '0008'.
ls_dd27p-viewfield  = 'ZAC22_XX_DIP-ALTEZZA'.
APPEND ls_dd27p TO l_dd27p_tab.

CLEAR ls_dd27p.
ls_dd27p-viewname   = 'ZAC22_XX_DIP_VIEW'.
ls_dd27p-objpos     = '0009'.
ls_dd27p-viewfield  = 'ZAC22_XX_DIP-ALTEZZA_UOM'.
APPEND ls_dd27p TO l_dd27p_tab.

CLEAR ls_dd27p.
ls_dd27p-viewname   = 'ZAC22_XX_DIP_VIEW'.
ls_dd27p-objpos     = '0010'.
ls_dd27p-viewfield  = 'ZAC22_XX_DIP-STIPENDIO'.
APPEND ls_dd27p TO l_dd27p_tab.

CLEAR ls_dd27p.
ls_dd27p-viewname   = 'ZAC22_XX_DIP_VIEW'.
ls_dd27p-objpos     = '0011'.
ls_dd27p-viewfield  = 'ZAC22_XX_DIP-STIPENDIO_UOM'.
APPEND ls_dd27p TO l_dd27p_tab.

CLEAR ls_dd27p.
ls_dd27p-viewname   = 'ZAC22_XX_DIP_VIEW'.
ls_dd27p-objpos     = '0012'.
ls_dd27p-viewfield  = 'ZAC22_XX_DIP-PERFORMANCE'.
APPEND ls_dd27p TO l_dd27p_tab.

CLEAR ls_dd27p.
ls_dd27p-viewname   = 'ZAC22_XX_DIP_VIEW'.
ls_dd27p-objpos     = '0013'.
ls_dd27p-viewfield  = 'ZAC22_XX_DIP-TEMPO_PIENO'.
APPEND ls_dd27p TO l_dd27p_tab.

CALL FUNCTION 'DDIF_VIEW_PUT'
  EXPORTING
    name              = l_viewname
    dd25v_wa          = l_dd25v_wa
  TABLES
    dd26v_tab         = l_dd26v_tab
    dd27p_tab         = l_dd27p_tab
    dd28j_tab         = l_dd28j_tab
    dd28v_tab         = l_dd28v_tab.

* 7. POPOLAMENTO TABELLA (script da eseguire con SM30)
*----------------------------------------------------------------------*
* Di seguito un esempio di script per il popolamento della tabella
* con SM30 (dopo aver attivato la View)

*&---------------------------------------------------------------------*
*& Report ZAC22_XX_POPULATE_DIP
*&---------------------------------------------------------------------*
*& Programma per popolare la tabella dipendenti
*&---------------------------------------------------------------------*
REPORT zac22_xx_populate_dip.

DATA: lt_dip TYPE STANDARD TABLE OF zac22_xx_dip,
      ls_dip TYPE zac22_xx_dip.

* 1. Rossi Giuseppe (M) - Milano
ls_dip-mandt           = sy-mandt.
ls_dip-codice_fiscale  = 'RSSGPP80A01F205Z'.
ls_dip-nome            = 'Giuseppe'.
ls_dip-cognome         = 'Rossi'.
ls_dip-genere          = 'M'.
ls_dip-data_nascita    = '19800101'.
ls_dip-luogo_nascita   = 'MILANO'.
ls_dip-altezza         = '175.50'.
ls_dip-altezza_uom     = 'CM'.
ls_dip-stipendio       = '2500.00'.
ls_dip-stipendio_uom   = 'EUR'.
ls_dip-performance     = '2.50'.
ls_dip-tempo_pieno     = 'X'.
ls_dip-utenza_creazione = sy-uname.
ls_dip-data_creazione  = sy-datum.
APPEND ls_dip TO lt_dip.

* 2. Rossi Maria (F) - Napoli
CLEAR ls_dip.
ls_dip-mandt           = sy-mandt.
ls_dip-codice_fiscale  = 'RSSMRA85B45F839W'.
ls_dip-nome            = 'Maria'.
ls_dip-cognome         = 'Rossi'.
ls_dip-genere          = 'F'.
ls_dip-data_nascita    = '19850205'.
ls_dip-luogo_nascita   = 'NAPOLI'.
ls_dip-altezza         = '165.00'.
ls_dip-altezza_uom     = 'CM'.
ls_dip-stipendio       = '2300.00'.
ls_dip-stipendio_uom   = 'EUR'.
ls_dip-performance     = '-1.20'.
ls_dip-tempo_pieno     = 'X'.
ls_dip-utenza_creazione = sy-uname.
ls_dip-data_creazione  = sy-datum.
APPEND ls_dip TO lt_dip.

* 3. Rossi Antonio (M) - Cagliari
CLEAR ls_dip.
ls_dip-mandt           = sy-mandt.
ls_dip-codice_fiscale  = 'RSSNTN79C15B354P'.
ls_dip-nome            = 'Antonio'.
ls_dip-cognome         = 'Rossi'.
ls_dip-genere          = 'M'.
ls_dip-data_nascita    = '19790315'.
ls_dip-luogo_nascita   = 'CAGLIARI'.
ls_dip-altezza         = '182.00'.
ls_dip-altezza_uom     = 'CM'.
ls_dip-stipendio       = '2800.00'.
ls_dip-stipendio_uom   = 'EUR'.
ls_dip-performance     = '3.75'.
ls_dip-tempo_pieno     = 'X'.
ls_dip-utenza_creazione = sy-uname.
ls_dip-data_creazione  = sy-datum.
APPEND ls_dip TO lt_dip.

* 4. Bianchi Laura (F) - Milano
CLEAR ls_dip.
ls_dip-mandt           = sy-mandt.
ls_dip-codice_fiscale  = 'BNCLRA90D60F205S'.
ls_dip-nome            = 'Laura'.
ls_dip-cognome         = 'Bianchi'.
ls_dip-genere          = 'F'.
ls_dip-data_nascita    = '19900420'.
ls_dip-luogo_nascita   = 'MILANO'.
ls_dip-altezza         = '168.50'.
ls_dip-altezza_uom     = 'CM'.
ls_dip-stipendio       = '2400.00'.
ls_dip-stipendio_uom   = 'EUR'.
ls_dip-performance     = '4.25'.
ls_dip-tempo_pieno     = ''.
ls_dip-utenza_creazione = sy-uname.
ls_dip-data_creazione  = sy-datum.
APPEND ls_dip TO lt_dip.

* 5. Bianchi Marco (M) - Pontedera
CLEAR ls_dip.
ls_dip-mandt           = sy-mandt.
ls_dip-codice_fiscale  = 'BNCMRC88E12G843K'.
ls_dip-nome            = 'Marco'.
ls_dip-cognome         = 'Bianchi'.
ls_dip-genere          = 'M'.
ls_dip-data_nascita    = '19880512'.
ls_dip-luogo_nascita   = 'PONTEDERA'.
ls_dip-altezza         = '179.00'.
ls_dip-altezza_uom     = 'CM'.
ls_dip-stipendio       = '2600.00'.
ls_dip-stipendio_uom   = 'EUR'.
ls_dip-performance     = '0.50'.
ls_dip-tempo_pieno     = 'X'.
ls_dip-utenza_creazione = sy-uname.
ls_dip-data_creazione  = sy-datum.
APPEND ls_dip TO lt_dip.

* 6. Verdi Giulia (F) - Cagliari
CLEAR ls_dip.
ls_dip-mandt           = sy-mandt.
ls_dip-codice_fiscale  = 'VRDGLI92H56B354J'.
ls_dip-nome            = 'Giulia'.
ls_dip-cognome         = 'Verdi'.
ls_dip-genere          = 'F'.
ls_dip-data_nascita    = '19920616'.
ls_dip-luogo_nascita   = 'CAGLIARI'.
ls_dip-altezza         = '170.00'.
ls_dip-altezza_uom     = 'CM'.
ls_dip-stipendio       = '2350.00'.
ls_dip-stipendio_uom   = 'EUR'.
ls_dip-performance     = '-0.80'.
ls_dip-tempo_pieno     = ''.
ls_dip-utenza_creazione = sy-uname.
ls_dip-data_creazione  = sy-datum.
APPEND ls_dip TO lt_dip.

* 7. Neri Paolo (M) - Napoli
CLEAR ls_dip.
ls_dip-mandt           = sy-mandt.
ls_dip-codice_fiscale  = 'NREPLA83L10F839Y'.
ls_dip-nome            = 'Paolo'.
ls_dip-cognome         = 'Neri'.
ls_dip-genere          = 'M'.
ls_dip-data_nascita    = '19830710'.
ls_dip-luogo_nascita   = 'NAPOLI'.
ls_dip-altezza         = '176.00'.
ls_dip-altezza_uom     = 'CM'.
ls_dip-stipendio       = '2450.00'.
ls_dip-stipendio_uom   = 'EUR'.
ls_dip-performance     = '1.20'.
ls_dip-tempo_pieno     = 'X'.
ls_dip-utenza_creazione = sy-uname.
ls_dip-data_creazione  = sy-datum.
APPEND ls_dip TO lt_dip.

* 8. Ferrari Chiara (F) - Pontedera
CLEAR ls_dip.
ls_dip-mandt           = sy-mandt.
ls_dip-codice_fiscale  = 'FRRCHR87M55G843L'.
ls_dip-nome            = 'Chiara'.
ls_dip-cognome         = 'Ferrari'.
ls_dip-genere          = 'F'.
ls_dip-data_nascita    = '19870815'.
ls_dip-luogo_nascita   = 'PONTEDERA'.
ls_dip-altezza         = '163.00'.
ls_dip-altezza_uom     = 'CM'.
ls_dip-stipendio       = '2250.00'.
ls_dip-stipendio_uom   = 'EUR'.
ls_dip-performance     = '2.10'.
ls_dip-tempo_pieno     = 'X'.
ls_dip-utenza_creazione = sy-uname.
ls_dip-data_creazione  = sy-datum.
APPEND ls_dip TO lt_dip.

* 9. Russo Alex (N) - Milano
CLEAR ls_dip.
ls_dip-mandt           = sy-mandt.
ls_dip-codice_fiscale  = 'RSSLXA95P21F205E'.
ls_dip-nome            = 'Alex'.
ls_dip-cognome         = 'Russo'.
ls_dip-genere          = 'N'.            " Non specificato
ls_dip-data_nascita    = '19950921'.
ls_dip-luogo_nascita   = 'MILANO'.
ls_dip-altezza         = '172.00'.
ls_dip-altezza_uom     = 'CM'.
ls_dip-stipendio       = '2100.00'.
ls_dip-stipendio_uom   = 'EUR'.
ls_dip-performance     = '-1.50'.
ls_dip-tempo_pieno     = ''.
ls_dip-utenza_creazione = sy-uname.
ls_dip-data_creazione  = sy-datum.
APPEND ls_dip TO lt_dip.

* 10. Esposito Kim (non dichiarato) - Cagliari
CLEAR ls_dip.
ls_dip-mandt           = sy-mandt.
ls_dip-codice_fiscale  = 'SPSKMI94D05B354Z'.
ls_dip-nome            = 'Kim'.
ls_dip-cognome         = 'Esposito'.
ls_dip-genere          = ''.             " Non dichiarato
ls_dip-data_nascita    = '19940405'.
ls_dip-luogo_nascita   = 'CAGLIARI'.
ls_dip-altezza         = '174.50'.
ls_dip-altezza_uom     = 'CM'.
ls_dip-stipendio       = '2200.00'.
ls_dip-stipendio_uom   = 'EUR'.
ls_dip-performance     = '1.80'.
ls_dip-tempo_pieno     = 'X'.
ls_dip-utenza_creazione = sy-uname.
ls_dip-data_creazione  = sy-datum.
APPEND ls_dip TO lt_dip.

* Inserimento dati in tabella
MODIFY zac22_xx_dip FROM TABLE lt_dip.
IF sy-subrc = 0.
  COMMIT WORK.
  WRITE: / 'Dati inseriti con successo!'.
ELSE.
  ROLLBACK WORK.
  WRITE: / 'Errore durante l''inserimento dei dati!'.
ENDIF.