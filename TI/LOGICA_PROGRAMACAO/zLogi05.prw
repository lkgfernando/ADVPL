#Include "Totvs.ch"

/*/{Protheus.doc} User Function zLogi05
  (long_description)
  @type  Function
  @author user
  @since 31/01/2023
  @version version
  @param param_name, param_type, param_descr
  @return return_var, return_type, return_description
  @example
  (examples)
  @see (links_or_references)
  /*/
User Function zLogi05()
  Local aArea := GetArea()

  //Chamando a função A
  fFuncaoA()

  //Chamando a função B
  fFuncaoB()

  //Chamando a função C
  fFuncaoC()

  //Chamando a função de teste
  fFuncaoTst()

  RestArea(aArea)
Return

/*/{Protheus.doc} fFuncaoA
  (long_description)
  @type  Static Function
  @author Fernando Rodrigues
  @since 31/01/2023
  @version version
  @example
  (examples)
  @see (links_or_references)
/*/
Static Function fFuncaoA()
  MsgInfo("Estou na static function A", "Static Function A")
Return 

/*/{Protheus.doc} fFuncaoB
  (long_description)
  @type  Static Function
  @author Fernando Rodrigues
  @since 31/01/2023
  @version version
  @param , , 
  @return , , 
  @example
  (examples)
  @see (links_or_references)
/*/
Static Function fFuncaoB()
  MsgInfo("Estou na função B", "Static Function B")
Return 

/*/{Protheus.doc} fFuncaoC
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
Static Function fFuncaoC()
  MsgInfo("Estou na função C", "Static Function C")
Return 

/*/{Protheus.doc} fFuncaoTst
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
Static Function fFuncaoTst()
  MsgInfo("Estou na função Teste", "Static function TST")
Return 
