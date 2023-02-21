#Include "Totvs.ch"

/*/{Protheus.doc} User Function zFunc01
  (long_description)
  @type  Function
  @author Fernando Rodrdirgues
  @since 09/02/2023
  @version 1.0
  @param , , 
  @return , , 
  @example
  (examples)
  @see (links_or_references)
  /*/
User Function zFunc01()
  Local aArea := GetArea()
  Local cNome := "Fernando Rodrigues"

  //Fun��o AT()
  Local cfAT := AT("R", cNome) //Localiza a posi��o de um caracter na string

  Alert(AllTrim(cNome), "Aten��o") // Retira espa�os em branco da direita e da esquerda
  Alert(cfAT, "Aten��o")
  Alert(Len(cNome)) // Conta quantidade de caracter dentreo de uma string
  Alert("SubStr(): " + SubStr(cNome, 10, 3))

  
  RestArea(aArea)
Return 
