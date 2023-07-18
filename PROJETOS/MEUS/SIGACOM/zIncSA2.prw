#Include "Totvs.ch"
#Include "FWMVCDef.ch"


/*/{Protheus.doc} User Function zIncSA2
    (long_description)
    @type  Function
    @author Fernando José Rodrigues
    @since 29/06/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function zIncSA2()
    Local aArea := FWGetArea()
    Local aParam := {Space(70)}
    Local aPerg := {}
    Local aRet := {}
    Local aLido := {}

    aAdd( aPerg, {6, "Arquivo a Importar" , aParam[01], "", ".T.", "!Empty(MV_PAR01)", 70, .T., "Arquivo .CSV|*.CSV" } )

    If Parambox(aPerg, "Inclusão de Fornecedores SA2", @aRet)
        FWMsgRun(,{|| LerArquivo(aRet[1], @aLido) }, , "Lendo o arquivo, por favor aguarde!" )

    EndIf


    FWRestArea(aArea)
Return 

/*/{Protheus.doc} LerArquivo
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 29/06/2023
    @version 1.0
    @param cArquivo, aLido 
    @return Nil, , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function LerArquivo(cArquivo, aLido)
    Local aTemp := {}
    Local cBuffer := ""
    Local nCount := 0
    Local nErros := 0
    Local lErro := .F.
    Local cErro := "Foram encontrados erros, as linhas abaixo não serão importados, deseja continuar?" + CRLF


    FT_FUse( cArquivo )
    FT_FGoTopo()

    While !FT_FEOF()
        nCount++
        cBuffer := FT_FREADLN()
        aTemp := StrTokArr2( cBuffer, ";")
        aAux := Array( 10 )

        If Empty(aTemp)
            cErro += cValTochar(nCount) + Iif(nErros == 10, CRLF, "/")
            If nErros == 10
                nErros := 0
            else
                nErros++
            EndIf
        else
            aAux[1] := aTemp[1]
            aAux[2] := aTemp[2]
            aAux[3] := aTemp[3]
            aAux[4] := aTemp[4]
            aAux[5] := aTemp[5]
            aAux[6] := aTemp[6]
            aAux[7] := aTemp[7]
            aAux[8] := aTemp[8]
            aAux[9] := aTemp[9]
            aAux[10] := aTemp[10]

            aAdd( aLido, aAux )
        EndIf

        FT_FSKIP()
    End

    If lErro
        If !MsgYesNo(cErro)
            Return
        EndIf    
    EndIf

Return Nil
