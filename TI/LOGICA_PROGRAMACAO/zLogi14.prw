#Include "Totvs.ch"

/*/{Protheus.doc} User Function zLogi14
    (long_description)
    @type  Function
    @author Fernando Rodrigues
    @since 23/02/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function zLogi14()
    Local aArea := GetArea()
    Local cMsg := ""
    Local nAtual := 0

    While .T.
        If MsgYesNo("Deseja continuar o laço", "Atenção")
            Loop
        Else
            Exit
        EndIf

    EndDo

    DbSelectArea('SA2')
    SA2->(DbSetOrder(1))

    While ! SA2->(Eof())
        nAtual++
        cMsg += "[ " + cValToChar(nAtual) + "]" + AllTrim(SA2->A2_NOME) + ";" + CRLF
        SA2->(DbSkip()) 
    EndDo

    Aviso("Atenção", cMsg, {"OK"}, 2)
    
    RestArea(aArea)
Return 
