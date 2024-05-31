#Include 'Totvs.ch'
#Include 'FWMVCDef.ch'

Static cTitulo   := "Cadastro Prato x Ingredientes"
Static cTabPai   := "Z01"
Static cTabFilho := "Z02"


/*/{Protheus.doc} User Function QKCAD01
    Cadastro de prato e a composição dos ingreditens
    @type  Function
    @author Fernando Rodrigues
    @since 06/08/2023
    @version 1.0
    @param , , 
    @return Nil, , 
    @example
    (examples)
    @see (links_or_references)
    /*/
User Function QKCAD01()
    Local aArea := FWGetArea()
    Local oBrowse
    Private aRotina := {}

    aRotina := MenuDef()

    oBrowse := FWMBrowse():New()
    oBrowse:SetAlias(cTabPai)
    oBrowse:SetDescription(cTitulo)
    oBrowse:DisableDetails()
    //oBrowse:AddLegend("Z2_MSBLQL <> '2'", "RED", "Bloqueado")
    //oBrowse:AddLegend("Z2_MSBLQL == '2'", "GREEN", "Ativo")

    oBrowse:Activate()

    FWRestArea(aArea)

Return Nil


/*/{Protheus.doc} MenuDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 06/08/2023
    @version 1.0
    @param , , 
    @return aRotina, , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function MenuDef()
    Local aRotina := {}

    ADD OPTION aRotina TITLE "Visualizar" ACTION "VIEWDEF.QKCAD01" OPERATION 1 ACCESS 0 
    ADD OPTION aRotina TITLE "Incluir" ACTION "VIEWDEF.QKCAD01" OPERATION 3 ACCESS 0 
    ADD OPTION aRotina TITLE "Alterar" ACTION "VIEWDEF.QKCAD01" OPERATION 4 ACCESS 0 
    ADD OPTION aRotina TITLE "Excluir" ACTION "VIEWDEF.QKCAD01" OPERATION 5 ACCESS 0 

Return aRotina


/*/{Protheus.doc} ModelDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 06/08/2023
    @version 1.0
    @param , , 
    @return oModel, , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function ModelDef()
    Local oStruPai   := FWFormStruct(1, cTabPai)
    Local oStruFilho := FWFormStruct(1, cTabFilho)
    Local aRelation  := {}
    Local oModel
    Local bPre       := Nil
    Local bPos       := Nil
    Local bCommit    := Nil
    Local bCancel    := Nil

    oModel := MPFormModel():New("QKCAD01M", bPre, bPos, bCommit, bCancel)
    oModel:AddFields("Z01MASTER", /*cOwner*/, oStruPai, /*{|oModel| u_QKCAD01B(oModel)}*/)
    oModel:AddGrid("Z02DETAIL", "Z01MASTER", oStruFilho, {|oModel| u_QKCAD01A(oModel)})
    oModel:SetDescription("Modelo de dados " + cTitulo)
    oModel:GetModel("Z01MASTER"):SetDescription("Dados de - " + cTitulo)
    oModel:GetModel("Z02DETAIL"):SetDescription("Grid de - " + cTitulo)
    oModel:SetPrimaryKey({})

    //Fazendo o Relacionamento
    aAdd(aRelation, {"Z02_FILIAL", "FWxFilial('Z02')"})
    aAdd(aRelation, {"Z02_CODZ01", "Z01_COD"})
    oModel:SetRelation("Z02DETAIL", aRelation, Z02->(IndexKey(1)))

    oModel:GetModel("Z02DETAIL"):SetUniqueLine({'Z02_COD'})

Return oModel

/*/{Protheus.doc} ViewDef
    (long_description)
    @type  Static Function
    @author Fernando Rodrigues
    @since 06/08/2023
    @version 1.0
    @param , , 
    @return oView, , 
    @example
    (examples)
    @see (links_or_references)
/*/
Static Function ViewDef()
    Local oModel := FWLoadModel("QKCAD01")
    Local oStruPai := FWFormStruct(2, cTabPai)
    Local oStruFilho := FWFormStruct(2, cTabFilho)
    Local oView

    oView := FWFormView():New()
    oView:SetModel(oModel)
    oView:AddField("VIEW_Z01", oStruPai, "Z01MASTER")
    oView:AddGrid("VIEW_Z02", oStruFilho, "Z02DETAIL")

    oView:CreateHorizontalBox("CABEC", 30)
    oView:CreateHorizontalBox("GRID", 70)
    oView:SetOwnerView("VIEW_Z01", "CABEC")
    oView:SetOwnerView("VIEW_Z02", "GRID")

    oView:EnableTitleView("VIEW_Z01", "Cabeçalho - Z01 (Pratos)")
    oView:EnableTitleView("VIEW_Z02", "Grid - Z02 (Ingredientes)")

    oStruFilho:RemoveField("Z02_CODZ01")

    oView:AddIncrementField("VIEW_Z02", "Z02_ITEM")
    //oView:Refresh()

Return oView

/*/{Protheus.doc} QKCAD01A
(long_description)
@type user function
@author Fernando Rodrigues
@since 29/05/2024
@version 12/
@param oModelZ02, , 
@return .T., , 
@example
(examples)
@see (links_or_references)
/*/
User Function QKCAD01A(oModelZ02)
    Local aArea     := FwGetArea()
    Local oModel    := FwModelActive()
    Local oModelZ01 := oModel:GetModel( 'Z01MASTER' )
    Local nTotal    := 0
    Local nValVen   := 0
    Local nI        := 0

    For nI := 1 To oModelZ02:Length()

        oModelZ02:GoLine(nI)

        If oModelZ02:IsDeleted()
            Loop
        EndIf

        nTotal += oModelZ02:GetValue('Z02_CUSTO')
    Next

    oModelZ01:LoadValue('Z01_VLRCUS', nTotal)
    
    nValVen := oModelZ01:GetValue('Z01_MARGEM') * oModelZ01:GetValue('Z01_VLRCUS')
    oModelZ01:LoadValue('Z01_PRCVEN', nValVen)

    FwRestArea(aArea)
Return .T.


/*/{Protheus.doc} QKCAD01AB
(long_description)
@type user function
@author Fernando Rodrigues
@since 29/05/2024
@version 12/
@param oModelZ01, , 
@return .T., , 
@example
(examples)
@see (links_or_references)
/*/
User Function QKCAD01B(oModelZ01)
    Local aArea := FwGetArea()
    Local oModel := FwModelActive()
    Local oModelCalc := oModel:GetModel('Z01MASTER')
    Local nVlVenda := 0
    
    

    nVlVenda := oModelZ01:GetValue('Z01_MARGEM') * oModelZ01:GetValue('Z01_VLRCUS')

    oModelCalc:LoadValue('Z01_PRCVEN', nVlVenda)


    FwRestArea(aArea)
Return .T.
