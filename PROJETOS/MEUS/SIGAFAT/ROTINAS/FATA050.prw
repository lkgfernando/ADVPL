#Include "Totvs.ch"
#Include "Topconn.ch"

/*/{Protheus.doc} FATA050
    Consulta de Status de NF-e diretamente na SEFAZ.
    Exibe tela de parametros (SX1/Pergunte), filtra NF-es na SF2
    pelo intervalo de data e numero informado, consulta o status
    atual na SEFAZ via chave de acesso (F2_CHVNFE) e exibe os
    resultados em browse.

    @type  User Function
    @author Gerado por IA (Claude Code)
    @since 12/03/2026
    @version 1.0
    @param  Nenhum
    @return Nil
    @see    fConsultaStatusNFe, fMontaResultados, fExibeResultados
/*/
User Function FATA050()

    Local aArea      := GetArea()
    Local cPerg      := "FATA050"
    Local aResultados := {}

    ValidPerg()

    If !Pergunte(cPerg, .T.)
        RestArea(aArea)
        Return Nil
    EndIf

    aResultados := fMontaResultados()

    If Len(aResultados) == 0
        MsgInfo("Nenhuma NF-e encontrada para os parametros informados.", "FATA050 - Consulta Status NF-e")
    Else
        fExibeResultados(aResultados)
    EndIf

    RestArea(aArea)

Return Nil

/*/{Protheus.doc} ValidPerg
    Cria/valida os registros de perguntas no SX1 para o grupo "FATA050".
    Garante que as perguntas existam antes de chamar Pergunte().

    @type  Static Function
    @author Gerado por IA (Claude Code)
    @since 12/03/2026
    @version 1.0
    @return Nil
/*/
Static Function ValidPerg()

    Local aArea   := GetArea()
    Local aPergs  := {}
    Local aItem   := {}
    Local nI      := 0
    Local cGrupo  := "FATA050"
    Local cOrdem  := ""

    // {ordem, pergunta, tipo, tamanho, decimal, valid, usado, help, default}
    aAdd(aPergs, {"01", "Data Emissao De      ?", "D", 8 , 0, "", "", "Data de emissao inicial para filtro", dToS(Date())          })
    aAdd(aPergs, {"02", "Data Emissao Ate     ?", "D", 8 , 0, "", "", "Data de emissao final para filtro",   dToS(Date())          })
    aAdd(aPergs, {"03", "NF De                ?", "C", 9 , 0, "", "", "Numero da NF-e inicial para filtro",  Space(9)              })
    aAdd(aPergs, {"04", "NF Ate               ?", "C", 9 , 0, "", "", "Numero da NF-e final para filtro",    Replicate(Chr(255), 9)})
    aAdd(aPergs, {"05", "Cliente De           ?", "C", 6 , 0, "", "", "Codigo do cliente inicial",           Space(6)              })
    aAdd(aPergs, {"06", "Cliente Ate          ?", "C", 6 , 0, "", "", "Codigo do cliente final",             Replicate(Chr(255), 6)})

    Begin Sequence

        DbSelectArea("SX1")
        DbSetOrder(1) // X1_GRPDESC

        For nI := 1 To Len(aPergs)
            aItem  := aPergs[nI]
            cOrdem := aItem[1]

            DbSeek(xChave("SX1", cGrupo + cOrdem))

            If SX1->(!Found()) .Or. SX1->(X1_GRPDESC) <> cGrupo .Or. SX1->(X1_ORDEM) <> cOrdem

                RecLock("SX1", .T.) // .T. = novo registro

                    SX1->X1_GRPDESC := cGrupo
                    SX1->X1_ORDEM   := cOrdem
                    SX1->X1_PERGUNT := aItem[2]
                    SX1->X1_TIPO    := aItem[3]
                    SX1->X1_TAMANHO := aItem[4]
                    SX1->X1_DECIMAL := aItem[5]
                    SX1->X1_VALID   := aItem[6]
                    SX1->X1_USADO   := aItem[7]
                    SX1->X1_HELP    := aItem[8]
                    SX1->X1_DEF     := aItem[9]
                    SX1->X1_GSC     := "G"

                MsUnlock()

            EndIf

        Next nI

    Recover

        // Falha silenciosa — Pergunte() usara defaults proprios
        // se SX1 nao puder ser gravado (ex: permissao)

    End Sequence

    RestArea(aArea)

