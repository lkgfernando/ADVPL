#Include "Protheus.ch"
#INCLUDE 'FWMVCDEF.CH'

/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���Funcao    �SIMULACAO FRETE   �Autor  �PAULO BINDO       � Data �  05/09/10   ���
������������������������������������������������������������������������������͹��
���Desc.     �SIMULA O FRETE                                                   ���
���          �												           	       ���
������������������������������������������������������������������������������͹��
���Uso       �SigaFat                                                          ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/


User Function ESTRD006(aRet,aRet2,aRet3)
	Local aCoors := FWGetDialogSize( oMainWnd )
	Local oPanelUp As Object
	Local oFWLayer As Object
	Local oPanelLeft As Object
	Local oPanelRight As Object
	Local oBrowseUp As Object
	Local oBrowseLeft As Object
	Local oBrowseRight As Object
	Local nItemMrk	:= 0
	Local oDlgPrinc As Object
	Local oSayCod  As Object
	Local oSay := NIL // CAIXA DE DI�LOGO GERADA

	Private cAlias := "TRB4"
	Private oTempTable
	Private c2Alias := "TRB2"
	Private o2TempTable
	Private c3Alias := "TRB3"
	Private o3TempTable
	Private cMark      := GetMark()


	//CARREGA DADOS
	FwMsgRun(NIL, {|oSay| LoadTRB1(aRet,aRet2,aRet3,oSay)}, "Processing", "Starting process...")


	//aAdd (aRet, {nNumCalc,cCodTransp,cNomeTRansp,nValFrete,nPrzEntr,cTpCalc,cTpFrete,cCidCol,cCidCalc,cAgrup,nValPis,nValCof,nValISS,nMelhorNeg})

	aBrowse := {{"N�mero C�lculo" 	,"C1_NRCALC"	,"C",16,0					 ,"@!"				  } ,; //"N�mero C�lculo"
	{"Cod.Transp"		,"CODTR1"		,"C",06,0					 ,""				  } ,;
	{"Nome Transp."		,"NOMETR"		,"C",20,0					 ,""				  } ,;
	{"Qtde Pedidos"		,"PEDIDOS"		,"N",15,0					 ,""				  } ,; //QUANTIDADE DE PEDIDOS
	{"Valor Frete" 		,"C1_VALFRT"   	,"N",12,2					 ,"@E 9,999,999.99"} ,; //"Valor Frete"
	{"Prazo de Entrega" ,"C1_DTPREN"  	,"N",5,0			 		 ,"@!"      		  } ,; //"Prazo de Entrega"
	{"Tp C�lculo"		,"C1_TPCALC"	,"C",10,0					 ,"@!"				  } ,; //"Tp C�lculo"
	{"Tp Frete" 		,"C1_TPFRT"    	,"C",01,0					 ,"@!" 				  } ,; //"Tp Frete"
	{"Cidade Coleta"	,"C1_CDCOLT"	,"C",TamSX3("GU7_NMCID")[1],0,"@!"				  } ,; //"Cidade Coleta"
	{"Cidade C�lculo" 	,"C1_CDCALC"	,"C",TamSX3("GU7_NMCID")[1],0,"@!"				  } ,; //"Cidade C�lculo"
	{"Agrupador" 		,"C1_NRAGR"   	,"C",08,0                    ,"@!"				  } ,; //"Agrupador"
	{"Valor PIS" 		,"C1_VLPIS"    	,"N",12,2					 ,"@E 9,999,999.99"	  } ,; //"Valor PIS"
	{"Valor COFINS" 	,"C1_VLCOF"   	,"N",12,2					 ,"@E 9,999,999.99"	  } ,; //"Valor COFINS"
	{"Valor ICMS/ISS" 	,"C1_VLISS"   	,"N",12,2					 ,"@E 9,999,999.99"	  } ,; //"Valor ICMS/ISS"
	{"Melhor Neg."      ,"C1_MENEG"   	,"C",1,0			 		 ,"@!"      		  }}   //"Melhor Negocia��o"

	bValid   := {||((oDlgPrinc:End(), .T.))}

	Define MsDialog oDlgPrinc Title 'Calculo Frete' From aCoors[1], aCoors[2] To aCoors[3], aCoors[4] Pixel
	//
	// Cria o conteiner onde ser�o colocados os browses
	//
	oFWLayer := FWLayer():New()
	oFWLayer:Init( oDlgPrinc, .F.)

	//
	// Define Painel Superior
	//
	oFWLayer:AddLine( 'UP', 40, .F. ) // Cria uma "linha" com 50% da tela
	oFWLayer:AddCollumn( 'ALL', 100, .T., 'UP' ) // Na "linha" criada eu crio uma coluna com 100% da tamanho dela
	oPanelUp := oFWLayer:GetColPanel( 'ALL', 'UP' ) // Pego o objeto desse peda�o do container

	oFWLayer:AddWindow( "ALL", "PANEL01", "TESTE" + ' - ' + "TESTE", 100, .F.,,, "UP" )

	oSayCod	:= TSay():New(03,10,{|| "CALCULO DE FRETE" },oFWLayer:GetWinPanel ( 'ALL' , 'PANEL01', 'UP' ),,,,,,.T.,,,87,07,,,,,,.T.)
	//oGetCod := TGet():New( 01, 105,bSetGet,oFWLayer:GetWinPanel ( 'BOX01' , 'PANEL01', 'LINE01' ), 182, 10,cPicture,/bValid/,,,,,,.T.,,,,,,,,,,cCodDig,,,,,,,,,,,,,)
	oButton := TButton():New(20, 250,"OK",oFWLayer:GetWinPanel ( 'ALL' , 'PANEL01', 'UP' ),bValid,30,10,,,,.T.)

	//
	// Painel Inferior
	//
	oFWLayer:AddLine( 'DOWN', 50, .F. ) // Cria uma "linha" com 50% da tela
	oFWLayer:AddCollumn( 'LEFT' , 50, .T., 'DOWN' ) // Na "linha" criada eu crio uma coluna com 50% da tamanho dela
	oFWLayer:AddCollumn( 'RIGHT', 50, .T., 'DOWN' ) // Na "linha" criada eu crio uma coluna com 50% da tamanho dela
	oPanelLeft := oFWLayer:GetColPanel( 'LEFT' , 'DOWN' ) // Pego o objeto do peda�o esquerdo
	oPanelRight := oFWLayer:GetColPanel( 'RIGHT', 'DOWN' ) // Pego o objeto do peda�o direito

	//
	// FWmBrowse Superior INTERCHANGE
	//

	oBrowseUp:= FWmBrowse():New()
	oBrowseUp:SetOwner( oPanelUp ) // Aqui se associa o browse ao componente de tela
	oBrowseUp:SetDescription( "C�lculos" )
	oBrowseUp:SetAlias( cAlias )
	oBrowseUp:SetTemporary(.T.)
	oBrowseUp:SetFields(aBrowse)
	//oBrowseUp:SetMenuDef( '' ) // Define de onde virao os botoes deste browse
	oBrowseUp:AddLegend( "C1_MENEG > '2'", "BR_CANCEL", "Pior" )
	oBrowseUp:AddLegend( "C1_MENEG == '2'", "YELLOW" , "Aceitavel" )
	oBrowseUp:AddLegend( "C1_MENEG == '1'", "GREEN" , "Melhor" )
	oBrowseUp:AddMarkColumns( { ||Iif( !Empty( MARK ),"LBOK","LBNO" ) },{ || Tk61MarkDM( oBrowseUp,@nItemMrk ) }) //, { || TK61MarlAll( oMarkBrow ), oMarkBrow:Refresh() } )
	oBrowseUp:SetProfileID( '1' ) // identificador (ID) para o Browse
	//oBrowseUp:ForceQuitButton() // For�a exibi��o do bot�o Sair
	//oBrowseUp:DisableConfig() //Desabilita a utiliza��o das configura��es do Browse
	//oBrowseUp:DisableFilter() //Desabilita a utiliza��o do filtro no Browse.
	oBrowseUp:DisableReport() //Desabilita a impress�o das informa��es dispon�veis no Browse.
	oBrowseUp:DisableDetails()
	oBrowseUp:SetWalkthru(.F.)
	oBrowseUp:SetAmbiente(.F.)
	oBrowseUp:Activate()

	//LADO ESQUERDO
	//aAdd(aRet2,{nNumCalc,nClassFret,nTipOper,cTrecho,cTabela,cNumNegoc,cRota,dDatValid,cFaixa,cTipoVei})
