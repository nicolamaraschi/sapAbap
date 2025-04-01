CLASS ltcl_calculator_test DEFINITION FINAL FOR TESTING
    DURATION SHORT
    RISK LEVEL HARMLESS.

  PRIVATE SECTION.
    DATA: mo_calculator TYPE REF TO lcl_calculator.

    METHODS:
      setup,
      test_addition FOR TESTING,
      test_subtraction FOR TESTING,
      test_multiplication FOR TESTING,
      test_division FOR TESTING,
      test_division_by_zero FOR TESTING,
      test_invalid_operator FOR TESTING.
ENDCLASS.

CLASS ltcl_calculator_test IMPLEMENTATION.

  METHOD setup.
    " Creazione dell'istanza della calcolatrice
    mo_calculator = NEW lcl_calculator( ).
  ENDMETHOD.

  METHOD test_addition.
    DATA: lv_result TYPE p DECIMALS 2,
          lv_error_msg TYPE string,
          lv_success TYPE abap_bool.

    lv_success = mo_calculator->calculate(
      iv_num1 = 5
      iv_operator = '+'
      iv_num2 = 3
      ev_result = lv_result
      ev_error_msg = lv_error_msg ).

    cl_abap_unit_assert=>assert_equals(
      act = lv_result
      exp = 8
      msg = 'Errore nell''addizione' ).

    cl_abap_unit_assert=>assert_true(
      act = lv_success
      msg = 'Addizione fallita inaspettatamente' ).
  ENDMETHOD.

  METHOD test_subtraction.
    DATA: lv_result TYPE p DECIMALS 2,
          lv_error_msg TYPE string,
          lv_success TYPE abap_bool.

    lv_success = mo_calculator->calculate(
      iv_num1 = 10
      iv_operator = '-'
      iv_num2 = 4
      ev_result = lv_result
      ev_error_msg = lv_error_msg ).

    cl_abap_unit_assert=>assert_equals(
      act = lv_result
      exp = 6
      msg = 'Errore nella sottrazione' ).

    cl_abap_unit_assert=>assert_true(
      act = lv_success
      msg = 'Sottrazione fallita inaspettatamente' ).
  ENDMETHOD.

  METHOD test_multiplication.
    DATA: lv_result TYPE p DECIMALS 2,
          lv_error_msg TYPE string,
          lv_success TYPE abap_bool.

    lv_success = mo_calculator->calculate(
      iv_num1 = 7
      iv_operator = '*'
      iv_num2 = 6
      ev_result = lv_result
      ev_error_msg = lv_error_msg ).

    cl_abap_unit_assert=>assert_equals(
      act = lv_result
      exp = 42
      msg = 'Errore nella moltiplicazione' ).

    cl_abap_unit_assert=>assert_true(
      act = lv_success
      msg = 'Moltiplicazione fallita inaspettatamente' ).
  ENDMETHOD.

  METHOD test_division.
    DATA: lv_result TYPE p DECIMALS 2,
          lv_error_msg TYPE string,
          lv_success TYPE abap_bool.

    lv_success = mo_calculator->calculate(
      iv_num1 = 8
      iv_operator = '/'
      iv_num2 = 2
      ev_result = lv_result
      ev_error_msg = lv_error_msg ).

    cl_abap_unit_assert=>assert_equals(
      act = lv_result
      exp = 4
      msg = 'Errore nella divisione' ).

    cl_abap_unit_assert=>assert_true(
      act = lv_success
      msg = 'Divisione fallita inaspettatamente' ).
  ENDMETHOD.

  METHOD test_division_by_zero.
    DATA: lv_result TYPE p DECIMALS 2,
          lv_error_msg TYPE string,
          lv_success TYPE abap_bool.

    lv_success = mo_calculator->calculate(
      iv_num1 = 8
      iv_operator = '/'
      iv_num2 = 0
      ev_result = lv_result
      ev_error_msg = lv_error_msg ).

    cl_abap_unit_assert=>assert_false(
      act = lv_success
      msg = 'Divisione per zero non rilevata' ).

    cl_abap_unit_assert=>assert_not_initial(
      act = lv_error_msg
      msg = 'Messaggio di errore mancante per divisione per zero' ).
  ENDMETHOD.

  METHOD test_invalid_operator.
    DATA: lv_result TYPE p DECIMALS 2,
          lv_error_msg TYPE string,
          lv_success TYPE abap_bool.

    lv_success = mo_calculator->calculate(
      iv_num1 = 5
      iv_operator = '%'
      iv_num2 = 3
      ev_result = lv_result
      ev_error_msg = lv_error_msg ).

    cl_abap_unit_assert=>assert_false(
      act = lv_success
      msg = 'Operatore non valido non rilevato' ).

    cl_abap_unit_assert=>assert_not_initial(
      act = lv_error_msg
      msg = 'Messaggio di errore mancante per operatore non valido' ).
  ENDMETHOD.

ENDCLASS.
