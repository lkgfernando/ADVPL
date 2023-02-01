//Bibliotecas
#Include "Totvs.ch"
#Include "FWMVCDef.ch"
#Include "Topconn.ch"

/*/{Protheus.doc} User Function zEXMARK
Exemplo para MarkBrowse
@author Fernando Jose Rodrigues
@since 07/12/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function zEXMARK()
	Local aArea := FWGetArea()
	Local aPergs   := {}
	Local xPar0 := sToD("")
	Local xPar1 := sToD("")
	
	//Adicionando os parametros do ParamBox
	aAdd(aPergs, {1, "Data De", xPar0,  "", ".T.", "", ".T.", 80,  .T.})
	aAdd(aPergs, {1, "Data At�", xPar1,  "", ".T.", "", ".T.", 80,  .T.})
	
	//Se a pergunta for confirma, chama a tela
	If ParamBox(aPergs, "Informe os parametros")
		fMontaTela()
	EndIf
	
	FWRestArea(aArea)
Return

/*/{Protheus.doc} fMontaTela
Monta a tela com a marca��o de dados
@author Fernando Jose Rodrigues
@since 07/12/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fMontaTela()
    Local aArea         := GetArea()
    Local aCampos := {}
    Local oTempTable := Nil
    Local aColunas := {}
    Local cFontPad    := 'Tahoma'
    Local oFontGrid   := TFont():New(cFontPad,,-14)
    //Janela e componentes
    Private oDlgMark
    Private oPanGrid
    Private oMarkBrowse
    Private cAliasTmp := GetNextAlias()
    Private aRotina   := MenuDef()
    //Tamanho da janela
    Private aTamanho := MsAdvSize()
    Private nJanLarg := aTamanho[5]
    Private nJanAltu := aTamanho[6]
     
    //Adiciona as colunas que ser�o criadas na tempor�ria
    aAdd(aCampos, { 'OK', 'C', 2, 0}) //Flag para marca��o
    aAdd(aCampos, { 'ZD1_CODIGO', 'C', 6, 0}) //CODIGO
    aAdd(aCampos, { 'ZD1_NOME', 'C', 100, 0}) //NOME ARTISTA

    //Cria a tabela tempor�ria
    oTempTable:= FWTemporaryTable():New(cAliasTmp)
    oTempTable:SetFields( aCampos )
    oTempTable:Create()  

    //Popula a tabela tempor�ria
    Processa({|| fPopula()}, 'Processando...')

    //Adiciona as colunas que ser�o exibidas no FWMarkBrowse
    aColunas := fCriaCols()
     
    //Criando a janela
    DEFINE MSDIALOG oDlgMark TITLE 'Tela para Marca��o de dados - Autumn Code Maker' FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL
        //Dados
        oPanGrid := tPanel():New(001, 001, '', oDlgMark, , , , RGB(000,000,000), RGB(254,254,254), (nJanLarg/2)-1,     (nJanAltu/2 - 1))
        oMarkBrowse := FWMarkBrowse():New()
        oMarkBrowse:SetAlias(cAliasTmp)                
        oMarkBrowse:SetDescription('Exemplo para MarkBrowse')
        oMarkBrowse:DisableFilter()
        oMarkBrowse:DisableConfig()
        oMarkBrowse:DisableSeek()
        oMarkBrowse:DisableSaveConfig()
        oMarkBrowse:SetFontBrowse(oFontGrid)
        oMarkBrowse:SetFieldMark('OK')
        oMarkBrowse:SetTemporary(.T.)
        oMarkBrowse:SetColumns(aColunas)
        //oMarkBrowse:AllMark() 
        oMarkBrowse:SetOwner(oPanGrid)
        oMarkBrowse:Activate()
    ACTIVATE MsDialog oDlgMark CENTERED
    
    //Deleta a tempor�ria e desativa a tela de marca��o
    oTempTable:Delete()
    oMarkBrowse:DeActivate()
    
    RestArea(aArea)
Return

