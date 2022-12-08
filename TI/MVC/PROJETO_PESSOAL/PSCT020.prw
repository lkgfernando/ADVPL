//Bibliotecas
#Include "Totvs.ch"
#Include "FWMVCDef.ch"

/*/{Protheus.doc} User Function PSCT020
Seleção de pedidos para cotação de frete
@author Fernando Jose Rodrigues
@since 08/12/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function PSCT020()
	Local aArea := FWGetArea()
	Local aPergs   := {}
	Local xPar0 := sToD("")
	Local xPar1 := sToD("")
	
	//Adicionando os parametros do ParamBox
	aAdd(aPergs, {1, "Data De:", xPar0,  "", ".T.", "", ".T.", 80,  .F.})
	aAdd(aPergs, {1, "Data Até", xPar1,  "", ".T.", "", ".T.", 80,  .F.})
	
	//Se a pergunta for confirma, chama a tela
	If ParamBox(aPergs, "Informe os parametros")
		fMontaTela()
	EndIf
	
	FWRestArea(aArea)
Return

/*/{Protheus.doc} fMontaTela
Monta a tela com a marcação de dados
@author Fernando Jose Rodrigues
@since 08/12/2022
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
     
    //Adiciona as colunas que serão criadas na temporária
    aAdd(aCampos, { 'OK', 'C', 2, 0}) //Flag para marcação
    aAdd(aCampos, { 'ZC1_PEDIDO', 'C', 6, 0}) //PEDIDO
    aAdd(aCampos, { 'ZC1_DATA', 'D', 8, 0}) //DATA COTAÇÃO
    aAdd(aCampos, { 'ZC1_CODCLI', 'C', 6, 0}) //COD CLIENTE
    aAdd(aCampos, { 'ZC1_LOJA', 'C', 4, 0}) //LOJA
    aAdd(aCampos, { 'A1_NOME', 'C', 80, 0}) //NOME CLIENTE
    aAdd(aCampos, { 'A1_MUN', 'C', 60, 0}) //CIDADE
    aAdd(aCampos, { 'A1_EST', 'C', 2, 0}) //UF

    //Cria a tabela temporária
    oTempTable:= FWTemporaryTable():New(cAliasTmp)
    oTempTable:SetFields( aCampos )
    oTempTable:Create()  

    //Popula a tabela temporária
    Processa({|| fPopula()}, 'Processando...')

    //Adiciona as colunas que serão exibidas no FWMarkBrowse
    aColunas := fCriaCols()
     
    //Criando a janela
    DEFINE MSDIALOG oDlgMark TITLE 'Tela para Marcação de dados - Autumn Code Maker' FROM 000, 000  TO nJanAltu, nJanLarg COLORS 0, 16777215 PIXEL
        //Dados
        oPanGrid := tPanel():New(001, 001, '', oDlgMark, , , , RGB(000,000,000), RGB(254,254,254), (nJanLarg/2)-1,     (nJanAltu/2 - 1))
        oMarkBrowse := FWMarkBrowse():New()
        oMarkBrowse:SetAlias(cAliasTmp)                
        oMarkBrowse:SetDescription('Seleção de pedidos para cotação de frete')
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
    
    //Deleta a temporária e desativa a tela de marcação
    oTempTable:Delete()
    oMarkBrowse:DeActivate()
    
    RestArea(aArea)
Return

