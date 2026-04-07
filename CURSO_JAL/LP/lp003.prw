#Include "Protheus.ch"

/*/{Protheus.doc} SomaDois
(long_description)
@type user function
@author Fernando Rodrigues
@since 07/04/2025
/*/
User Function SomaDois()
  Local aResps  := {}
  Local aPergs  := {}
  Local nA      := 0
  Local nB      := 0
  Local nResult := 0

  aAdd(aPergs,{1,"Digite o 1º numero",nA,"9999","","","",20,.T.})
  aAdd(aPergs,{1,"Digite o 2º numero",nB,"9999","","","",20,.T.})

  If ParamBox(aPergs, "Teste Parâmetros....", aResps)
    nResult := aResps[1] + aResps[2]
    Alert("O Resultato: " + cValToChar(nResult) )
  else
    Alert("Processo cancelado pelo usuário") 
  EndIf

Return

/*/{Protheus.doc} SomaSeq
(long_description)
@type user function
@author Fernando Rodrigues
@since 09/04/2025
@version 
(examples)
Faça um programa que some os nuemros da sequencia de 1 a 100 e exibir o resultado
@see (links_or_references)
/*/
User Function SomaSeq()
  Local nX  := 0
  Local nResult := 0

  For nX := 1 To 100
    nResult += nX
  Next nX

  Alert(cValToChar(nResult))

Return 

/*/{Protheus.doc} SomaPar
(long_description)
@type user function
@author Fernando Rodrigues
@since 09/04/2025
@example
Faça um programa que soma numeros pares e multiplique os numeros impares de 1 a 100 e exibir o resultado
/*/
User Function SomaPar()
  Local nX    := 0
  Local nResPar := 0
  Local nResImp := 0

  For nX := 1 To 100
    If nX % 2 == 0
      nResPar += nX
    else
      If nX == 1 
        nResImp := 1
      else
        nResImp *= nX
      EndIf
    EndIf
  Next nX 
  Alert("A soma dos números pares é: "+cValToChar(nResPar))
  Alert("A multiplicação dos números impares é: "+cValToChar(nResImp))

Return 

/*/{Protheus.doc} SomaPri
(long_description)
@type user function
@author Fernando Rodrigues
@since 09/04/2025
@version 
@param , , 
@return , , 
@example
(examples)
@see (links_or_references)
/*/
User Function SomaPri()
  Local nResult    := 0
  Local nI         := 0
  Local nJ         := 0
  Local nContador  := 0

  For nI := 1 To 1000
    nContador := 0
    For nJ := 1 To nI
      If nI % nJ == 0
        nContador++
      EndIf
    Next nJ

    If nContador == 2
      nResult += nI
    EndIf

  Next nI 
  
  Alert("A soma dos números pares é: "+cValToChar(nResult))

Return 
