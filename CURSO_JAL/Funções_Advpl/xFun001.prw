#Include "Protheus.ch"


/*/{Protheus.doc} xFun001
Exemplo de fun��o Advpl
@type user function
@author Fernando Rodrigues
@since 25/05/2025
/*/
User Function xFun001(nNumEnv)
  Local nNumero := 10
  Default nNumEnv := 0 

  If nNumero > nNumEnv
    Alert("nNumero � maior!")
  else
    Alert("� menor")
  EndIf

Return 

/*/{Protheus.doc} xChaFun
Chama fun��es que est� sendo utilizada no exemplo da aula
@type user function
@author Fernando Rodrigues
@since 25/05/2025
@version 12/Superiro

/*/
User Function xChaFun()
  U_xFun001(15)
Return 
