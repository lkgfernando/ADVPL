#Include "Totvs.ch"


/*/{Protheus.doc} User Function FrImpNcm
    (long_description)
    @type  Function
    @author Fernando José Rodrigues
    @since 27/07/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function FrImpNcm()
    Local aArea := FWGetArea()

    If FWAlertYesNo("Deseja Atualizar a tabela de NCMs no Protheus?", "Continua")
        Processa( { || fImport() }, 'NCMs...' )
    EndIf

    FWRestArea(aArea)
Return 

/*/{Protheus.doc} fImport
    (long_description)
    @type  Static Function
    @author Fernando José Rodriuges
    @since 27/07/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function fImport()
    Local cLinkDown  := "https://portalunico.siscomex.gov.br/classif/api/publico/nomenclatura/download/json?perfil=PUBLICO"
    Local cTxtJSon   := ""
    Local cError     := ""
    Local jImport
    Local jNomenclat
    Local jNCMAtu
    Local nNCMAtu    := 0
    Local cCodigo    := ""
    Local cDescric   := ""
    Local aDados     := {}
    Local cLog       := ""
    Local nLinhaErro := 0

    //Variaveis para log ExecAuto
    Private lMSHelpAuto    := .T.
    Private lAutoErrNoFile := .T.
    Private lMsErroAuto    := .F.

    cTxtJson := HttpGet(cLinkDown)
    cTxtJson := FWNoAccent(cTxtJson)
    
    If ! Empty(cTxtJson)
        jImport := JsonObject():New()
        cError := jImport:FromJson(cTxtJson)
        

        DbSelectArea("SYD")
        SYD->(DbSetOrder(1))

        If Empty(cError)
            jNomenclat := jImport:GetJsonObject('Nomenclaturas')

            nTotal := Len(jNomenclat)
            ProcRegua(nTotal)

            For nNCMAtu := 1 To nTotal
                IncProc("Processando registro " + cValTochar(nNCMAtu) + " de " + cValToChar(nTotal) + "...")


                jNCMAtu := jNomenclat[nNCMAtu]
                cCodigo := jNCMAtu:GetJsonObject("Codigo")
                cDescric := jNCMAtu:GetJsonObject("Descricao")

                cCodigo  := StrTran(cCodigo, '.', "")  
                cDescric := StrTran(cDescric, "-", "")
                cDescric := StrTran(cDescric, "<i>", "")
                cDescric := StrTran(cDescric, "</i>", "")

                If Len(cCodigo) == 8 .And. ! SYD->(MsSeek(FWxFilial("SYD") + cCodigo))
                    aDados := {}
                    aAdd(aDados, {"YD_TEC", cCodigo,        Nil} )
                    aAdd(aDados, {"YD_DESC_P", cDescric,    Nil} )
                    aAdd(aDados, {"YD_UNID", "UN",          Nil} )

                    lMsErroAuto := .F.
                    MsExecAuto( {|x, y| MVC_EICA130(x, y)}, aDados, 3 )

                    If lMsErroAuto
                        cPastaErro := '\x_logs\'
                        cNomeErro := 'erro_syd_cod_' + cCodigo + "_" + dToS(Date()) + '_' + StrTran(Time(), ':','-') + '.txt'

                        If ! ExistDir(cPastaErro)
                            MakeDir(cPastaErro)
                        EndIf

                        cTextoErro := ""
                        cTextoErro += "Codigo:      " + cCodigo + CRLF
                        cTextoErro += "Descricao:   " + cDescric + CRLF
                        cTextoErro += "--" + CRLF + CRLF
                        aLogErro := GetAutoGRLog()

                        For nLinhaErro := 1 To Len(aLogErro)
                            cTextoErro += aLogErro[nLinhaErro] + CRLF
                        Next 

                        MemoWrite(cPastaErro + cNomeErro, cTextoErro)
                        cLog += '- Falha ao incluir o registro, codigo[' + cCodigo + '], veja o arquivo de log em ' + cPastaErro + cNomeErro + CRLF
                    Else
                        cLog += '+ Sucesso no Execauto no codigo ' + cCodigo + ';' + CRLF   
                    EndIf

                EndIf

            Next

            If ! Empty(cLog)
                cDirTmp := GetTempPath()
                cArqLog := 'importacao_' + dToS(Date()) + '_' + StrTran(Time(), ':', '-') + '.log'
                MemoWrite(cDirTmp + cArqLog, cLog)
                ShellExecute('OPEN', cArqLog, '', cDirTmp, 1)
            EndIf 
        Else
            FWAlertError("Houve um falha na converão do JSON:" + CRLF + cError, "Erro no Parse")
        EndIf
    EndIf

Return 
