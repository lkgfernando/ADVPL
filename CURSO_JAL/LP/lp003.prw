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

  aAdd(aPergs,{1,"Digite o 1� numero",nA,"","","","",20,.T.})
  aAdd(aPergs,{1,"Digite o 2� numero",nB,"","","","",20,.T.})

  If ParamBox(aPergs, "Teste Par�metros....", aResps)
    nResult := aResps[1] + aResps[2]
    Alert("O Resultato: " + cValToChar(nResult) )
  else
    Alert("Processo cancelado pelo usu�rio") 
  EndIf

Return
