*&---------------------------------------------------------------------*
*& Class ZCL_DELIVERY_BLOCK_CONTROLLER
*&---------------------------------------------------------------------*
CLASS zcl_delivery_block_controller DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor,

      get_data
        IMPORTING
          iv_vkorg       TYPE vbak-vkorg
          it_auart       TYPE RANGE OF vbak-auart
          it_lifsk       TYPE RANGE OF vbak-lifsk
          iv_excl_credit TYPE abap_bool OPTIONAL,

      change_delivery_block
        IMPORTING
          iv_vbeln     TYPE vbak-vbeln
          iv_new_lifsk TYPE vbak-lifsk
        RETURNING
          VALUE(rv_success) TYPE abap_bool,

      get_sales_documents
        RETURNING
          VALUE(rt_documents) TYPE zcl_delivery_block_model=>tt_sales_doc.

  PRIVATE SECTION.
    DATA:
      mo_model TYPE REF TO zcl_delivery_block_model,
      mt_documents TYPE zcl_delivery_block_model=>tt_sales_doc.
ENDCLASS.

CLASS zcl_delivery_block_controller IMPLEMENTATION.
  METHOD constructor.
    " Initialize model
    CREATE OBJECT mo_model.
  ENDMETHOD.

  METHOD get_data.
    " Get data from model
    mt_documents = mo_model->get_sales_documents(
      iv_vkorg       = iv_vkorg
      it_auart       = it_auart
      it_lifsk       = it_lifsk
      iv_excl_credit = iv_excl_credit ).
  ENDMETHOD.

  METHOD change_delivery_block.
    " Update delivery block
    rv_success = mo_model->update_delivery_block(
      iv_vbeln     = iv_vbeln
      iv_new_lifsk = iv_new_lifsk ).

    " Refresh data if update was successful
    IF rv_success = abap_true.
      " Refresh the specific document in the internal table
      LOOP AT mt_documents ASSIGNING FIELD-SYMBOL(<ls_doc>) WHERE vbeln = iv_vbeln.
        <ls_doc>-lifsk = iv_new_lifsk.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.

  METHOD get_sales_documents.
    rt_documents = mt_documents.
  ENDMETHOD.
ENDCLASS.