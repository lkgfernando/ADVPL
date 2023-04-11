#Include "Totvs.ch"

/*/{Protheus.doc} User Function zOO07
    (long_description)
    @type  Function
    @author Fernando Jose Rodrigues
    @since 10/04/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function zOO07()
	Local aArea       := FWGetArea()
	Local nCorFundo   := RGB(235, 238, 238)
	Local nJanAltura  := 222
	Local nJanLargur  := 404
	Local cJanTitulo  := 'Exempo TFont'
	Local lDimPixels  := .T.
	Local lCentraliz  := .T.
	Local nObjLinha   := 0
	Local nObjColun   := 0
	Local nObjLargu   := 0
	Local nObjAltur   := 0
	Private oDialogPvt
	Private bBlocoIni :={|| /* fSuaFuncao */ }
	//							1		2			3			4			5			6			7		8			9			10				11
	//		 TFont():New( [ cName ], [ uPar2 ], [ nHeight ], [ uPar4 ], [ lBold ], [ uPar6 ], [ uPar7 ], [ uPar8 ], [ uPar9 ], [ lUnderline ], [ lItalic ] )
	//Objeto 0
	Private oSayObj0
	Private cSayObj0  := 'Tahoma, -12, Normal'
	Private oFontPad  := TFont():New("Tahoma", /*uPar2*/, -12)
	//Objeto 1
	Private oSayObj1
	Private cSayObj1  := 'Tahoma, -12, Negrito'
	Private oFontNeg  := TFont():New("Tahoma", /*uPar2*/, -12       , /*uPar4*/ , .T.)
	//Objeto 2
	Private oSayObj2
	Private cSayObj2  := 'Tahoma, -14, Sublinhado'
	Private oFontSub  := TFont():New("Tahoma", /*uPar2*/, -14, /**uPar4*/, .F., /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, .T.)
				
	//Objeto 3
	Private oSayObj3
	Private cSayObj3  := 'Tahoma, -16, Itálico'
	Private oFontIta  := TFont():New("Tahoma", /*uPar2*/, -16  , /*uPar4*/, .F., /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, .F., .T.)
	//Ogjeto 4
	Private oSayObj4
	Private cSayObj4  := 'Arial, -10, Tudo'
	Private oFontTudo := TFont():New("Arial" , /*uPar2*/, -10       , /*uPar4*/, .T.       , /*uPar6*/, /*uPar7*/, /*uPar8*/, /*uPar9*/, .T., .T.)
	//Cria a dialog
	ODialogPvt        := TDialog():New(0       , 0        , nJanAltura, nJanLargur, cJanTitulo,          ,          ,          ,          ,    , nCorFundo, , , lDimPixels)

	//Objeto usando a classe TSay
	nObjLinha := 9
	nObjColun := 7
	nObjLargu := 200
	nObjAltur := 20
    oSayObj0  := TSay():New(nObjLinha, nObjColun, {|| cSayObj0}, oDialogPvt, /*cPicture*/, oFontPad, , , , lDimPixels, /*nClrText*/, /*nClrBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

	nObjLinha := 29
	nObjColun := 7
	nObjLargu := 200
	nObjAltur := 20
	oSayObj1  := TSay():New(nObjLinha, nObjColun, {|| cSayObj1}, oDialogPvt, /*cPicture*/, oFontNeg, , , , lDimPixels, /*nClrText*/, /*nCrlBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

	nObjLinha := 49
	nObjColun := 7
	nObjLargu := 200
	nObjAltur := 20
	oSayObj2  := TSay():New(nObjLinha, nObjColun, {|| cSayObj2}, oDialogPvt, /*cPicture*/, oFontSub, , , , lDimPixels, /*nCrlText*/, /*nCrlBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

	nObjLinha := 69
	nObjColun := 7
	nObjLargu := 200
	nObjAltur := 20
	oSayObj3  := TSay():New(nObjLinha, nObjColun, {|| cSayObj3}, oDialogPvt, /*cPicture*/, oFontIta, , , , lDimPixels, /*nCrlText*/, /*nCrlBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)

	nObjLinha := 89
	nObjColun := 7
	nObjLargu := 200
	nObjAltur := 20
	oSayObj4  := TSay():New(nObjLinha, nObjColun, {|| cSayObj4}, odialogPvt, /*cPicture*/, oFontTudo, , , , lDimPixels, /*nCrlText*/, /*nCrlBack*/, nObjLargu, nObjAltur, , , , , , /*lHTML*/)
                

    oDialogPvt:Activate(, , , lCentraLiz, , , bBlocoIni)

	FWRestArea(aArea)
Return
