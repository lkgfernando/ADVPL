#Include "Totvs.ch"


/*/{Protheus.doc} User Function zArray
    (long_description)
    @type  Function
    @author Fernando Rodrigues
    @since 26/06/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function zArray()
    Local aArea := FWGetArea()
    Local aVeiculos := {}
    Local aTexto := ""
    Local x := 0
    Local y := 0

    aAdd(aVeiculos, {"FUSCA", "VW", .F., 1964, 30000})
    aAdd(aVeiculos, {"VECTRA", "CHEVOLET", .T., 1995, 50000 })
    aAdd(aVeiculos, {"FIESTA", "FORD", .F., 2008, 19000})

    aSort(aVeiculos, , ,{|x,y| x[1] < y[1]}) //Organiza o array em ordem alfabetica

    For x := 1 To Len(aVeiculos)
        For y := 1 To Len(aVeiculos[x])

            If Valtype(aVeiculos[x,y]) == 'N'
                aTexto += cValToChar(aVeiculos[x,y]) + " | "
            ElseIf Valtype(aVeiculos[x,y]) == 'L'
                If aVeiculos[x,y] == .T.
                    aVeiculos[x,y] := "VERDADEIRO"
                Else
                    aVeiculos[x,y] := "FALSO"
                EndIf

                aTexto += aVeiculos[x,y] + " | "
            Else
                aTexto += aVeiculos[x,y] + " | "
            EndIf
            
        Next y
        aTexto += CRLF
    Next x

    FwAlertInfo(aTexto, "Veiculos")

    FWRestArea(aArea)
Return 
