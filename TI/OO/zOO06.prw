#Include "Totvs.ch"


/*/{Protheus.doc} User Function zOO06
    (long_description)
    @type  Function
    @author Fernando Rodrigues
    @since 13/03/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function zOO06()
    Local nJanAltu   := 200
    Local nJanLarg   := 600
    Local lDimPixels := .T.
    Local lCentraliz := .T.
    Local bBlocoOk   :={|| lOk := .T.                                            , oDlgAux:End()}
    Local bBlocoCan  :={|| lOk := .F.                                            , oDlgAux:End()}
    Local aOutrasAc  :={{"BMP", {|| Alert("Cliquei no 1")}, "Botão1"}            , {"BMP", {|| Alert("Clique no 2")}, "Botão2" }}
    Local bBlocoIni  :={|| EnchoiceBar(oDlgAux, bBlocoOk, bBlocoCan, , aOutrasAc)}
    Local cJanTitulo := "Tela usando TDialog com EnchoiceBar"
    Private oDlgAux
    Private lOk      := .F.

    oDlgAux := TDialog():New(0, 0, nJanAltu, nJanLarg, cJanTitulo, , , , , , /*nCorFundo*/, , , lDimPixels)
    
    oDlgAux:Activate(, , , lCentraliz, , , bBlocoIni)

    If lOk
        FWAlertSuccess("Foi clicado no botão confirmar!", "OK")
    EndIf

Return 
