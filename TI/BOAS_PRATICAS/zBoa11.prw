#Include "Totvs.ch"


/*/{Protheus.doc} User Function zBoa11
    Exemplo de boas práticas - Alias temporária
    @author Fernando Jose Rodrigues
    @since 15/09/2022
    @version 1.0
/*/
User Function zBoa11()
    Local aArea     := GetArea()
    Local cAliasTmp := "TMP_XPTO"

    oTempTable      := FWTemporaryTable():New(cAliasTmp)

    aFields         := {}
    aadd(aFields, {"FILIAL", "C", 2 , 0})
    aadd(aFields, {"NOME"  , "C", 50, 0})
    aadd(aFields, {"VALOR" , "N", 8 , 2})
    aadd(aFields, {"EMISAO", "D", 8 , 0})

    oTempTable:SetFields( aFields )

    oTempTable:Create()

    RecLock(cAliasTmp, .T.)
        (cAliasTmp)->FILIAL  := ""
        (cAliasTmp)->NOME    := "Teste"
        (cAliasTmp)->VAL     := 30
        (cAliasTmp)->EMISSAO := Date()
    (cAliasTmp)->(MsUnlock)

    MsgAlert("Nome real da temporaria: [" + oTempTable:GetRealName() + "]", "Tabela temporaria")

    oTempTable:Delete()

    RestArea(aArea)
Return
