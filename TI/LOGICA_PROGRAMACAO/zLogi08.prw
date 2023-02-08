#Include "Totvs.ch"


/*/{Protheus.doc} User Function zLogi08
    (long_description)
    @type  Function
    @author Fernando Rodrigues
    @since 03/02/2023
    @version version
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function zLogi08()
    Local aArea := GetArea()
    Local aNomes := {}
    Local aSobrenomes := Array(3)
    Local aPessoa := {}
    Local cMsg := ""
    Local nAtual 

    aAdd(aNomes, "Fernando")
    aAdd(aNomes, "Kauan")

    aSobrenomes[1] := "Rodrigues"
    aSobrenomes[2] := "Sabaini"

    cMsg := aNomes[1] + " " + aSobrenomes[1] + CRLF
    cMsg += aNomes[2] + " " + aSobrenomes[2] + CRLF

    MsgInfo(cMsg)

    aAdd(aPessoa, {"Fernando", sToD("19850330"), "Taquarituba"})
    aAdd(aPessoa, {"Kauan" , sToD("20110107"), "Campinas"})
    aAdd(aPessoa, {"Livia", sToD("20141007"), "Campinas"})

    For nAtual := 1 To Len(aPessoa)
        cMsg += aPessoa[nAtual][1] + " nasceu no dia " + dToS(aPessoa[nAtual][2]) + " em " + aPessoa[nAtual][3] + CRLF
    Next

    MsgInfo(cMsg)

    //Inserindo elementos no Array

    aSize(aPessoa, Len(aPessoa) + 1)
    aIns(aPessoa, 4)
    aPessoa[4] := {"Glacieli", sToD("19771005"), "Florida"}
    cMsg += aPessoa[4][1] + " nasceu no dia " + dToS(aPessoa[4][2]) + " em " + aPessoa[4][3]

    MsgInfo(cMsg)

    //Procura um elemento no array
    nPos := aScan(aPessoa, { | x | AllTrim(Upper(x[1])) == "KAUAN"})

    If nPos > 0
        MsgInfo("Kauan foi encontrado na linha " + cValToChar(nPos) + ".", "Atenção")
    Else 
        MsgInfo("Kauan não foi encontrado", "Atenção") 
    EndIf

    RestArea(aArea)
Return 