/*/{Protheus.doc} MenuDef
Botões usados no Browse
@author Fernando Jose Rodrigues
@since 08/12/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function MenuDef()
    Local aRotina := {}
     
    //Criação das opções
    ADD OPTION aRotina TITLE 'Continuar'  ACTION 'u_PSCT020O'     OPERATION 2 ACCESS 0
Return aRotina

/*/{Protheus.doc} fPopula
Executa a query SQL e popula essa informação na tabela temporária usada no browse
@author Fernando Jose Rodrigues
@since 08/12/2022
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
    cQryDados += "SELECT ZC1_PEDIDO, ZC1_DATA, ZC1_CODCLI, ZC1_LOJA, A1_NOME, A1_MUN, A1_EST FROM ZC1010 ZC1 "		+ CRLF
    cQryDados += " "		+ CRLF
    cQryDados += "INNER JOIN SA1010 SA1 ON ZC1.ZC1_CODCLI = SA1.A1_COD AND ZC1.ZC1_LOJA = SA1.A1_LOJA AND ZC1.D_E_L_E_T_ <> '*' "		+ CRLF
    cQryDados += " "		+ CRLF
    cQryDados += "WHERE ZC1_DATA >= '" + DTOS(MV_PAR01) + "' AND ZC1_DATA <= '" + DTOS(MV_PAR02) + "'"		+ CRLF
    PLSQuery(cQryDados, 'QRYDADTMP')

    //Definindo o tamanho da régua
    DbSelectArea('QRYDADTMP')
    Count to nTotal
    ProcRegua(nTotal)
    QRYDADTMP->(DbGoTop())

    //Enquanto houver registros, adiciona na temporária
    While ! QRYDADTMP->(EoF())
        nAtual++
        IncProc('Analisando registro ' + cValToChar(nAtual) + ' de ' + cValToChar(nTotal) + '...')

        RecLock(cAliasTmp, .T.)
            (cAliasTmp)->OK := Space(2)
            (cAliasTmp)->ZC1_PEDIDO := QRYDADTMP->ZC1_PEDIDO
            (cAliasTmp)->ZC1_DATA := QRYDADTMP->ZC1_DATA
            (cAliasTmp)->ZC1_CODCLI := QRYDADTMP->ZC1_CODCLI
            (cAliasTmp)->ZC1_LOJA := QRYDADTMP->ZC1_LOJA
            (cAliasTmp)->A1_NOME := QRYDADTMP->A1_NOME
            (cAliasTmp)->A1_MUN := QRYDADTMP->A1_MUN
            (cAliasTmp)->A1_EST := QRYDADTMP->A1_EST
        (cAliasTmp)->(MsUnlock())

        QRYDADTMP->(DbSkip())
    EndDo
    QRYDADTMP->(DbCloseArea())
    (cAliasTmp)->(DbGoTop())
Return

/*/{Protheus.doc} fCriaCols
Função que gera as colunas usadas no browse (similar ao antigo aHeader)
@author Fernando Jose Rodrigues
@since 08/12/2022
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
    
    //Adicionando campos que serão mostrados na tela
    //[1] - Campo da Temporaria
    //[2] - Titulo
    //[3] - Tipo
    //[4] - Tamanho
    //[5] - Decimais
    //[6] - Máscara
    aAdd(aEstrut, { 'ZC1_PEDIDO', 'PEDIDO', 'C', 6, 0, '@!'})
    aAdd(aEstrut, { 'ZC1_DATA', 'DATA COTAÇÃO', 'D', 8, 0, ''})
    aAdd(aEstrut, { 'ZC1_CODCLI', 'COD CLIENTE', 'C', 6, 0, '@!'})
    aAdd(aEstrut, { 'ZC1_LOJA', 'LOJA', 'C', 4, 0, '@!'})
    aAdd(aEstrut, { 'A1_NOME', 'NOME CLIENTE', 'C', 80, 0, '@!'})
    aAdd(aEstrut, { 'A1_MUN', 'CIDADE', 'C', 60, 0, '@!'})
    aAdd(aEstrut, { 'A1_EST', 'UF', 'C', 2, 0, '@!'})

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

/*/{Protheus.doc} User Function PSCT020O
Função acionada pelo botão continuar da rotina
@author Fernando Jose Rodrigues
@since 08/12/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

User Function PSCT020O()
    Processa({|| fProcessa()}, 'Processando...')
Return

/*/{Protheus.doc} fProcessa
Função que percorre os registros da tela
@author Fernando Jose Rodrigues
@since 08/12/2022
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
    Local cNumPed := ''
    Local cVirgula := 0
    
    //Define o tamanho da régua
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
            

            cNumPed += "'"+(cAliasTmp)->ZC1_PEDIDO +"'" 
            /*
            //Aqui dentro você pode fazer o seu processamento
            Alert((cAliasTmp)->ZC1_PEDIDO)
            */
        EndIf

         If cVirgula < nTotMarc
            cVirgula++
            cNumPed += ','
        EndIf
         
        (cAliasTmp)->(DbSkip())
    EndDo
    
    cNumPed := SubStr(cNumPed, 1, Len(cNumPed) -1)
    //Mostra a mensagem de término e caso queria fechar a dialog, basta usar o método End()
    //FWAlertInfo('Dos [' + cValToChar(nTotal) + '] registros, foram processados [' + cValToChar(nTotMarc) + '] registros', 'Atenção')
    //oDlgMark:End()

    Processa({|| fGeraExcel(cNumPed)}, 'Processando...')

    FWRestArea(aArea)
