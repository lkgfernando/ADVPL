#Include "Totvs.ch"
#Include "RWMAKE.ch"

/*
+============================================================================================================+
| Função: [ RELTMS001 ==> PRIMEIRO RELATORIO NO TMSPRINTER ]                                                |
| Função: [ RELTMS01 ]                                                                                      |
| Autor:  [ FERNANDO JOSE RODRIGUES ]                                                                       |
| Data Criacao: [ 07/03/2022 ]                                                                              |
| Última Alteração: [  ]                                                                                    |
+============================================================================================================+
*/

User Function RELTMS01()
    Local nX            := 0
    Private cTitulo     := "Relatório Exemplo"
    Private oRelatorio
    Private oFonte1     := TFont():New('Courier New',, -18, .T., .T.,,,,,/*lUnderline*/,/*lItelic*/)
    Private oFonte2     := TFont():New('Tahoma',, 25, .T., .T.,,,,,/*lUnderline*/,/*lItelic*/)
    

    //
    oRelatorio := TMSPrinter():New(cTitulo)
    oRelatorio:Setup()          //Abre a tela de configuração da impressora
    oRelatorio:SetLandscape()   //Definir como paisagem

    //Inicia a Pagina
    oRelatorio:StartPage()

    //Escrever
    oRelatorio:Say(200, 010, 'Linha para teste de impressão [Courier New -18]', oFonte1)
    oRelatorio:Say(270, 030, 'Linha para teste de impressão [Tahoma 25]', oFonte2,,CLR_RED)
    
    //Escreva Linha
    oRelatorio:Line(400, 010, 400, 800)
    // Linha diagonal oRelatorio:Line(400, 010, 800, 800)

    //Criar um retangulo
    oRelatorio:Box(410, 010, 800, 800)

    //Imprima um retangulo em azul
    oBrush1 := TBrush():New(,CLR_HBLUE)
    oRelatorio:FillRect({415, 015, 795, 795}, oBrush1)

    //Termina a Pagina
    oRelatorio:EndPage()

    //Inicio de outra pagina2
    oRelatorio:StartPage()

    nLinha := 100

    For nX := 1 to 10
        oRelatorio:Say(nLinha, 010, 'Impressão na linha' + cValToChar(nLinha), oFonte1)
        nLinha += 150
    Next

    //Termina Pagina 2
    oRelatorio:EndPage()
    //Exibe Preview
    oRelatorio:Preview()


Return