/*
	a2Browse := {{"N�mero C�lculo" 	,   "C2_NRCALC"  , "C",  06, 0, "@!"    } ,; //"N�mero C�lculo"
	{"Class Frete" 		,	"C2_CDCLFR"  , "C",  04, 0, "@!"    } ,; //"Class Frete"
	{"Tipo Opera��o"	,	"C2_CDTPOP"  , "C",  10, 0, "@!"    } ,; //"Tipo Opera��o"
	{"Trecho" 			,	"C2_SEQ"     , "C",  04, 0, "@!"    } ,; //"Trecho"
	{"Cod.Tarnsp." 		,	"CODTRANS"   , "C",  06, 0, "@!"    } ,;
		{"Nr tabela " 		,	"C2_NRTAB"   , "C",  06, 0, "@!"	} ,; //"Nr tabela "
	{"Nr Negoc" 		,	"C2_NRNEG"   , "C",  06, 0, "@!"	} ,; //"Nr Negoc"
	{"Rota" 			,	"C2_NRROTA"  , "C",  16, 0, "@!"    } ,; //"Rota"
	{"Data Validade" 	,	"C2_DTVAL"   , "D",  08, 0, ""	    } ,; //"Data Validade"
	{"Faixa" 			,	"C2_CDFXTV"  , "C",  04, 0, "@!"	} ,; //"Faixa"
	{"Tipo Ve�culo" 	,	"C2_CDTPVC"  , "C",  10, 0, "@!"    } }  //"Tipo Ve�culo"
*/

	a2Browse := {{"N�mero C�lculo" 	,   "C2_NRCALC"  , "C",  06, 0, "@!"    } ,; //"N�mero C�lculo"
	{"Pedido"	 		,	"C2_CHVGWU"  , "C",  50, 0, "@!"    } } //"Pedido"


	oBrowseLeft:= FWMBrowse():New()
	oBrowseLeft:SetOwner( oPanelLeft )
	oBrowseLeft:SetDescription( 'Tabelas' )
	oBrowseLeft:DisableDetails()
	oBrowseLeft:DisableReport()
	oBrowseLeft:SetWalkthru(.F.)
	oBrowseLeft:SetAmbiente(.F.)
	oBrowseLeft:SetAlias( c2Alias )
	oBrowseLeft:SetTemporary(.T.)
	oBrowseLeft:SetFields(a2Browse)
	oBrowseLeft:SetProfileID( '2' )
	oBrowseLeft:Activate()

	//TERCEIRA DIREITO

	a3Browse := {{"N�mero C�lculo" 	, "C3_NRCALC"  , "C",  16, 0, "@!"  		       } ,; //"N�mero C�lculo"
	{"Class Frete" 		, "C3_CDCLFR"  , "C",  04, 0, "@!"  	           } ,; //"Class Frete"
	{"Tipo Opera��o"	, "C3_CDTPOP"  , "C",  10, 0, "@!"  		       } ,; //"Tipo Opera��o"
	{"Trecho" 			, "C3_SEQ"     , "C",  04, 0, "@!" 	    	   } ,; //"Trecho"
	{"Componente" 		, "C3_COPFRT"  , "C",  20, 0, "@!"                } ,; //"Componente"
	{"Categoria" 		, "C3_CATVAL"  , "C",  20, 0, "@!"                } ,; //"Categoria"
	{"Valor Frete" 		, "C3_VLFRT"   , "N",  12, 2, "@E 9,999,999.99"} ,; //"Valor Frete"
	{"Qtde C�lculo" 	, "C3_QTDCALC" , "N",  12, 2, "@E 9,999,999.99"} ,; //"Qtde C�lculo"
	{"Total Frete" 		, "C3_TOTFRT"  , "C",  01, 0, "@!"                } }  //"Total Frete"


	oBrowseRight:= FWMBrowse():New()
	oBrowseRight:SetOwner( oPanelRight )
	oBrowseRight:SetDescription( 'Composi��o Frete' )
	oBrowseRight:DisableDetails()
	oBrowseRight:DisableReport()
	oBrowseRight:SetWalkthru(.F.)
	oBrowseRight:SetAmbiente(.F.)
	oBrowseRight:SetAlias( c3Alias )
	oBrowseRight:SetTemporary(.T.)
	oBrowseRight:SetFields(a3Browse)
	oBrowseRight:SetProfileID( '3' )
	oBrowseRight:Activate()


	oRelac1:= FWBrwRelation():New()
	oRelac1:AddRelation( oBrowseUp , oBrowseLeft , { {'C2_NRCALC' , 'C1_NRCALC' } } )
	oRelac1:Activate()

	oRelac2:= FWBrwRelation():New()
	oRelac2:AddRelation( oBrowseUp, oBrowseRight, { {	'C3_NRCALC' , 'C1_NRCALC' }} )
	oRelac2:Activate()

	Activate MsDialog oDlgPrinc Center  on Init EnchoiceBar(oDlgPrinc,{||Iif(OkTransp(),oDlgPrinc:End(),.F.)},{||oDlgPrinc:End()})

	oTempTable:Delete()
	o2TempTable:Delete()
	o3TempTable:Delete()


