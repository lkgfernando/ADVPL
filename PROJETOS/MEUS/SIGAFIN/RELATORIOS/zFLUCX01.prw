#Include "Totvs.ch"
#Include "ApWizard.ch"


Static cNomeArq := "RELATORIO_FLUXOCAIXA"
/*/{Protheus.doc} zFLUCX01
Relatorio de fluxo de caixa
@type user function
@author Fernando Rodrigues
@since 15/05/2024
@version 12/Sup
@param , , 
@return , , 
@example
(examples)
@see (links_or_references)
/*/
User Function zFLUCX01()
	Local aArea := FwGetArea()
	Local oWizard
	Local aParambox := {}
	Local lOk := .F.
	Local cNomeEmpr := ""

	AjustaSXB()


	DEFINE WIZARD oWizard ;
		TITLE "Relatório gerencial do financeiro" ;
		HEADER "Fluxo de Caixa" ;
		MESSAGE "Avance para continuar";
		TEXT "Estre procedimento irá gerar em <b>planilha eletrônica</b> no formato excel, o relatório de Fluxo de Caixa" PANEL;
	NEXT {|| .T.  } ;
	FINISH {|| .T.} ;

CREATE PANEL oWizard ;
	HEADER "Fluxo de Caixa" ;
	MESSAGE "Informe os parâmetro para extração do relatório" PANEL ;
	NEXT {|| ConfProcess()} ;
	FINISH {|| ConfProcess()} ;
	PANEL

CREATE PANEL oWizard HEADER "Fluxo de Caixa";
	MESSAGE "Informe os dados que compõe o fluxo" PANEL;
	BACK {|| .T.} ;
	NEXT {|| lOk := MsgYesNo("Confirma a Geração do Fluxo"), lOk };
	FINISH {|| lOk := MsgYesNo("Cofirma a Geração do Fluxo"), lOk }


ACTIVATE WIZARD oWizard CENTERED

FwRestArea(aArea)
Return


/*/{Protheus.doc} ConfProcess
  (long_description)
  @type  Static Function
  @author Fernando Rodrigues
  @since 15/05/2024
  @version 12/sup
  @param , , 
  @return lRet, , 
  @example
  (examples)
  @see (links_or_references)
/*/
Static Function ConfProcess()
	Local lRet := .T.

Return lRet


/*/{Protheus.doc} AjustaSXB
  (long_description)
  @type  Static Function
  @author Fernando Rodrigues
  @since 15/05/2024
  @version 12/Sup
  @param , , 
  @return , , 
  @example
  (examples)
  @see (links_or_references)
/*/
Static Function AjustaSXB()
	Local aArea := FwGetArea()
	Local aSXB := {}
	Local aEstrut := {}
	Local i,j

	aEstrut := {"XB_ALIAS"  , "XB_TIPO"   , "XB_SEQ", "XB_COLUNA" , "XB_DESCRI"                   , "XB_DESCSPA"                    , "XB_DESCENG"                  , "XB_CONTEM"}

	aAdd(aSXB, {"MCPFN"     , "1"         , "01"    , "RE"        , "Pasta da Gravaçao da Planilha", "Pasta da Gravaçao da Planilha", "Pasta da Gravaçao da Planilha", "SA3"          } )
	aAdd(aSXB, {"MCPFN"     , "2"         , "01"    , "01"        , ""                             , ""                             , ""                             ,  ".T."         } )
	aAdd(aSXB, {"MCPFN"     , "5"         , "01"    , ""          , ""                             , ""                             , ""                             ,"u_InGetPfn10()"} )

	For i := 1 To Len(aSXB)

		If !Empty(aSXB[i][1])
			If !DbSeek(PadR(aSXB[i,1], Len(SXB->XB_ALIAS)) + PadR(aSXB[i,2], Len(SXB->XB_TIPO)) + PadR(aSXB[i,3], Len(SXB->XB_SEQ)) + PadR(aSXB[i,4], Len(SXB->XB_COLUNA)))
				RecLock("SXB", .T.)
			Else
				RecLock("SXB", .F.)
			EndIf
			For j := 1 To Len(aSXB[i])
				If !Empty(FieldName(FieldPos(aEstrut[j])))
					FieldPut(FieldPos(aEstrut[j]), aSXB[i,j])
				EndIf
			Next j
		EndIf

	Next i

	FwRestArea(aArea)

Return

/*/{Protheus.doc} InGetPfn10
(long_description)
@type user function
@author Fernando Rodrigues
@since 15/05/2024
@version 12/Sup
@param , , 
@return , , 
@example
(examples)
@see (links_or_references)
/*/
User Function InGetPfn10()
	Local cPasta := ""

	cPasta := AllTrim(cGetFile("Direório", "Diretório para gravação da planilha", , , .T., nOr(GETF_LOCALHARD , GETF_RETDIRECTORY , GETF_NETWORKDRIVE), .F.))
	aRetParam[05] := cPasta
Return
