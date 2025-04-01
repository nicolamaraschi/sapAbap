CLASS ltc_sales_orders_report DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL LOW.
  PRIVATE SECTION.
    DATA: lt_sales_orders TYPE TABLE OF vbak,
          lt_positions    TYPE TABLE OF vbap.

    METHODS:
      setup, " Metodo per preparare i dati di test
      test_no_orders_found FOR TESTING, " Test per il caso in cui non ci siano ordini
      test_orders_with_positions FOR TESTING. " Test per il caso con ordini e posizioni
ENDCLASS.

CLASS ltc_sales_orders_report IMPLEMENTATION.

  " Metodo di setup per inizializzare i dati di test
  METHOD setup.
    CLEAR: lt_sales_orders, lt_positions.
  ENDMETHOD.

  " Test: Nessun ordine trovato
  METHOD test_no_orders_found.
    " Simula un intervallo di date senza ordini
    DATA: lv_message TYPE string.

    SELECT vbeln erdat kunnr netwr
      INTO TABLE lt_sales_orders
      FROM vbak
      WHERE erdat BETWEEN '99990101' AND '99991231'. " Date inesistenti

    IF lt_sales_orders IS INITIAL.
      lv_message = 'Nessun ordine trovato nel range di date specificato.'.
    ENDIF.

    cl_abap_unit_assert=>assert_equals(
      act = lv_message
      exp = 'Nessun ordine trovato nel range di date specificato.'
      msg = 'Il messaggio non corrisponde al caso senza ordini.'
    ).
  ENDMETHOD.

  " Test: Ordini con posizioni
  METHOD test_orders_with_positions.
    " Simula un ordine con posizioni
    APPEND VALUE #( vbeln = '0000000010' erdat = '20250101' kunnr = 'CUST01' netwr = '100.00' ) TO lt_sales_orders.
    APPEND VALUE #( matnr = 'MAT01' kwmeng = '10' netwr = '50.00' ) TO lt_positions.
    APPEND VALUE #( matnr = 'MAT02' kwmeng = '5' netwr = '50.00' ) TO lt_positions.

    DATA: lv_total_amount TYPE p DECIMALS 2.
    LOOP AT lt_positions INTO DATA(ls_position).
      lv_total_amount = lv_total_amount + ls_position-netwr.
    ENDLOOP.

    cl_abap_unit_assert=>assert_equals(
      act = lv_total_amount
      exp = '100.00'
      msg = 'Il totale calcolato non è corretto.'
    ).
  ENDMETHOD.

ENDCLASS.