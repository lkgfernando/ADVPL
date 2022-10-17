#Include "Totvs.ch"


/*/{Protheus.doc} User Function MkBrwSA3
    (long_description)
    @type  Function
    @author Fernando José Rodrigues
    @since 17/10/2022
    /*/
User Function MkBrwSA3()
    Local aArea := GetArea()
    Local aCpos := {}
    Local aCampos := {}
    Local nI := 0
    Local cAlias := "SA3"
    Private aRotina := {}
    Private cCadastro := "Cadastro de Vendedores"
    Private aRecSel := {}

    AADD(aRotina, {"Visuarlizar Lote", "U_VisLote", 0, 5})

    AADD(aCpos, "A3_COD")
    AADD(aCpos, "A3_NOME")
    AADD(aCpos, "A3_NREDUZ")

    DbSelectArea("SX3")
    DbSetOrder(2)

    For nI := 1 To Len(aCpos)
        If DbSeek(aCpos[nI])
            AADD(aCampos,{X3_CAMPO,"" ,IIF(nI == 1, "", Trim(X3_TITULO)), Trim(X3_PICTURE)})
        EndIf
    Next nI

    DbSelectArea(cAlias)
    DbSetOrder(1)
    MarkBrow(cAlias, aCpos[1], "A3_TIPVEND = '2'", aCampos, .F., GetMark("SA3","A3_ZOK"))
  

    RestArea(aArea)
Return 
