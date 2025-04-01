class ltcl_calculator_test DEFINITION FINAL FOR TESTING
    RISK LEVEL HARMLESS
    DURATION SHORT.

    PRIVATION SECTION.
        DATA:
        mo_calculator TYPE REF TO zcl_calculator.

        METHODS:
                setup,
                test_addition FOR TESTING,
                test_subtraction FOR TESTING,
                test_multiplication FOR TESTING,
                test_division FOR TESTING,
                test_division_by_zero FOR TESTING,
ENDCLASS.

CLASS ltcl_calculator_test IMPLEMENTATION.
    METHOD setup.
        " crea instanza di test
        mo_calculator = NEW zcl_calculator().
    ENDMETHOD.

    METHOD test_addition.
        DATA(lv_a)=5.
        DATA(lv_b)=3.
        DATA(lv_expted_result)=8.

        DATA(lv_result) = mo_calculator->add(
            iv_a = lv_a
            iv_b = lv_b ).
        cl_abap_unit_assert=>assert_equals(
            exp = lv_expted_result
            act= lv_result
            msg= "errore addizione"
            ).       
    ENDMETHOD.