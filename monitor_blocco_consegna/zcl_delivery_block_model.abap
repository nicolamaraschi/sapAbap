*&---------------------------------------------------------------------*
*& Class ZCL_DELIVERY_BLOCK_MODEL
*&---------------------------------------------------------------------*
CLASS zcl_delivery_block_model DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES: BEGIN OF ty_sales_doc,
             vbeln       TYPE vbak-vbeln,
             auart       TYPE vbak-auart,
             lifsk       TYPE vbak-lifsk,
             kunnr_ag    TYPE vbpa-kunnr,
             name1_ag    TYPE adrc-name1,
             kunnr_we    TYPE vbpa-kunnr,
             name1_we    TYPE adrc-name1,
             item_count  TYPE i,
           END OF ty_sales_doc.

    TYPES: tt_sales_doc TYPE TABLE OF ty_sales_doc.

    METHODS:
      get_sales_documents
        IMPORTING
          iv_vkorg          TYPE vbak-vkorg
          it_auart          TYPE RANGE OF vbak-auart
          it_lifsk          TYPE RANGE OF vbak-lifsk
          iv_excl_credit    TYPE abap_bool OPTIONAL
        RETURNING
          VALUE(rt_result)  TYPE tt_sales_doc,

      update_delivery_block
        IMPORTING
          iv_vbeln      TYPE vbak-vbeln
          iv_new_lifsk  TYPE vbak-lifsk
        RETURNING
          VALUE(rv_success) TYPE abap_bool.

  PRIVATE SECTION.
    METHODS:
      get_partner_data
        IMPORTING
          iv_vbeln      TYPE vbak-vbeln
          iv_parvw      TYPE vbpa-parvw
        EXPORTING
          ev_kunnr      TYPE vbpa-kunnr
          ev_name1      TYPE adrc-name1.
ENDCLASS.

CLASS zcl_delivery_block_model IMPLEMENTATION.
  METHOD get_sales_documents.
    DATA: lt_vbak  TYPE TABLE OF vbak,
          ls_vbak  TYPE vbak,
          ls_result TYPE ty_sales_doc.

    " Get sales document headers
    SELECT * FROM vbak INTO TABLE lt_vbak
      WHERE vkorg = iv_vkorg
      AND auart IN it_auart
      AND lifsk IN it_lifsk.

    " Exclude credit-blocked orders if requested
    IF iv_excl_credit = abap_true.
      DELETE lt_vbak WHERE cmps_cm = 'B'.
    ENDIF.

    " Process each document
    LOOP AT lt_vbak INTO ls_vbak.
      CLEAR ls_result.
      ls_result-vbeln = ls_vbak-vbeln.
      ls_result-auart = ls_vbak-auart.
      ls_result-lifsk = ls_vbak-lifsk.

      " Get sold-to party data
      get_partner_data(
        EXPORTING
          iv_vbeln = ls_vbak-vbeln
          iv_parvw = 'AG'
        IMPORTING
          ev_kunnr = ls_result-kunnr_ag
          ev_name1 = ls_result-name1_ag ).

      " Get ship-to party data
      get_partner_data(
        EXPORTING
          iv_vbeln = ls_vbak-vbeln
          iv_parvw = 'WE'
        IMPORTING
          ev_kunnr = ls_result-kunnr_we
          ev_name1 = ls_result-name1_we ).

      " Get item count
      SELECT COUNT(*) FROM vbap
        INTO ls_result-item_count
        WHERE vbeln = ls_vbak-vbeln.

      APPEND ls_result TO rt_result.
    ENDLOOP.
  ENDMETHOD.

  METHOD get_partner_data.
    DATA: ls_vbpa TYPE vbpa,
          ls_adrc TYPE adrc.

    SELECT SINGLE * FROM vbpa INTO ls_vbpa
      WHERE vbeln = iv_vbeln
      AND posnr = ''
      AND parvw = iv_parvw.

    IF sy-subrc = 0.
      ev_kunnr = ls_vbpa-kunnr.
      
      SELECT SINGLE * FROM adrc INTO ls_adrc
        WHERE addrnumber = ls_vbpa-adrnr.
        
      IF sy-subrc = 0.
        ev_name1 = ls_adrc-name1.
      ENDIF.
    ENDIF.
  ENDMETHOD.

  METHOD update_delivery_block.
    DATA: ls_order_header_in  TYPE bapisdh1,
          ls_order_header_inx TYPE bapisdh1x,
          lt_return           TYPE TABLE OF bapiret2.

    " Prepare input for BAPI
    ls_order_header_in-dlv_block = iv_new_lifsk.
    ls_order_header_inx-dlv_block = abap_true.
    ls_order_header_inx-updateflag = 'U'.

    " Call BAPI to update delivery block
    CALL FUNCTION 'BAPI_SALESORDER_CHANGE'
      EXPORTING
        salesdocument    = iv_vbeln
        order_header_in  = ls_order_header_in
        order_header_inx = ls_order_header_inx
      TABLES
        return           = lt_return.

    " Check for errors
    READ TABLE lt_return WITH KEY type = 'E' TRANSPORTING NO FIELDS.
    IF sy-subrc <> 0.
      " No errors, commit the changes
      CALL FUNCTION 'BAPI_TRANSACTION_COMMIT'
        EXPORTING
          wait = abap_true.
      rv_success = abap_true.
    ELSE.
      " Errors occurred, rollback
      CALL FUNCTION 'BAPI_TRANSACTION_ROLLBACK'.
      rv_success = abap_false.
    ENDIF.
  ENDMETHOD.
ENDCLASS.