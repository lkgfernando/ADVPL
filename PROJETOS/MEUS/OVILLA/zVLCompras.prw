#Include "Totvs.ch"
#Include "FWMVCDef.ch"


/*/{Protheus.doc} User Function zVLCompras
    (long_description)
    @type  Function
    @author Fernando José Rodrigues
    @since 26/05/2023
    @version 1.0
    @param , , 
    @return Nil, , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function zVLCompras()
    Local aArea := FWGetArea()
    Local oBrowse

    oBrowse := FWMBrowse():New()
    oBrowse:SetAlias('ZC1')
    oBrowse:SetDescription('Compras Semanais')

    oBrowse:Activate()
    

    FWRestArea(aArea)

Return Nil

/*/{Protheus.doc} MenuDef
    (long_description)
    @type  Static Function
    @author Fernando José Rodrigues
    @since 31/05/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function MenuDef()
    Local aRotina := {}


    ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEW.zVLCompras" OPERATION 1 ACCESS 0
    ADD OPTION aRotina TITLE "Incluir" ACTION "VIEW.zVLCompras" OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE "Alterar" ACTION "VIEW.zVLCompras" OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE "Excluir" ACTION "VIEW.zVLCompras" OPERATION 5 ACCESS 0
    ADD OPTION aRotina TITLE "Imprimir" ACTION "VIEW.zVLCompras" OPERATION 8 ACCESS 0
    ADD OPTION aRotina TITLE "Copiar" ACTION "VIEW.zVLCompras" OPERATION 9 ACCESS 0

Return aRotina


/*/{Protheus.doc} ModelDef
    (long_description)
    @type  Static Function
    @author Fernando José Rodrigues
    @since 31/05/2023
    @version version
    @param , , 
    @return oModel, return_type, return_description
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function ModelDef()
    Local oStruct := FWFormStruct(1, cAliasMVC)
    
Return oModel
