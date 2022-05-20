#Include 'Totvs.ch'
#Include 'RWMAKE.ch'

/*
+============================================================================================================+
| Função: [ RELLTPRO ==> IMPRIME UMA LISTAGEM DE PRODUTO ]                                                  |
| Função: [ RELLTPRO ]                                                                                      |
| Autor:  [ FERNANDO JOSE RODRIGUES ]                                                                       |
| Data Criacao: [ 07/03/2022 ]                                                                              |
| Última Alteração: [  ]                                                                                    |
+============================================================================================================+
*/

User Function RELLTPRO()
    PRIVATE cTitulo     := 'Relatório de Produtos'
    PRIVATE oDlg
    PRIVATE oFont1      := tFont():New('Courier New',, -10, .T., .F.,,,,,/*lUnderline*/,/*lItelic*/)
    PRIVATE oFont2      := tFont():New('Tahoma',, -15, .T., .T.,,,,,/*lUnderline*/,/*lItelic*/)
    PRIVATE oFont3      := tFont():New('Courier New',,, .T., .T.,,,,,/*lUnderline*/,/*lItelic*/)
    PRIVATE oFont4      := tFont():New('Times New Roman',,10, .T., /*lBold*/,,,,,/*lUnderline*/,/*lItelic*/)
    PRIVATE oFont5      := tFont():New('Courier New',,-14, .T., .T.,,,,,/*lUnderline*/,/*lItelic*/)

    oRelatorio := TMSPrinter():New(cTitulo)
    oRelatorio:Setup()
    oRelatorio:SetLandscape() //Definir como paisagem com Landscape ou Portrait Retrato
    oRelatorio:SetPaperSize(9) //Define o tipo de papel que irá utilizar.

    
    Ms_Flush()      //Descarega o Spool de impressão
    //Imprimir o Relatório
    oRelatorio:StartPage()

    Imprimir()

    oRelatorio:EndPage()
    oRelatorio:End()


    //CRIA A TELA PARA CONFORME INFORMAÇÕES ABAIXO
    DEFINE MSDIALOG oDlg FROM 264,182 TO 441,613 TITLE cTitulo OF oDlg PIXEL
        @ 004,010 TO 082,157 LABEL "" OF oDlg PIXEL

        @ 015,017 SAY "Esta rotina tem por objetivo imprimir"   OF oDlg PIXEL Size 150,010 FONT oFont3 COLOR CLR_HBLUE
        @ 030,017 SAY "o relatorio customizado:"                OF oDlg PIXEL Size 150,010 FONT oFont3 COLOR CLR_HBLUE
        @ 045,017 SAY cTitulo                                   OF oDlg PIXEL Size 150,010 FONT oFont3 COLOR CLR_HBLUE

        @ 06,167 BUTTON "&Imprime"          SIZE 036,012    ACTION oRelatorio:Print()   OF oDlg PIXEL
        @ 28,167 BUTTON "&Preview"          SIZE 036,012    ACTION oRelatorio:Preview() OF oDlg PIXEL
        @ 49,167 BUTTON "&Sair"             SIZE 036,012    ACTION oDlg:End()           OF oDlg PIXEL


    ACTIVATE MSDIALOG oDlg CENTERED



Return

Static Function Imprimir()
    LOCAL nLin := 9999
    LOCAL nPage := 1
    LOCAL nPosCodigo := 0100
    LOCAL nPosDesc := 0350
    LOCAL nPosTipo := 1000
    LOCAL nPosArmz := 1150
    LOCAL nPosGrup := 1400
    LOCAL nFinCol  := oRelatorio:nHorzRes() //1700
    LOCAL oBrush1

    SB1->( DbSetOrder(1) )
    SB1->( DbGoTop() )
    
    MsgAlert(cValTochar(nFinCol), "Fim Coluna")
    
    While !SB1->( EOF() )
        If nLIn >= oRelatorio:nVertRes()
            If nLin != 9999
                oRelatorio:EndPage()
                oRelatorio:StartPage()
                nPage += 1
            EndIf

            nLin := 0030 // Inicio do cabeçalho
            //Monta o Cabeçalho do Relatorio
            oRelatorio:SayBitmap( nLin, 0100, '\system\logosant.bmp', 300, 172)
            oRelatorio:Say(nLin, 0600, UPPER(cTitulo), oFont2) // Titulo da páginda do relatorio
            oRelatorio:Box(nLin, 1600, nLin + 100, 2350) // Desenhado um box
            oRelatorio:Say(nLin, 1650, 'Data: ' + dToc(dDataBase), oFont3)
            oRelatorio:Say(nLin, 2050, 'Pag.: ' + CValToChar(nPage), oFont3)
            nLin += 40
            oRelatorio:Say(nLin, 1650, 'Usuaário: ' + UsrFullName(RetCodUsr()), oFont3)

            nLIn += 200 // indica a distancia do cabeçalho do item

            //CRIAÇÃO DO TITULOS DA LISTAGEM
            oRelatorio:Say(nLin, nPosCodigo,'CÓDIGO',     oFont5)
            oRelatorio:Say(nLin, nPosDesc,  'DESCRIÇÃO',  oFont5)
            oRelatorio:Say(nLin, nPosTipo,  'TIPO',       oFont5)
            oRelatorio:Say(nLin, nPosArmz,  'ARMAZEM',    oFont5)
            oRelatorio:Say(nLin, nPosGrup,  'GRUPO',      oFont5)
            
            nLin += 0055
            //Adicinando uma linha entro o titulo e os dadso
            oRelatorio:Line( nLin, 0010, nLin, oRelatorio:nHorzRes() )

            nLin += 0055

        EndIf 
        
        oBrush1 := TBrush():New(, CLR_HGRAY )

        //Relatorio Zebrado
        if nLin % 2 == 0
            oRelatorio:FillRect( {nLin, nPosCodigo, nLin + 40, nFinCol}, oBrush1 )
        EndIf

        oRelatorio:Say( nLin, nPosCodigo, SB1->B1_COD,      oFont4 )
        oRelatorio:Say( nLin, nPosDesc,   SB1->B1_DESC,     oFont4 )
        oRelatorio:Say( nLin, nPosTipo,   SB1->B1_TIPO,     oFont4 )
        oRelatorio:Say( nLin, nPosArmz,   SB1->B1_LOCPAD,   oFont4 )
        oRelatorio:Say( nLin, nPosGrup,   SB1->B1_GRUPO,    oFont4 )

        nLin += 0045
        SB1->( DbSkip() )

    EndDo
Return