Return Nil

/*/{Protheus.doc} fMontaResultados
    Executa query BeginSQL em SF2 (LEFT JOIN SA1) aplicando os filtros
    dos parametros informados pelo usuario (MV_PAR01..MV_PAR06).
    Retorna array com uma linha por NF-e encontrada.

    @type  Static Function
    @author Gerado por IA (Claude Code)
    @since 12/03/2026
    @version 1.0
    @return Array — cada elemento: {cDoc, cSerie, cEmissao, cCliente, cLoja, cNome, cChvNfe, cNfEsta, nValBrut}
/*/
Static Function fMontaResultados()

    Local aArea      := GetArea()
    Local aResultados := {}
    Local cDoc       := ""
    Local cSerie     := ""
    Local cEmissao   := ""
    Local cCliente   := ""
    Local cLoja      := ""
    Local cNome      := ""
    Local cChvNfe    := ""
    Local cNfEsta    := ""
    Local nValBrut   := 0

    Begin Sequence

        BeginSql Alias "QNFE"
            SELECT SF2.F2_DOC     , SF2.F2_SERIE  , SF2.F2_EMISSAO ,
                   SF2.F2_CLIENTE , SF2.F2_LOJA    , SA1.A1_NOME    ,
                   SF2.F2_CHVNFE  , SF2.F2_NFESTA  , SF2.F2_VALBRUT
            FROM   %table:SF2% SF2
            LEFT JOIN %table:SA1% SA1
                ON  SA1.A1_COD    = SF2.F2_CLIENTE
                AND SA1.A1_LOJA   = SF2.F2_LOJA
                AND SA1.A1_FILIAL = %xFilial:SA1%
                AND SA1.D_E_L_E_T_ <> '*'
            WHERE  SF2.F2_FILIAL   = %xFilial:SF2%
              AND  SF2.F2_EMISSAO BETWEEN %exp:dToS(MV_PAR01)% AND %exp:dToS(MV_PAR02)%
              AND  SF2.F2_DOC     BETWEEN %exp:MV_PAR03%       AND %exp:MV_PAR04%
              AND  SF2.F2_CLIENTE BETWEEN %exp:MV_PAR05%       AND %exp:MV_PAR06%
              AND  SF2.F2_CHVNFE  <> ''
              AND  SF2.D_E_L_E_T_ <> '*'
            ORDER BY SF2.F2_EMISSAO, SF2.F2_DOC
        EndSql

        QNFE->(DbGoTop())

        While QNFE->(!EOF())

            cDoc     := AllTrim(QNFE->F2_DOC)
            cSerie   := AllTrim(QNFE->F2_SERIE)
            cEmissao := AllTrim(QNFE->F2_EMISSAO)
            cCliente := AllTrim(QNFE->F2_CLIENTE)
            cLoja    := AllTrim(QNFE->F2_LOJA)
            cNome    := AllTrim(QNFE->A1_NOME)
            cChvNfe  := AllTrim(QNFE->F2_CHVNFE)
            cNfEsta  := AllTrim(QNFE->F2_NFESTA)
            nValBrut := QNFE->F2_VALBRUT

            aAdd(aResultados, {cDoc, cSerie, cEmissao, cCliente, cLoja, cNome, cChvNfe, cNfEsta, nValBrut})

            QNFE->(DbSkip())

        EndDo

        QNFE->(DbCloseArea())

    Recover

        // Em caso de erro na query, retorna array vazio
        aResultados := {}

    End Sequence

    RestArea(aArea)

Return aResultados

