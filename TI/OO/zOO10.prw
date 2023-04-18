//Bibliotecas
#Include 'TOTVS.ch'

/*/{Protheus.doc} User Function zOO10
Funcao com tela customizada usando a classe TDialog que foi gerado pelo PDialogMaker
@type  Function
@author Fernando José Rodrigues
@since 12/04/2023 
@see https://atiliosistemas.com/portfolio/pdialogmaker/
@obs Obrigado por usar um aplicativo da Atilio Sistemas
/*/

User Function zOO10()
    Local aArea         := FWGetArea()
    Local nCorFundo     := RGB(238, 238, 238)
    Local nJanAltura    := 190
    Local nJanLargur    := 245 
    Local cJanTitulo    := 'Exemplo Combo'
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
    Private cSayObj0    := 'Região:'  
    //objeto1 
    Private oCmbObj1 
    Private cCmbObj1    := 'XX'  
    Private aCmbObj1    := {'XX=Nenhuma Região', 'NT=Norte', 'ND=Nordeste', 'CO=Centro Oeste', 'SD=Sudeste', 'SU=Sul'}  
    //objeto2 
    Private oSayObj2 
    Private cSayObj2    := 'Estado:'  
    //objeto3 
    Private oCmbObj3 
    Private cCmbObj3    := ''  
    Private aCmbObj3    := {}  

    //objeto4
    Private oBrnObj4
    Private cBtnObj4    := 'Confirmar'
    Private bBtnObj4    :={|| MsgInfo( 'Região [' + cCmbObj1 + '] e Estado [' + cCmbObj3 + ']' , 'Combos escolhidos' )}
    
    //Cria a dialog
    oDialogPvt := TDialog():New(0, 0, nJanAltura, nJanLargur, cJanTitulo, , , , , , nCorFundo, , , lDimPixels)
    
        //objeto0 - usando a classe TSay
        nObjLinha := 8
        nObjColun := 7
        nObjLargu := 28
        nObjAltur := 6
        oSayObj0  := TSay():New(nObjLinha, nObjColun, {|| cSayObj0}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

        //objeto1 - usando a classe TComboBox
        nObjLinha := 17
        nObjColun := 18
        nObjLargu := 100
        nObjAltur := 12
        oCmbObj1  := TComboBox():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , cCmbObj1 := u, cCmbObj1)}, aCmbObj1, nObjLargu, nObjAltur, oDialogPvt, , {|| fAtuCmb()}, /*bValid*/, /*nClrText*/, /*nClrBack*/, lDimPixels, oFontPadrao)

        //objeto2 - usando a classe TSay
        nObjLinha := 35
        nObjColun := 7
        nObjLargu := 28
        nObjAltur := 6
        oSayObj2  := TSay():New(nObjLinha, nObjColun, {|| cSayObj2}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

        //objeto3 - usando a classe TComboBox
        nObjLinha := 44
        nObjColun := 18
        nObjLargu := 100
        nObjAltur := 12
        oCmbObj3  := TComboBox():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , cCmbObj3 := u, cCmbObj3)}, aCmbObj3, nObjLargu, nObjAltur, oDialogPvt, , /*bChange*/, /*bValid*/, /*nClrText*/, /*nClrBack*/, lDimPixels, oFontPadrao)

        //objeto4
        nObjLinha := 72
        nObjColun := 70
        nObjLargu := 50
        nObjAltur := 15
        oBtnObj4  := TButton():New(nObjLinha, nObjColun, cBtnObj4, oDialogPvt, bBtnObj4, nObjLargu, nObjAltur, , oFontPadrao, , lDimPixels)

    
    //Ativa e exibe a janela
    oDialogPvt:Activate(, , , lCentraliz, , , bBlocoIni)
    
    FWRestArea(aArea)
Return


/*/{Protheus.doc} fAtuCmb
    (long_description)
    @type  Static Function
    @author Fernando José Rodriges
    @since 13/04/2023
    @version 1+0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function fAtuCmb()
    Local aEstado := {}

    If cCmbObj1 == "NT"
        aAdd(aEstado, "RR=Roraima")
        aAdd(aEstado, "AP=Amapá")
        aAdd(aEstado, "AM=Amazonas")
        aAdd(aEstado, "PA=Pará")
        aAdd(aEstado, "AC=Acre")
        aAdd(aEstado, "RO=Rondônia")
        aAdd(aEstado, "TO=Tocantins")

    ElseIf cCmbObj1 == "ND"
        aAdd(aEstado, "MA=Maranhão")
        aAdd(aEstado, "PI=Piauí")
        aAdd(aEstado, "CE=Ceará")
        aAdd(aEstado, "RN=Rio Grande do Norte")
        aAdd(aEstado, "PB=Paraíba")
        aAdd(aEstado, "PE=Pernambuco")
        aAdd(aEstado, "AL=Alagoas")
        aAdd(aEstado, "SE=Sergipe")
        aAdd(aEstado, "BA=Bahia")

    ElseIf cCmbObj1 == "CO"
        aAdd(aEstado, "MT=Mato Grosso")
        aAdd(aEstado, "DF=Distrito Federal")
        aAdd(aEstado, "GO=Goiás")
        aAdd(aEstado, "MS=Mato Grosso do Sul")
    
    ElseIf cCmbObj1 == "SD"
        aAdd(aEstado, "MG=Minas Gerais")
        aAdd(aEstado, "ES=Espírito Santo")
        aAdd(aEstado, "RJ=Rio de Janeiro")
        aAdd(aEstado, "SP=São Paulo")

    ElseIf cCmbObj1 == "SU"
        aAdd(aEstado, "PR=Paraná")
        aAdd(aEstado, "SC=Santa Catarina")
        aAdd(aEstado, "RS=Rio Grande do Sul")

    Else
        aAdd(aEstado, "")
    EndIf

    oCmbObj3:SetItems(aEstado)
    oCmbObj3:Refresh()

Return 
