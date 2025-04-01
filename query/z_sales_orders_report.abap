REPORT z_sales_orders_report.

" Parametri di input
PARAMETERS:
  p_date_from TYPE vbak-erdat OBLIGATORY, " Data inizio
  p_date_to   TYPE vbak-erdat OBLIGATORY. " Data fine

" Dati interni
DATA: lt_sales_orders TYPE TABLE OF vbak,
      lt_positions    TYPE TABLE OF vbap,
      lv_total_amount TYPE p DECIMALS 2.

" Selezione dei dati
START-OF-SELECTION.

  " Estrarre gli ordini di vendita nel range di date
  SELECT vbeln erdat kunnr netwr
    INTO TABLE lt_sales_orders
    FROM vbak
    WHERE erdat BETWEEN p_date_from AND p_date_to.

  " Controllo se ci sono dati
  IF lt_sales_orders IS INITIAL.
    WRITE: / 'Nessun ordine trovato nel range di date specificato.'.
    RETURN.
  ENDIF.

  " Loop sugli ordini per calcolare i dettagli
  LOOP AT lt_sales_orders INTO DATA(ls_order).
    CLEAR: lv_total_amount, lt_positions.

    " Estrarre le posizioni dell'ordine
    SELECT matnr kwmeng netwr
      INTO TABLE lt_positions
      FROM vbap
      WHERE vbeln = ls_order-vbeln.

    " Calcolare il totale dell'ordine
    LOOP AT lt_positions INTO DATA(ls_position).
      lv_total_amount = lv_total_amount + ls_position-netwr.
    ENDLOOP.

    " Stampare i dettagli dell'ordine
    WRITE: / 'Ordine:', ls_order-vbeln,
           'Cliente:', ls_order-kunnr,
           'Data:', ls_order-erdat,
           'Totale:', lv_total_amount.
  ENDLOOP.
END-OF-SELECTION.
