#Include "Totvs.ch"
#Include "FwMvcDef.ch"


/*/{Protheus.doc} User Function Zs1Semana
    (long_description)
    @type  Function
    @author Fernando Rodrigues
    @since 22/05/2023
    @version 1.0
    @param , , 
    @return , , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function Zs1Semana()
    Local oBrowse

    oBrowse := FWMBrowse():New()
    oBrowse:SetAlias('ZS1')
    oBrowse:SetDescription('Cadastro de Semanas')
    
    oBrowse:DisableDetails()
    oBrowse:Activate()

Return Nil 


/*/{Protheus.doc} MenuDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 22/05/2023
    @version 1.0
    @param , , 
    @return aRotina, , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function MenuDef()
    Local aRotina := {}

    ADD OPTION aRotina TITLE 'Pesquisar' ACTION 'PesqBrw'       OPERATION 1 ACCESS 0
    ADD OPTION aRotina TITLE 'Visualizar'   ACTION 'VIEWDEF.Zs1Semana' OPERATION 2 ACCESS 0
    ADD OPTION aRotina TITLE 'Incluir'      ACTION 'VIEWDEF.Zs1Semana' OPERATION 3 ACCESS 0
    ADD OPTION aRotina TITLE 'Alterar'      ACTION 'VIEWDEF.Zs1Semana' OPERATION 4 ACCESS 0
    ADD OPTION aRotina TITLE 'Excluir'      ACTION 'VIEWDEF.Zs1Semana' OPERATION 5 ACCESS 0
    ADD OPTION aRotina TITLE 'Imprimir'     ACTION 'VIEWDEF.Zs1Semana' OPERATION 8 ACCESS 0
    ADD OPTION aRotina TITLE 'Copiar'       ACTION 'VIEWDEF.Zs1Semana' OPERATION 9 ACCESS 0

Return aRotina



/*/{Protheus.doc} ModelDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 22/05/2023
    @version 1.0
    @param , , 
    @return oModel, , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function ModelDef()
    Local oStruZS1 := FWFormStruct( 1, 'ZS1', /*bAvalCampo*/, /*lViewUsado*/)
    Local oModel

    // Remove campos da estrutura
    //oStruZS1:RemoveField('campo que deseja remover')

    oModel := MPFormModel():New('MOD1ZS1', /*bPreValidacao*/, /*bPosValidacao*/, /*bCommit*/, /*bCancel*/)

    //Adiciona modelo uma estrutura de formulário de edição por campo
    oModel:AddFields( 'ZS1MASTER', /*cOwner*/, oStruZS1, /*bPreValidacao*/, /*bPosValidacao*/, /*bCarga*/ )

    oModel:SetPrimaryKey({'ZS1_FILIAL', 'ZS1_COD', 'ZS1_ANO'})

    oModel:SetDescription('Modelo de dados Cadastros Semanais')

    oModel:GetModel('ZS1MASTER'):SetDescription('Dados Semanais')

    //oModel:SetVldActivate( {|oModel| MOD1ACT( oModel )} )
    

Return oModel

/*/{Protheus.doc} ViewDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 22/05/2023
    @version 1.0
    @param , , 
    @return oView, , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function ViewDef()
    Local oModel := FWLoadModel( 'Zs1Semana' )

    Local oStruZS1 := FWFormStruct(2, 'ZS1')

    Local oView

    oView := FWFormView():New()

    oView:SetModel(oModel)

    oView:AddField('VIEW_ZS1', oStruZS1, 'ZS1MASTER')

    oView:CreateHorizontalBox('TELA', 100)

    oView:SetOwnerView('VIEW_ZS1', 'TELA')

    oView:SetCloseOnOk({|| .T.})

Return oView
