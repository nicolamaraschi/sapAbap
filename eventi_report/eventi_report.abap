*&---------------------------------------------------------------------*
*& Report Z_MULTI_SEARCH
*&---------------------------------------------------------------------*
*& Multiple Search Program for Materials, Sales Orders, Purchase Orders,
*& and Deliveries
*&---------------------------------------------------------------------*
REPORT z_multi_search.

************************************************************************
* SELECTION SCREEN
************************************************************************
PARAMETERS:
  p_mat RADIOBUTTON GROUP rb,
  p_odv RADIOBUTTON GROUP rb,
  p_oda RADIOBUTTON GROUP rb,
  p_con RADIOBUTTON GROUP rb DEFAULT 'X'.

* Material search fields
SELECT-OPTIONS: s_matnr FOR mara-matnr MODIF ID mat.

* Sales Order search fields
SELECT-OPTIONS: s_vbeln FOR vbak-vbeln MODIF ID odv.

* Purchase Order search fields
SELECT-OPTIONS: s_ebeln FOR ekko-ebeln MODIF ID oda.

* Delivery search fields
SELECT-OPTIONS: s_likp FOR likp-vbeln MODIF ID del.

************************************************************************
* AT SELECTION-SCREEN OUTPUT
************************************************************************
AT SELECTION-SCREEN OUTPUT.
  PERFORM control_screen_fields.

************************************************************************
* START-OF-SELECTION
************************************************************************
START-OF-SELECTION.
  CASE 'X'.
    WHEN p_mat.
      PERFORM get_material_data.
    WHEN p_odv.
      PERFORM get_sales_order_data.
    WHEN p_oda.
      PERFORM get_purchase_order_data.
    WHEN p_con.
      PERFORM get_delivery_data.
  ENDCASE.

*&---------------------------------------------------------------------*
*& Form CONTROL_SCREEN_FIELDS
*&---------------------------------------------------------------------*
*Questo form gestisce la visualizzazione dinamica dei campi di selezione sullo schermo.
FORM control_screen_fields.
  " Hide all selection options by default
  LOOP AT SCREEN.
    IF screen-group1 = 'MAT' OR
       screen-group1 = 'ODV' OR
       screen-group1 = 'ODA' OR
       screen-group1 = 'DEL'.
      screen-active = 0.
      MODIFY SCREEN.
    ENDIF.
  ENDLOOP.

  " Show only relevant fields based on radio button selection
  CASE 'X'.
    WHEN p_mat.
      " Show Material search fields
      LOOP AT SCREEN.
        IF screen-group1 = 'MAT'.
          screen-active = 1.
          MODIFY SCREEN.
        ENDIF.
      ENDLOOP.

    WHEN p_odv.
      " Show Sales Order search fields
      LOOP AT SCREEN.
        IF screen-group1 = 'ODV'.
          screen-active = 1.
          MODIFY SCREEN.
        ENDIF.
      ENDLOOP.

    WHEN p_oda.
      " Show Purchase Order search fields
      LOOP AT SCREEN.
        IF screen-group1 = 'ODA'.
          screen-active = 1.
          MODIFY SCREEN.
        ENDIF.
      ENDLOOP.

    WHEN p_con.
      " Show Delivery search fields
      LOOP AT SCREEN.
        IF screen-group1 = 'DEL'.
          screen-active = 1.
          MODIFY SCREEN.
        ENDIF.
      ENDLOOP.
  ENDCASE.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form GET_MATERIAL_DATA
*&---------------------------------------------------------------------*
*Recupera e visualizza i dati dei materiali
FORM get_material_data.
  DATA: lt_mara TYPE TABLE OF mara,
        ls_mara TYPE mara,
        ls_makt TYPE makt.

  " Get materials
  SELECT * FROM mara INTO TABLE lt_mara
    WHERE matnr IN s_matnr.

  " Display material data
  WRITE: / 'MATERIAL DATA:'.
  WRITE: / 'MATNR', 30 'MTART', 45 'MBRSH', 60 'MEINS', 75 'MAKTX'.
  ULINE.

  LOOP AT lt_mara INTO ls_mara.
    " Get material description in login language
    CLEAR ls_makt.
    SELECT SINGLE * FROM makt INTO ls_makt
      WHERE matnr = ls_mara-matnr
      AND spras = sy-langu.

    WRITE: / ls_mara-matnr, 30 ls_mara-mtart, 45 ls_mara-mbrsh, 60 ls_mara-meins, 75 ls_makt-maktx.
  ENDLOOP.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form GET_SALES_ORDER_DATA
