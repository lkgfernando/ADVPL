#Include "Totvs.ch"

/*/{Protheus.doc} User Function zLogi04
  (long_description)
  @type  Function
  @author Fernando Rodrigues
  @since 31/01/2023
  @version version
  @param , , 
  @return , , 
  @example
  @obs O tipo User function pode ser chamado em qualquer lugar do Protheus com 
    o prefixo U_ (letra U com underscore/underline), por exemplo, u_Logi04()

    As nomenclaturas utilizadas, geralmente s�o:
    AABBBXNN, onde:
    AA ==> Sigla da empresa
    BBB ==> M�dulo da fun��o
    X ==> Tipo (Atualiza��o, consulta, Relat�rio, Miscelania, Job, etc..)
    NN ==> Sequ�ncia, por exemplo:
    ASFATR87 ==> Atilio Sistemas, faturamento, Relat�rio, sequ�ncia 87.

    Se for fontes gen�ricos, de uma lib por exemplo, iniciamos a fun��o de usu�rio com a letra "z"

    J� as fun��es est�ticas n�o tem limita��o de tamanho de caracteres (at� 10)
    Para seguir um padr�o, tentamos come�ar com elas utilizando a letra "f"
  (examples)
  @see (links_or_references)
  /*/
User Function zLogi04()
  Local aArea := GetArea()

  MsgInfo("Estou utilizando a User function zLogi04", "Aten��o!!")

  RestArea(aArea)
  
Return 
