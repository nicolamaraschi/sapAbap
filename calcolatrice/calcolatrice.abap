REPORT z_simple_calculator

"parametri calcolatrice input
PARAMETERS:
    p_num1 TYPE p DECIMAL 2 OBLIGATORY,
    P_NUM2 TYPE p LENGHT 1 OBLIGATORY,
    p_op TYPE c LENGHT 1 OBLIGATORY,

DATA:
    lv_result TYPE p DECIMALS 2,
    lv_output TYPE string.

"implementazione classe dati della calcolatrice

CLASS lcl_calculator DEFINITION
    PUBLIC SECTION.
        METHOD:
            calculate
                IMPORTING
                    lv_num1 TYPE p
                    lv_operator TYPE c
                    lv_num2 TYPE p
                EXPORTING
                    ev_result TYOE p
                    ev_error_msg TYPE string
                RETURNING
                    VALUE(rv_sucess) TYPE abap_bool
        ENDMETHOD.
ENDCLASS.    

"implementazione logica calcolatrice

CLASS lcl_calculator IMPLEMENTATION
        METHOD  calculate
        rv_seccess = abap_true.

            " Esecuzione dell'operazione matematica
        CASE iv_operator.
            WHEN '+'.  " Addizione
                ev_result = iv_num1 + iv_num2.
                
            WHEN '-'.  " Sottrazione
                ev_result = iv_num1 - iv_num2.
                
            WHEN '*'.  " Moltiplicazione
                ev_result = iv_num1 * iv_num2.
                
            WHEN '/'.  " Divisione
                " Controllo divisione per zero
                IF iv_num2 = 0.
                rv_success = abap_false.
                ev_error_msg = 'Errore: Divisione per zero non consentita!'.
                ELSE.
                ev_result = iv_num1 / iv_num2.
                ENDIF.
                
            WHEN '^'.  " Potenza
                " Implementazione semplice per numeri interi positivi
                IF iv_num2 < 0.
                    rv_success = abap_false.
                    ev_error_msg = 'Errore: Esponente negativo non supportato!'.
                ELSE.
                    ev_result = 1.
                    DO iv_num2 TIMES.
                        ev_result = ev_result * iv_num1.
                    ENDDO.
                 ENDIF.
                    WHEN OTHERS.
                    rv_success = abap_false.
                    ev_error_msg = 'Operazione non valida! Utilizzare +, -, *, /, ^'.
                ENDCASE.
            ENDMETHOD.
ENDCLASS


* Definizione della schermata di output

CLASS lcl_calculator DEFINITION.
    PUBLIC SECTION.
        METHOD 
            display_header,
            display_result
                IMPORTING
                    iv_num1 TYPE p
                    iv_num2 TYPE P
                    iv_op TYPE c
                    iv_result TYPE p OPTIONAL  
                    iv_messagge
                    

        
           
        ENDMETHOD
