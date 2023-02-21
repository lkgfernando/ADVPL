#Include "Totvs.ch"


/*/{Protheus.doc} User Function zLogi11
  (long_description)
  @type  Function
  @author Fernando Rodrigues
  @since 16/02/2023
  @version 1.00
  @param , , 
  @return , , 
  @example
  (examples)
  @see (links_or_references)
  /*/
User Function zLogi11()
  Local aArea := GetArea()
  Local cNome := ""
  Local nTipo := 0

  cNome := Upper("Maria")

  Do Case
    Case cNome == "FERNANDO"
      nTipo := 1
    Case cNome == "MARIA"
      nTipo := 2
    Case cNome == "KAUAN"
      nTipo := 3
    
    OtherWise
      nTipo := 4
      
  EndCase

  Alert("O tipo é " + cValToChar(nTipo))

  RestArea(aArea)
Return 
