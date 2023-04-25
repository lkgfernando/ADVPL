#Include "Totvs.ch"
#Include "TopConn.ch"


/*/{Protheus.doc} User Function zAltSB1
    (long_description)
    @type  Function
    @author Fernando José Rodrigues
    @since 19/04/2023
    @version 1.0
    @param
    @return 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function zAltSB1()
    Local aArea  := FWGetArea()
    Local aParam :={Space(70)}
    Local aPerg  := {}
    Local aRet   := {}
    Local aLido  := {}

    aAdd( aPerg, {6, "Arquivo a Importar" , aParam[01], "", ".T.", "!Empty(MV_PAR01)", 70, .T., "Arquivo .CSV|*.CSV" } )

    If Parambox( aPerg, "Alteração Campo SB1", @aRet)

        //Leitura do Arquivo
        FWMsgRun(, {|| LerArquivo( aRet[1], @aLido ) }, , "Lendo o arquivo, por favor aguarde")

        If Len( aLido ) > 0
            If MsgYesNo("Exitem " + AllTrim(Str( Len(aLido) ) ) + " registro no arquivo deseja alterar a tabela SB1?" )
                Processa( {|| ProcSB1( aLido, aRet)}, "Fazendo alteração, Por favor aguarde...")
            EndIf
        EndIf

    EndIf

    FWRestArea(aArea)
Return Nil


/*/{Protheus.doc} LerArquivo
    (long_description)
    @type  Static Function
    @author Fernando José Rodrigues
    @since 19/04/2023
    @version 1+0
    @param cArquivo, aLido, , 
    @return , , 
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
    Local cErro := "Foram encontrados erros, as linhas abaixo não serão importadas, deseja continuar? " + CRLF

    FT_FUse( cArquivo )
    FT_FGoTop()

    While !FT_FEOF()
        nCount++
        cBuffer := FT_FREADLN()
        aTemp := StrToKarr( cBuffer, ";")
        aAux := Array( 09 )

        If Len(aTemp) < 2
            cErro += cValToChar(nCount)+ Iif(nErros == 10, CRLF ,  "/")
            If nErros == 10
                nErros := 0
            Else
                nErros++
            EndIf
            lErro := .T.
        Else
            If Len(aTemp) == 2
               
                aAux[1] := aTemp[1] //Codigo produto
                aAux[2] := aTemp[2] //Campo a ser alterado

            
            EndIf

            If Len(aTemp) == 3
                aAux[1] := aTemp[1] //Filial
                aAux[2] := aTemp[2] //Codigo do produto
                aAux[3] := aTemp[3] //Campo a ser alterado
            EndIf
            
            aAdd( aLido, aAux )
        EndIf

        FT_FSkip()
    End
    
    If lErro
        If !MsgYesNo(cErro)
            Return
        EndIf
    EndIf

Return Nil


/*/{Protheus.doc} ProcSB1
    (long_description)
    @type  Static Function
    @author Fernando José Rodrigues
    @since 19/04/2023
    @version 1.0
    @param aLido, aRet, , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function ProcSB1(aLido, aRet)
    //Local cFilSB1   := ""
    Local cProduto  := ""
    Local cOrigem   := ""
    Local cLinha    := ""
    Local lErro     := .F.

    Local cMensagem := ""
    Local aDados    := {}
    Local aLogs     := {}
    Local nX        := 0

    ProcRegua( Len(aLido) )

    //aLido := ASort(aLido, , , { |x, y| x[1] + x[4] < y[1] + y[4]})

    For nX := 1 To Len(aLido)
        aDados := {}
        lErro := .F.
        cLinha := AllTrim( Str(nX) )
        //cFilSB1 := PadL( aLido[nX][1], TamSX3("B1_FILIAL")[1] )
        cProduto := PadR( aLido[nX][1], TamSX3("B1_COD")[1])
        cOrigem := PadR( aLido[nX][2], TamSX3("B1_ORIGEM")[1])
       

         IncProc( "Alterando Produtos: " + cProduto)

         ProcessMessage()
        
        DbSelectArea('SB1')
        SB1->(DbSetOrder(1))
        
        If SB1->(DbSeek(FWFilial('SB1') + cProduto))


            If SB1->B1_MSBLQL <> "1"

                RecLock('SB1', .F.)
                    SB1->B1_ORIGEM := cOrigem
                SB1->(MSUnlock())

            Else
                cMensagem := "Produto " + AllTrim(cProduto) + " está com bloqueio para uso "
                lErro := .T.
                aAdd( aLogs, {lErro, "Linha: " + cLinha, cMensagem})
            
            EndIf

        Else    
            
            lErro := .T.
            cMensagem := "Produto " + AllTrim(cProduto) + " não cadastrado"
            
        EndIf

        If !lErro
            cMensagem := "Produto " + AllTrim(cProduto) + " alterado com sucesso"
        EndIf

        aAdd( aLogs, {lErro, "Linha: " + cLinha, cMensagem})

    Next nX


    If Len( aLogs ) > 0
        MostraLog( aLogs )
    EndIf

   

Return Nil


/*/{Protheus.doc} MostraLgo
    (long_description)
    @type  Static Function
    @author Fernando José Rodrigues
    @since 20/04/2023
    @version 1.0
    @param aLogs, , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function MostraLog(aLogs)
    Local oFontL := TFont():New("Tahoma", , -12, , .T., , , , , .F., .F.)
    Local cMask := "Arquivos Texto" + "(*.TXT)|*.txt|"
    Local cMemo := ""
    Local cFile := ""
   // Local cTexto := ""
    Local oBtnSair 
    Local oGrpLog
    Local oPanelB
    Local oMemo
    Local oDlgLog
    

    DEFINE MSDIALOG oDlgLog TITLE "Log de Alteração SB1" FROM 000, 000 TO 400, 700 COLORS 0, 16777215 PIXEL

    @ 182, 000 MSPANEL oPanelB SIZE 350, 017 OF oDlgLog COLORS 0, 16777215 RAISED
    oPanelB:Align := CONTROL_ALIGN_BOTTOM

    @ 002, 002 LISTBOX oLogs Fields HEADER, "", "Linha do Arquivo" SIZE 100, 176 OF oDlgLog PIXEL ColSizes 50,50
    oLogs:SetArray(aLogs)
    oLogs:bChange := {|| cMemo := aLogs[oLogs:nAt, 3], oMemo:Refresh()}
    oLogs:bLine := {|| {;
                        IF(aLogs[oLogs:nAt, 1], LoadBitmap( GetResources(), "BR_VERMELHO" ), LoadBitmap( GetResources(), "BR_VERDE" ) ), ;
                            aLogs[oLogs:nAt,2];
                            }}
    @ 001, 105 GROUP oGrpLog TO 178, 350 PROMPT " Log do Processamento " OF oDlgLog COLOR 0, 16777215 PIXEL
    @ 009, 107 GET oMemo VAR cMemo OF oDlgLog MULTILINE SIZE 240, 166 COLORS 0, 16777215 HSCROLL PIXEL Font oFontL
    DEFINE SBUTTON oBtnSair FROM 185, 150 TYPE 01 OF oDlgLog ENABLE Action( oDlgLog:End() )
    DEFINE SBUTTON oBtnSave FROM 185, 180 TYPE 13 OF oDlgLog ENABLE Action( cFile := cGetFile( cMask, ""), If( Empty(cFile), .T., GrvLog(aLogs, cFile) ) )

    ACTIVATE MSDIALOG oDlgLog CENTERED

Return 