/*/{Protheus.doc} MenuDef
Bot�es usados no Browse
@author Fernando Jose Rodrigues
@since 07/12/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function MenuDef()
    Local aRotina := {}
     
    //Cria��o das op��es
    ADD OPTION aRotina TITLE 'Continuar'  ACTION 'u_zEXMARKO'     OPERATION 2 ACCESS 0
Return aRotina

/*/{Protheus.doc} fPopula
Executa a query SQL e popula essa informa��o na tabela tempor�ria usada no browse
@author Fernando Jose Rodrigues
@since 07/12/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fPopula()
    Local cQryDados := ''
    Local nTotal := 0
    Local nAtual := 0

    //Monta a consulta
    cQryDados += "SELECT " + CRLF
    cQryDados += "      ZD1_CODIGO, " + CRLF
    cQryDados += "      ZD1_NOME " + CRLF
    cQryDados += " FROM ZD1990 "		+ CRLF
    cQryDados += " "		+ CRLF
    cQryDados += "WHERE ZD1_DTFORM >= '" + dTos(mv_par01) + "' AND ZD1_DTFORM <= '" + dTos(mv_par02) + "'"		+ CRLF
    PLSQuery(cQryDados, 'QRYDADTMP')

    //Definindo o tamanho da r�gua
    DbSelectArea('QRYDADTMP')
    Count to nTotal
    ProcRegua(nTotal)
    QRYDADTMP->(DbGoTop())

    //Enquanto houver registros, adiciona na tempor�ria
    While ! QRYDADTMP->(EoF())
        nAtual++
        IncProc('Analisando registro ' + cValToChar(nAtual) + ' de ' + cValToChar(nTotal) + '...')

        RecLock(cAliasTmp, .T.)
            (cAliasTmp)->OK := Space(2)
            (cAliasTmp)->ZD1_CODIGO := QRYDADTMP->ZD1_CODIGO
            (cAliasTmp)->ZD1_NOME := QRYDADTMP->ZD1_NOME
        (cAliasTmp)->(MsUnlock())

        QRYDADTMP->(DbSkip())
    EndDo
    QRYDADTMP->(DbCloseArea())
    (cAliasTmp)->(DbGoTop())
Return

/*/{Protheus.doc} fCriaCols
Fun��o que gera as colunas usadas no browse (similar ao antigo aHeader)
@author Fernando Jose Rodrigues
@since 07/12/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fCriaCols()
    Local nAtual       := 0 
    Local aColunas := {}
    Local aEstrut  := {}
    Local oColumn
    
    //Adicionando campos que ser�o mostrados na tela
    //[1] - Campo da Temporaria
    //[2] - Titulo
    //[3] - Tipo
    //[4] - Tamanho
    //[5] - Decimais
    //[6] - M�scara
    aAdd(aEstrut, { 'ZD1_CODIGO', 'CODIGO', 'C', 6, 0, '@!'})
    aAdd(aEstrut, { 'ZD1_NOME', 'NOME ARTISTA', 'C', 100, 0, '@!'})

    //Percorrendo todos os campos da estrutura
    For nAtual := 1 To Len(aEstrut)
        //Cria a coluna
        oColumn := FWBrwColumn():New()
        oColumn:SetData(&('{|| ' + cAliasTmp + '->' + aEstrut[nAtual][1] +'}'))
        oColumn:SetTitle(aEstrut[nAtual][2])
        oColumn:SetType(aEstrut[nAtual][3])
        oColumn:SetSize(aEstrut[nAtual][4])
        oColumn:SetDecimal(aEstrut[nAtual][5])
        oColumn:SetPicture(aEstrut[nAtual][6])

        //Adiciona a coluna
        aAdd(aColunas, oColumn)
    Next
Return aColunas

/*/{Protheus.doc} User Function zEXMARKO
Fun��o acionada pelo bot�o continuar da rotina
@author Fernando Jose Rodrigues
@since 07/12/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function zEXMARKO()
    Processa({|| fProcessa()}, 'Processando...')
Return

/*/{Protheus.doc} fProcessa
Fun��o que percorre os registros da tela
@author Fernando Jose Rodrigues
@since 07/12/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fProcessa()
    Local aArea     := FWGetArea()
    Local cMarca    := oMarkBrowse:Mark()
    Local nAtual    := 0
    Local nTotal    := 0
    Local nTotMarc := 0
    Local cCaracter := ''
    Local cVirgula  := 0


    //Define o tamanho da r�gua
    DbSelectArea(cAliasTmp)
    (cAliasTmp)->(DbGoTop())
    Count To nTotal
    ProcRegua(nTotal)
    
    //Percorrendo os registros
    (cAliasTmp)->(DbGoTop())
    While ! (cAliasTmp)->(EoF())
        nAtual++
        IncProc('Analisando registro ' + cValToChar(nAtual) + ' de ' + cValToChar(nTotal) + '...')
    
        //Caso esteja marcado
        If oMarkBrowse:IsMark(cMarca)
            nTotMarc++
            
            cCaracter += "'" + (cALiasTmp)->ZD1_CODIGO + "'"
            //Aqui dentro voc� pode fazer o seu processamento
            //Alert((cAliasTmp)->ZD1_CODIGO)

        EndIf

        If cVirgula < nTotMarc
            cVirgula++
            cCaracter += ','
        EndIf

         
        (cAliasTmp)->(DbSkip())
    EndDo

    cCaracter := SubStr(cCaracter, 1, Len(cCaracter) -1)

    //Mostra a mensagem de t�rmino e caso queria fechar a dialog, basta usar o m�todo End()
    FWAlertInfo('Dos [' + cValToChar(nTotal) + '] registros, foram processados [' + cValToChar(nTotMarc) + '] registros' + cCaracter, 'Aten��o')
    //oDlgMark:End()

    FWRestArea(aArea)
Return