*&---------------------------------------------------------------------*
*Recupera e visualizza i dati degli ordini di vendita:
FORM get_sales_order_data.
  DATA: lt_vbak TYPE TABLE OF vbak,
        ls_vbak TYPE vbak,
        lt_vbap TYPE TABLE OF vbap,
        ls_vbap TYPE vbap.

  " Get sales orders
  SELECT * FROM vbak INTO TABLE lt_vbak
    WHERE vbeln IN s_vbeln.

  " Display sales order header data
  WRITE: / 'SALES ORDER DATA:'.
  WRITE: / 'VBELN', 15 'ERDAT', 30 'ERZET', 45 'AUART', 60 'NETWR', 75 'WAERK'.
  ULINE.

  LOOP AT lt_vbak INTO ls_vbak.
    WRITE: / ls_vbak-vbeln, 15 ls_vbak-erdat, 30 ls_vbak-erzet, 45 ls_vbak-auart, 
           60 ls_vbak-netwr, 75 ls_vbak-waerk.

    " Get sales order items
    CLEAR lt_vbap.
    SELECT * FROM vbap INTO TABLE lt_vbap
      WHERE vbeln = ls_vbak-vbeln.

    " Display sales order item data
    WRITE: / '  Item Data:'.
    WRITE: / '  POSNR', 15 'MATNR', 45 'ARKTX'.
    ULINE.

    LOOP AT lt_vbap INTO ls_vbap.
      WRITE: / '  ', ls_vbap-posnr, 15 ls_vbap-matnr, 45 ls_vbap-arktx.
    ENDLOOP.
    SKIP 1.
  ENDLOOP.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form GET_PURCHASE_ORDER_DATA
*&---------------------------------------------------------------------*
*Recupera e visualizza i dati degli ordini di acquisto:
FORM get_purchase_order_data.
  DATA: lt_ekko TYPE TABLE OF ekko,
        ls_ekko TYPE ekko,
        lt_ekpo TYPE TABLE OF ekpo,
        ls_ekpo TYPE ekpo.

  " Get purchase orders
  SELECT * FROM ekko INTO TABLE lt_ekko
    WHERE ebeln IN s_ebeln.

  " Display purchase order header data
  WRITE: / 'PURCHASE ORDER DATA:'.
  WRITE: / 'EBELN', 15 'BUKRS', 30 'BSTYP', 45 'BSART', 60 'LIFNR', 75 'EKORG'.
  ULINE.

  LOOP AT lt_ekko INTO ls_ekko.
    WRITE: / ls_ekko-ebeln, 15 ls_ekko-bukrs, 30 ls_ekko-bstyp, 45 ls_ekko-bsart,
           60 ls_ekko-lifnr, 75 ls_ekko-ekorg.

    " Get purchase order items
    CLEAR lt_ekpo.
    SELECT * FROM ekpo INTO TABLE lt_ekpo
      WHERE ebeln = ls_ekko-ebeln.

    " Display purchase order item data
    WRITE: / '  Item Data:'.
    WRITE: / '  EBELP', 15 'MATNR', 45 'TXZ01'.
    ULINE.

    LOOP AT lt_ekpo INTO ls_ekpo.
      WRITE: / '  ', ls_ekpo-ebelp, 15 ls_ekpo-matnr, 45 ls_ekpo-txz01.
    ENDLOOP.
    SKIP 1.
  ENDLOOP.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form GET_DELIVERY_DATA
*&---------------------------------------------------------------------*
*Recupera e visualizza i dati delle consegne:
FORM get_delivery_data.
  DATA: lt_likp TYPE TABLE OF likp,
        ls_likp TYPE likp,
        lt_lips TYPE TABLE OF lips,
        ls_lips TYPE lips.

  " Get deliveries
  SELECT * FROM likp INTO TABLE lt_likp
    WHERE vbeln IN s_likp.

  " Display delivery header data
  WRITE: / 'DELIVERY DATA:'.
  WRITE: / 'VBELN', 15 'LFART', 30 'VSTEL', 45 'WADAT', 60 'INCO1', 75 'INCO2'.
  ULINE.

  LOOP AT lt_likp INTO ls_likp.
    WRITE: / ls_likp-vbeln, 15 ls_likp-lfart, 30 ls_likp-vstel, 45 ls_likp-wadat,
           60 ls_likp-inco1, 75 ls_likp-inco2.

    " Get delivery items
    CLEAR lt_lips.
    SELECT * FROM lips INTO TABLE lt_lips
      WHERE vbeln = ls_likp-vbeln.

    " Display delivery item data
    WRITE: / '  Item Data:'.
    WRITE: / '  POSNR', 15 'MATNR', 45 'LFIMG', 60 'MEINS'.
    ULINE.

    LOOP AT lt_lips INTO ls_lips.
      WRITE: / '  ', ls_lips-posnr, 15 ls_lips-matnr, 45 ls_lips-lfimg, 60 ls_lips-meins.
    ENDLOOP.
    SKIP 1.
  ENDLOOP.
ENDFORM.