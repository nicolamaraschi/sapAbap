*&---------------------------------------------------------------------*
*& Report ZMONITOR_DELIVERY_BLOCK
*&---------------------------------------------------------------------*
*& Monitor delivery blocks in sales documents
*&---------------------------------------------------------------------*
REPORT zmonitor_delivery_block.

*&---------------------------------------------------------------------*
*& Class ZCL_DELIVERY_BLOCK_VIEW
*&---------------------------------------------------------------------*
CLASS zcl_delivery_block_view DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS:
      constructor,

      display_selection_screen,

      display_results
        IMPORTING
          it_documents TYPE zcl_delivery_block_model=>tt_sales_doc,

      handle_user_command
        IMPORTING
          iv_ucomm TYPE syucomm
        RETURNING
          VALUE(rv_exit) TYPE abap_bool,

      modify_block_popup
        IMPORTING
          iv_vbeln           TYPE vbak-vbeln
        RETURNING
          VALUE(rv_new_lifsk) TYPE vbak-lifsk.

  PRIVATE SECTION.
    DATA:
      mo_alv       TYPE REF TO cl_salv_table,
      mo_controller TYPE REF TO zcl_delivery_block_controller.

    METHODS:
      prepare_alv
        IMPORTING
          io_alv TYPE REF TO cl_salv_table,

      on_user_command FOR EVENT added_function OF cl_salv_events
        IMPORTING e_salv_function.
ENDCLASS.

