#Include "Totvs.ch"


/*/{Protheus.doc} User Function zLogi07
    (long_description)
    @type  Function
    @author Fernando Rodrigues
    @since 01/02/2023
    @version version
    @param param_name, param_type, param_descr
    @return return_var, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function zLogi07()
    Local aArea := GetArea()

    fFormAnt()

    RestArea(aArea)
Return

/*/{Protheus.doc} fFormAnt
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 01/02/2023
    @version 
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function fFormAnt()

    // Local bBloco := {|| }
    Local bAoQuadrado := { | nvalor | nQuadrado := nValor * nValor, Alert("Valor quadrado: " + cValToChar(nQuadrado)) }  
    Local cDataNascimento := "30/03/1985"
    Local dData := cToD(cDataNascimento)
    Local nIdade := 0
    EVal(bAoQuadrado, 5)
    EVal(bAoQuadrado, 7)



    // Local cNome := ""
    // Local nIdade := 0
    // Local lCurso := .T.
    // Local dDataNasc := sToD("")

    If dDataBase >= dData
        nIdade :=  Year(dDataBase) - Year(dData)
        MsgInfo("Sua idade é : " + cValTochar(nIdade), "Sua idade!!!")
    Else
        MsgInfo("Alguma coisa aconteceu favor verificar seu código", "Atenção")
    EndIf
    // Local xVaviavel := Nil
    // Local oFont := TFont():New()
    // Alert(oFont:Bold)
   
    // Local aDados := {}

Return 