Return NIL


/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���Funcao    �ModelDef      �Autor  �Microsiga           � Data �  05/09/10   ���
������������������������������������������������������������������������������͹��
������������������������������������������������������������������������������͹��
���Uso       �SigaFat                                                          ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/

Static Function ModelDef()

	// Cria a estrutura a ser usada no Modelo de Dados
	Local oModel := Nil

	//Cria��o da estrutura de dados utilizada na interface
	Local oStruTRB1 := FWFormModelStruct():New()
	Local oStruTRB2 := FWFormModelStruct():New()
	Local oStruTRB3 := FWFormModelStruct():New()


	//oStruTRB1:AddTable(cAlias,{"CODTR1","INTERID1","DATAINF"},"TMPTRB1")
	oStruTRB1:AddTable(cAlias,{"C1_NRCALC"},"TMPTRB1")

/*
	//Adiciona os campos da estrutura
	oStruTRB1:AddField(;
		"Cod Transp",;                                                                                   // [01]  C   Titulo do campo //"Cod. Revis�o"
	"Cod Transp",;                                                                                   // [02]  C   ToolTip do campo //"Cod. Revis�o"
	"CODTR1",;                                                                                  // [03]  C   Id do Field
	"C",;                                                                                       // [04]  C   Tipo do campo
	6,;                                                                                        // [05]  N   Tamanho do campo
	0,;                                                                                         // [06]  N   Decimal do campo
	Nil,;                                                                                       // [07]  B   Code-block de valida��o do campo
	Nil,;                                                                                       // [08]  B   Code-block de valida��o When do campo
	{},;                                                                                        // [09]  A   Lista de valores permitido do campo
	.F.,;                                                                                       // [10]  L   Indica se o campo tem preenchimento obrigat�rio
	Nil,;  														                                // [11]  B   Code-block de inicializacao do campo
	.T.,;                                                                                       // [12]  L   Indica se trata-se de um campo chave
	.F.,;                                                                                       // [13]  L   Indica se o campo pode receber valor em uma opera��o de update.
	.F.)                                                                                        // [14]  L   Indica se o campo � virtual
*/

	oStruTRB1:AddField("N�mero C�lculo"		,"N�mero C�lculo"	,"C1_NRCALC"	,"C",16,0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB1:AddField("Cod.Transp"			,"Cod.Transp"		,"CODTR1"		,"C",06,0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB1:AddField("Nome Transp."		,"Nome Transp."		,"NOMETR"		,"C",20,0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB1:AddField("Qtde Pedidos"		,"Qtde Pedidos"		,"PEDIDOS"		,"N",12,0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB1:AddField("Valor Frete"		,"Valor Frete"		,"C1_VALFRT"	,"N",12,2,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB1:AddField("Prazo de Entrega"	,"Prazo de Entrega"	,"C1_DTPREN"	,"N",5,0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB1:AddField("Tp C�lculo"			,"Tp C�lculo"		,"C1_TPCALC"	,"C",10,0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB1:AddField("Tp Frete"			,"Tp Frete"			,"C1_TPFRT"		,"C",01,0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB1:AddField("Cidade Coleta"		,"Cidade Coleta"	,"C1_CDCOLT"	,"C",TamSX3("GU7_NMCID")[1],0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB1:AddField("Cidade C�lculo"		,"Cidade C�lculo"	,"C1_CDCALC"	,"C",TamSX3("GU7_NMCID")[1],0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB1:AddField("Agrupador"			,"Agrupador"		,"C1_NRAGR"		,"C",08,0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB1:AddField("Valor PIS"			,"Valor PIS"		,"C1_VLPIS"		,"N",12,2,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB1:AddField("Valor COFINS"		,"Valor COFINS"		,"C1_VLCOF"		,"N",12,2,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB1:AddField("Valor ICMS/ISS"		,"Valor ICMS/ISS"	,"C1_VLISS"		,"N",12,2,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB1:AddField("Melhor Neg."		,"Melhor Neg."		,"C1_MENEG"		,"C",01,0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)


	//SEGUNDA TABELA
	//oStruTRB2:AddTable(cAlias,{"ICODTR2","SKU","QTDE"},"TMPTRB2")
	oStruTRB2:AddTable(cAlias,{"CODTR2"},"TMPTRB2")
/*
	oStruTRB2:AddField("N�mero C�lculo"	,"N�mero C�lculo"	,"C2_NRCALC"		,"C",06,0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB2:AddField("Class Frete"	,"Class Frete"		,"C2_CDCLFR"		,"C",04,0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB2:AddField("Tipo Opera��o"	,"Tipo Opera��o"	,"C2_CDTPOP"		,"C",10,0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB2:AddField("Trecho"			,"Trecho"			,"C2_SEQ"			,"C",04,0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB2:AddField("Cod.Trans."		,"Cod.Trans."		,"CODTRANS"			,"C",06,0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB2:AddField("Nr tabela"		,"Nr tabela"		,"C2_NRTAB"			,"C",06,0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB2:AddField("Nr Negoc"		,"Nr Negoc"			,"C2_NRNEG"			,"C",06,0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB2:AddField("Rota"			,"Rota"				,"C2_NRROTA"		,"C",16,0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB2:AddField("Data Validade"	,"Data Validade"	,"C2_DTVAL"			,"D",08,0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB2:AddField("Faixa"			,"Faixa"			,"C2_CDFXTV"		,"C",04,0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB2:AddField("Tipo Ve�culo"	,"Tipo Ve�culo"		,"C2_CDTPVC"		,"C",10,0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
*/

	oStruTRB2:AddField("N�mero C�lculo"	,"N�mero C�lculo"	,"C2_NRCALC"		,"C",06,0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB2:AddField("Pedido"	,"Pedido"					,"C2_CHVGWU"		,"C",50,0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)

	//TERCEIRA TABELA

	//oStruTRB3:AddTable(cAlias,{"INTERID3","REPLY","DATAINF","ERROR"},"TMPTRB3")
	oStruTRB3:AddTable(cAlias,{"CODTR3"},"TMPTRB3")

	oStruTRB3:AddField("N�mero C�lculo"		,"N�mero C�lculo"	,"C3_NRCALC"	,"C",16,0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB3:AddField("Class Frete"		,"Class Frete"		,"C3_CDCLFR"	,"C",04,0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB3:AddField("Tipo Opera��o"		,"Tipo Opera��o"	,"C3_CDTPOP"	,"C",10,0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB3:AddField("Trecho"				,"Trecho"			,"C3_SEQ"		,"C",04,0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB3:AddField("Componente"			,"Componente"		,"C3_COPFRT"	,"C",20,0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB3:AddField("Categoria"			,"Categoria"		,"C3_CATVAL"	,"C",20,0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB3:AddField("Valor Frete"		,"Valor Frete"		,"C3_VLFRT"		,"N",12,2,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB3:AddField("Qtde C�lculo"		,"Qtde C�lculo"		,"C3_QTDCALC"	,"N",12,2,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)
	oStruTRB3:AddField("Total Frete"		,"Total Frete"		,"C3_TOTFRT"	,"C",01,0,Nil,Nil,{},.F.,Nil,.F.,.F.,.F.)


	oModel := MPFormModel():New("ESTRD006",/*bPre*/,/*bPos*/,/*bCommit*/,/*bCancel*/)


	//Atribuindo formul�rios para o modelo
	oModel:AddFields("TRB1MASTER",/*cOwner*/,oStruTRB1)
	oModel:AddFields("TRB2LEFT",/*cOwner*/,oStruTRB2)
	oModel:AddFields("TRB3RIGHT",/*cOwner*/,oStruTRB3)

	//Setando a chave prim�ria da rotina
	//oModel:SetPrimaryKey({'CODREV'})

	//Adicionando descri��o ao modelo
	oModel:SetDescription("Calculo de Frete")

Return oModel




/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���Funcao    �ViewDef        �Autor  �Microsiga           � Data �  05/09/10   ���
������������������������������������������������������������������������������͹��
���Desc.     �Esta rotina tem o objetivo de permitir a inclus�o, altera��o,    ���
���          �exclus�o e efetiva��o uma publica��o de pre�os           	       ���
������������������������������������������������������������������������������͹��
���Uso       �SigaFat                                                          ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/

Static Function ViewDef()
	// Cria um objeto de Modelo de dados baseado no ModelDef() do fonte informado
	Local oModel := FWLoadModel( 'ESTRD006' )
	// Cria a estrutura a ser usada na View
	Local oStruTRB1 := FWFormViewStruct():New()
	Local oStruTRB2 := FWFormViewStruct():New()
	Local oStruTRB3 := FWFormViewStruct():New()

	// Interface de visualiza��o constru�da
	Private oView
/*
	//Adicionando campos da estrutura
	oStruTRB1:AddField(;
		"CODTR1",;                  // [01]  C   Nome do Campo
	"01",;                      // [02]  C   Ordem
	"Cod Transp",;                   // [03]  C   Titulo do campo //"Cod. Revis�o"
	"Cod Transp",;                   // [04]  C   Descricao do campo //"Cod. Revis�o"
	Nil,;                       // [05]  A   Array com Help
	"C",;                       // [06]  C   Tipo do campo
	"",;                      // [07]  C   Picture
	Nil,;                       // [08]  B   Bloco de PictTre Var
	Nil,;                       // [09]  C   Consulta F3
	.F.,;                       // [10]  L   Indica se o campo � alteravel
	Nil,;                       // [11]  C   Pasta do campo
	Nil,;                       // [12]  C   Agrupamento do campo
	Nil,;                       // [13]  A   Lista de valores permitido do campo (Combo)
	Nil,;                       // [14]  N   Tamanho maximo da maior op��o do combo
	nIL,; 				        // [15]  C   Inicializador de Browse
	Nil,;                       // [16]  L   Indica se o campo � virtual
	Nil,;                       // [17]  C   Picture Variavel
	Nil)                        // [18]  L   Indica pulo de linha ap�s o campo

*/



	oStruTRB1:AddField("C1_NRCALC","01","N�mero C�lculo"		,"N�mero C�lculo"			,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB1:AddField("CODTR1","01","Cod.Transp"				,"Cod.Transp"				,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB1:AddField("NOMETR","01","Nome Transp."				,"Nome Transp."				,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB1:AddField("PEDIDOS","01","Qtde.Pedidos"			,"Qtde.Pedidos"				,Nil,"N","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB1:AddField("C1_VALFRT","01","Valor Frete"			,"Valor Frete"				,Nil,"N","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB1:AddField("C1_DTPREN","01","Prazo de Entrega"		,"Prazo de Entrega"			,Nil,"N","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB1:AddField("C1_TPCALC","01","Tp C�lculo"			,"Tp C�lculo"				,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB1:AddField("C1_TPFRT","01","Tp Frete"				,"Tp Frete"					,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB1:AddField("C1_CDCOLT","01","Cidade Coleta"			,"Cidade Coleta"			,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB1:AddField("C1_CDCALC","01","Cidade C�lculo"		,"Cidade C�lculo"			,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB1:AddField("C1_NRAGR","01","Agrupador"				,"Agrupador"				,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB1:AddField("C1_VLPIS","01","Valor PIS"				,"Valor PIS"				,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB1:AddField("C1_VLCOF","01","Valor COFINS"			,"Valor COFINS"				,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB1:AddField("C1_VLISS","01","Valor ICMS/ISS"			,"Valor ICMS/ISS"			,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB1:AddField("C1_MENEG","01","Melhor Neg."			,"Melhor Neg."				,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)



	//SEGUNDA QUADRO
	//Adicionando campos da estrutura
/*
	oStruTRB2:AddField("C2_NRCALC"	,"01","N�mero C�lculo"	,"N�mero C�lculo"	,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB2:AddField("C2_CDCLFR"	,"01","Class Frete"		,"Class Frete"		,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB2:AddField("C2_CDTPOP"	,"01","Tipo Opera��o"	,"Tipo Opera��o"	,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB2:AddField("C2_SEQ"		,"01","Trecho"			,"Trecho"			,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB2:AddField("CODTRANS"	,"01","Cod.Trans."		,"Cod.Trans."		,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB2:AddField("C2_NRTAB"	,"01","Nr tabela"		,"Nr tabela"		,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB2:AddField("C2_NRNEG"	,"01","Nr Negoc"		,"Nr Negoc"			,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB2:AddField("C2_NRROTA"	,"01","Rota"			,"Rota"				,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB2:AddField("C2_DTVAL"	,"01","Data Validade"	,"Data Validade"	,Nil,"D","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB2:AddField("C2_CDFXTV"	,"01","Faixa"			,"Faixa"			,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB2:AddField("C2_CDTPVC"	,"01","Tipo Ve�culo"	,"Tipo Ve�culo"		,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
*/
	oStruTRB2:AddField("C2_NRCALC"	,"01","N�mero C�lculo"	,"N�mero C�lculo"	,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB2:AddField("C2_CHVGWU"	,"01","Pedido"			,"Pedido"			,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)

	//TERCEIRA TABELA

	//Adicionando campos da estrutura
	//Adiciona os campos da estrutura
	oStruTRB2:AddField("C3_NRCALC"	,"01","N�mero C�lculo"		,"N�mero C�lculo"		,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB2:AddField("C3_CDCLFR"	,"01","Class Frete"			,"Class Frete"			,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB2:AddField("C3_CDTPOP"	,"01","Tipo Opera��o"		,"Tipo Opera��o"		,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB2:AddField("C3_SEQ"		,"01","Trecho"				,"Trecho"				,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB2:AddField("C3_COPFRT"	,"01","Componente"			,"Componente"			,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB2:AddField("C3_CATVAL"	,"01","Categoria"			,"Categoria"			,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB2:AddField("C3_VLFRT"	,"01","Valor Frete"			,"Valor Frete"			,Nil,"N","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB2:AddField("C3_QTDCALC"	,"01","Qtde C�lculo"		,"Qtde C�lculo"			,Nil,"N","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)
	oStruTRB2:AddField("C3_TOTFRT"	,"01","Total Frete"			,"Total Frete"			,Nil,"C","",Nil,Nil,.F.,Nil,Nil,Nil,Nil,nIL,Nil,Nil,Nil)


	// Cria o objeto de View
	oView := FWFormView():New()
	// Define qual o Modelo de dados ser� utilizado na View
	oView:SetModel( oModel )
	// Adiciona no nosso View um controle do tipo formul�rio
	// (antiga Enchoice)

	oView:AddField("VIEW_TRB1", oStruTRB1, "TRB1MASTER")
	oView:SetOwnerView('VIEW_TRB1','SUPERIOR')
	oView:AddField("VIEW_TRB2", oStruTRB2, "TRB2LEFT")
	oView:AddField("VIEW_TRB3", oStruTRB3, "TRB3RIGHT")

	oView:EnableControlBar(.T.)

Return oView

/*
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
������������������������������������������������������������������������������ͻ��
���Funcao    �LoadTRB1        �Autor  �Microsiga           � Data �  05/09/10   ���
������������������������������������������������������������������������������͹��
���Desc.     �Esta rotina tem o objetivo de permitir a inclus�o, altera��o,    ���
���          �exclus�o e efetiva��o uma publica��o de pre�os           	       ���
������������������������������������������������������������������������������͹��
���Uso       �SigaFat                                                          ���
������������������������������������������������������������������������������ͼ��
����������������������������������������������������������������������������������
����������������������������������������������������������������������������������
*/
Static Function LoadTRB1(aRet,aRet2,aRet3,oSay)

	Local aFields := {}
	Local kk 	  := 0

	//-------------------
	//Cria��o do objeto
	//-------------------
	oTempTable := FWTemporaryTable():New( cAlias )

	//--------------------------
	//Monta os campos da tabela
	//--------------------------

	aadd(aFields,{"MARK"		,"C",02,0})
	aadd(aFields,{"C1_NRCALC"	,"C",16,0})
	aadd(aFields,{"CODTR1"		,"C",06,0})
	aadd(aFields,{"NOMETR"		,"C",20,0})
	aadd(aFields,{"PEDIDOS"		,"N",15,0})
	aadd(aFields,{"C1_VALFRT"	,"N",12,2})
	aadd(aFields,{"C1_DTPREN"	,"N",05,0})
	aadd(aFields,{"C1_TPCALC"	,"C",10,0})
	aadd(aFields,{"C1_TPFRT"	,"C",01,0})
	aadd(aFields,{"C1_CDCOLT"	,"C",TamSX3("GU7_NMCID")[1],0})
	aadd(aFields,{"C1_CDCALC"	,"C",TamSX3("GU7_NMCID")[1],0})
	aadd(aFields,{"C1_NRAGR"	,"C",08,0})
	aadd(aFields,{"C1_VLPIS"	,"N",12,2})
	aadd(aFields,{"C1_VLCOF"	,"N",12,2})
	aadd(aFields,{"C1_VLISS"	,"N",12,2})
	aadd(aFields,{"C1_MENEG"	,"C",01,0})


	oTemptable:SetFields( aFields )
	oTempTable:AddIndex("INDICE1", {"C1_VALFRT", "C1_DTPREN"} )
	//------------------
	//Cria��o da tabela
	//------------------
	oTempTable:Create()

	//-------------------
	//Cria��o do objeto
	//-------------------
	o2TempTable := FWTemporaryTable():New( c2Alias )
	aFields := {}
	//--------------------------
	//Monta os campos da tabela
	//--------------------------
	/*
	aadd(aFields,{"C2_NRCALC"	,"C",06,0})
	aadd(aFields,{"C2_CDCLFR"	,"C",04,0})
	aadd(aFields,{"C2_CDTPOP"	,"C",10,0})
	aadd(aFields,{"C2_SEQ"		,"C",04,0})
	aadd(aFields,{"CODTRANS"	,"C",06,0})
	aadd(aFields,{"C2_NRTAB"	,"C",06,0})
	aadd(aFields,{"C2_NRNEG"	,"C",06,0})
	aadd(aFields,{"C2_NRROTA"	,"C",16,0})
	aadd(aFields,{"C2_DTVAL"	,"D",08,0})
	aadd(aFields,{"C2_CDFXTV"	,"C",04,0})
	aadd(aFields,{"C2_CDTPVC"	,"C",10,0})
*/

	aadd(aFields,{"C2_NRCALC"	,"C",06,0})
	aadd(aFields,{"C2_CHVGWU"	,"C",50,0})

	o2Temptable:SetFields( aFields )

	//------------------
	//Cria��o da tabela
	//------------------
	o2TempTable:Create()


	o3TempTable := FWTemporaryTable():New( c3Alias )
	aFields := {}
	//--------------------------
	//Monta os campos da tabela
	//--------------------------
	aadd(aFields,{"C3_NRCALC"	,"C",16,0})
	aadd(aFields,{"C3_CDCLFR"	,"C",04,0})
	aadd(aFields,{"C3_CDTPOP"	,"C",10,0})
	aadd(aFields,{"C3_SEQ"		,"C",04,0})
	aadd(aFields,{"C3_COPFRT"	,"C",20,0})
	aadd(aFields,{"C3_CATVAL"	,"C",20,0})
	aadd(aFields,{"C3_VLFRT"	,"N",12,2})
	aadd(aFields,{"C3_QTDCALC"	,"N",12,2})
	aadd(aFields,{"C3_TOTFRT"	,"C",01,0})

	o3Temptable:SetFields( aFields )

	//------------------
	//Cria��o da tabela
	//------------------
	o3TempTable:Create()

	//ORDENA ARRAY E CLASSIFICA MELHOR NEGOCIACAO
	ASort(aRet,,,{|x,y|x[5]+x[4] < y[5]+y[4]})

	For KK:=1 To Len(aRet)
		aRet[KK][14] := cValToChar(KK)
	Next



	//GRAVA CABECALHO
	For kk:=1 To Len(aRet)

		oSay:SetText("Gravando cabecalho: " + StrZero(kk, 6)) // ALTERA O TEXTO CORRETO
		ProcessMessage() // FOR�A O DESCONGELAMENTO DO SMARTCLIENT

		dbSelectArea("TRB4")
		RecLock("TRB4",.T.)


		//aAdd (aRet, {nNumCalc,cCodTransp,cNomeTRansp,nValFrete,nPrzEntr,cTpCalc,cTpFrete,cCidCol,cCidCalc,cAgrup,nValPis,nValCof,nValISS,nMelhorNeg,NPEDIDOS})

		TRB4->MARK		:= ""
		TRB4->C1_NRCALC	:= aRet[kk][1]
		TRB4->CODTR1	:= aRet[kk][2]
		TRB4->NOMETR	:= aRet[kk][3]
		TRB4->PEDIDOS	:= aRet[kk][15]
		TRB4->C1_VALFRT	:= aRet[kk][4]
		TRB4->C1_DTPREN	:= aRet[kk][5]
		TRB4->C1_TPCALC	:= aRet[kk][6]
		TRB4->C1_TPFRT	:= aRet[kk][7]
		TRB4->C1_CDCOLT	:= aRet[kk][8]
		TRB4->C1_CDCALC	:= aRet[kk][9]
		TRB4->C1_NRAGR	:= aRet[kk][10]
		TRB4->C1_VLPIS	:= aRet[kk][11]
		TRB4->C1_VLCOF	:= aRet[kk][12]
		TRB4->C1_VLISS	:= aRet[kk][13]
		TRB4->C1_MENEG	:= aRet[kk][14]

		TRB4->(MsUnlock())
	Next

	//GRAVA ITENS
	For kk:=1 To Len(aRet2)

		oSay:SetText("Gravando itens: " + StrZero(kk, 6)) // ALTERA O TEXTO CORRETO
		ProcessMessage() // FOR�A O DESCONGELAMENTO DO SMARTCLIENT


		dbSelectArea("TRB2")
		RecLock("TRB2",.T.)
/*
		TRB2->C2_NRCALC	:= aRet2[kk][1]
		TRB2->C2_CDCLFR	:= aRet2[kk][2]
		TRB2->C2_CDTPOP	:= aRet2[kk][3]
		TRB2->C2_SEQ	:= aRet2[kk][4]
		TRB2->CODTRANS	:= aRet2[kk][5]
		TRB2->C2_NRTAB	:= aRet2[kk][6]
		TRB2->C2_NRNEG	:= aRet2[kk][7]
		TRB2->C2_NRROTA	:= aRet2[kk][8]
		TRB2->C2_DTVAL	:= aRet2[kk][9]
		TRB2->C2_CDFXTV	:= aRet2[kk][10]
		TRB2->C2_CDTPVC	:= aRet2[kk][11]
*/
		TRB2->C2_NRCALC	:= aRet2[kk][1]
		TRB2->C2_CHVGWU	:= aRet2[kk][2]


		TRB2->(MsUnlock())
	Next

	//TERCEIRO OBJETO
	//GRAVA ITENS
//aAdd(aRet3,{nNumCalc,nClassFret,nTipOper,cTrecho,cComp,cCateg,nValFr,nQtdCalc,nTotFr})
	For kk:=1 To Len(aRet)

		oSay:SetText("Gravando detalhes: " + StrZero(kk, 6)) // ALTERA O TEXTO CORRETO
		ProcessMessage() // FOR�A O DESCONGELAMENTO DO SMARTCLIENT

		dbSelectArea("TRB3")
		RecLock("TRB3",.T.)

		TRB3->C3_NRCALC	:= aRet3[kk][1]
		TRB3->C3_CDCLFR	:= aRet3[kk][2]
		TRB3->C3_CDTPOP	:= aRet3[kk][3]
		TRB3->C3_SEQ	:= aRet3[kk][4]
		TRB3->C3_COPFRT	:= aRet3[kk][5]
		TRB3->C3_CATVAL	:= aRet3[kk][6]
		TRB3->C3_VLFRT	:= aRet3[kk][7]
		TRB3->C3_QTDCALC:= aRet3[kk][8]
		TRB3->C3_TOTFRT	:= aRet3[kk][9]


		TRB3->(MsUnlock())
	Next

Return(.T.)



//-------------------------------------------------------------------------
/*/{Protheus.doc} Tk61MarkDM

Fun��o de sele��o de registros

@sample Tk61MarkDM( oMarkBrow )

@param   oMarkBrow		->		Objeto da do Browse

@author Thamara Villa

@since 20/03/2014
@version 12.0
/*/
//-------------------------------------------------------------------------
Static Function Tk61MarkDM( oMarkBrow,nItemMrk )
	Default nItemMrk	:= 0 	//Item j� marcado
	nRecnoTRB4 := Recno()

	If nItemMrk == 0  //Nenhum Item Marcado em Mem�ria
		RecLock("TRB4",.F.)
		TRB4->MARK := cMark
		TRB4->(MsUnLock())
		nItemMrk++
	ElseIf TRB4->MARK == cMark //Item J� Marcado
		RecLock("TRB4",.F.)
		TRB4->MARK := ""
		TRB4->(MsUnLock())
		nItemMrk--
	Else //Marca o Item selecionado e desmarca o Item j� marcado anteriormente.
		dbSelectArea("TRB4")
		dbGoTop()
		While !Eof()
			If !Empty(TRB4->MARK)
				RecLock("TRB4",.F.)
				TRB4->MARK := ""
				TRB4->(MsUnLock())
				nItemMrk--
				Exit
			EndIf
			dbSkip()
		End

		dbSelectArea("TRB4")
		dbGoTo(nRecnoTRB4)
		RecLock("TRB4",.F.)
		TRB4->MARK := cMark
		TRB4->(MsUnLock())
		nItemMrk++
	EndIf

	oMarkBrow:Refresh()
Return( Nil )

//-------------------------------------------------------------------------
/*/{Protheus.doc} OkTransp

Valida se foi selecionada uma transportadora e alimenta a vari�vel da transportadora



@author Paulo Bindo

@since 01/07/2022
@version 12.0
/*/
//-------------------------------------------------------------------------

Static Function OkTransp()
	Local lRet := .F.


	dbSelectArea("TRB4")
	dbGoTop()
	While !Eof()
		If !Empty(TRB4->MARK)
			_transp := TRB4->CODTR1
			lRet := .T.
		EndIf
		dbSkip()
	End

	If !lRet
		Help(,, "LE009M-1",,"Selecione uma transportadora para continuar",1,0,,,,,,{"Dever� ser marcada uma transportadora"})
	EndIf


Return(lRet)
