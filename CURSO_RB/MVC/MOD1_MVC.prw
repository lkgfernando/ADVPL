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
