//Bibliotecas
#Include 'TOTVS.ch'

/*/{Protheus.doc} User Function zOO11
Funcao com tela customizada usando a classe TDialog que foi gerado pelo PDialogMaker
@type  Function
@author Fernando Jos� Rodrigues
@since 18/04/2023 
@see https://atiliosistemas.com/portfolio/pdialogmaker/
@obs Obrigado por usar um aplicativo da Atilio Sistemas
/*/

User Function zOO11()
    Local aArea         := FWGetArea()
    Local nCorFundo     := RGB(238, 238, 238)
    Local nJanAltura    := 190
    Local nJanLargur    := 318 
    Local cJanTitulo    := 'Exemplo TCheckBox'
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
    Private oChkObj0 
    Private lChkObj0    := .F.  
    Private cChkObj0    := 'CheckBox vindo desmarcado'  
    //objeto1 
    Private oChkObj1 
    Private lChkObj1    := .T.  
    Private cChkObj1    := 'CheckBox vindo marcado'  
    //objeto2 
    Private oChkObj2 
    Private lChkObj2    := .T.  
    Private cChkObj2    := 'CheckBox desativado'  
    //objeto3 
    Private oBtnObj3 
    Private cBtnObj3    := 'Confirmar'  
    Private bBtnObj3    := {|| MsgInfo('Coloque sua funcao aqui', 'Atencao objeto3')}  
    
    //Cria a dialog
    oDialogPvt := TDialog():New(0, 0, nJanAltura, nJanLargur, cJanTitulo, , , , , , nCorFundo, , , lDimPixels)
    
        //objeto0 - usando a classe TCheckBox
        nObjLinha := 5
        nObjColun := 7
        nObjLargu := 110
        nObjAltur := 15
        oChkObj0  := TCheckBox():New(nObjLinha, nObjColun, cChkObj0, {|u| Iif(PCount() > 0 , lChkObj0 := u, lChkObj0)}, oDialogPvt, nObjLargu, nObjAltur, , /*bLClicked*/, oFontPadrao, /*bValid*/, /*nClrText*/, /*nClrPane*/, , lDimPixels)

        //objeto1 - usando a classe TCheckBox
        nObjLinha := 25
        nObjColun := 7
        nObjLargu := 110
        nObjAltur := 15
        oChkObj1  := TCheckBox():New(nObjLinha, nObjColun, cChkObj1, {|u| Iif(PCount() > 0 , lChkObj1 := u, lChkObj1)}, oDialogPvt, nObjLargu, nObjAltur, , /*bLClicked*/, oFontPadrao, /*bValid*/, /*nClrText*/, /*nClrPane*/, , lDimPixels)

        //objeto2 - usando a classe TCheckBox
        nObjLinha := 45
        nObjColun := 7
        nObjLargu := 110
        nObjAltur := 15
        oChkObj2  := TCheckBox():New(nObjLinha, nObjColun, cChkObj2, {|u| Iif(PCount() > 0 , lChkObj2 := u, lChkObj2)}, oDialogPvt, nObjLargu, nObjAltur, , /*bLClicked*/, oFontPadrao, /*bValid*/, /*nClrText*/, /*nClrPane*/, , lDimPixels)
        oChkObj2:lActive := .F.

        //objeto3 - usando a classe TButton
        nObjLinha := 70
        nObjColun := 7
        nObjLargu := 110
        nObjAltur := 15
        oBtnObj3  := TButton():New(nObjLinha, nObjColun, cBtnObj3, oDialogPvt, bBtnObj3, nObjLargu, nObjAltur, , oFontPadrao, , lDimPixels)

    
    //Ativa e exibe a janela
    oDialogPvt:Activate(, , , lCentraliz, , , bBlocoIni)
    
    FWRestArea(aArea)
Return
