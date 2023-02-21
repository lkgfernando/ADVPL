#Include "Totvs.ch"

/*/{Protheus.doc} User Function zLogi10
  (long_description)
  @type  Function
  @author Fernando Rodrigues
  @since 16/02/2023
  @version 1.0
  @param , , 
  @return , , 
  @example
  (examples)
  @see (links_or_references)
  /*/
User Function zLogi10(cIndent)
  Local aArea := GetArea()
  Local cNome := cIndent
  Local cCompara := "FERNANDO"

  If Upper(cNome) == cCompara
    Alert("Olá " + cNome + " Seja bem vido ao nosso sistema")
  ElseIf Upper(cNome) == "NOVO CLIENTE"
    Alert("Seja bem vindo ao sue primeiro acesso " + cNome)
  Else
    Alert("Inicie seu cadastro!!!! " + cNome)
  EndIf
  
  RestArea(aArea)
Return 
