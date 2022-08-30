#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'FWMVCDEF.CH'


/*/{Protheus.doc} MOD1_MVC
    Montagem da tela em MVC da tabela SZ1

    @author Fernando Jose Rodrigues

    @since 30/08/2022

/*/
User Function MOD1_MVC()
    Local oBrowse

    oBrowse := FwMBrowse():New()
    oBrowse:SetAlias('SZ1')
    oBrowse:SetDescription('Cadastro de UM Cliente')
    oBrowse:AddLegend("Z1_TIPO == 'D'", "YELLOW",   "Divide")
    oBrowse:AddLegend("Z1_TIPO == 'M'", "GREEN" ,   "Multiplica")

    oBrowse:DisableDetail()
    oBrowse:Activate()

Return Nil


/*/{Protheus.doc} MenuDef
    Montagem do menu em MVC

    @author Fernando José Rodrigues
    @since 30/08/2022

/*/
Static Function MenuDef()
    Local aRotina := {}

    ADD OPTION aRotina  TITLE 'Pesquisar'   ACTION 'PesqBrw'                    OPERATION 1 ACCESS 0
    ADD OPTION aRotina  TITLE 'Visualizar'  ACTION 'VIEWDEF.MOD1_MVC'           OPERATION 2 ACCESS 0
    ADD OPTION aRotina  TITLE 'Incluir'     ACTION 'VIEWDEF.MOD1_MVC'           OPERATION 3 ACCESS 0
    ADD OPTION aRotina  TITLE 'Alterar'     ACTION 'VIEWDEF.MOD1_MVC'           OPERATION 4 ACCESS 0
    ADD OPTION aRotina  TITLE 'Excluir'     ACTION 'VIEWDEF.MOD1_MVC'           OPERATION 5 ACCESS 0
    ADD OPTION aRotina  TITLE 'Imprimir'    ACTION 'VIEWDEF.MOD1_MVC'           OPERATION 8 ACCESS 0
    ADD OPTION aRotina  TITLE 'Copiar'      ACTION 'VIEWDEF.MOD1_MVC'           OPERATION 9 ACCESS 0

Return aRotina


/*/{Protheus.doc} ModelDef
    Cria a etrutura a ser usada no modelo de dados
    @type  Static Function
    @author Fernando Jose rodrigues
    @since 30/08/2022
/*/
Static Function ModelDef(param_name)
    Local oStruSZ1 := FWFormStruct(1, 'SZ1', /*bAvalCampo*/, /*lViewUsado*/)
    Local oModel

    oModel := MPFormModel():New('MOD1MVCM', , , ,)

    oModel:AddFields('SZ1MASTER', , oStruSZ1, , , , )

    oModel:SetPrimaryKey({'Z1_FILIAL,', 'Z1_CLIENT', 'Z1_LOJA'})

    oModel:SetDescription( 'Modelo de dados de UM Clientes')

    oModel:GetModel( 'SZ1MASTER' ):SetDescription('Dados de UM Cliente')

    oModel:SetVldActivate( { |oMOdel| MOD1ACT( oMOdel )})


Return oModel

/*/{Protheus.doc} ViewDef
    Cria um objeto de Modelo de dados baseado no Model Def no fonte informado
    @type  Static Function
    @author Fernando José Rodrigues
    @since 30/08/2022
/*/
Static Function ViewDef()
    
    
Return return_var
