#Include "Protheus.ch"
#Include "RESTFul.ch"
#Include "TopConn.ch"


/*/{Protheus.doc} 
(long_description)
@type user function
@author 
@since 
@version 
@param , , 
@return , , 
@example
(examples)
@see (links_or_references)
/*/
WSRESTFUL zWSProdutos DESCRIPTION 'WebService Cadastro de Produtos'

WSDATA id           AS STRING
WSDATA updated_at   AS STRING
WSDATA limit        AS INTEGER
WSDATA page         AS INTEGER

// Métodos
WSMETHOD GET  ID  DESCRIPTION 'Retorna o registro pesquisado' WSSYNTAX '/zWSProdutos/get_id?{id}'                       PATH 'get_id'   PRODUCES APPLICATION_JSON
//WSMETHOD GET ALL    DESCRIPTION 'Retorna todos os registros'    WSSYNTAX '/zWSProduto/get_all?{updated_at, limit, page}'    PATH 'get_all'  PRODUCES APPLICATION_JSON
//WSMETHOD POST NEW   DESCRIPTION 'Inclusão de registro'          WSSYNTAX '/zWSProduto/new'                                  PATH 'new'      PRODUCES APPLICATION_JSON

ENDWSRESTFUL 


/*/{Protheus.doc} WSMETHOD GET ID WSRECEIVE id 
(long_description)
@type user function
@author user
@since 06/05/2026
@version version
/*/
WSMETHOD GET ID WSRECEIVE id WSSERVICE zWSProdutos
    Local lRet      := .T.
    Local jResponse := JsonObject():New()
    Local cAliasWS  := 'SB1'


    If Empty(::id)
        Self:setStatus(500)
        jResponse['errorId']    := 'ID001'
        jResponse['error']      := 'ID vazio'
        jResponse['solution']   := 'Informe o ID'
    Else

        dbSelectArea(cAliasWS)
        (cAliasWS)->(dbSetOrder(1))

        If ! (cAliasWS)->(MsSeek(FWxFilial(cAliasWS) + ::id))
            Self:setStatus(500)
            jResponse['errorId']    := 'ID002'
            jResponse['error']      := 'ID não encontrado'
            jResponse['solution']   := 'Informe um ID válido na tabela ' +  cAliasWS
            
        Else
            jResponse['cod']    := (cAliasWS)->B1_COD
            jResponse['desc']   := (cAliasWS)->B1_DESC
            jResponse['tipo']   := (cAliasWS)->B1_TIPO
            jResponse['um']     := (cAliasWS)->B1_UM
            jResponse['locpad'] := (cAliasWS)->B1_LOCPAD
            jResponse['grupo']  := (cAliasWS)->B1_GRUPO
        EndIf

    EndIf

    Self:SetContentType('application/json')
    Self:SetResponse(jResponse:toJSON())

Return lRet
