#Include "Totvs.ch"

/*/{Protheus.doc} User Function zBlocoCod
    Exemplo de calculo de desconto de uma compra com bloco de código
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
User Function zBlocoCod()
    Local aArea     := FWGetArea()
    Local nValorP   := 0
    Local bCalcDesc := {|x| y , z := x * y}
    Local nValorLiq := 0
    Local cDesconto := ""

    nValorP := 499.00

    If nValorP < 100.00
        y := 0.10
    ElseIf nValorP < 200.00
        y := 0.15
    ElseIf nValorP < 500.00
        y := 0.50
    EndIf

    cDesconto := cValToChar(y * 100) + "%"

    
    nValorLiq := nValorP - Eval(bCalcDesc,nValorP)

    FWAlertInfo("Sua compra foi de <strong> R$ " + cValToChar(Round(nValorLiq,3)) + "</strong> foi concedido um desconto de: " + cDesconto, "Calculando com bloco de código")

    FWRestArea(aArea)
Return 
