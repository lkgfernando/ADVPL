#Include "Totvs.ch"

User Function FIN050INC()
Local aArray   := {}
Local cPrefix  := SuperGetMv("MS_PREFIXO", .F.,  "CRF")
Local cTipo    := SuperGetMv("MS_TIPO"   , .F.,  "DEP")
Local cNatur   := SuperGetMv("MS_NATUREZ", .F.,  "900.000")
Local cFornece := SuperGetMv("MS_FORNECE", .F.,  "000010")
Local cLoja    := SuperGetMv("MS_LOJAFOR", .F.,  "01")
 
Private lMsErroAuto := .F.

If FwAlertYesNo("Deseja realmente efetivar a movimentação?", "Efetivação Movimentos")

  If ZZ4->ZZ4_STATUS == "A"
 
    aArray := { { "E2_PREFIXO"  , cPrefix           , NIL },;
                { "E2_NUM"      , ZZ4->ZZ4_COD      , NIL },;
                { "E2_TIPO"     , cTipo             , NIL },;
                { "E2_NATUREZ"  , cNatur            , NIL },;
                { "E2_FORNECE"  , cFornece          , NIL },;
                { "E2_LOJA"     , cLoja             , NIL },;
                { "E2_EMISSAO"  , dDataBase         , NIL },;
                { "E2_VENCTO"   , dDataBase + 30    , NIL },;
                { "E2_VALOR"    , ZZ4->ZZ4_TOTAL    , NIL } }
    
        MsExecAuto( { |x,y,z| FINA050(x,y,z)}, aArray,, 3)  // 3 - Inclusao, 4 - Alteração, 5 - Exclusão
        If lMsErroAuto
          MostraErro()
        Else
          RecLock("ZZ4", .F.)
            ZZ4->ZZ4_STATUS := "E"
          ZZ4->(MsUnLock())
          FwAlertInfo("Título incluído com sucesso!")
        EndIf
        
    EndIf

  Else
    FwAlertInfo("Efetivação permitida apenas para movimentos abertos!", "Atenção")
  EndIf



 
Return
