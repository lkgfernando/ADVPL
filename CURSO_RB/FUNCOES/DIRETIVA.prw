#INCLUDE "PROTHEUS.CH"


/*
// ##############################################################################################
// Projeto: Crie uma user function zDiretiva, uma static function zRecebe
// Modulo : 
// Fonte  : zDertiva
// -------------+----------------------+---------------------------------------------------------
// Data         | Autor                | Descricao
// -------------+----------------------+---------------------------------------------------------
// 27/06/2022   | FERNANDO RODRIGUE    | PARA FINS EDUCACIONAIS      
// -------------+----------------------+---------------------------------------------------------*/

User Function zDiretiva()
    Local aArea := GetArea()
    Local nValor1 := 10
    Local nValor2 := 20
    Local nResultado := 0

    nResultado := zRecebe(@nValor1,nValor2)

    MsgAlert(cValtoChar(nResultado), "Teste de função")

    RestArea(aArea)
Return



Static Function zRecebe(nValor1, nValor2)
    Local nRetorno := 0

    nValor1 := 20

    nRetorno := nValor1 * nValor2


Return (nRetorno)
