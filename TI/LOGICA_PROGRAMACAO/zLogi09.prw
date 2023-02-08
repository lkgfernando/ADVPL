#Include "Totvs.ch"


/*/{Protheus.doc} User Function zLogi09
  (long_description)
  @type  Function
  @author Fernando Rodrigues
  @since 08/02/2023
  @version version
  @param , , 
  @return , , 
  @example
  (examples)
  @see (links_or_references)
  /*/
User Function zLogi09()
  Local aArea :=  GetArea()
  Local cNome := ""
  Local cNome2 := ""

  cNome := "Fernando"
  cNome := cNome + " Rodrigues"

  // Operador ;
  cNome := "Fernando " + ; // Quebra linha do código
        "Rodrigues"
  

  //Operador @
  cNome := ""
  cNome2 := "Rodrigues"

  fFuncao(cNome, @cNome2)

  MsgInfo(cNome + " " + cNome2, "Atenção")

  RestArea(aArea)
Return 


/*/{Protheus.doc} fFuncao
  (long_description)
  @type  Static Function
  @author Fernando Rodrigues
  @since 
  @version version
  @param var1,var2, , 
  @return , , 
  @example
  (examples)
  @see (links_or_references)
/*/
Static Function fFuncao(cVar1,cVar2)
  cVar1 := "Variável 1"
  cVar2 := "Vaviável 2"

Return 
