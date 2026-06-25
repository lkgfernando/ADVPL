#Include "Totvs.ch"
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
WSMETHOD GET  ID    DESCRIPTION 'Retorna o registro pesquisado' WSSYNTAX '/zWSProdutos/get_id?{id}'                         PATH 'get_id'   PRODUCES APPLICATION_JSON
WSMETHOD GET ALL    DESCRIPTION 'Retorna todos os registros'    WSSYNTAX '/zWSProduto/get_all?{updated_at, limit, page}'    PATH 'get_all'  PRODUCES APPLICATION_JSON
WSMETHOD POST NEW   DESCRIPTION 'Inclusão de registro'          WSSYNTAX '/zWSProduto/new'                                  PATH 'new'      PRODUCES APPLICATION_JSON

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



WSMETHOD GET ALL WSRECEIVE updated_at, limit, page WSSERVICE zWSProdutos
    Local lRet      := .T.
    Local jResponse := JsonObject():New()
    Local cQueryTab := ''
    Local nTamanho  := 10
    Local nTotal    := 0
    Local nPags     := 0
    Local nPagina   := 0
    Local nAtual    := 0
    Local oRegistro
    Local cAliasWS  := 'SB1'

    cQueryTab := " SELECT " + CRLF
    cQueryTab += "  TAB.R_E_C_N_O_ AS TABREC " + CRLF
    cQueryTab += "  FROM " + CRLF
    cQueryTab += "  " + RetSqlName(cAliasWS) + " TAB " + CRLF
    cQueryTab += "  WHERE " + CRLF
    cQueryTab += "  TAB.D_E_L_E_T_ = ' ' " + CRLF

    If ! Empty(::updated_at)
        cQueryTab += "  AND (( CASE WHEN SUBSTRING(B1_USERLGA, 03, 1) != '' THEN " + CRLF
        cQueryTab += "      CONVERT(VARCHAR, DATEADD(DAY, ((ASCII(SUBSTRING(B1_USERLGA, 12, 1)) - 50) * 100 + (ASCII(SUBSTRING(B1_USERLGA, 16,1)) - 50)), '19960101'),112) " + CRLF
        cQueryTab += "    ELSE  '' " + CRLF
        cQueryTab += "    END) >= '" + StrTran(::updated_at, '-', '') + "') " + CRLF
    EndIf

    cQueryTab += "  ORDER BY " + CRLF
    cQueryTab += "      TABREC " + CRLF

    TCQuery cQueryTab New Alias 'QRY_TAB'

    If QRY_TAB->(Eof())
        Self:setStatus(500)
        jResponse['errorId']    := 'ALL003'
        jResponse['error']      := 'Registro(s) não encotrado(s)'
        jResponse['solution']   := 'A consulta de registro não retornou nenhuma informação'
    Else
        jResponse['Objects'] := {}

        Count To nTotal
        QRY_TAB->(DbGoTop())
        
        If ! Empty(::limit)
            nTamanho := ::limit
        EndIf

        nPags := NoRound(nTotal / nTamanho, 0)
        nPags += Iif(nTotal % nTamanho != 0, 1, 0)

        If ! Empty(::page)
            nPagina := ::page
        EndIf

        If nPagina <= 0 .Or. nPagina > nPags
            nPagina := 1
        EndIf

        If nPagina != 1
            QRY_TAB->(DbSkip((nPagina - 1) * nTamanho))
        EndIf

        jJsonMeta := JsonObject():New()
        jJsonMeta['total'] := nTotal
        jJsonMeta['current_page']   := nPagina
        jJsonMeta['total_page']     := nPags
        jJsonMeta['total_itens']    := nTamanho
        jResponse['meta']           := jJsonMeta


        While ! QRY_TAB->(Eof())

            nAtual++

            If nAtual > nTamanho
                Exit
            EndIf

            dbSelectArea(cAliasWS)
            (cAliasWS)->(dbGoTo(QRY_TAB->TABREC))

            oRegistro := JsonObject():New()
            oRegistro['cod']    := (cAliasWS)->B1_COD
            oRegistro['desc']   := (cAliasWS)->B1_DESC      
            oRegistro['tipo']   := (cAliasWS)->B1_TIPO
            oRegistro['um']     := (cAliasWS)->B1_UM
            oRegistro['locpad'] := (cAliasWS)->B1_LOCPAD
            oRegistro['grupo']  := (cAliasWS)->B1_GRUPO

            aAdd(jResponse['Objects'], oRegistro)

            QRY_TAB->(dbSkip())
   
        EndDo

    EndIf

    QRY_TAB->(dbCloseArea())
    
    Self:SetContentType('application/json')
    Self:SetResponse(jResponse:toJSON())

Return lRet
