#Include "Totvs.ch"


/*/{Protheus.doc} User Function zCalcFator
  (long_description)
  @type  Function
  @author Fernando Rodrigues
  @since 08/02/2023
  @version 1.0
  @param nFator, , 
  @return , , 
  @example
  (examples)
  @see (links_or_references)
  /*/
User Function zCalcFator(nFat)
  Local aArea := GetArea()
  Local nFator := nFat
  Local nResultado := 1
  Local nCnt

  //Calcula fatorial
  For nCnt := nFator To 1 Step -1
    nResultado *= nCnt
  Next nCnt

  //Exibir o resultado na tela, através da função alet

  Alert("O fatorial de " + cValToChar(nFator) + ;
        " é " + cValToChar(nResultado))
  
  RestArea(aArea)
Return 
