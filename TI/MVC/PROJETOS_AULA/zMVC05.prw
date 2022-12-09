#Include "Totvs.ch"
#Include "FWMVCDef.ch"


/*/{Protheus.doc} User Function zMVC05
    (long_description)
    @type  Function
    @author Fernando Rodrigues
    @since 07/12/2022
/*/
User Function zMVC05()
    Private oMark
    Private aRotina := {}

    aRotina := MenuDef()

    oMark := FwMarkBrowse():New()
    oMark:Setalias('ZD1')

    oMark:SetSemaphore(.T.)
    oMark:SetDescription('Seleção do Cadastro de Artista')
    oMark:SetFieldMark('ZD1_OK')

    oMark:Activate()

Return Nil

/*/{Protheus.doc} MenuDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 08/12/2022
/*/
Static Function MenuDef()
    Local aRotina := {}
    
    ADD OPTION aRotina TITLE 'Processar' ACTION 'U_zMarkProc' OPERATION 2 ACCESS 0

Return aRotina

/*/{Protheus.doc} User Function zMarkProc
    (long_description)
    @type  Function
    @author Fernando Rodrigues
    @since 08/12/2022
/*/
User Function zMarkProc()
    Local aArea := FWGetArea()
    Local cMarca := oMark:Mark()
    Local nTotal := 0

    ZD1->(DbGoTop())
    While ! ZD1->(EOF())

        If oMark:IsMark(cMarca)
            nTotal++

            //Limpando o campo ZD1_OK
            RecLock('ZD1', .F.)
                ZD1_OK := ''
            ZD1->(MsUnlock())
        EndIf

        ZD1->(DbSkip())

    EndDo

    MsgInfo('Foram marcados <b>' + cValToChar( nTotal ) + ' artistas </b>.', "Atenção")

    FWRestArea(aArea)
Return
