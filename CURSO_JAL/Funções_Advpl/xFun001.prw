#Include "Protheus.ch"


/*/{Protheus.doc} xFun001
Exemplo de função Advpl
@type user function
@author Fernando Rodrigues
@since 25/05/2025
/*/
User Function xFun001(nNumEnv)
  Local nNumero := 10
  Default nNumEnv := 0 

  If nNumero > nNumEnv
    Alert("nNumero é maior!")
  else
    Alert("É menor")
  EndIf

Return 

/*/{Protheus.doc} xChaFun
Chama funções que estã sendo utilizada no exemplo da aula
@type user function
@author Fernando Rodrigues
@since 25/05/2025
@version 12/Superiro

/*/
User Function xChaFun()
  U_xFun001(15)
Return 