Return

/*/{Protheus.doc} fGeraExcel
Criacao do arquivo Excel na funcao PSREL010
@author Fernando Jose Rodrigues
@since 08/12/2022
@version 1.0
@type function
@obs Codigo gerado automaticamente pelo Autumn Code Maker
@see http://autumncodemaker.com
/*/

Static Function fGeraExcel(cNumPed)
	Local cQryDad  := ""
	Local oFWMsExcel
	Local oExcel
	Local cArquivo    := GetTempPath() + "PSREL010.xml"
	Local cWorkSheet := "Cotação"
	Local cTitulo    := "Pagadora do Frete: Plasticos Santana Ere"
	Local nAtual := 0
	Local nTotal := 0
	
	//Montando consulta de dados
	cQryDad += "SELECT ZC1_PEDIDO, A1_NOME, A1_MUN, A1_EST, A1_CGC, ZC1_VLNF, ZC1_VOLUME, ZC1_CUB, ZC1_PESO FROM ZC1010 ZC1 "		+ CRLF
	cQryDad += " "		+ CRLF
	cQryDad += "INNER JOIN SA1010 SA1 ON ZC1.ZC1_CODCLI = SA1.A1_COD AND ZC1.ZC1_LOJA = SA1.A1_LOJA AND ZC1.D_E_L_E_T_ <> '*' "		+ CRLF
	cQryDad += " "		+ CRLF
	cQryDad += "WHERE ZC1_PEDIDO IN (" + cNumPed +")"		+ CRLF
	
	//Executando consulta e setando o total da regua
	PlsQuery(cQryDad, "QRY_DAD")
	DbSelectArea("QRY_DAD")
	
	//Cria a planilha do excel
	oFWMsExcel := FWMSExcel():New()
	
	//Criando a aba da planilha
	oFWMsExcel:AddworkSheet(cWorkSheet)
	
	//Criando a Tabela e as colunas
	oFWMsExcel:AddTable(cWorkSheet, cTitulo)
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Pedido Cliente", 1, 1, .F.)
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Nome Cliente", 1, 1, .F.)
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Cidade", 1, 1, .F.)
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "UF", 1, 1, .F.)
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "CNPJ", 2, 1, .F.)
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Valor da Nota Fiscal", 2, 3, .F.)
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Volume", 2, 2, .F.)
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Cubagem", 2, 2, .F.)
	oFWMsExcel:AddColumn(cWorkSheet, cTitulo, "Peso Bruto", 2, 2, .F.)
	
	//Definindo o tamanho da regua
	Count To nTotal
	ProcRegua(nTotal)
	QRY_DAD->(DbGoTop())
	
	//Percorrendo os dados da query
	While !(QRY_DAD->(EoF()))
		
		//Incrementando a regua
		nAtual++
		IncProc("Adicionando registro " + cValToChar(nAtual) + " de " + cValToChar(nTotal) + "...")
		
		//Adicionando uma nova linha
		oFWMsExcel:AddRow(cWorkSheet, cTitulo, {;
			QRY_DAD->ZC1_PEDIDO,;
			QRY_DAD->A1_NOME,;
			QRY_DAD->A1_MUN,;
			QRY_DAD->A1_EST,;
			QRY_DAD->A1_CGC,;
			QRY_DAD->ZC1_VLNF,;
			QRY_DAD->ZC1_VOLUME,;
			QRY_DAD->ZC1_CUB,;
			QRY_DAD->ZC1_PESO;
		})
		
		QRY_DAD->(DbSkip())
	EndDo
	QRY_DAD->(DbCloseArea())
	
	//Ativando o arquivo e gerando o xml
	oFWMsExcel:Activate()
	oFWMsExcel:GetXMLFile(cArquivo)
	
	//Abrindo o excel e abrindo o arquivo xml
	oExcel := MsExcel():New()
	oExcel:WorkBooks:Open(cArquivo)
	oExcel:SetVisible(.T.)
	oExcel:Destroy()
	
Return
