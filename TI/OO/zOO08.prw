//Bibliotecas
#Include 'TOTVS.ch'

/*/{Protheus.doc} User Function zOO08
Funcao com tela customizada usando a classe TDialog que foi gerado pelo PDialogMaker
@type  Function
@author Fernando Jos� Rodrigues
@since 11/04/2023 
@see https://atiliosistemas.com/portfolio/pdialogmaker/
@obs Obrigado por usar um aplicativo da Atilio Sistemas
/*/

User Function zOO08()
    Local aArea         := FWGetArea()
    Local nCorFundo     := RGB(238, 238, 238)
    Local nJanAltura    := 222
    Local nJanLargur    := 404 
    Local cJanTitulo    := 'Exemplo TSay'
    Local lDimPixels    := .T. 
    Local lCentraliz    := .T. 
    Local nObjLinha     := 0
    Local nObjColun     := 0
    Local nObjLargu     := 0
    Local nObjAltur     := 0
    Private cFontNome   := 'Tahoma'
    Private oFontPadrao := TFont():New(cFontNome, , -12)
    Private oDialogPvt 
    Private bBlocoIni   := {|| /*fSuaFuncao()*/ } //Aqui voce pode acionar funcoes customizadas que irao ser acionadas ao abrir a dialog 
    //objeto0 
    Private oSayObj0 
    Private cSayObj0    := 'Label comum'  
    //objeto1 
    Private oSayObj1 
    Private cSayObj1    := '<h3>Label Html - <font color="blue">teste</font></h3>'  
    //objeto2 
    Private oSayObj2 
    Private cSayObj2    := 'Label com cores'  
    //objeto3 
    Private oSayObj3 
    Private cSayObj3    := 'Label com CSS'  
    //objeto4 
    Private oSayObj4 
    Private cSayObj4    := 'Label com clique'  
    
    //Cria a dialog
    oDialogPvt := TDialog():New(0, 0, nJanAltura, nJanLargur, cJanTitulo, , , , , , nCorFundo, , , lDimPixels)
    
        //objeto0 - usando a classe TSay
        nObjLinha := 9
        nObjColun := 7
        nObjLargu := 180
        nObjAltur := 15
        oSayObj0  := TSay():New(nObjLinha, nObjColun, {|| cSayObj0}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

        //objeto1 - usando a classe TSay
        nObjLinha := 29
        nObjColun := 7
        nObjLargu := 180
        nObjAltur := 15
        oSayObj1  := TSay():New(nObjLinha, nObjColun, {|| cSayObj1}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , .T.)

        //objeto2 - usando a classe TSay
        nObjLinha := 49
        nObjColun := 7
        nObjLargu := 180
        nObjAltur := 15
        oSayObj2  := TSay():New(nObjLinha, nObjColun, {|| cSayObj2}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, RGB(255, 0, 0), /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

        //objeto3 - usando a classe TSay
        nObjLinha := 69
        nObjColun := 7
        nObjLargu := 180
        nObjAltur := 15
        oSayObj3  := TSay():New(nObjLinha, nObjColun, {|| cSayObj3}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)
        oSayObj3:SetCSS("background-color: #FF0000; color: #0D0D0D")

        //objeto4 - usando a classe TSay
        nObjLinha := 89
        nObjColun := 7
        nObjLargu := 180
        nObjAltur := 15
        oSayObj4  := TSay():New(nObjLinha, nObjColun, {|| cSayObj4}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)
        oSayObj4:bLClicked := {|| FWAlertInfo("Cliquei no bot�o esquerdo do Mouse", "blClicked")}
        oSayObj4:bRClicked := {|| FWAlertInfo("Cliquei no bot�o direito do Mouse", "bRClicked")}


    
    //Ativa e exibe a janela
    oDialogPvt:Activate(, , , lCentraliz, , , bBlocoIni)
    
    FWRestArea(aArea)
Return
