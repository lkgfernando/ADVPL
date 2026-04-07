#INCLUDE 'PROTHEUS.CH'


/*
// ##############################################################################################
// Projeto: EXEMPLO DE FUNCIONAMENTO DA FUNÇÃO EVAL
// Modulo : 
// Fonte  : zEval01
// -------------+----------------------+---------------------------------------------------------
// Data         | Autor                | Descricao
// -------------+----------------------+---------------------------------------------------------
// 24/06/2022   | Fernando Rodrigues   | Apenas para fins educacionais
// -------------+----------------------+---------------------------------------------------------*/


User Function zEval01()
    LOCAL nNumero := 100

    bBloco := {|x| y := 5, z := x * y} //Exemplo de bloco de código

    nValor := Eval(bBloco, nNumero)

    MsgInfo(cValToChar(nValor), "Bloco de código")

Return
