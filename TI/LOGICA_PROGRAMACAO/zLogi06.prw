#Include "Totvs.ch"

//Constantes
#Define STR_NOME "Terminal de Informa��o"

//Variaveis est�ticas

Static dDataHoje := Date()
Static dHoraHoje := Time()


/*/{Protheus.doc} User Function zLogi06
  (long_description)
  @type  Function
  @author Fernando Rodrigues
  @since 31/01/2023
  @version version
  @param , , 
  @return , , 
  @example
  (examples)
  @see (links_or_references)
  /*/
User Function zLogi06()
  Local aArea := GetArea()
  Local cNome := "Fernando"
  Private cSobreNome := "Rodrigues"
  Public __cCidade := "Artur Nogueira"

  //Mostranto as vari�veis
  MsgInfo(cNome + " " + cSobrenome + " est� em " + __cCidade + " no dia " + dToC(dDataHoje) + " as " + dHoraHoje, "Aten��o")

  fFuncTst()

  RestArea(aArea)

Return 

/*/{Protheus.doc} fFuncTst
  (long_description)
  @type  Static Function
  @author Fernando Rodrigues
  @since 31/01/2023
  @version 
  @param , , 
  @return , , 
  @example
  (examples)
  @see (links_or_references)
/*/
Static Function fFuncTst()
  Local aArea := GetArea()
  Local cNome := "..."

  MsgInfo(cNome + " " + cSobreNome, "Aten��o")

  RestArea(aArea)
Return 
