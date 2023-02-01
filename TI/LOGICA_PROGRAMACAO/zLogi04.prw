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

    As nomenclaturas utilizadas, geralmente são:
    AABBBXNN, onde:
    AA ==> Sigla da empresa
    BBB ==> Módulo da função
    X ==> Tipo (Atualização, consulta, Relatório, Miscelania, Job, etc..)
    NN ==> Sequência, por exemplo:
    ASFATR87 ==> Atilio Sistemas, faturamento, Relatório, sequência 87.

    Se for fontes genéricos, de uma lib por exemplo, iniciamos a função de usuário com a letra "z"

    Já as funções estáticas não tem limitação de tamanho de caracteres (até 10)
    Para seguir um padrão, tentamos começar com elas utilizando a letra "f"
  (examples)
  @see (links_or_references)
  /*/
User Function zLogi04()
  Local aArea := GetArea()

  MsgInfo("Estou utilizando a User function zLogi04", "Atenção!!")

  RestArea(aArea)
  
Return 