CLASS zcl_delivery_block_view IMPLEMENTATION.
  METHOD constructor.
    " Initialize controller
    CREATE OBJECT mo_controller.
  ENDMETHOD.

  METHOD display_selection_screen.
    " Selection screen parameters and select-options
    PARAMETERS:
      p_vkorg TYPE vbak-vkorg OBLIGATORY,
      p_excl  TYPE char1 AS CHECKBOX DEFAULT 'X'.

    SELECT-OPTIONS:
      s_auart FOR vbak-auart OBLIGATORY,
      s_lifsk FOR vbak-lifsk OBLIGATORY.

    " At selection screen end
    AT SELECTION-SCREEN.
      " Validate inputs if needed

    " After selection screen
    AT SELECTION-SCREEN OUTPUT.
      " Modify screen if needed
  ENDMETHOD.

  METHOD display_results.
    DATA: lo_functions TYPE REF TO cl_salv_functions_list.

    " Create ALV table
    TRY.
        cl_salv_table=>factory(
          IMPORTING
            r_salv_table = mo_alv
          CHANGING
            t_table      = it_documents ).

        " Configure ALV
        prepare_alv( mo_alv ).

        " Get functions and add our custom button
        lo_functions = mo_alv->get_functions( ).
        lo_functions->set_all( abap_true ).

        " Add custom button for changing delivery block
        lo_functions->add_function(
          name     = 'CHANGE_BLOCK'
          icon     = icon_change
          text     = 'Change Delivery Block'
          tooltip  = 'Change delivery block for selected document'
          position = if_salv_c_function_position=>right_of_salv_functions ).

        " Register handler for user commands
        SET HANDLER on_user_command FOR mo_alv->get_event( ).

        " Display ALV
        mo_alv->display( ).

      CATCH cx_salv_msg.
        MESSAGE 'Error creating ALV grid' TYPE 'E'.
    ENDTRY.
  ENDMETHOD.

  METHOD handle_user_command.
    DATA: lv_new_lifsk TYPE vbak-lifsk,
          lv_success   TYPE abap_bool,
          lt_selected  TYPE salv_t_row,
          lv_index     TYPE i,
          ls_document  TYPE zcl_delivery_block_model=>ty_sales_doc.

    " Get selected rows
    lt_selected = mo_alv->get_selections( )->get_selected_rows( ).

    IF lines( lt_selected ) <> 1.
      MESSAGE 'Please select exactly one document' TYPE 'I'.
      RETURN.
    ENDIF.

    " Get selected row
    READ TABLE lt_selected INTO lv_index INDEX 1.
    
    " Get document data
    DATA(lt_documents) = mo_controller->get_sales_documents( ).
    READ TABLE lt_documents INTO ls_document INDEX lv_index.
    
    " Process user command
    CASE iv_ucomm.
      WHEN 'CHANGE_BLOCK'.
        " Show popup for delivery block change
        lv_new_lifsk = modify_block_popup( ls_document-vbeln ).
        
        IF lv_new_lifsk IS NOT INITIAL.
          " Update delivery block
          lv_success = mo_controller->change_delivery_block(
            iv_vbeln     = ls_document-vbeln
            iv_new_lifsk = lv_new_lifsk ).
            
          IF lv_success = abap_true.
            MESSAGE 'Delivery block updated successfully' TYPE 'S'.
            " Refresh ALV
            mo_alv->refresh( ).
          ELSE.
            MESSAGE 'Error updating delivery block' TYPE 'E'.
          ENDIF.
        ENDIF.
        
      WHEN OTHERS.
        " Handle other commands
    ENDCASE.
  ENDMETHOD.

  METHOD modify_block_popup.
    DATA: lv_block TYPE vbak-lifsk.

    " Create popup for entering delivery block
    CALL FUNCTION 'POPUP_GET_VALUES'
      EXPORTING
        popup_title     = 'Modify Delivery Block'
        value1          = 'Delivery Block'
      IMPORTING
        value1          = lv_block
      EXCEPTIONS
        error_in_fields = 1
        OTHERS          = 2.

    IF sy-subrc = 0 AND lv_block IS NOT INITIAL.
      rv_new_lifsk = lv_block.
    ENDIF.
  ENDMETHOD.

  METHOD prepare_alv.
    DATA: lo_columns TYPE REF TO cl_salv_columns_table,
          lo_column  TYPE REF TO cl_salv_column.

    " Set column titles
    lo_columns = io_alv->get_columns( ).
    lo_columns->set_optimize( abap_true ).

    TRY.
        lo_column = lo_columns->get_column( 'VBELN' ).
        lo_column->set_short_text( 'Doc. #' ).
        lo_column->set_medium_text( 'Document' ).
        lo_column->set_long_text( 'Sales Document' ).

        lo_column = lo_columns->get_column( 'AUART' ).
        lo_column->set_short_text( 'Type' ).
        lo_column->set_medium_text( 'Doc Type' ).
        lo_column->set_long_text( 'Document Type' ).

        lo_column = lo_columns->get_column( 'LIFSK' ).
        lo_column->set_short_text( 'DlvBlck' ).
        lo_column->set_medium_text( 'Dlv Block' ).
        lo_column->set_long_text( 'Delivery Block' ).

        lo_column = lo_columns->get_column( 'KUNNR_AG' ).
        lo_column->set_short_text( 'Sold-to' ).
        lo_column->set_medium_text( 'Sold-to' ).
        lo_column->set_long_text( 'Sold-to Party' ).

        lo_column = lo_columns->get_column( 'NAME1_AG' ).
        lo_column->set_short_text( 'Name' ).
        lo_column->set_medium_text( 'Sold-to Name' ).
        lo_column->set_long_text( 'Sold-to Party Name' ).

        lo_column = lo_columns->get_column( 'KUNNR_WE' ).
        lo_column->set_short_text( 'Ship-to' ).
        lo_column->set_medium_text( 'Ship-to' ).
        lo_column->set_long_text( 'Ship-to Party' ).

        lo_column = lo_columns->get_column( 'NAME1_WE' ).
        lo_column->set_short_text( 'Name' ).
        lo_column->set_medium_text( 'Ship-to Name' ).
        lo_column->set_long_text( 'Ship-to Party Name' ).

        lo_column = lo_columns->get_column( 'ITEM_COUNT' ).
        lo_column->set_short_text( 'Items' ).
        lo_column->set_medium_text( 'Item Count' ).
        lo_column->set_long_text( 'Number of Items' ).

      CATCH cx_salv_not_found.
        " Handle exception
    ENDTRY.

    " Set selection mode
    io_alv->get_selections( )->set_selection_mode( if_salv_c_selection_mode=>row_column ).

    " Set display settings
    io_alv->get_display_settings( )->set_striped_pattern( abap_true ).
    io_alv->get_display_settings( )->set_list_header( 'Delivery Block Monitor' ).
  ENDMETHOD.

  METHOD on_user_command.
    " Handle ALV user commands
    handle_user_command( e_salv_function ).
  ENDMETHOD.
ENDCLASS.

*&---------------------------------------------------------------------*
*& Main Program
*&---------------------------------------------------------------------*
DATA:
  go_view       TYPE REF TO zcl_delivery_block_view,
  go_controller TYPE REF TO zcl_delivery_block_controller.

START-OF-SELECTION.
  " Create objects
  CREATE OBJECT go_view.
  CREATE OBJECT go_controller.

  " Display selection screen
  go_view->display_selection_screen( ).

  " Get data from controller
  go_controller->get_data(
    iv_vkorg       = p_vkorg
    it_auart       = s_auart[]
    it_lifsk       = s_lifsk[]
    iv_excl_credit = p_excl ).

  " Display results
  go_view->display_results( go_controller->get_sales_documents( ) ).