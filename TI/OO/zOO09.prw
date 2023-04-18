//Bibliotecas
#Include 'TOTVS.ch'

/*/{Protheus.doc} User Function zOO09
Funcao com tela customizada usando a classe TDialog que foi gerado pelo PDialogMaker
@type  Function
@author Fernando José Rodrigues
@since 11/04/2023 
@see https://atiliosistemas.com/portfolio/pdialogmaker/
@obs Obrigado por usar um aplicativo da Atilio Sistemas
/*/

User Function zOO09()
    Local aArea         := FWGetArea()
    Local nCorFundo     := RGB(238, 238, 238)
    Local nJanAltura    := 257
    Local nJanLargur    := 318 
    Local cJanTitulo    := 'Exemplo TGet'
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
    Private cSayObj0    := 'Normal'  
    //objeto7 
    Private oGetObj7 
    Private xGetObj7    := sTod("") //Se o get for data para inicilizar use dToS(''), se for numerico inicie com 0  
    //objeto1 
    Private oSayObj1 
    Private cSayObj1    := 'Com ReadOnly'  
    //objeto8 
    Private oGetObj8 
    Private xGetObj8    := Space(10) //Se o get for data para inicilizar use dToS(''), se for numerico inicie com 0  
    //objeto2 
    Private oSayObj2 
    Private cSayObj2    := 'Inativo' 
     //objeto9 
    Private oGetObj9 
    Private xGetObj9    := Space(10) //Se o get for data para inicilizar use dToS(''), se for numerico inicie com 0   
    //objeto3 
    Private oSayObj3 
    Private cSayObj3    := 'PlaceHolder'  
     //objeto10 
    Private oGetObj10 
    Private xGetObj10    := Space(10) //Se o get for data para inicilizar use dToS(''), se for numerico inicie com 0  
    //objeto4 
    Private oSayObj4 
    Private cSayObj4    := 'Com F3' 
     //objeto11 
    Private oGetObj11 
    Private xGetObj11    := Space(10) //Se o get for data para inicilizar use dToS(''), se for numerico inicie com 0  
    //objeto5 
    Private oSayObj5 
    Private cSayObj5    := 'Com Picture'  
     //objeto12 
    Private oGetObj12 
    Private xGetObj12    := 0 //Se o get for data para inicilizar use dToS(''), se for numerico inicie com 0  
    //objeto6 
    Private oSayObj6 
    Private cSayObj6    := 'Com Valid'   
    //objeto13 
    Private oGetObj13 
    Private xGetObj13    := 0 //Se o get for data para inicilizar use dToS(''), se for numerico inicie com 0  
    //objeto14 
    Private oBtnObj14 
    Private cBtnObj14    := 'Ok'  
    Private bBtnObj14    := {|| MsgInfo('Clicou no OK', 'Atencao')}  
    
    //Cria a dialog
    oDialogPvt := TDialog():New(0, 0, nJanAltura, nJanLargur, cJanTitulo, , , , , , nCorFundo, , , lDimPixels)
    
        //objeto0 - usando a classe TSay
        nObjLinha := 4
        nObjColun := 4
        nObjLargu := 40
        nObjAltur := 6
        oSayObj0  := TSay():New(nObjLinha, nObjColun, {|| cSayObj0}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

        //objeto7 - usando a classe TGet
        nObjLinha := 3
        nObjColun := 49
        nObjLargu := 100
        nObjAltur := 10
        oGetObj7  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , xGetObj7 := u, xGetObj7)}, oDialogPvt, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels, , , , , , , , , , , , , ,.T.)
        //oGetObj7:cPlaceHold := 'Digite aqui um texto...'   //Texto que sera exibido no campo antes de ter conteudo
        //oGetObj7:cF3        := 'Codigo da consulta padrao' //Codigo da consulta padrao / F3 que sera habilitada
        //oGetObj7:bValid     := {|| fFuncaoVld()}           //Funcao para validar o que foi digitado
        //oGetObj7:lReadOnly  := .T.                         //Para permitir o usuario clicar mas nao editar o campo
        //oGetObj7:lActive    := .F.                         //Para deixar o campo inativo e o usuario nao conseguir nem clicar
        //oGetObj7:Picture    := '@!'                        //Mascara / Picture do campo

        //objeto1 - usando a classe TSay
        nObjLinha := 19
        nObjColun := 4
        nObjLargu := 40
        nObjAltur := 6
        oSayObj1  := TSay():New(nObjLinha, nObjColun, {|| cSayObj1}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

        //objeto8 - usando a classe TGet
        nObjLinha := 19
        nObjColun := 49
        nObjLargu := 100
        nObjAltur := 10
        oGetObj8  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , xGetObj8 := u, xGetObj8)}, oDialogPvt, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
        //oGetObj8:cPlaceHold := 'Digite aqui um texto...'   //Texto que sera exibido no campo antes de ter conteudo
        //oGetObj8:cF3        := 'Codigo da consulta padrao' //Codigo da consulta padrao / F3 que sera habilitada
        //oGetObj8:bValid     := {|| fFuncaoVld()}           //Funcao para validar o que foi digitado
        oGetObj8:lReadOnly  := .T.                         //Para permitir o usuario clicar mas nao editar o campo
        //oGetObj8:lActive    := .F.                         //Para deixar o campo inativo e o usuario nao conseguir nem clicar
        //oGetObj8:Picture    := '@!'                        //Mascara / Picture do campo

        //objeto2 - usando a classe TSay
        nObjLinha := 34
        nObjColun := 4
        nObjLargu := 40
        nObjAltur := 6
        oSayObj2  := TSay():New(nObjLinha, nObjColun, {|| cSayObj2}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)
        //objeto9 - usando a classe TGet
        nObjLinha := 33
        nObjColun := 49
        nObjLargu := 100
        nObjAltur := 10
        oGetObj9  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , xGetObj9 := u, xGetObj9)}, oDialogPvt, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
        //oGetObj9:cPlaceHold := 'Digite aqui um texto...'   //Texto que sera exibido no campo antes de ter conteudo
        //oGetObj9:cF3        := 'Codigo da consulta padrao' //Codigo da consulta padrao / F3 que sera habilitada
        //oGetObj9:bValid     := {|| fFuncaoVld()}           //Funcao para validar o que foi digitado
        //oGetObj9:lReadOnly  := .T.                         //Para permitir o usuario clicar mas nao editar o campo
        oGetObj9:lActive    := .F.                         //Para deixar o campo inativo e o usuario nao conseguir nem clicar
        //oGetObj9:Picture    := '@!'                        //Mascara / Picture do campo

        //objeto3 - usando a classe TSay
        nObjLinha := 49
        nObjColun := 4
        nObjLargu := 40
        nObjAltur := 6
        oSayObj3  := TSay():New(nObjLinha, nObjColun, {|| cSayObj3}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)
        //objeto10 - usando a classe TGet
        nObjLinha := 48
        nObjColun := 49
        nObjLargu := 100
        nObjAltur := 10
        oGetObj10  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , xGetObj10 := u, xGetObj10)}, oDialogPvt, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
        oGetObj10:cPlaceHold := 'Digite aqui um texto...'   //Texto que sera exibido no campo antes de ter conteudo
        //oGetObj10:cF3        := 'Codigo da consulta padrao' //Codigo da consulta padrao / F3 que sera habilitada
        //oGetObj10:bValid     := {|| fFuncaoVld()}           //Funcao para validar o que foi digitado
        //oGetObj10:lReadOnly  := .T.                         //Para permitir o usuario clicar mas nao editar o campo
        //oGetObj10:lActive    := .F.                         //Para deixar o campo inativo e o usuario nao conseguir nem clicar
        //oGetObj10:Picture    := '@!'                        //Mascara / Picture do campo


        //objeto4 - usando a classe TSay
        nObjLinha := 64
        nObjColun := 4
        nObjLargu := 40
        nObjAltur := 6
        oSayObj4  := TSay():New(nObjLinha, nObjColun, {|| cSayObj4}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)
         //objeto11 - usando a classe TGet
        nObjLinha := 63
        nObjColun := 49
        nObjLargu := 100
        nObjAltur := 10
        oGetObj11  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , xGetObj11 := u, xGetObj11)}, oDialogPvt, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels, , , , , , , , , , , , , , .T.)
        //oGetObj11:cPlaceHold := 'Digite aqui um texto...'   //Texto que sera exibido no campo antes de ter conteudo
        oGetObj11:cF3        := 'SB1' //Codigo da consulta padrao / F3 que sera habilitada
        //oGetObj11:bValid     := {|| fFuncaoVld()}           //Funcao para validar o que foi digitado
        //oGetObj11:lReadOnly  := .T.                         //Para permitir o usuario clicar mas nao editar o campo
        //oGetObj11:lActive    := .F.                         //Para deixar o campo inativo e o usuario nao conseguir nem clicar
        //oGetObj11:Picture    := '@!'                        //Mascara / Picture do campo


        //objeto5 - usando a classe TSay
        nObjLinha := 79
        nObjColun := 4
        nObjLargu := 40
        nObjAltur := 6
        oSayObj5  := TSay():New(nObjLinha, nObjColun, {|| cSayObj5}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)
         //objeto12 - usando a classe TGet
        nObjLinha := 78
        nObjColun := 49
        nObjLargu := 100
        nObjAltur := 10
        oGetObj12  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , xGetObj12 := u, xGetObj12)}, oDialogPvt, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels, , , , , , , , , , , , , , .T.)
        //oGetObj12:cPlaceHold := 'Digite aqui um texto...'   //Texto que sera exibido no campo antes de ter conteudo
        //oGetObj12:cF3        := 'Codigo da consulta padrao' //Codigo da consulta padrao / F3 que sera habilitada
        //oGetObj12:bValid     := {|| fFuncaoVld()}           //Funcao para validar o que foi digitado
        //oGetObj12:lReadOnly  := .T.                         //Para permitir o usuario clicar mas nao editar o campo
        //oGetObj12:lActive    := .F.                         //Para deixar o campo inativo e o usuario nao conseguir nem clicar
        oGetObj12:Picture    := '@E 999.99'                        //Mascara / Picture do campo

        //objeto6 - usando a classe TSay
        nObjLinha := 94
        nObjColun := 4
        nObjLargu := 40
        nObjAltur := 6
        oSayObj6  := TSay():New(nObjLinha, nObjColun, {|| cSayObj6}, oDialogPvt, /*cPicture*/, oFontPadrao, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)    
        //objeto13 - usando a classe TGet
        nObjLinha := 93
        nObjColun := 49
        nObjLargu := 100
        nObjAltur := 10
        oGetObj13  := TGet():New(nObjLinha, nObjColun, {|u| Iif(PCount() > 0 , xGetObj13 := u, xGetObj13)}, oDialogPvt, nObjLargu, nObjAltur, /*cPict*/, /*bValid*/, /*nClrFore*/, /*nClrBack*/, oFontPadrao, , , lDimPixels)
        //oGetObj13:cPlaceHold := 'Digite aqui um texto...'   //Texto que sera exibido no campo antes de ter conteudo
        //oGetObj13:cF3        := 'Codigo da consulta padrao' //Codigo da consulta padrao / F3 que sera habilitada
        oGetObj13:bValid     := {|| fFuncaoVld()}           //Funcao para validar o que foi digitado
        //oGetObj13:lReadOnly  := .T.                         //Para permitir o usuario clicar mas nao editar o campo
        //oGetObj13:lActive    := .F.                         //Para deixar o campo inativo e o usuario nao conseguir nem clicar
        oGetObj13:Picture    := '@E 999'                        //Mascara / Picture do campo

        //objeto14 - usando a classe TButton
        nObjLinha := 109
        nObjColun := 4
        nObjLargu := (nJanAltura/2) - 2
        nObjAltur := 15
        oBtnObj14  := TButton():New(nObjLinha, nObjColun, cBtnObj14, oDialogPvt, bBtnObj14, nObjLargu, nObjAltur, , oFontPadrao, , lDimPixels)

    
    //Ativa e exibe a janela
    oDialogPvt:Activate(, , , lCentraliz, , , bBlocoIni)
    
    FWRestArea(aArea)
Return


/*/{Protheus.doc} fFuncaoVld
    (long_description)
    @type  Static Function
    @author Fernando José Rodrigues
    @since 11/04/2023
    @version 1.0
    @param , , 
    @return lRet, , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function fFuncaoVld()
    Local aArea := FWGetArea()
    Local lRet := .T.

    If xGetObj13 > 0
        lRet := .T.
    else
        lRet := .F.
        Alert("Falha na validação")
    EndIf

    FWRestArea(aArea)
Return lRet
