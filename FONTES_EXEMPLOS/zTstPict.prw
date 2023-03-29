#Include "Totvs.ch"

/*/{Protheus.doc} User Function zTstPict
    Alteração de picture de campo conforme o tipo de produto exemplo de mascara igual ao cnpj.
    @type  Function
    @author Fernando Rodrigues
    @since 01/03/2023
    @version 1.0
    @param , , 
    @return cMascara, , 
    @example
    (examples)
    @see https://terminaldeinformacao.com/2023/03/01/como-fazer-uma-picture-variavel-num-campo-do-protheus/

    /*/
User Function zTstPict()
    Local aArea := FWGetArea()
    Local cMascara := ""
    Local cTipo := FWFldGet("B1_TIPO")

    If cTipo == "PA"
        cMascara := "@R 999999"

    ElseIf cTipo == "PI"
        cMascara := "@R 9999"
    
    ElseIf cTipo == "MP"
        cMascara := "@R 99999999"
    
    Else
        cMascara := "@R 9999999999"
    EndIf

    cMascara += "%C"

    FWRestArea(aArea)
Return cMascara
