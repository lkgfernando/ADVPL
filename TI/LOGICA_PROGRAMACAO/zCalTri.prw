#Include "Totvs.ch"

/*/{Protheus.doc} User Function zCalTri
    (long_description)
    @type  Function
    @author Fernando Rodrigues
    @since 21/02/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function zCalTri()
    Local aArea    := GetArea()
    Local nMes     := Month(Date())
    Local cPeriodo := ""

    Do Case
        Case nMes >= 1 .And. nMes <= 3
            cPeriodo := "Primeiro Trimestre"
           
        Case nMes >= 4 .And. nMes <= 6
            cPeriodo := "Segundo Trimestre"
            
        Case nMes >= 7 .And. nMes <= 9
            cPeriodo := "Terceiro Trimestre"
            
        Case nMes >= 12
            cPeriodo := "Quarto Trimestre"
            
        Otherwise
            cPeriodo := "Trimestre calculado errado, favor conferir o lançamento"
    EndCase

    MsgInfo("Você está no trimestre: " + cPeriodo, "Atenção")

    RestArea(aArea)
Return 