/*/{Protheus.doc} fConsultaStatusNFe
    Consulta o status atual de uma NF-e diretamente na SEFAZ
    usando a chave de acesso de 44 digitos (F2_CHVNFE).

    Tenta em ordem:
      1. FWNFeSitNF(cChave)     — funcao framework padrao (P12+)
      2. NFECONSULTA(cChave)    — fallback versoes anteriores
      3. Retorno local (F2_NFESTA) se ambos falharem

    @type  Static Function
    @author Gerado por IA (Claude Code)
    @since 12/03/2026
    @version 1.0
    @param  cChave  Character — Chave de acesso NF-e (44 caracteres)
    @param  cNfEsta Character — Status local da NF-e (F2_NFESTA): "1", "2", "3"
    @return Character — Descricao do status obtido
/*/
Static Function fConsultaStatusNFe(cChave, cNfEsta) As Character

    Local cStatus   := ""
    Local xRetorno  := Nil
    Local nCodRet   := 0

    If Empty(cChave) .Or. Len(AllTrim(cChave)) <> 44
        Return "Chave invalida"
    EndIf

    // --- Tentativa 1: FWNFeSitNF (Protheus 12 framework) ---
    Begin Sequence

        If ExistBlock("FWNFeSitNF")
            xRetorno := ExecBlock("FWNFeSitNF", .F., .F., {cChave})
        ElseIf Type("FWNFeSitNF()") <> "U"
            xRetorno := FWNFeSitNF(cChave)
        Else
            Break
        EndIf

    Recover

        xRetorno := Nil

    End Sequence

    // --- Tentativa 2: NFECONSULTA (versoes anteriores) ---
    If xRetorno == Nil

        Begin Sequence

            If ExistBlock("NFECONSULTA")
                xRetorno := ExecBlock("NFECONSULTA", .F., .F., {cChave})
            ElseIf Type("NFECONSULTA()") <> "U"
                xRetorno := NFECONSULTA(cChave)
            EndIf

        Recover

            xRetorno := Nil

        End Sequence

    EndIf

    // --- Interpretacao do retorno ---
    If xRetorno <> Nil

        If ValType(xRetorno) == "N"
            nCodRet := xRetorno
        ElseIf ValType(xRetorno) == "C"
            nCodRet := Val(xRetorno)
        EndIf

        Do Case
            Case nCodRet == 100  ; cStatus := "Autorizada"
            Case nCodRet == 101  ; cStatus := "Cancelada"
            Case nCodRet == 110  ; cStatus := "Denegada"
            Case nCodRet == 217  ; cStatus := "Nao encontrada"
            Case nCodRet == 301  ; cStatus := "Uso denegado"
            Case nCodRet == 302  ; cStatus := "Rejeicao"
            Case nCodRet >   0   ; cStatus := "Status: " + AllTrim(Str(nCodRet))
            Otherwise
                If ValType(xRetorno) == "C" .And. !Empty(xRetorno)
                    cStatus := AllTrim(xRetorno)
                Else
                    cStatus := "Retorno desconhecido"
                EndIf
        EndCase

    Else

        // Fallback: usa status local (F2_NFESTA)
        Do Case
            Case cNfEsta == "1" ; cStatus := "Autorizada (local)"
            Case cNfEsta == "2" ; cStatus := "Cancelada (local)"
            Case cNfEsta == "3" ; cStatus := "Denegada (local)"
            Otherwise           ; cStatus := "Nao consultado"
        EndCase

    EndIf

Return cStatus

