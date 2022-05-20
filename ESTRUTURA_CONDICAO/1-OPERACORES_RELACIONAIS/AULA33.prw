#Include "Protheus.ch"

/*  
* FUNÇÃO PARA ESTUDO DE CONDIÇÃO IF ELSE ANINHADO
*/
User Function AULA33()
Local nNumero1 := 20
Local nNumero2 := 30

//Verificar se a variavel nNumero1 é maior que nNumero2

if nNumero1 > nNumero2
    MsgInfo("Numero 1 -> " + cValToChar(nNumero1) + " > (maior que) Numero 2 -> " + cValToChar(nNumero2))
else
    if nNumero1 < nNumero2
        MsgInfo("Numero 1 -> " + cValToChar(nNumero1) + " < (menor que) Numero 2 -> " + cValToChar(nNumero2))
    else
        MsgInfo("Numero 1 -> " + cValToChar(nNumero1) + " = (igual) Numero 2-> " + cValToChar(nNumero2))
    EndIf
    
EndIf

Return
