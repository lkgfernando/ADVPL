#INCLUDE 'Totvs.CH'
#INCLUDE 'FWMVCDEF.CH'


/*/{Protheus.doc} MOD1_MVC
    Montagem da tela em MVC da tabela SZ1

    @author Fernando Jose Rodrigues

    @since 30/08/2022

/*/
User Function ZMOD1()
    Local aArea := FWGetArea()
    Local oBrowse
    Private aRotina := {}

    aRotina := MenuDef()

    oBrowse := FwMBrowse():New()
    oBrowse:SetAlias("SZ1")
    oBrowse:SetDescription('Cadastro de UM Cliente')
    oBrowse:AddLegend("SZ1->Z1_TIPO == 'D'", "YELLOW",   "Divide")
    oBrowse:AddLegend("SZ1->Z1_TIPO == 'M'", "GREEN" ,   "Multiplica")

    //oBrowse:DisableDetail()
    oBrowse:Activate()

    FWRestArea(aArea)
Return Nil


/*/{Protheus.doc} MenuDef
    Montagem do menu em MVC

    @author Fernando José Rodrigues
    @since 30/08/2022

/*/
Static Function MenuDef()
    Local aRotina := {}

    ADD OPTION aRotina Title 'Visualizar' Action 'VIEWDEF.ZMOD1' OPERATION 2 ACCESS 0
    ADD OPTION aRotina Title 'Incluir'    Action 'VIEWDEF.ZMOD1' OPERATION 3 ACCESS 0
    ADD OPTION aRotina Title 'Alterar'    Action 'VIEWDEF.ZMOD1' OPERATION 4 ACCESS 0
    ADD OPTION aRotina Title 'Excluir'    Action 'VIEWDEF.ZMOD1' OPERATION 5 ACCESS 0
    ADD OPTION aRotina Title 'Imprimir'   Action 'VIEWDEF.ZMOD1' OPERATION 8 ACCESS 0
    ADD OPTION aRotina Title 'Copiar'     Action 'VIEWDEF.ZMOD1' OPERATION 9 ACCESS 0

    // ADD OPTION aRotina  TITLE "Pesquisar"    ACTION "PesqBrw"            OPERATION 1 ACCESS 0
    // ADD OPTION aRotina  TITLE "Visualizar"   ACTION "VIEWDEF."   OPERATION 2 ACCESS 0
    // ADD OPTION aRotina  TITLE "Incluir"      ACTION "VIEWDEF."   OPERATION 3 ACCESS 0
    // ADD OPTION aRotina  TITLE "Alterar"      ACTION "VIEWDEF."   OPERATION 4 ACCESS 0
    // ADD OPTION aRotina  TITLE "Excluir"      ACTION "VIEWDEF."   OPERATION 5 ACCESS 0
    // ADD OPTION aRotina  TITLE "Imprimir"     ACTION "VIEWDEF."   OPERATION 8 ACCESS 0
    // ADD OPTION aRotina  TITLE "Copiar"       ACTION "VIEWDEF."   OPERATION 9 ACCESS 0

Return aRotina


/*/{Protheus.doc} ModelDef
    Cria a etrutura a ser usada no modelo de dados
    @type  Static Function
    @author Fernando Jose rodrigues
    @since 30/08/2022
/*/
Static Function ModelDef()
    Local oStruSZ1 := FWFormStruct(1, "SZ1")
    Local oModel

    oModel := MPFormModel():New("ZMOD1M", Nil, Nil, Nil, Nil)

    oModel:AddFields('SZ1MASTER', , oStruSZ1)

    oModel:SetDescription( 'Modelo de dados de UM Clientes')

    oModel:GetModel("SZ1MASTER"):SetDescription('Dados de UM Cliente')
    
    oModel:SetPrimaryKey({})

    //oModel:SetVldActivate( { |oModel| MOD1ACT( oModel )})


Return oModel

/*/{Protheus.doc} ViewDef
    Cria um objeto de Modelo de dados baseado no Model Def no fonte informado
    @type  Static Function
    @author Fernando José Rodrigues
    @since 30/08/2022
/*/
Static Function ViewDef()
    Local oModel := FWLoadModel("ZMOD1")
    Local oStruSZ1 := FWFormStruct(2, "SZ1")
    Local oView

    //Cria a visualizacao do cadastro
	oView := FWFormView():New()
	oView:SetModel(oModel)
	oView:AddField("VIEW_SZ1", oStruSZ1, "SZ1MASTER")
	oView:CreateHorizontalBox("TELA" , 100 )
	oView:SetOwnerView("VIEW_SZ1", "TELA")

    // oView := FWFormView():New()

    // oView:SetModel( oModel )

    // oView:AddField( 'VIEW_SZ1', oStruSZ1, 'SZ1MASTER')

    // //oStruSz1:RemoveField('Z1_MVC')

    // oView:CreateHorizontalBox( 'TELA', 100 )

    // //oView:SetCloseOnOk({|| .T.})

    // oView:SetOwnerView( 'VIEW_SZ1', 'TELA')
    
    
    
Return oView

// /*/{Protheus.doc} MOD1CPOS
//         Montagem view em MVC
//     @type  Static Function
//     @author Fernando Jose Rodrigues
//     @since 30/08/2022
// /*/
// Static Function MOD1CPOS(oModel)
//     Local nOperation := oModel:GetOperation()
//     Local lRet       := .T.

//     If nOperation == 4
//         If Empty( oModel:GetValue( 'SZ1MASTER', 'Z1_MVC'))
//             Help( ,, 'HELP',, 'Informe o campo MVC', 1, 0)
//             lRet := .F.
//         EndIf
//     EndIf    
// Return lRet

// /*/{Protheus.doc} MOD1ACT
//     Passa o model sem dados
//     @type  Static Function
//     @author Fernando José Rodrigues
//     @since 30/08/2022
// /*/
// Static Function MOD1ACT(oModel)
//     Local aArea         := GetArea()
//     Local cQuery        := ''
//     Local cTmp          := ''
//     Local lRet          := .T.
//     Local nOperation    := oModel:GetOperation()

//     If nOperation == 5 .And. lRet
//         cTmp := GetNextAlias()

//         cQuery := " SELECT Z1_CLIENT FROM " + RetSqlName('SZ1') + " Z1 "
//         cQuery += "WHERE EXIXTS ( "
//         cQuery += "         SELECT 1 FROM " + RetSqlName('SA1') + " A1 "
//         cQuery += "         WHERE Z1_CLIENT = A1_COD AND Z1_LOJA = A1_LOJA"
//         cQuery += "         AND A1.D_E_L_E_T <> '*' "
//         cQuery += "         AND Z1_CLIENT = '" + SZ1->Z1_CLIENT + "' "
//         cQuery += "         AND Z1.D_E_L_E_T = ' ' "
//     EndIf

//     dbUseArea(.T., "TOPCONN", TcGenQry( ,, cQuery), cTmp, .F., .T.)

//     lRet := (cTmp)-> ( EOF())
//     (cTmp)->(dbCloseArea())

//     If !lRet
//         Help( , , 'HELP',, 'Este Cadastro não pode ser excluido.', 1, 0)
//     EndIf

//     RestArea(aArea)
// Return lRet 