/*/{Protheus.doc} fExibeResultados
    Exibe os resultados da consulta em um browse modal (aTBrowse/FWBrowse).
    Para cada linha, consulta o status na SEFAZ via fConsultaStatusNFe().

    Colunas exibidas:
      NF | Serie | Emissao | Cliente | Nome | Chave NF-e | Status Local | Status SEFAZ | Valor

    @type  Static Function
    @author Gerado por IA (Claude Code)
    @since 12/03/2026
    @version 1.0
    @param  aResultados Array — retorno de fMontaResultados()
    @return Nil
/*/
Static Function fExibeResultados(aResultados)

    Local aDados    := {}
    Local aHeader   := {}
    Local aRow      := {}
    Local aLinha    := {}
    Local nI        := 0
    Local cStatusSefaz := ""
    Local cTitulo   := "Consulta Status NF-e - SEFAZ"

    // --- Monta cabecalho ---
    // {titulo, largura, picture}
    aAdd(aHeader, {"NF"          , 10, "@!"    })
    aAdd(aHeader, {"Serie"       ,  5, "@!"    })
    aAdd(aHeader, {"Emissao"     , 10, "@D"    })
    aAdd(aHeader, {"Cliente"     ,  8, "@!"    })
    aAdd(aHeader, {"Nome"        , 25, "@!"    })
    aAdd(aHeader, {"Chave NF-e"  , 20, "@!"    })
    aAdd(aHeader, {"Status Local",  6, "@!"    })
    aAdd(aHeader, {"Status SEFAZ", 18, "@!"    })
    aAdd(aHeader, {"Valor"       , 14, "@E 9.2"})

    // --- Monta dados consultando SEFAZ ---
    For nI := 1 To Len(aResultados)

        aRow  := aResultados[nI]

        // aRow = {cDoc, cSerie, cEmissao, cCliente, cLoja, cNome, cChvNfe, cNfEsta, nValBrut}
        cStatusSefaz := fConsultaStatusNFe(aRow[7], aRow[8])

        aLinha := {}
        aAdd(aLinha, PadR(aRow[1], 9))                              // NF
        aAdd(aLinha, PadR(aRow[2], 3))                              // Serie
        aAdd(aLinha, CToD(SubStr(aRow[3], 7, 2) + "/" + ;          // Emissao (AAAAMMDD -> Date)
                          SubStr(aRow[3], 5, 2) + "/" + ;
                          SubStr(aRow[3], 1, 4)))
        aAdd(aLinha, PadR(aRow[4] + "-" + aRow[5], 9))             // Cliente-Loja
        aAdd(aLinha, PadR(aRow[6], 25))                             // Nome
        aAdd(aLinha, PadR(Left(aRow[7], 20), 20))                   // Chave (truncada p/ display)
        aAdd(aLinha, PadR(aRow[8], 6))                              // Status Local
        aAdd(aLinha, PadR(cStatusSefaz, 18))                        // Status SEFAZ
        aAdd(aLinha, aRow[9])                                       // Valor

        aAdd(aDados, aLinha)

    Next nI

    // --- Exibe em browse ---
    fExibeBrowse(cTitulo, aHeader, aDados)

Return Nil

/*/{Protheus.doc} fExibeBrowse
    Monta e exibe um dialogo modal com aTBrowse contendo
    os dados da consulta de NF-e.

    @type  Static Function
    @author Gerado por IA (Claude Code)
    @since 12/03/2026
    @version 1.0
    @param  cTitulo  Character — Titulo da janela
    @param  aHeader  Array     — Definicoes de colunas {titulo, largura, picture}
    @param  aDados   Array     — Linhas de dados a exibir
    @return Nil
/*/
Static Function fExibeBrowse(cTitulo, aHeader, aDados)

    Local oDlg    := Nil
    Local oBrw    := Nil
    Local oBtnFec := Nil
    Local nLin    := 0
    Local nPosCol := 0
    Local nI      := 0
    Local nDlgW   := 900
    Local nDlgH   := 500
    Local nBrwT   := 5
    Local nBrwL   := 5
    Local nBrwB   := 455
    Local nBrwR   := 890
    Local nCurRow := 1

    DEFINE MSDIALOG oDlg TITLE cTitulo FROM 0, 0 TO nDlgH, nDlgW PIXEL

        @ nBrwT, nBrwL TBROWSE oBrw ;
            OF oDlg ;
            TO nBrwB - 30, nBrwR ;
            PIXEL

        // Adiciona colunas
        nPosCol := 0
        For nI := 1 To Len(aHeader)
            oBrw:AddColumn(TBColumn():New(aHeader[nI][1], ;
                           {|| If(nCurRow >= 1 .And. nCurRow <= Len(aDados), ;
                                  aDados[nCurRow][nI], ;
                                  "")} ))
            oBrw:aColumns[nI]:nWidth  := aHeader[nI][2] * 7  // pixels aproximados
            nPosCol += aHeader[nI][2]
        Next nI

        // Navegacao do browse
        oBrw:GoTopBlock    := {|| nCurRow := 1}
        oBrw:GoBottomBlock := {|| nCurRow := Max(1, Len(aDados))}
        oBrw:SkipBlock     := {|n| nLin := 0, ;
                                   If(n > 0, ;
                                      If(nCurRow < Len(aDados), (nCurRow++, nLin := 1), nLin := 0), ;
                                      If(nCurRow > 1,           (nCurRow--, nLin := -1), nLin := 0)), ;
                                   nLin}

        @ nBrwB - 22, nDlgW / 2 - 30 BUTTON oBtnFec PROMPT "Fechar" ;
            OF oDlg ;
            ACTION oDlg:End() ;
            PIXEL

    ACTIVATE MSDIALOG oDlg CENTERED

Return Nil
