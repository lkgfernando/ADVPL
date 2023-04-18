#Include "Totvs.ch"


/*/{Protheus.doc} User Function zOO12
    (long_description)
    @type  Function
    @author Fernando José Rodrigues
    @since 18/04/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function zOO12()
    Local aArea := FWGetArea()
    Local nCorFundo := RGB(238, 238, 238)
    Local nJanAltura := 190
    Local nJanLargura := 220
    Local cJanTitulo := "Exemplo TRadMenu"
    Local lDimPixels := .T.
    Local lCentraliz := .T.
    Local nObjLinha := 0
    Local nObjColun := 0
    Local nObjLargu := 0
    Local nObjAltur := 0
    Private cFontNome := 'Tahoma'
    Private oFontPadrao := TFont():New(cFontNome, , -12)
    Private oDialogPvt
    Private bBlocoIni := {|| /*Minha função*/}
    //Radio
    Private nRadOpc := 1
    Private aRadItens := {"Azul", "Branco", "Laranja", "Preto", "Verde", "Vermelho"}
    Private oRadCores
    //Objeto0
    Private oBtnObj0
    Private cBtnObj0 := "Confirmar"
    Private bBtnObj0 := {|| MsgInfo('Opção escolhida: ' + cValTochar(nRadOpc) + " - " + aRadItens[nRadOpc], 'Atenção')}

    //Criar dialog
    oDialogPvt := TDialog():New(0, 0, nJanAltura, nJanLargura, cJanTitulo, , , , , , nCorFundo, , , lDimPixels)

        //Menu com opções do Radio
        nObjLinha := 10
        nObjColun := 14
        nObjLargu := 80
        nObjAltur := 0
        /*                              1           2           3                           4                               5           6           7               8           9           10          11          12          13      14          15              16          17     18 */
        oRadCores := TRadMenu():New(nObjLinha, nObjColun, aRadItens, {|u| Iif(Pcount() == 0, nRadOpc, nRadOpc := u)}, oDialogPvt, /*uParam6*/, /*bChange*/, /*nClrText*/, /*nCrlPane*/, /*cMsg*/, /*uParam11*/, /*bWhen*/, nObjlargu, nObjAltur, /*bValid*/, /*uParam16*/, lDimPixels, .T.)
        oRadCores:oFont := oFontPadrao

        //tButton
        nObjLInha := 70
        nobjColun := 14
        nObjLargu := 50
        nObjAltur := 15
        oBtnObj0 := TButton():New(nObjLInha, nObjColun, cBtnObj0, oDialogPvt, bBtnObj0, nObjLargu, nObjaltur, , oFontPadrao, , lDimPixels) 

    oDialogPvt:Activate(, , , lCentraliz, , , bBlocoIni)
    
    FWRestArea(aArea)
Return 
